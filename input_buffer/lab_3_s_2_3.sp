
.lib "C:\synopsys\lib\mm0355v.l" tt_5V
.global vdd gnd

*轉態點 2V inv
.subckt inv2 in out
MP out in vdd vdd pch5 l=0.5u w=3.1u
MN out in gnd gnd nch5 l=0.5u w=2u
.ends

*轉態點 3V inv
.subckt inv3 in out
MP out in vdd vdd pch5 l=0.5u w=6.2u
MN out in gnd gnd nch5 l=0.5u w=0.5u
.ends

*轉態點 2.5V buffer
.subckt buffer in out
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

xinv2 in schO1 inv3
xinv3 in schO2 inv2

MP O0 schO1 vdd vdd pch5 l=0.5u w=3.9u
MN O0 schO2 gnd gnd nch5 l=0.5u w=1u

xinvC1 O0 O2 inv01
xinvC2 O2 O0 inv10
xinvBu O2 out buffer

Vin in gnd dc 1 pulse(0,5,0u,10u,10u,0u,20u)
Cl out gnd 1pf
vdd vdd gnd 5V

.meas tran tdr trig v(in) val=2.5 rise=2
+targ v(out) val=2.5 rise=2
.meas tran tdf trig v(in) val=2.5 fall=2
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