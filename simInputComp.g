include prot_pyr

float inject

create xform /data [20,50,250,500]
create xgraph /data/voltage

create xform /pulsedata [280,50,300,500]
create xgraph /pulsedata/pulsegraph

create xform /bdata [580,50,300,500]
create xgraph /bdata/voltage

create xform /cdata [880,50,300,500]
create xgraph /cdata/channel

//echo {{argv {1}}@{argv {2}}}

str comp = {argv {2}}
//str filenam = “2HzV1”
//echo {comp}

xhide data
xhide pulsedata
xhide bdata

//create table recording soma Vm
create table /somatable
call somatable TABCREATE 1500000 0 1500000
setfield /somatable step_mode 3
addmsg /prot_pyr/{comp} /somatable INPUT Vm

xshow /data
xshow /pulsedata
xshow /bdata
xshow /cdata

//set simulation time step size for clock 0
setclock 0 1e-5

addmsg /prot_pyr/{comp} /data/voltage PLOT Vm *volts *red
addmsg /prot_pyr/{comp} /bdata/voltage PLOT Vm *volts *black

create disk_in /diskin
setfield /diskin nx 1 ny 1 filename {{argv {1}}@".txt"} dt 10 leave_open 1 
call /diskin RESET
addmsg /diskin /prot_pyr/{comp} INJECT val[0][0]
addmsg /diskin /pulsedata/pulsegraph PLOT val[0][0] *randomIn *orange

addmsg /prot_pyr/{comp}/Na /cdata/channel PLOT Gk *Na,Siemens *black
addmsg /prot_pyr/{comp}/K_DR /cdata/channel PLOT Gk *K_DR,Siemens *red
addmsg /prot_pyr/{comp}/K_A /cdata/channel PLOT Gk *K_A,Siemens *blue

create xbutton /data/RESET -script reset
create xbutton /data/RUN -script "step 5 -time"
create xbutton /data/SAVE -script "tab2file somaVm /somatable table -overwrite"
create xbutton /data/QUIT -script "quit"

reset

check

step 15 -time
tab2file {{{argv {1}}@{comp}}@"out.txt"} /somatable table -overwrite
quit
