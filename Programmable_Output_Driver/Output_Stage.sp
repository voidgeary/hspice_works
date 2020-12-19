#output_stage
.lib "C:\synopsys\lib\cic018.l" tt
.global vdd gnd

MP1 out GP vdd vdd p_18 l=0.18u w=0.82u m=3
MN1 out GN gnd gnd n_18 l=0.18u w=0.18u m=3

vdd vdd gnd 1.8V
Va GP gnd pulse(0,1.8,1u,1n,1n,1u,2u)
Vb GN gnd pulse(0,1.8,2u,1n,1n,2u,4u)
C1 out gnd 1pf

.tran 10n 40u
.end