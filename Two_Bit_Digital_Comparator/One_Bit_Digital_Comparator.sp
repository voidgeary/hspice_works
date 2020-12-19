#OBDC
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

X1 A iA inv
X2 B iB inv

X3 A iB s nor2  *smaller
X4 B iA l nor2  *larger
X5 s l  e nor2  *equal

Vdd vdd gnd dc 1.8
V1 A GND PULSE ( 0V 1.8V 2u 1u 1u 9u 20u ) 
V2 B GND PULSE ( 0V 1.8V 2u 1u 1u 19u 40u ) 
*Va A gnd pulse(0,1.8,1u,1n,1n,1u,2u)
*Vb B gnd pulse(0,1.8,2u,1n,1n,2u,4u)

Cl s gnd 0.1pf
C2 e gnd 0.1pf
C3 l gnd 0.1pf

.option post=2
.tran 10u 40u
.end