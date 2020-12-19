#0.9V_nor2
.lib "C:\synopsys\lib\cic018.l" tt

MP1 s_1 A vdd vdd p_18 l=0.18u w=0.82u
MP2 out B s_1 vdd p_18 l=0.18u w=0.82u

MN1 out A gnd gnd n_18 l=0.18u w=0.18u
MN2 out B gnd gnd n_18 l=0.18u w=0.18u

vdd vdd gnd 1.8V
Va A gnd pulse(0,1.8,1u,1n,1n,1u,2u)
Vb B gnd pulse(0,1.8,2u,1n,1n,2u,4u)
Cl out gnd 1pf

.option post=2
.tran 10n 40u
.end