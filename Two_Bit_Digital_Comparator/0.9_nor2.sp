#0.9V_nor2
.lib "C:\synopsys\lib\cic018.l" tt

MP1 s_1 A vdd vdd p_18 l=0.5u w=3.5u
MP2 out B s_1 vdd p_18 l=0.5u w=3.5u

MN1 out A gnd gnd n_18 l=0.5u w=0.6u
MN2 out B gnd gnd n_18 l=0.5u w=0.6u

vdd vdd gnd 1.8V
Va A gnd pulse(0,1.8,1u,1n,1n,1u,2u)
Vb B gnd pulse(0,1.8,2u,1n,1n,2u,4u)
Cl out gnd 1pf

.option post=2
.tran 10n 40u
.end