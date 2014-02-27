create xform /data
create xgraph /data/voltage

xshow /data

addmsg /prot_pyr/soma /data/voltage PLOT Vm *volts *red
addmsg /prot_pyr/soma /data/voltage PLOT inject *current *blue

setclock 0 0.0005

create pulsegen /pulse
setfield /pulse level1 200e-12 width1 500e-3

addmsg /pulse /prot_pyr/soma INJECT output

create xbutton /data/RESET -script reset
create xbutton /data/RUN -script "step 4 -time"
create xbutton /data/QUIT -script "xhide /data"

check
reset
