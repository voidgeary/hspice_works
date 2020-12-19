#Ring_oscillator
.lib "C:\synopsys\lib\cic018.l" tt
.global vdd gnd

.subckt inv in out
MP1 out in vdd vdd p_18 l=0.18u w=0.82u
MN1 out in gnd gnd n_18 l=0.18u w=0.18u
.ends inv

.subckt inv_2 in out
X1 in temp inv
X2 temp out inv
.ends inv_2

.subckt nand2 A B out
MP1 out A vdd vdd p_18 l=0.18u w=0.82u
MP2 out B vdd vdd p_18 l=0.18u w=0.82u

MN1 out A s_1 gnd n_18 l=0.18u w=0.18u
MN2 s_1 B gnd gnd n_18 l=0.18u w=0.18u
.ends nand2

X1 vc out t1 nand2

X2 t1 t2 inv_2
X3 t2 t3 inv_2
X4 t3 t4 inv_2
X5 t4 t5 inv_2
X6 t5 t6 inv_2
X7 t6 out inv_2

X100 out vo inv

vdd vdd gnd 1.8v
C1 vo gnd 0.01p
vc vc gnd pulse(0V 1.8V 1u 1p 1p 4us 4us)
.tran 1u 5u
.op

.meas tran pmax avg power from=1us to=5us
.meas tran prid trig v(vo) val=1.6 Td=2u rise=1 targ v(vo) val=1.6 rise=2
.meas tran f param='1/prid'

.alter
.lib 'C:\synopsys\lib\cic018.l' ff
.alter
.lib 'C:\synopsys\lib\cic018.l' fs
.alter
.lib 'C:\synopsys\lib\cic018.l' ss
.alter
.lib 'C:\synopsys\lib\cic018.l' sf
.end