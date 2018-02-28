wifi.setmode(wifi.STATION)
wifi.sta.config {ssid="yournetwork", pwd="yourpassword"}
wifi.sta.connect()

dofile("trig.lua")
dofile("complex.lua")

mv_val = {0,0,0}

dofile("polladc.lua")
dofile("httpd.lua")
