-- Initialise ESP2866 module
-- This program has two modes based on state JP8 jumper.
-- When pins on JP8 are connected the program will run setup.lua program (configuration mode)
-- When pins on JP8 are unconnected the program will run blinkLEd.lua program (or any other program)
-- Copyright [2015] [werar@go2.pl https://github.com/werar]
--Licensed under the Apache License, Version 2.0 (the "License")  http://www.apache.org/licenses/LICENSE-2.0


gpio.mode(1,gpio.INPUT)  --JP8 is connected to JP8
if gpio.read(1)==0 then
  print("Run in configuration mode")
  dofile("setup.lc") --you must compile setup.lua before!
else

print("Setting up WIFI...")
wifi.setmode(wifi.STATION)

--read config file (first two lines)
file.open("conf.txt", "r") 
local sid=file.readline() --ssid name
local pass=file.readline() -- password
file.close()

wifi.sta.config(string.gsub(sid,"\n",""),string.gsub(pass,"\n","")) --remove and of line character and set up ssid
wifi.sta.connect() -- connect to wifi

tmr.alarm(1, 1000, 1, function()  --try every one sec
  if wifi.sta.getip()== nil then 
    print("IP unavaiable, Waiting...") 
  else 
    tmr.stop(1)
    print("Config done, IP is "..wifi.sta.getip())
    print("*** You've got 3 sec to stop timer 0 ***") -- stop timers if you want to upload something new
    tmr.alarm(0, 3000, 0, function()
      dofile("temp_via_web.lua") end)
      end 
    end)
  end