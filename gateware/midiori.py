#!/usr/bin/env python3

from migen import *
from migen.fhdl import verilog
from migen.genlib.fifo import *
from migen.genlib.coding import *
import midiori_platform
import subprocess

base_addr = Constant(0xeafa00 >> 1)

describe = subprocess.check_output(["git", "describe", "--tags", "--long"]).strip().decode()
version_string = Array(("midiori "+describe+"\x00").encode('shift_jis'))

def _divisor(freq_in, freq_out, max_ppm=None):
    divisor = freq_in // freq_out
    if divisor <= 0:
        raise ArgumentError("output frequency is too high")

    ppm = 1000000 * ((freq_in / divisor) - freq_out) / freq_out
    if max_ppm is not None and ppm > max_ppm:
        raise ArgumentError("output frequency deviation is too high")

    return divisor


class UART(Module):
    def __init__(self, tx, clk_freq, baud_rate):
        self.tx_data = Signal(8)
        self.tx_ready = Signal()
        self.tx_ack = Signal()

        divisor = _divisor(freq_in=clk_freq, freq_out=baud_rate, max_ppm=50000)

        tx_counter = Signal(max=divisor)
        self.tx_strobe = tx_strobe = Signal()
        self.comb += tx_strobe.eq(tx_counter == 0)
        self.sync += \
            If(tx_counter == 0,
                tx_counter.eq(divisor - 1)
            ).Else(
                tx_counter.eq(tx_counter - 1)
            )

        self.tx_bitno = tx_bitno = Signal(3)
        self.tx_latch = tx_latch = Signal(8)
        self.submodules.tx_fsm = FSM(reset_state="IDLE")
        self.tx_fsm.act("IDLE",
            self.tx_ack.eq(1),
            If(self.tx_ready,
                NextValue(tx_counter, divisor - 1),
                NextValue(tx_latch, self.tx_data),
                NextState("START")
            ).Else(
                NextValue(tx, 1)
            )
        )
        self.tx_fsm.act("START",
            If(self.tx_strobe,
                NextValue(tx, 0),
                NextState("DATA")
            )
        )
        self.tx_fsm.act("DATA",
            If(self.tx_strobe,
                NextValue(tx, tx_latch[0]),
                NextValue(tx_latch, Cat(tx_latch[1:8], 0)),
                NextValue(tx_bitno, tx_bitno + 1),
                If(self.tx_bitno == 7,
                    NextState("STOP")
                )
            )
        )
        self.tx_fsm.act("STOP",
            If(self.tx_strobe,
                NextValue(tx, 1),
                NextState("IDLE")
            )
        )

class Midiori(Module):
    def __init__(self):
        # tx uart registers
        self.tx = Signal()
        self.uart_tx = Signal()
        self.uart = UART(self.uart_tx, 16000000, 31250)
        self.brke = Signal()
        self.txe = Signal()
        self.comb += If(self.brke,
            self.tx.eq(0),
        ).Else(
            self.tx.eq(self.uart_tx)
        )
        self.submodules += self.uart
        self.fifo = SyncFIFOBuffered(8, 16)
        self.submodules += self.fifo
        # the itx fifo is described as a 4 deep fifo,
        # but it's really just 4 different types of
        # messages that can be sent
        itx_fifo_fe = Signal()
        itx_fifo_in_progress = Signal()
        self.comb += self.uart.tx_ready.eq(self.fifo.readable | itx_fifo_fe)
        self.comb += If(itx_fifo_in_progress,
            self.fifo.re.eq(0)
        ).Else(
            self.fifo.re.eq(self.uart.tx_ack)
        )
        self.comb += If(itx_fifo_fe,
            self.uart.tx_data.eq(0xfe)
        ).Else(
            self.uart.tx_data.eq(self.fifo.dout)
        )
        self.sync += If(self.uart.tx_ack & itx_fifo_fe & ~itx_fifo_in_progress,
            itx_fifo_fe.eq(0),
            itx_fifo_in_progress.eq(1)
        ).Elif(self.uart.tx_ack & itx_fifo_in_progress,
            itx_fifo_in_progress.eq(0),
        )
        self.addr = Signal(23)
        self._irq = Signal(reset=1)
        self._iack = Signal()
        self._as = Signal()
        self._lds = Signal()
        self._dtready = Signal(reset=1)
        self._rw = Signal()
        self.exreset = Signal(reset=1)
        self.data = TSTriple(8)
        self.addr_num = Signal(3)
        self.register_num = Signal(8)
        self.version_index = Signal(5)

        # internal read-only registers

        self.txemp = Signal()
        self.comb += self.txemp.eq(self.fifo.level == 0)
        self.txrdy = Signal()
        self.comb += self.txrdy.eq(self.fifo.writable)
        self.txidl = Signal()
        self.ase = Signal()
        txidl_counter = Signal(21)
        self.sync += If(txidl_counter >= 1280000,
            txidl_counter.eq(0),
            self.txidl.eq(1),
            itx_fifo_fe.eq(self.ase)
        ).Elif(~self.txemp | ~self.txe,
            txidl_counter.eq(0)
        ).Else(
            txidl_counter.eq(txidl_counter + 1)
        )
        self.txbsy = Signal()
        self.comb += self.txbsy.eq(0)
        self.tsr = Signal(8)
        self.comb += self.tsr.eq(Cat(self.txbsy,0,self.txidl,0,0,0,self.txrdy,self.txemp))

        # internal read-write registers
        self.group_num = Signal(4)
        self.ier = Signal(8)
        self.ivo = Signal(3)
        self.ic = Signal()

        #8us clock divider
        midi_divider = Signal(7)
        #all games should set this to 1, but
        #simulate it for completeness
        clkm = Signal()
        self.sync += midi_divider.eq(midi_divider-1)
        midi_clk_en = Signal()
        self.comb += If(clkm,
                            midi_clk_en.eq(midi_divider == 0)
                        ).Else(
                            midi_clk_en.eq(midi_divider[0:6] == 0)
                        )

        # irq controller
        self.isr = Signal(8, reset=0x00)
        self.ivr = Signal(8)
        self.vec = Signal(4)
        self.isr_masked = Signal(8)
        self.comb += self.isr_masked.eq(self.isr & self.ier)
        isr_pe = PriorityEncoder(8)
        self.submodules += isr_pe
        self.comb += isr_pe.i.eq(self.isr_masked)
        self.comb += self.vec.eq(Cat(isr_pe.o, isr_pe.n))
        self.comb += self.ivr.eq(Cat(0,self.vec,self.ivo))
        self.comb += self._irq.eq(self.isr_masked == 0)

        # irq sets
        self.previous_empty = Signal()
        self.sync += If((self.previous_empty == 0) & (self.txemp == 1),
                        self.isr[6].eq(1)
        )
        self.sync += self.previous_empty.eq(self.txemp)

        #general purpose timer
        gpt_low_byte_cache = Signal(8)
        gpt_reset_value = Signal(16)
        gpt_counter = Signal(14)
        self.sync += If(midi_clk_en,
            If((gpt_counter == 0) & (gpt_reset_value > 1),
                gpt_counter.eq(gpt_reset_value),
                self.isr[7].eq(1)
            ).Else(
                gpt_counter.eq(gpt_counter-1)
            )
        )

        #midi clock timer
        clock_low_byte_cache = Signal(8)
        clock_reset_value = Signal(16)
        clock_counter = Signal(14)
        self.sync += If(midi_clk_en,
            If((clock_counter == 0) & (clock_reset_value > 1),
                clock_counter.eq(clock_reset_value),
                self.isr[1].eq(1)
            ).Else(
                clock_counter.eq(clock_counter-1)
            )
        )

        #midi click counter
        # todo: clock off midi clock and implement isr mux
        click_counter = Signal(7)
        click_reset_value = Signal(7)
        self.sync += If(0,
            If((click_counter == 0) & (click_reset_value > 0),
               click_counter.eq(click_reset_value),
               self.isr[1].eq(1)
            ).Else(
                click_counter.eq(click_counter-1)
            )
        )

        #register io state machine
        self.xltr_oe = Signal()
        self.comb += self.addr_num.eq(self.addr[0:3])
        self.comb += self.register_num.eq(Cat(self.addr_num, 0, self.group_num))
        fsm = FSM(reset_state="IDLE")
        self.submodules += fsm
        fsm.act("IDLE",
                self._dtready.eq(1),
                self.xltr_oe.eq(1),
                If((self._iack == 0) & (self._irq == 0),
                   #enable xltr early
                   self.xltr_oe.eq(0),
                   NextState("IACK")
                ).Elif((self._as == 0) &
                   (self.addr[3:24] == base_addr[3:24]),
                   # enable xltr early
                   self.xltr_oe.eq(0),
                   If(self._lds == 0,
                       If((self._rw == 1),
                           NextState("RDATA"),
                       ).Else(
                           NextState("WDATA"),
                       )
                   )
                )
        )
        fsm.act("IACK",
                self._dtready.eq(0),
                self.data.o.eq(self.ivr),
                If(self._iack == 1,
                   NextState("IDLE")
                )
        )
        fsm.act("RDATA",
                self._dtready.eq(0),
                If(self.addr_num == 0,
                   # irq vector register
                   self.data.o.eq(self.ivr)
                ).Elif(self.addr_num == 2,
                    self.data.o.eq(self.isr)
                ).Else(
                    If(self.register_num == 0x34,
                       self.data.o.eq(0x04)
                    ).Elif(self.register_num == 0x36,
                           self.data.o.eq(0x00)
                    ).Elif(self.register_num == 0x54,
                           self.data.o.eq(self.tsr)
                    ).Elif(self.register_num == 0x64,
                           self.data.o.eq(0xa0)
                    ).Elif(self.register_num == 0x74,
                           self.data.o.eq(0x00)
                    ).Elif(self.register_num == 0x96,
                           self.data.o.eq(0xFF)
                    ).Elif(self.register_num == 0xF5,
                           self.data.o.eq(version_string[self.version_index])
                    )
                ),
                If(self._as == 1,
                   NextState("IDLE")
                )
        )
        fsm.act("WDATA",
                self._dtready.eq(0),
                If(self.addr_num == 0x01,
                   NextValue(self.group_num, self.data.i[0:4]),
                   NextValue(self.ic, self.data.i[7])
                ).Elif(self.addr_num == 0x03,
                      NextValue(self.isr, self.isr & ~self.data.i)
                ).Else(
                    If(self.register_num == 0x04,
                       NextValue(self.ivo, self.data.i[5:8])
                    ).Elif(self.register_num == 0x06,
                           NextValue(self.ier, self.data.i)
                    ).Elif(self.register_num == 0x14,
                           NextValue(self.ase, self.data.i[5])
                    ).Elif(self.register_num == 0x55,
                           NextValue(self.txe, self.data.i[0]),
                           If(self.data.i[2],
                              NextValue(self.txidl, 0)
                           ),
                           NextValue(self.brke, self.data.i[3])
                    ).Elif(self.register_num == 0x56,
                       NextValue(self.fifo.we, 1),
                       NextValue(self.fifo.din, self.data.i),
                       # clear tx empty isr
                       NextValue(self.isr[6], 0)
                    ).Elif(self.register_num == 0x66,
                           NextValue(clkm, self.data.i[1])
                    ).Elif(self.register_num == 0x67,
                           NextValue(click_reset_value, self.data.i[0:7]),
                           If(self.data.i[7],
                              NextValue(click_counter, self.data.i[0:7]),
                           )
                    ).Elif(self.register_num == 0x84,
                           NextValue(gpt_low_byte_cache, self.data.i)
                    ).Elif(self.register_num == 0x85,
                           NextValue(gpt_reset_value, Cat(gpt_low_byte_cache, self.data.i[0:6])),
                           If(self.data.i[7],
                              NextValue(gpt_counter, Cat(gpt_low_byte_cache, self.data.i[0:6]))
                           )
                    ).Elif(self.register_num == 0x86,
                           NextValue(clock_low_byte_cache, self.data.i)
                    ).Elif(self.register_num == 0x87,
                           NextValue(clock_reset_value, Cat(clock_low_byte_cache, self.data.i[0:6])),
                           If(self.data.i[7],
                              NextValue(clock_counter, Cat(clock_low_byte_cache, self.data.i[0:6]))
                           )
                    ).Elif(self.register_num == 0xF4,
                           NextValue(self.version_index, self.data.i)
                    )
                ),
                #only spend one cycle in WDATA
                #so that writes only happen once
                NextState("WWAIT")
        )
        fsm.act("WWAIT",
                self._dtready.eq(0),
                NextValue(self.fifo.we, 0),
                If(self._as == 1,
                   NextState("IDLE")
                )
        )

        #manual resets - the bus FSM cannot be reset during an ic
        #todo: consider using clock domain reset instead
        self.sync += If(self.exreset == 0 | self.ic,
                        self.group_num.eq(0),
                        clkm.eq(0),
                        self.ivo.eq(0),
                        self.ier.eq(0),
                        self.isr.eq(0),
                        self.txe.eq(0),
                        self.brke.eq(0),
                        self.ase.eq(0),
                        gpt_counter.eq(0),
                        gpt_low_byte_cache.eq(0),
                        gpt_reset_value.eq(0),
                        clock_counter.eq(0),
                        clock_low_byte_cache.eq(0),
                        clock_reset_value.eq(0),
                        )

def midi_read(m, reg):
    yield m.addr.eq(base_addr+1)
    yield m._as.eq(0)
    yield m._lds.eq(0)
    yield m._rw.eq(0)
    yield m.data.i.eq(reg >> 4)
    while (yield m._dtready == 1):
        yield
    yield m._as.eq(1)
    yield m._lds.eq(1)
    while (yield m._dtready == 0):
        yield
    yield m._rw.eq(1)
    yield m.addr.eq(base_addr+(reg&0x0F))
    yield m._as.eq(0)
    yield m._lds.eq(0)
    while (yield m._dtready == 1):
        yield
    yield m._as.eq(1)
    yield m._lds.eq(1)
    while (yield m._dtready == 0):
        yield

def midi_write(m, reg, value):
    yield m.addr.eq(base_addr+1)
    yield m._as.eq(0)
    yield m._lds.eq(0)
    yield m._rw.eq(0)
    yield m.data.i.eq(reg >> 4)
    while (yield m._dtready == 1):
        yield
    yield m._as.eq(1)
    yield m._lds.eq(1)
    while (yield m._dtready == 0):
        yield
    yield m._rw.eq(0)
    yield m.data.i.eq(value)
    yield m.addr.eq(base_addr+(reg&0x0F))
    yield m._as.eq(0)
    yield m._lds.eq(0)
    while (yield m._dtready == 1):
        yield
    yield m._as.eq(1)
    yield m._lds.eq(1)
    while (yield m._dtready == 0):
        yield

def midi_wait_empty(m):
    while (yield m.fifo.level > 0):
        yield

def midi_iack(m):
    while (yield m._irq == 1):
        yield
    yield m._iack.eq(0)
    while (yield m._dtready == 1):
        yield
    yield m._iack.eq(1)
    while (yield m._dtready == 0):
        yield

def test(m):
    yield m.addr.eq(0)
    yield m._as.eq(1)
    yield m._lds.eq(1)
    yield m._rw.eq(1)
    yield m._iack.eq(1)
    yield
    assert(yield m._dtready == 1)
    yield m.addr.eq(base_addr)
    yield
    yield m._as.eq(0)
    yield m._lds.eq(0)
    yield
    yield m._as.eq(1)
    yield m._lds.eq(1)
    yield
    assert(yield m._dtready == 0)
    yield
    # test reset
    yield from midi_write(m, 0x06, 0xFF)
    yield
    yield from midi_write(m, 0x01, 0x80)
    yield
    yield from midi_write(m, 0x01, 0x00)
    yield
    assert(yield m.ier == 0x00)
    #configure
    yield from midi_read(m, 0x34)
    yield from midi_read(m, 0x16)
    yield from midi_write(m, 0x04, 0xE0)
    yield from midi_write(m, 0x06, 0x40) #tx irq only
    yield from midi_write(m, 0x55, 0x01)
    for i in range(0,2):
        yield from midi_write(m, 0x56, i)
    assert(yield m.isr == 0x00)
    assert(yield m.vec == 8)
    assert(yield m.fifo.dout == 0x00)
    yield from midi_iack(m)
    yield from midi_wait_empty(m)
    assert(yield m.isr == 0x40)
    assert(yield m.vec == 6)
    yield from midi_write(m, 0xf4, 0x00)
    yield from midi_read(m, 0xf5)
    for i in range(1, 10000):
        yield

if __name__ == "__main__":
    import sys
    if sys.argv[1] == "sim":
        m = Midiori()
        run_simulation(m, test(m), vcd_name="midiori.vcd")
    else:
        plat = midiori_platform.Platform()
        m = Midiori()
        m.comb += m.addr.eq(plat.request("addr"))
        m.comb += m._as.eq(plat.request("as"))
        m.comb += m._lds.eq(plat.request("lds"))
        m.comb += m._rw.eq(plat.request("rw"))
        m.comb += plat.request("dtack").eq(m._dtready)
        m.specials += m.data.get_tristate(plat.request("data"))
        m.comb += plat.request("xltr_oe").eq(m.xltr_oe)
        m.comb += m.data.oe.eq(~plat.request("iddir"))
        m.comb += plat.request("tx").eq(m.tx)
        m.comb += plat.request("irq2").eq(m._irq)
        m.comb += m._iack.eq(plat.request("iack2"))
        m.comb += m.exreset.eq(plat.request("exreset"))
        plat.build(m)
