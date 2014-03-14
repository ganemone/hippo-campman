//create randomspike /randomspike
//setfield ^ min_amp -300e-12 max_amp 100e-12 rate 10000 reset 1 reset_value 0
//addmsg /randomspike /prot_pyr/soma INJECT state
create disk_in /diskin
setfield /diskin nx 1 ny 1 filename rand2.txt dt 10 leave_open 1 
call /diskin RESET
addmsg /diskin /prot_pyr/soma INJECT val[0][0]

