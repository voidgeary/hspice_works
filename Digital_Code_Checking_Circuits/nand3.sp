#nand3
.lib "C:\synopsys\lib\cic018.l" tt

MP1 out A vdd vdd p_18 l=0.5u w=3.5u
MP2 out B vdd vdd p_18 l=0.5u w=3.5u
MP3 out C vdd vdd p_18 l=0.5u w=3.5u

MN1 out A s_1 gnd n_18 l=0.5u w=0.6u
MN2 s_1 B s_2 gnd n_18 l=0.5u w=0.6u
MN3 s_2 C gnd gnd n_18 l=0.5u w=0.6u

vdd vdd gnd 1.8V
Va A gnd dc 1 pulse(0,1.8,1u,1n,1n,1u,2u)
Vb B gnd dc 1 pulse(0,1.8,2u,1n,1n,2u,4u)
Vc C gnd dc 1 pulse(0,1.8,4u,1n,1n,4u,8u)
Cl out gnd 1pf

.options post=2
.tran 10n 20u
.end