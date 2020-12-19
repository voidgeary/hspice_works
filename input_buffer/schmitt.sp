#schmitt_circuit

.lib "C:\synopsys\lib\mm0355v.l" tt_5V
.global vdd gnd

*轉態點 2V inv
.subckt inv2 in out
MP out in vdd vdd pch5 l=0.5u w=2.3u
MN out in gnd gnd nch5 l=0.5u w=1.5u
.ends

*轉態點 3V inv
.subckt inv3 in out
MP out in vdd vdd pch5 l=0.5u w=10.4u
MN out in gnd gnd nch5 l=0.5u w=1u
.ends

*轉態點 2.5V inv 雙節點輸入
.subckt inv2.5 inp inn out
MP out inp vdd vdd pch5 l=0.5u w=3.9u m=5
MN out inn gnd gnd nch5 l=0.5u w=1u m=5
.ends

*轉態點 inv back
.subckt inv10 in out
MP out in vdd vdd pch5 l=0.5u w=0.5u
MN out in gnd gnd nch5 l=0.5u w=0.5u
.ends

.subckt buffer in out
MP out in vdd vdd pch5 l=0.5u w=3.9u m=20
MN out in gnd gnd nch5 l=0.5u w=1u m=20
*MP2 mid_out2 mid_out vdd vdd pch5 l=0.5u w=3.9u m=25
*MN2 mid_out2 mid_out gnd gnd nch5 l=0.5u w=1u m=25
*MP3 out mid_out2 vdd vdd pch5 l=0.5u w=3.9u m=30
*MN3 out mid_out2 gnd gnd nch5 l=0.5u w=1u m=30
.ends


X1 in mid_out1 inv3					*3V_inv
X2 in mid_out2 inv2					*2V_inv

X3 mid_out1 mid_out2 fb_in inv2.5	
*MP fb_in mid_out1 vdd vdd pch5 l=0.5u w=3.9u
*MN fb_in mid_out2 gnd gnd nch5 l=0.5u w=1u
	
X4 fb_in fb_in bf_in inv2.5			
X5 bf_in fb_in inv10				*feedback_inv
X6 bf_in out buffer			        *buffer

Cl out gnd 5pf
vdd vdd gnd 5V
*Vin in gnd dc 1 pulse(0,5,10n,1n,1n,9n,20n)
Vin in gnd pwl 0,0,100u,5,200u,0

.meas tran tr trig v(out) val=0.5 rise=2
+targ v(out) val=4.5 rise=2
.meas tran tf trig v(out) val=4.5 fall=2
+targ v(out) val=0.5 fall=2
.meas tran tdr trig v(in) val=3 rise=2
+targ v(out) val=2.5 rise=2
.meas tran tdf trig v(in) val=2 fall=2
+targ v(out) val=2.5 fall=2
.meas tran pwr avg power

.dc vin  0,6,0.05
.dc vin  6,0,0.05
*.TRAN 10p 45ns
.TRAN 10n 200u
.alter
.lib "C:\synopsys\lib\mm0355v.l" ss_5V
.alter
.lib "C:\synopsys\lib\mm0355v.l" ff_5V
.end