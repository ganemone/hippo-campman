include prot_pyr

create xform /data [20,50,250,500]
create xgraph /data/voltage

create xform /pulsedata [280,50,300,500]
create xgraph /pulsedata/pulsegraph

create xform /bdata [580,50,300,500]
create xgraph /bdata/voltage

create xform /cdata [880,50,300,500]
create xgraph /cdata/channel

str comp = "soma"

//create table recording soma Vm
create table /somatable
call somatable TABCREATE 4001 0 4001
setfield /somatable step_mode 3
addmsg /prot_pyr/soma /somatable INPUT Vm

xshow /data
xshow /pulsedata
xshow /bdata
xshow /cdata

//set simulation time step size for clock 0
setclock 0 .7e-5

addmsg /prot_pyr/soma /data/voltage PLOT Vm *volts *red
addmsg /prot_pyr/soma /data/voltage PLOT inject *current *blue
addmsg /prot_pyr/{comp} /bdata/voltage PLOT Vm *volts *black

//create pulse generator
create pulsegen /pulse
setfield /pulse level1 {-1800e-12} width1 {500e-3} delay1 100e-3 delay2 100

//connect pulse generator to cell ("inject pulse")
addmsg /pulse /prot_pyr/as1 INJECT output
addmsg /pulse /pulsedata/pulsegraph PLOT output *pulse *orange

addmsg /prot_pyr/{comp}/Na /cdata/channel PLOT Gk *Na,Siemens *black
addmsg /prot_pyr/{comp}/K_DR /cdata/channel PLOT Gk *K_DR,Siemens *red
addmsg /prot_pyr/{comp}/K_A /cdata/channel PLOT Gk *K_A,Siemens *blue

create xbutton /data/RESET -script reset
create xbutton /data/RUN -script "step 1 -time"
create xbutton /data/SAVE -script "tab2file somaVmHyper /somatable table -overwrite"
create xbutton /data/QUIT -script "quit"

reset
step 5 -time
check
