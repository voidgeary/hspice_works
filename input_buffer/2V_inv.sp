#2V_inv
.lib "C:\synopsys\lib\mm0355v.l" tt_5V

MP out in vdd vdd pch5 l=0.5u w=2.3u
MN out in gnd gnd nch5 l=0.5u w=1.5u

vdd vdd gnd 5V
Vin in gnd dc 1 pulse(0,5,1u,1n,1n,1u,2u)
Cl out gnd 1pf

.dc vin 0,5,0.05
.end