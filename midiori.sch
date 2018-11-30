EESchema Schematic File Version 4
LIBS:midiori-cache
EELAYER 26 0
EELAYER END
$Descr USLedger 17000 11000
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L x68k:x68000_expansion J?
U 1 1 5BFF029F
P 2150 -1050
F 0 "J?" H 2206 -75 50  0000 C CNN
F 1 "x68000_expansion" H 2206 -166 50  0000 C CNN
F 2 "" H 1750 -150 50  0001 C CNN
F 3 "" H 1750 -150 50  0001 C CNN
	1    2150 -1050
	1    0    0    -1  
$EndComp
Text Label 1250 7950 2    50   ~ 0
DB0
Text Label 1250 7850 2    50   ~ 0
DB1
Text Label 1250 7750 2    50   ~ 0
DB2
Text Label 1250 7650 2    50   ~ 0
DB3
Text Label 1250 7550 2    50   ~ 0
DB4
Text Label 1250 7450 2    50   ~ 0
DB5
Text Label 1250 7350 2    50   ~ 0
DB6
Text Label 1250 7150 2    50   ~ 0
DB7
Text Label 2300 3750 0    50   ~ 0
AB1
Text Label 2300 3850 0    50   ~ 0
AB2
Text Label 2300 3950 0    50   ~ 0
AB3
Text Label 2300 4050 0    50   ~ 0
AB4
Text Label 2300 4150 0    50   ~ 0
AB5
Text Label 2300 4250 0    50   ~ 0
AB6
Text Label 2300 4450 0    50   ~ 0
AB7
Text Label 2300 4550 0    50   ~ 0
AB8
Text Label 2300 4650 0    50   ~ 0
AB9
Text Label 2300 4750 0    50   ~ 0
AB10
Text Label 2300 4850 0    50   ~ 0
AB11
Text Label 2300 4950 0    50   ~ 0
AB12
Text Label 2300 5050 0    50   ~ 0
AB13
Text Label 2300 5150 0    50   ~ 0
AB14
Text Label 2300 5250 0    50   ~ 0
AB15
Text Label 2300 5450 0    50   ~ 0
A16
Text Label 2300 5550 0    50   ~ 0
A17
Text Label 2300 5650 0    50   ~ 0
A18
Text Label 2300 5750 0    50   ~ 0
A19
Text Label 2300 5850 0    50   ~ 0
A20
Text Label 2300 5950 0    50   ~ 0
A21
Text Label 2300 6050 0    50   ~ 0
A22
Text Label 2300 6150 0    50   ~ 0
A23
Wire Wire Line
	2300 8150 2450 8150
Wire Wire Line
	2450 8150 2450 8250
Wire Wire Line
	2450 8250 2300 8250
$Comp
L power:+5V #PWR?
U 1 1 5BFF1288
P 2450 8150
F 0 "#PWR?" H 2450 8000 50  0001 C CNN
F 1 "+5V" H 2465 8323 50  0000 C CNN
F 2 "" H 2450 8150 50  0001 C CNN
F 3 "" H 2450 8150 50  0001 C CNN
	1    2450 8150
	1    0    0    -1  
$EndComp
Connection ~ 2450 8150
Wire Wire Line
	1250 3450 1000 3450
Wire Wire Line
	1000 3450 1000 3350
Wire Wire Line
	1000 3350 1250 3350
$Comp
L power:+5V #PWR?
U 1 1 5BFF12FF
P 1000 3350
F 0 "#PWR?" H 1000 3200 50  0001 C CNN
F 1 "+5V" H 1015 3523 50  0000 C CNN
F 2 "" H 1000 3350 50  0001 C CNN
F 3 "" H 1000 3350 50  0001 C CNN
	1    1000 3350
	1    0    0    -1  
$EndComp
Connection ~ 1000 3350
Wire Wire Line
	2300 3350 2700 3350
Wire Wire Line
	2700 3350 2700 4350
Wire Wire Line
	2700 4350 2300 4350
Wire Wire Line
	2700 4350 2700 5350
Wire Wire Line
	2700 5350 2300 5350
Connection ~ 2700 4350
Wire Wire Line
	2300 7350 2700 7350
Wire Wire Line
	2700 7350 2700 5350
Connection ~ 2700 5350
Wire Wire Line
	1250 8250 900  8250
Wire Wire Line
	900  8250 900  8050
Wire Wire Line
	900  8050 1250 8050
Wire Wire Line
	900  8050 900  7250
Wire Wire Line
	900  7250 1250 7250
Connection ~ 900  8050
Wire Wire Line
	900  7250 900  6250
Wire Wire Line
	900  6250 1250 6250
Connection ~ 900  7250
Wire Wire Line
	900  6250 900  4250
Wire Wire Line
	900  4250 1250 4250
Connection ~ 900  6250
$Comp
L power:GND #PWR?
U 1 1 5BFF1D46
P 2700 7350
F 0 "#PWR?" H 2700 7100 50  0001 C CNN
F 1 "GND" H 2705 7177 50  0000 C CNN
F 2 "" H 2700 7350 50  0001 C CNN
F 3 "" H 2700 7350 50  0001 C CNN
	1    2700 7350
	1    0    0    -1  
$EndComp
Connection ~ 2700 7350
$Comp
L power:GND #PWR?
U 1 1 5BFF1DB3
P 900 8250
F 0 "#PWR?" H 900 8000 50  0001 C CNN
F 1 "GND" H 905 8077 50  0000 C CNN
F 2 "" H 900 8250 50  0001 C CNN
F 3 "" H 900 8250 50  0001 C CNN
	1    900  8250
	1    0    0    -1  
$EndComp
Connection ~ 900  8250
$Comp
L 74xx:74LS245 U1
U 1 1 5BFE4DDF
P 4550 6850
F 0 "U1" H 4550 7828 50  0000 C CNN
F 1 "74LS245" H 4550 7737 50  0000 C CNN
F 2 "" H 4550 6850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS245" H 4550 6850 50  0001 C CNN
	1    4550 6850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5BFE4F30
P 4550 6050
F 0 "#PWR?" H 4550 5900 50  0001 C CNN
F 1 "+5V" H 4565 6223 50  0000 C CNN
F 2 "" H 4550 6050 50  0001 C CNN
F 3 "" H 4550 6050 50  0001 C CNN
	1    4550 6050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5BFE4F97
P 4550 7650
F 0 "#PWR?" H 4550 7400 50  0001 C CNN
F 1 "GND" H 4555 7477 50  0000 C CNN
F 2 "" H 4550 7650 50  0001 C CNN
F 3 "" H 4550 7650 50  0001 C CNN
	1    4550 7650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 6250 3650 6250
Text Label 4050 6350 2    50   ~ 0
DB7
Text Label 4050 6450 2    50   ~ 0
DB6
Text Label 4050 6550 2    50   ~ 0
DB5
Text Label 4050 6650 2    50   ~ 0
DB4
Text Label 4050 6750 2    50   ~ 0
DB3
Text Label 4050 6850 2    50   ~ 0
DB2
Text Label 4050 6950 2    50   ~ 0
DB1
Text Label 4050 7050 2    50   ~ 0
DB0
$Comp
L 74xx:74LS133 U3
U 1 1 5BFE5824
P 4650 4150
F 0 "U3" H 4650 4975 50  0000 C CNN
F 1 "74LS133" H 4650 4884 50  0000 C CNN
F 2 "" H 4650 4150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS133" H 4650 4150 50  0001 C CNN
	1    4650 4150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS133 U?
U 2 1 5BFE5AAA
P 3650 1300
F 0 "U?" H 3880 1346 50  0000 L CNN
F 1 "74LS133" H 3880 1255 50  0000 L CNN
F 2 "" H 3650 1300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS133" H 3650 1300 50  0001 C CNN
	2    3650 1300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS133 U2
U 1 1 5BFE5C09
P 3850 3550
F 0 "U2" H 3850 4375 50  0000 C CNN
F 1 "74LS133" H 3850 4284 50  0000 C CNN
F 2 "" H 3850 3550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS133" H 3850 3550 50  0001 C CNN
	1    3850 3550
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS133 U?
U 2 1 5BFE5CB5
P 4650 1300
F 0 "U?" H 4880 1346 50  0000 L CNN
F 1 "74LS133" H 4880 1255 50  0000 L CNN
F 2 "" H 4650 1300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS133" H 4650 1300 50  0001 C CNN
	2    4650 1300
	1    0    0    -1  
$EndComp
Text Label 3550 2950 2    50   ~ 0
AB5
Text Label 3550 3050 2    50   ~ 0
AB6
Text Label 3550 3150 2    50   ~ 0
AB4
Text Label 3550 3250 2    50   ~ 0
AB8
Text Label 3550 3350 2    50   ~ 0
AB7
Text Label 3550 4150 2    50   ~ 0
AB10
Text Label 3550 4050 2    50   ~ 0
AB20
Text Label 3550 3950 2    50   ~ 0
AB16
Text Label 3550 3850 2    50   ~ 0
AB18
Wire Wire Line
	3550 3450 3550 3550
Wire Wire Line
	3550 3650 3550 3550
Connection ~ 3550 3550
Wire Wire Line
	3550 3750 3550 3650
Connection ~ 3550 3650
$Comp
L power:GND #PWR?
U 1 1 5BFE694A
P 3200 3750
F 0 "#PWR?" H 3200 3500 50  0001 C CNN
F 1 "GND" H 3205 3577 50  0000 C CNN
F 2 "" H 3200 3750 50  0001 C CNN
F 3 "" H 3200 3750 50  0001 C CNN
	1    3200 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 3750 3200 3750
Connection ~ 3550 3750
Wire Wire Line
	4150 3550 4350 3550
$Comp
L power:+5V #PWR?
U 1 1 5BFE7542
P 4250 3400
F 0 "#PWR?" H 4250 3250 50  0001 C CNN
F 1 "+5V" H 4265 3573 50  0000 C CNN
F 2 "" H 4250 3400 50  0001 C CNN
F 3 "" H 4250 3400 50  0001 C CNN
	1    4250 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 3400 4250 3650
Wire Wire Line
	4250 3650 4350 3650
Text Label 4350 3750 2    50   ~ 0
AB21
Text Label 4350 3850 2    50   ~ 0
AB22
Text Label 4350 3950 2    50   ~ 0
AB19
Text Label 4350 4050 2    50   ~ 0
AB17
Text Label 4350 4250 2    50   ~ 0
AB15
Text Label 4350 4350 2    50   ~ 0
AB14
Text Label 4350 4450 2    50   ~ 0
AB13
Text Label 4350 4550 2    50   ~ 0
AB12
Text Label 4350 4650 2    50   ~ 0
AB11
Text Label 4350 4750 2    50   ~ 0
AB9
Text Label 1250 5750 2    50   ~ 0
A
Text Label 1250 5850 2    50   ~ 0
B
Text Label 1250 5950 2    50   ~ 0
C
$Comp
L 74xx:74LS08 U4
U 1 1 5BFE84F1
P 3600 4650
F 0 "U4" H 3600 4975 50  0000 C CNN
F 1 "74LS08" H 3600 4884 50  0000 C CNN
F 2 "" H 3600 4650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 3600 4650 50  0001 C CNN
	1    3600 4650
	1    0    0    -1  
$EndComp
Text Label 3300 4750 2    50   ~ 0
AB23
Text Label 3300 4550 2    50   ~ 0
A
Wire Wire Line
	3900 4650 4050 4650
Wire Wire Line
	4050 4650 4050 4150
Wire Wire Line
	4050 4150 4350 4150
$Comp
L 74xx:74LS08 U4
U 2 1 5BFE8E6E
P 3600 5150
F 0 "U4" H 3600 5475 50  0000 C CNN
F 1 "74LS08" H 3600 5384 50  0000 C CNN
F 2 "" H 3600 5150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 3600 5150 50  0001 C CNN
	2    3600 5150
	1    0    0    -1  
$EndComp
Text Label 3300 5050 2    50   ~ 0
IACK4
Text Label 3300 5250 2    50   ~ 0
IACK2
$Comp
L 74xx:74LS08 U4
U 3 1 5BFE9128
P 5350 4700
F 0 "U4" H 5350 5025 50  0000 C CNN
F 1 "74LS08" H 5350 4934 50  0000 C CNN
F 2 "" H 5350 4700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS08" H 5350 4700 50  0001 C CNN
	3    5350 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 5150 4300 5150
Wire Wire Line
	4300 5150 4300 4800
Wire Wire Line
	4300 4800 4800 4800
Wire Wire Line
	4800 4800 4800 4600
Wire Wire Line
	4800 4600 5050 4600
Wire Wire Line
	4950 4150 4950 4800
Wire Wire Line
	4950 4800 5050 4800
$Comp
L 74xx:74LS157 U15
U 1 1 5BFEAE46
P 6750 3100
F 0 "U15" H 6850 3900 50  0000 C CNN
F 1 "74LS157" H 6950 4050 50  0000 C CNN
F 2 "" H 6750 3100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 6750 3100 50  0001 C CNN
	1    6750 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 2500 6050 2500
Wire Wire Line
	6050 2500 6050 2800
Wire Wire Line
	6050 2800 6250 2800
Wire Wire Line
	6250 3400 6050 3400
Wire Wire Line
	6050 3400 6050 3200
Connection ~ 6050 2800
Wire Wire Line
	6250 3100 6050 3100
Connection ~ 6050 3100
Wire Wire Line
	6050 3100 6050 2800
Wire Wire Line
	6250 3200 6050 3200
Connection ~ 6050 3200
Wire Wire Line
	6050 3200 6050 3100
Wire Wire Line
	6050 3800 6050 3400
Wire Wire Line
	6250 3800 6050 3800
Connection ~ 6050 3400
Wire Wire Line
	6750 4100 6400 4100
Wire Wire Line
	6050 4100 6050 3800
Connection ~ 6050 3800
$Comp
L power:GND #PWR?
U 1 1 5BFEE368
P 6400 4100
F 0 "#PWR?" H 6400 3850 50  0001 C CNN
F 1 "GND" H 6405 3927 50  0000 C CNN
F 2 "" H 6400 4100 50  0001 C CNN
F 3 "" H 6400 4100 50  0001 C CNN
	1    6400 4100
	1    0    0    -1  
$EndComp
Connection ~ 6400 4100
Wire Wire Line
	6400 4100 6050 4100
$Comp
L power:+5V #PWR?
U 1 1 5BFEE4D3
P 6750 2200
F 0 "#PWR?" H 6750 2050 50  0001 C CNN
F 1 "+5V" H 6750 2350 50  0000 C CNN
F 2 "" H 6750 2200 50  0001 C CNN
F 3 "" H 6750 2200 50  0001 C CNN
	1    6750 2200
	1    0    0    -1  
$EndComp
Text Label 6250 2600 2    50   ~ 0
AB1
Text Label 6250 2900 2    50   ~ 0
AB2
Text Label 6250 3500 2    50   ~ 0
AB3
$Comp
L 74xx:74LS10 U9
U 1 1 5BFEF576
P 5550 3700
F 0 "U9" H 5550 4025 50  0000 C CNN
F 1 "74LS10" H 5550 3934 50  0000 C CNN
F 2 "" H 5550 3700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS10" H 5550 3700 50  0001 C CNN
	1    5550 3700
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS10 U?
U 4 1 5BFEF61C
P 5800 1350
F 0 "U?" H 6030 1396 50  0000 L CNN
F 1 "74LS10" H 6030 1305 50  0000 L CNN
F 2 "" H 5800 1350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS10" H 5800 1350 50  0001 C CNN
	4    5800 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 3700 6250 3700
Text Label 5250 3600 2    50   ~ 0
C
Text Label 5250 3700 2    50   ~ 0
B
Text Label 5250 3800 2    50   ~ 0
A
$Comp
L 74xx:74LS32 U7
U 4 1 5BFF0D2A
P 6450 4850
F 0 "U7" H 6450 5175 50  0000 C CNN
F 1 "74LS32" H 6450 5084 50  0000 C CNN
F 2 "" H 6450 4850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 6450 4850 50  0001 C CNN
	4    6450 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 4700 5650 4700
Wire Wire Line
	6150 4950 5700 4950
Wire Wire Line
	5700 4950 5700 4700
Text Label 5900 5050 2    50   ~ 0
AS
$Comp
L x68k:ym3802-x U6
U 1 1 5BFF5246
P 8100 4850
F 0 "U6" H 8400 5015 50  0000 C CNN
F 1 "ym3802-x" H 8400 4924 50  0000 C CNN
F 2 "" H 8100 4850 50  0001 C CNN
F 3 "" H 8100 4850 50  0001 C CNN
	1    8100 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 6350 8000 6350
Wire Wire Line
	5050 6450 8000 6450
Wire Wire Line
	5050 6550 8000 6550
Wire Wire Line
	8000 4950 8000 2500
Wire Wire Line
	8000 2500 7250 2500
Wire Wire Line
	8000 5050 7900 5050
Wire Wire Line
	7900 5050 7900 2800
Wire Wire Line
	7900 2800 7250 2800
Wire Wire Line
	8000 5150 7800 5150
Wire Wire Line
	7800 5150 7800 3400
Wire Wire Line
	7800 3400 7250 3400
$Comp
L power:+5V #PWR?
U 1 1 5BFFC272
P 7600 5150
F 0 "#PWR?" H 7600 5000 50  0001 C CNN
F 1 "+5V" H 7615 5323 50  0000 C CNN
F 2 "" H 7600 5150 50  0001 C CNN
F 3 "" H 7600 5150 50  0001 C CNN
	1    7600 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 5150 7600 5350
Wire Wire Line
	7600 5350 8000 5350
Wire Wire Line
	6750 4850 7500 4850
Wire Wire Line
	7500 4850 7500 5550
Wire Wire Line
	7500 5550 8000 5550
$Comp
L 74xx:74LS32 U7
U 3 1 5BFFEC84
P 7050 5400
F 0 "U7" H 7050 5725 50  0000 C CNN
F 1 "74LS32" H 7050 5634 50  0000 C CNN
F 2 "" H 7050 5400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 7050 5400 50  0001 C CNN
	3    7050 5400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS32 U7
U 2 1 5BFFEDB4
P 7050 5950
F 0 "U7" H 7050 6275 50  0000 C CNN
F 1 "74LS32" H 7050 6184 50  0000 C CNN
F 2 "" H 7050 5950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS32" H 7050 5950 50  0001 C CNN
	2    7050 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7350 5400 7350 5750
Wire Wire Line
	7350 5750 8000 5750
Wire Wire Line
	7350 5950 8000 5950
$Comp
L 74xx_IEEE:7407 U14
U 4 1 5C008A84
P 5650 6000
F 0 "U14" H 5650 6466 50  0000 C CNN
F 1 "7407" H 5650 6375 50  0000 C CNN
F 2 "" H 5650 6000 50  0001 C CNN
F 3 "" H 5650 6000 50  0001 C CNN
	4    5650 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 6000 6200 6150
Wire Wire Line
	6200 6150 8000 6150
$Comp
L Device:R R4
U 1 1 5C00A856
P 6200 5850
F 0 "R4" H 6270 5896 50  0000 L CNN
F 1 "10K" H 6270 5805 50  0000 L CNN
F 2 "" V 6130 5850 50  0001 C CNN
F 3 "~" H 6200 5850 50  0001 C CNN
	1    6200 5850
	1    0    0    -1  
$EndComp
Connection ~ 6200 6000
$Comp
L power:+5V #PWR?
U 1 1 5C00A939
P 6200 5700
F 0 "#PWR?" H 6200 5550 50  0001 C CNN
F 1 "+5V" H 6215 5873 50  0000 C CNN
F 2 "" H 6200 5700 50  0001 C CNN
F 3 "" H 6200 5700 50  0001 C CNN
	1    6200 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 6250 3650 7250
Wire Wire Line
	3650 7250 4050 7250
Text Label 5100 6000 2    50   ~ 0
EXRESET
$Comp
L 74xx:74LS04 U8
U 1 1 5C01222B
P 5750 5300
F 0 "U8" H 5750 5617 50  0000 C CNN
F 1 "74LS04" H 5750 5526 50  0000 C CNN
F 2 "" H 5750 5300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 5750 5300 50  0001 C CNN
	1    5750 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 5300 6450 5300
Wire Wire Line
	6450 5300 6450 6050
Wire Wire Line
	6450 6050 6750 6050
Wire Wire Line
	6750 5500 6750 5850
Text Label 6750 5500 2    50   ~ 0
LDS
Wire Wire Line
	6750 5300 6750 5100
Wire Wire Line
	6750 5100 5450 5100
Wire Wire Line
	5450 5100 5450 5300
Text Label 5450 5100 2    50   ~ 0
RW
$Comp
L Oscillator:CXO_DIP8 X1
U 1 1 5C01CB41
P 4050 10000
F 0 "X1" H 4391 10046 50  0000 L CNN
F 1 "CXO_DIP8" H 4391 9955 50  0000 L CNN
F 2 "Oscillator:Oscillator_DIP-8" H 4500 9650 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 3950 10000 50  0001 C CNN
	1    4050 10000
	1    0    0    -1  
$EndComp
$Comp
L Oscillator:CXO_DIP8 X2
U 1 1 5C01D210
P 7000 10050
F 0 "X2" H 7341 10096 50  0000 L CNN
F 1 "CXO_DIP8" H 7341 10005 50  0000 L CNN
F 2 "Oscillator:Oscillator_DIP-8" H 7450 9700 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/OSZI.pdf" H 6900 10050 50  0001 C CNN
	1    7000 10050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 6650 8000 6650
Wire Wire Line
	5050 6750 8000 6750
Wire Wire Line
	5050 6850 8000 6850
Wire Wire Line
	5050 6950 8000 6950
Wire Wire Line
	5050 7050 8000 7050
Text Label 1250 4650 2    50   ~ 0
EXRESET
Text Label 1250 4750 2    50   ~ 0
DTACK
Text Label 1250 5350 2    50   ~ 0
RW
Text Label 1250 5550 2    50   ~ 0
LDS
Text Label 1250 5650 2    50   ~ 0
AS
Text Label 3000 6250 0    50   ~ 0
IDDIR
Text Label 2300 3550 0    50   ~ 0
10MHz
Text Label 2300 7450 0    50   ~ 0
IRQ2
Text Label 2300 7550 0    50   ~ 0
IRQ4
Text Label 2300 7650 0    50   ~ 0
IACK2
Text Label 2300 7750 0    50   ~ 0
IACK4
$EndSCHEMATC
