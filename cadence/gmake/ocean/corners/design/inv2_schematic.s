# File name: PlayTime_inv2_schematic.S.
# Subcircuit for cell: inv2.
# Generated for: spectreS.
# Generated on Aug 15 16:57:50 1997.

m1 (out in vdd\! vdd\!)  \pmos  region=\triode w=2e-6 l=6e-6 as=2e-6*6e-6 &
ad=2e-6*6e-6 ps=20e-6 pd=20e-6 m=1.0  
v1 (vdd\! 0) \vsource  type=\dc dc=3.3 
v0 (in 0) \vsource  type=\pulse val0=0.0 val1=3.3 period=1.5e-6 delay=1e-&
9 rise=100e-9 fall=150e-9 width=600e-9 
m0 (out in 0 0)  \nmos  region=\triode w=3e-6 l=500e-9 as=3e-6*500e-9 &
ad=3e-6*500e-9 ps=8e-6 pd=8e-6 m=1.0  

