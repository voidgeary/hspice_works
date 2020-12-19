
.lib "C:\synopsys\lib\mm0355v.l" tt_5V
.global vdd gnd

*轉態點 1.2V inv
.subckt inv2 in out
MP out in vdd vdd pch5 l=0.5u w=0.8u
MN out in gnd gnd nch5 l=0.5u w=4.1u
.ends

*轉態點 1.6V inv
.subckt inv3 in out
MP out in vdd vdd pch5 l=0.5u w=1u
MN out in gnd gnd nch5 l=0.5u w=1.4u
.ends

*轉態點 2.5V buffer inv
.subckt bufferinv in out
MP out in vdd vdd pch5 l=0.5u w=3.9u
MN out in gnd gnd nch5 l=0.5u w=1u
.ends
*轉態點 inv back
.subckt inv10 in out
MP out in vdd vdd pch5 l=0.5u w=0.5u
MN out in gnd gnd nch5 l=0.5u w=0.5u
.ends
*轉態點 inv pass
.subckt inv01 in out
MP out in vdd vdd pch5 l=0.5u w=3.9u
MN out in gnd gnd nch5 l=0.5u w=1u
.ends

.subckt schmitt in out
xinv2 in schO1 inv3
xinv3 in schO2 inv2
MP O0 schO1 vdd vdd pch5 l=0.5u w=3.9u
MN O0 schO2 gnd gnd nch5 l=0.5u w=1u
xinvC1 O0 O2 inv01
xinvC2 O2 O0 inv10
xinvBu O2 out bufferinv
.ends

*buffer 轉態點 2.5V
.subckt buffer in out
MP mid in vdd vdd pch5 l=0.5u w=3.8u m=4
MN mid in gnd gnd nch5 l=0.5u w=1u m=4
MP1 out mid vdd vdd pch5 l=0.5u w=3.9u m=20
MN1 out mid gnd gnd nch5 l=0.5u w=1u m=20
.ends

x1 in 2 schmitt
x2 2 out buffer
Vin in gnd dc 1 pulse(0,2.8,10u,1u,1u,9u,20u)
Cl out gnd 20pf
vdd vdd gnd 5V

.meas tran tdr trig v(in) val=1.4 rise=2
+targ v(out) val=2.5 rise=2
.meas tran tdf trig v(in) val=1.4 fall=2
+targ v(out) val=2.5 fall=2
.meas tran tr trig v(out) val=0.5 rise=2
+targ v(out) val=4.5 rise=2
.meas tran tf trig v(out) val=4.5 fall=2
+targ v(out) val=0.5 fall=2
.meas tran td trig v(in) val=2.5 rise=2
+targ v(out) val=2.5 fall=2

.dc vin 0,6,0.05
.TRAN 10p 45us
.option post=2
.end