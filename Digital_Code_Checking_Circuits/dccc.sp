#DCCC
.lib "C:\synopsys\lib\cic018.l" tt
.global vdd gnd

*0.9V_inv
.subckt inv in out 
MP1 out in vdd vdd p_18 l=0.5u w=3.5u
MN1 out in gnd gnd n_18 l=0.5u w=0.6u
.ends inv

*0.9V_nand3
.subckt nand3 A B C out
MP1 out A vdd vdd p_18 l=0.5u w=3.5u
MP2 out B vdd vdd p_18 l=0.5u w=3.5u
MP3 out C vdd vdd p_18 l=0.5u w=3.5u

MN1 out A s_1 gnd n_18 l=0.5u w=0.6u
MN2 s_1 B s_2 gnd n_18 l=0.5u w=0.6u
MN3 s_2 C gnd gnd n_18 l=0.5u w=0.6u
.ends nand3

*0.9V_nand2
.subckt nand2 A B out
MP1 out A vdd vdd p_18 l=0.5u w=3.5u
MP2 out B vdd vdd p_18 l=0.5u w=3.5u

MN1 out A s_1 gnd n_18 l=0.5u w=0.6u
MN2 s_1 B gnd gnd n_18 l=0.5u w=0.6u
.ends nand2

*dff
.subckt dff CLK D RESET Q
X1 CLK iCLK inv
X2 RESET iRESET inv

X3 n4  n2    n1  nand2
X4 n1  iCLK  iRESET  n2  nand3
X5 n2  iCLK  n4      n3  nand3
X6 n3  D     iRESET  n4  nand3

X7 n2  n6    Q   nand2
X8 Q   n3    iRESET  n6  nand3
.ends dff

.subckt dccc CLK RESET Vi Vo
* Subcircuit Body
X1 CLK Ad RESET A dff
X2 CLK Bd RESET B dff
X3 CLK Cd RESET C dff

X4 A iC Vi Ain1 nand3
X5 B C iVi Ain2 nand3
X6 Ain1 Ain2 Ad nand2

X7 B iC Vi Bin1 nand3
X8 iB C Vi Bin2 nand3
X9 Bin1 Bin2 Bd nand2

X10 B iC Cin2 nand2
X11 iB iVi Cin3 nand2
X12 iA Cin2 Cin3 Cd nand3

X13 A iA inv
X14 B iB inv
X15 C iC inv
X16 Vi iVi inv

X17 A C iVo nand2
X18 iVo Vo inv
.ends dccc

VGND GND 0v DC 0v
VVDD VDD GND DC 1.8V

XDCCC CLK RESET Vi Vo DCCC
V1 Vi GND pulse(0V 1.8V 5u 0.1u 0.1u 10u 15u)
V2 CLK GND pulse(0V 1.8V 3u 0.1u 0.1u 5u 10u)
V3 RESET GND pulse(0V 1.8V 10u 0.1u 0.1u 2u 100u)

.MEAS TRAN PMax AVG Power From = 0us To 140us 

.temp 0
.options accurate=0 post=1
.tran 0.01u 140u
.alter
.lib 'C:\synopsys\lib\cic018.l' FF
.temp 20
.alter
.lib 'C:\synopsys\lib\cic018.l' SS
.temp 75
.end 