-- Initialise config file 

-- This program has two modes based on state JP8 jumper.
-- Copyright [2015] [werar@go2.pl https://github.com/werar]
--Licensed under the Apache License, Version 2.0 (the "License")  http://www.apache.org/licenses/LICENSE-2.0

function writeConf(params)
  file.open("conf.txt","w")
  file.writeline("ssidName") -- wifi ssid name
  file.writeline("wifi_password") -- wifi password
  --file.writeline("184.106.153.149") -- thinkspeak ip
  --file.writeline("thinkspeak_token") -- thinkspeak token
  file.close()
  print("Config is saved");
end

writeConf();
