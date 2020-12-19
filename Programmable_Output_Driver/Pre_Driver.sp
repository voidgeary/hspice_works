#pre_driver
.lib "C:\synopsys\lib\cic018.l" tt
.global vdd gnd

.subckt inv in out
MP1 out in vdd vdd p_18 l=0.18u w=0.82u
MN1 out in gnd gnd n_18 l=0.18u w=0.18u
.ends inv

.subckt nor2 A B out
MP1 s_1 A vdd vdd p_18 l=0.18u w=0.82u
MP2 out B s_1 vdd p_18 l=0.18u w=0.82u

MN1 out A gnd gnd n_18 l=0.18u w=0.18u
MN2 out B gnd gnd n_18 l=0.18u w=0.18u
.ends nor2

.subckt nand2 A B out
MP1 out A vdd vdd p_18 l=0.18u w=0.82u
MP2 out B vdd vdd p_18 l=0.18u w=0.82u

MN1 out A s_1 gnd n_18 l=0.18u w=0.18u
MN2 s_1 B gnd gnd n_18 l=0.18u w=0.18u
.ends nand2


X1 IN E GP nand2
X2 E iE inv
X3 IN iE GN nor2

vdd vdd gnd 1.8V
Va IN gnd pulse(0,1.8,1u,1n,1n,1u,2u)
Vb E gnd pulse(0,1.8,2u,1n,1n,2u,4u)
Cl GP gnd 1pf
C2 GN gnd 1pf

.tran 10n 40u
.end