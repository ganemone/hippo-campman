create xform /data
create xgraph /data/voltage

create xform /pulsedata
create xgraph /pulsedata/pulsegraph

xshow /data
xshow /pulsedata

setclock 0 0.0005

addmsg /prot_pyr/soma /data/voltage PLOT Vm *volts *red
addmsg /prot_pyr/soma /data/voltage PLOT inject *current *blue

create pulsegen /pulse
setfield /pulse level1 -200e-12 width1 500e-3 level2 0 delay1 1

addmsg /pulse /prot_pyr/ac6c INJECT output
addmsg /pulse /pulsedata/pulsegraph PLOT output *pulse *orange

create xbutton /data/RESET -script reset
create xbutton /data/RUN -script "step 2 -time"
create xbutton /data/QUIT -script "xhide /data"

check
reset
