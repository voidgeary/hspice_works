
.lib "C:\synopsys\lib\mm0355v.l" tt_5V

MP out in vdd vdd pch5 l=0.5u w=1.5u
MN out in gnd gnd nch5 l=0.5u w=3.5u

Vin in gnd dc 1 pulse(0,5,1u,1n,1n,1u,2u)
Cl out gnd 1pf
vdd vdd gnd 5V

.dc vin 0,2.8,0.05
.TRAN 10n 10us
.end