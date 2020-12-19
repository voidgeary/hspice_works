
.lib "C:\synopsys\lib\cic018.l" tt
MP out in vdd vdd P_18 l=0.18u w=3.58u
MN out in gnd gnd N_18 l=0.18u w=0.54u
Vin in gnd dc 1 pulse(0,3.3,1u,1n,1n,1u,2u)
Cl out gnd 1pf
vdd vdd gnd 3.3V
.dc vin 0,3.3,0.05
.TRAN 10n 10us
.end