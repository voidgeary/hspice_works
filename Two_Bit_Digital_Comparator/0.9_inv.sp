#0.9V_inv
.lib "C:\synopsys\lib\cic018.l" tt

MP1 out in vdd vdd p_18 l=0.5u w=3.5u
MN1 out in gnd gnd n_18 l=0.5u w=0.6u

vdd vdd gnd 1.8V
Vin in gnd pulse(0,1.8,1u,1n,1n,1u,2u)
Cl out gnd 1pf

.option post=2
.tran 10u 20u
.dc vin 0,1.8,0.05
.end