#output_stage1
.lib "C:\synopsys\lib\cic018.l" tt
.global vdd gnd

.subckt output_stage1 GP GN out
MP1_P in1P GP vdd vdd p_18 l=0.18u w=1.64u m=m1
MN1_P in1P GP gnd gnd n_18 l=0.18u w=0.4u m=m1

MP1_N in1N GN vdd vdd p_18 l=0.18u w=1.64u m=m1
MN1_N in1N GN gnd gnd n_18 l=0.18u w=0.4u m=m1

MP2_P in2P in1P vdd vdd p_18 l=0.18u w=1.64u m=m2
MN2_P in2P in1P gnd gnd n_18 l=0.18u w=0.4u m=m2

MP2_N in2N in1N vdd vdd p_18 l=0.18u w=1.64u m=m2
MN2_N in2N in1N gnd gnd n_18 l=0.18u w=0.4u m=m2

MP1 out in2P vdd vdd p_18 l=0.18u w=0.82u m=m3
MN1 out in2N gnd gnd n_18 l=0.18u w=0.18u m=m3
.ends output_stage1

X1 in in out output_stage1

vdd vdd gnd 1.8V
Vin in gnd pulse(0,1.8,1u,1n,1n,1u,2u)
Cl out gnd 1pf

.param m1=5 m2=25 m3=125
.dc vin 0,1.8,0.05
.end