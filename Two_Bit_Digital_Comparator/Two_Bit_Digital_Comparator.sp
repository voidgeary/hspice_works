#TBDC
.lib "C:\synopsys\lib\cic018.l" tt
.global vdd gnd

*0.9V_inv
.subckt inv in out
MP1 out in vdd vdd p_18 l=0.5u w=3.5u
MN1 out in gnd gnd n_18 l=0.5u w=0.6u
.ends inv

*0.9V_nor2
.subckt nor2 A B out
MP1 s_1 A vdd vdd p_18 l=0.5u w=3.5u
MP2 out B s_1 vdd p_18 l=0.5u w=3.5u

MN1 out A gnd gnd n_18 l=0.5u w=0.6u
MN2 out B gnd gnd n_18 l=0.5u w=0.6u
.ends nor2

*OBDC
.subckt OBDC A B s e l
X1 A iA inv
X2 B iB inv

X3 A iB s nor2  *smaller
X4 B iA l nor2  *larger
X5 s l  e nor2  *equal
.ends OBDC

*nor_and2
.subckt and2 A B out
X1 A iA inv
X2 B iB inv

X3 iA iB out nor2
.ends and2

*nor_or2
.subckt or2 A B out
X1 A B iA_B nor2
X2 iA_B out inv
.ends or2

.subckt TBDC  X0 X1 XEqualY XLargeY XSmallY Y0 Y1
* Subcircuit Body
.ends TBDC
*one_bit
X1 X1 Y1 s1 e1 l1 OBDC
X2 X0 Y0 s0 e0 l0 OBDC
*A < B
X3 e1 s0  Xes and2
X4 s1 Xes XSmallY or2
*A = B
X5 e1 e0 XEqualY and2
*A > B
X6 e1 l0  Xel and2
X7 l1 Xel XLargeY or2

C1 XSmallY GND 0.1pf
C2 XEqualY GND 0.1pf
C3 XLargeY GND 0.1pf

VGND GND 0v DC 0v
VVDD VDD GND DC 1.8V

XTBDC X0 X1 XEqualY XLargeY XSmallY Y0 Y1 TBDC 

V1 X0 GND PULSE ( 0V 1.8V 2u 1u 1u 9u 20u )
V2 X1 GND PULSE ( 0V 1.8V 2u 1u 1u 19u 40u )
V3 Y0 GND PULSE ( 0V 1.8V 2u 1u 1u 39u 80u )
V4 Y1 GND PULSE ( 0V 1.8V 2u 1u 1u 79u 160u )
.MEAS TRAN Pmax AVG Power From = 2us To 162us
.temp 27
.options accurate=0 post=2
.tran 0.01u 162u
.end