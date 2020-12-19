#dffr
.lib "C:\synopsys\lib\cic018.l" tt
.global vdd gnd

*0.9V_inv
.subckt inv in out 
MP1 out in vdd vdd p_18 l=0.5u w=3.5u
MN1 out in gnd gnd n_18 l=0.5u w=0.6u
.ends inv

*0.9V_nand3
.subckt nand3 A B C out
MP1 out A vdd vdd p_18 l=0.5u w=3.5u
MP2 out B vdd vdd p_18 l=0.5u w=3.5u
MP3 out C vdd vdd p_18 l=0.5u w=3.5u

MN1 out A s_1 gnd n_18 l=0.5u w=0.6u
MN2 s_1 B s_2 gnd n_18 l=0.5u w=0.6u
MN3 s_2 C gnd gnd n_18 l=0.5u w=0.6u
.ends nand3

*0.9V_nand2
.subckt nand2 A B out
MP1 out A vdd vdd p_18 l=0.5u w=3.5u
MP2 out B vdd vdd p_18 l=0.5u w=3.5u

MN1 out A s_1 gnd n_18 l=0.5u w=0.6u
MN2 s_1 B gnd gnd n_18 l=0.5u w=0.6u
.ends nand2

X1 CLK iCLK inv
X2 RESET iRESET inv

X3 n4  n2    n1  nand2
X4 n1  iCLK  iRESET  n2  nand3
X5 n2  iCLK  n4      n3  nand3
X6 n3  D     iRESET  n4  nand3

X7 n2  n6    Q   nand2
X8 Q   n3    iRESET  n6  nand3

vdd  vdd    gnd dc 1.8
vd   D      gnd dc 1 pulse(0,1.8,5u,0.1u,0.1u,10u,15u)
vclk CLK    gnd dc 1 pulse(0,1.8,3u,0.1u,0.1u,5u,10u)
vre  RESET  gnd dc 1 pulse(0,1.8,10u,0.1u,0.1u,2u,100u)
Cl Q gnd 1pf

.tran 0.01u 140u
.end