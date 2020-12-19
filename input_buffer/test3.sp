
.lib "C:\synopsys\lib\mm0355v.l" tt_5V
.global vdd gnd

*轉態點 1.4V inv
.subckt inv1 in out
MP out in vdd vdd pch5 l=0.5u w=1.5u
MN out in gnd gnd nch5 l=0.5u w=3.5u
.ends

*補償用 buffer
.subckt inv2 in out
MP out in vdd vdd pch5 l=0.5u w=2.4u
MN out in gnd gnd nch5 l=0.5u w=1u
.ends

*輸出用 轉態點 2.5V inv buffer
.subckt inv3 in out
MP out in vdd vdd pch5 l=0.5u w=5.5u m=5
MN out in gnd gnd nch5 l=0.5u w=1.5u m=5
.ends

.subckt inv4 in out
MP out in vdd vdd pch5 l=0.5u w=5.5u m=25
MN out in gnd gnd nch5 l=0.5u w=1.5u m=25
.ends

*轉態點 1.2V inv
.subckt inv1.2 in out
MP out in vdd vdd pch5 l=0.5u w=1.5u
MN out in gnd gnd nch5 l=0.5u w=7u
.ends

*轉態點 1.6V inv
.subckt inv1.6 in out
MP out in vdd vdd pch5 l=0.5u w=1.5u
MN out in gnd gnd nch5 l=0.5u w=2.1u
.ends

*轉態點 2.5V inv 雙節點輸入
.subckt inv2.5 inp inn out
MP out inp vdd vdd pch5 l=0.5u w=3.9u
MN out inn gnd gnd nch5 l=0.5u w=1u
.ends

*轉態點 inv back
.subckt inv10 in out
MP out in vdd vdd pch5 l=0.5u w=0.5u
MN out in gnd gnd nch5 l=0.5u w=0.5u
.ends

*schmitt
.subckt SMT in out
X1 in mid_out1 inv1.6					*1.6V_inv
X2 in mid_out2 inv1.2					*1.2V_inv

X3 mid_out1 mid_out2 fb_in inv2.5	
*MP fb_in mid_out1 vdd vdd pch5 l=0.5u w=3.9u
*MN fb_in mid_out2 gnd gnd nch5 l=0.5u w=1u
	
X4 fb_in fb_in bf_in inv2.5			
X5 bf_in fb_in inv10				*feedback_inv
X6 bf_in bf_in out inv2.5			*buffer
.ends


*x0 in out inv1
x0 in s1_out SMT
x1 s1_out s2_out inv3
x2 s2_out out inv4

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

.dc vin 0,2.8,0.05
.TRAN 10n 70us
.end