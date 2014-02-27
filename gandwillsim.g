include prot_pyr


create xform /data
create xgraph /data/voltage

create xform /pulsedata
create xgraph /pulsedata/pulsegraph

create xform /bdata
create xgraph /bdata/voltage


xhide data
xhide pulsedata
xhide bdata

//create table recording soma Vm
create table /somatable
call somatable TABCREATE 4001 0 4001
setfield /somatable step_mode 3
addmsg /prot_pyr/soma /somatable INPUT Vm

xshow /data
xshow /pulsedata
xshow /bdata

//set simulation time step size for clock 0
setclock 0 0.0005

addmsg /prot_pyr/soma /data/voltage PLOT Vm *volts *red
addmsg /prot_pyr/soma /data/voltage PLOT inject *current *blue
addmsg /prot_pyr/a# /bdata/voltage PLOT Vm *volts *black

//create pulse generator
create pulsegen /pulse
setfield /pulse level1 200e-12 width1 500e-3 level2 0 delay1 1

//connect pulse generator to cell
addmsg /pulse /prot_pyr/soma INJECT output
addmsg /pulse /pulsedata/pulsegraph PLOT output *pulse *orange

create xbutton /data/RESET -script reset
create xbutton /data/RUN -script "step 2 -time"
create xbutton /data/SAVE -script "tab2file somaVm /somatable table -overwrite"
create xbutton /data/QUIT -script "xhide /data"

check
reset
