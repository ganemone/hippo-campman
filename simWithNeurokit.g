//create pulse generator
create pulsegen /pulse
setfield /pulse level1 {800e-12} width1 {500e-3} delay1 .1 delay2 100

//connect pulse generator to cell ("inject pulse")
addmsg /pulse /prot_pyr/soma INJECT output

step 1 -time
