#0.9V_inv
.lib "C:\synopsys\lib\cic018.l" tt

*MP1 out in vdd vdd p_18 l=0.18u w=0.82u
*MN1 out in gnd gnd n_18 l=0.18u w=0.18u

MP1 out in vdd vdd p_18 l=0.18u w=1.64u
MN1 out in gnd gnd n_18 l=0.18u w=0.4u

vdd vdd gnd 1.8V
Vin in gnd pulse(0,1.8,1u,1n,1n,1u,2u)
Cl out gnd 1pf


.dc vin 0,1.8,0.05
.end