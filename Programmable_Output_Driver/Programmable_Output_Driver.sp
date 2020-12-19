#Programmable_Output_Driver 
.lib "C:\synopsys\lib\cic018.l" tt
.global vdd gnd

.subckt inv in out
MP1 out in vdd vdd p_18 l=0.18u w=0.82u
MN1 out in gnd gnd n_18 l=0.18u w=0.18u
.ends inv

.subckt nor2 A B out
MP1 s_1 A vdd vdd p_18 l=0.18u w=0.88u
MP2 out B s_1 vdd p_18 l=0.18u w=0.88u

MN1 out A gnd gnd n_18 l=0.18u w=0.18u
MN2 out B gnd gnd n_18 l=0.18u w=0.18u
.ends nor2

.subckt nand2 A B out
MP1 out A vdd vdd p_18 l=0.18u w=0.56u
MP2 out B vdd vdd p_18 l=0.18u w=0.56u

MN1 out A s_1 gnd n_18 l=0.18u w=0.18u
MN2 s_1 B gnd gnd n_18 l=0.18u w=0.18u
.ends nand2

.subckt decoder S0 S1 E0 E1 E2
X1 S0 S1 E0 nor2
V1 E1 S1 0
V2 E2 S0 0
.ends decoder

.subckt pre_driver IN E GP GN
X1 IN E GP nand2
X2 E iE inv
X3 IN iE GN nor2
.ends pre_driver

.subckt output_stage1 GP GN out
MP1 out GP vdd vdd p_18 l=0.18u w=0.55u m=100
MN1 out GN gnd gnd n_18 l=0.18u w=0.18u m=100
.ends output_stage1

.subckt output_stage2 GP GN out
MP1 out GP vdd vdd p_18 l=0.18u w=0.9u m=125
MN1 out GN gnd gnd n_18 l=0.18u w=0.36u m=125
.ends output_stage2

.subckt output_stage3 GP GN out
MP1 out GP vdd vdd p_18 l=0.18u w=0.65u m=75
MN1 out GN gnd gnd n_18 l=0.18u w=0.18u m=75
.ends output_stage3

.subckt output_stage1_buffer GP GN GPout GNout
MP1_P in1P GP vdd vdd p_18 l=0.18u w=1.64u m=5
MN1_P in1P GP gnd gnd n_18 l=0.18u w=0.4u m=5

MP1_N in1N GN vdd vdd p_18 l=0.18u w=1.64u m=5
MN1_N in1N GN gnd gnd n_18 l=0.18u w=0.4u m=5

MP2_P GPout in1P vdd vdd p_18 l=0.18u w=1.64u m=25
MN2_P GPout in1P gnd gnd n_18 l=0.18u w=0.4u m=25

MP2_N GNout in1N vdd vdd p_18 l=0.18u w=1.64u m=25
MN2_N GNout in1N gnd gnd n_18 l=0.18u w=0.4u m=25
.ends output_stage1_buffer

.subckt output_stage2_buffer GP GN GPout GNout
MP1_P in1P GP vdd vdd p_18 l=0.18u w=1.64u m=5
MN1_P in1P GP gnd gnd n_18 l=0.18u w=0.4u m=5

MP1_N in1N GN vdd vdd p_18 l=0.18u w=1.64u m=5
MN1_N in1N GN gnd gnd n_18 l=0.18u w=0.4u m=5

MP2_P GPout in1P vdd vdd p_18 l=0.18u w=1.64u m=25
MN2_P GPout in1P gnd gnd n_18 l=0.18u w=0.4u m=25

MP2_N GNout in1N vdd vdd p_18 l=0.18u w=1.64u m=25
MN2_N GNout in1N gnd gnd n_18 l=0.18u w=0.4u m=25
.ends output_stage2_buffer

.subckt output_stage3_buffer GP GN GPout GNout
MP1_P in1P GP vdd vdd p_18 l=0.18u w=1.64u m=5
MN1_P in1P GP gnd gnd n_18 l=0.18u w=0.4u m=5

MP1_N in1N GN vdd vdd p_18 l=0.18u w=1.64u m=5
MN1_N in1N GN gnd gnd n_18 l=0.18u w=0.4u m=5

MP2_P GPout in1P vdd vdd p_18 l=0.18u w=1.64u m=25
MN2_P GPout in1P gnd gnd n_18 l=0.18u w=0.4u m=25

MP2_N GNout in1N vdd vdd p_18 l=0.18u w=1.64u m=25
MN2_N GNout in1N gnd gnd n_18 l=0.18u w=0.4u m=25
.ends output_stage3_buffer

X1 S0 S1 E0 E1 E2 decoder

X2 IN E0 GP0 GN0 pre_driver
X3 IN E1 GP1 GN1 pre_driver
X4 IN E2 GP2 GN2 pre_driver

X5 GP0 GN0 GP0out GN0out output_stage1_buffer
X6 GP1 GN1 GP1out GN1out output_stage2_buffer
X7 GP2 GN2 GP2out GN2out output_stage3_buffer

X8 GP0out GN0out out output_stage1
X9 GP1out GN1out out output_stage2
X10 GP2out GN2out out output_stage3
*X8 out1 out buffer
.param S0=0 S1=0

vdd vdd gnd 1.8
VIN IN 0 PULSE (0 1.8 1U 0.5U 0.5U 4.5U 10U)
VS0 S0 gnd dc S0
VS1 S1 gnd dc S1
CL out gnd 100pf

.measure tran tr trig v(out) val=0.18 td=0 rise=1 targ v(out) val=1.62 td=0 rise=1
.measure tran tf trig v(out) val=1.62 td=0 fall=1 targ v(out) val=0.18 td=0 fall=1
.measure tran tmis param='abs(tr-tf)'
.measure tran MAXI MAX i(CL) from=1u to=25u

.option accurate=1
.temp 25
.param S0=0 S1=0
.tran 1u 25u
.dc vin 0,1.8,0.05

.alter
.lib "C:\synopsys\lib\cic018.l" ff
.temp 0
.param S0=1.8 S1=0
.dc vin 0,1.8,0.05

.alter
.lib "C:\synopsys\lib\cic018.l" ss
.temp 75
.param S0=0 S1=1.8
.dc vin 0,1.8,0.05
.end
