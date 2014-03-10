create randomspike /randomspike
setfield ^ min_amp -300e-12 max_amp 100e-12 rate 10000 reset 1 reset_value 0
addmsg /randomspike /prot_pyr/soma INJECT state

