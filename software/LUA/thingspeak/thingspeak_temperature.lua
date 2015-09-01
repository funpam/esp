-- Copyright [2015] [werar@go2.pl https://github.com/werar]
--Licensed under the Apache License, Version 2.0 (the "License")  http://www.apache.org/licenses/LICENSE-2.0

-- remember to upload first ds18b20.lua and compile it lc(ds18b20.lua)



function getTemp()
	local t=require("ds18b20")
	t.setup(4) --GPIO2 for 1WIRE
	local temp=t.read()
	tmr.delay(1000 * 1000)
	temp=t.read()
	print("Measured temperature: ")
	print(temp)
    t = nil
    ds18b20 = nil
    package.loaded["ds18b20"]=nil
	return temp
end	



first_time=1 --first time the temperature is wrongly measured. That is why is skipped.
thingspeakKey="XE8TZ74P34CXQKCZ" --put here your thinkspeak.com key 
print("Measure temperature and send it to ThingSpeak.com (API KEY:"..thingspeakKey..")\n")

--- Get temp and send data to thingspeak.com
function sendData()
 temperature=getTemp()
 if first_time==1 then 
   first_time=0
   print("Skip first measurement:"..temperature.." C\n")
   return
 end
 print("Measured temperature: "..temperature.." C\n")
 print("Sending data ("..temperature..") to thingspeak.com. API key:"..thingspeakKey..".")
 conn=net.createConnection(net.TCP, 0) 
 conn:on("receive", function(conn, payload) print("rec:"..payload) end)
 conn:connect(80,'184.106.153.149') -- api.thingspeak.com 184.106.153.149
 conn:send("GET /update?key="..thingspeakKey.."&field1="..temperature.." HTTP/1.1\r\n") 
 conn:send("Host: api.thingspeak.com\r\n") 
 conn:send("Accept: */*\r\n") 
 conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
 conn:send("\r\n")
 conn:on("sent",function(conn)
                  print("Closing Connection")
                  conn:close()
                end)
 conn:on("disconnection", function(conn)
                            print("Got disconnection...")
                          end)
end



-- send data every X ms to thingSpeak.com
tmr.alarm(0, 60000, 1, function() sendData() end )


