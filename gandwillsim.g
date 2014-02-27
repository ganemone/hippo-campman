xhide data
xhide pulsedata
xhide bdata

create xform /data
create xgraph /data/voltage

create xform /pulsedata
create xgraph /pulsedata/pulsegraph

create xform /bdata
create xgraph /bdata/voltage

create table /somatable
call somatable TABCREATE 100 0 100
setfield /somatable step_mode 4
addmsg /prot_pyr/soma /somatable INPUT x

xshow /data
xshow /pulsedata
xshow /bdata

setclock 0 0.0005

addmsg /prot_pyr/soma /data/voltage PLOT Vm *volts *red
addmsg /prot_pyr/soma /data/voltage PLOT inject *current *blue
addmsg /prot_pyr/a# /bdata/voltage PLOT Vm *volts *black

create pulsegen /pulse
setfield /pulse level1 200e-12 width1 500e-3 level2 0 delay1 1

addmsg /pulse /prot_pyr/a# INJECT output
addmsg /pulse /pulsedata/pulsegraph PLOT output *pulse *orange

create xbutton /data/RESET -script reset
create xbutton /data/RUN -script "step 2 -time"
create xbutton /data/SAVE -script "tab2file somaVm /somatable somatable"
create xbutton /data/QUIT -script "xhide /data"

check
reset
