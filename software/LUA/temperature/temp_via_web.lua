-- Measure temperature using dallas DS1820 (via 1-WIRE bus)
-- Copyright [2015] [werar@go2.pl https://github.com/werar]
--Licensed under the Apache License, Version 2.0 (the "License")  http://www.apache.org/licenses/LICENSE-2.0

function readConf()
    conf={}
    if(file.open("conf.txt", "r")) then
     local a=file.readline()
     if(a~=nil) then conf.sid=string.gsub(a,"\n","") end
     a=file.readline()
     if(a~=nil) then conf.password=string.gsub(a,"\n","") end
     file.close()
	end
    return conf
end

function getTemp()
	local t=require("ds18b20")
	t.setup(4) --GPIO for 1WIRE
	local temp=t.read()
	tmr.delay(1000 * 1000)
	temp=t.read()
	print("Measured temp: ")
	print(temp)
    -- Don't forget to release it after use
    t = nil
    ds18b20 = nil
    package.loaded["ds18b20"]=nil
	return temp
end	

print("Open this url to read temperature  http://"..wifi.sta.getip())

srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive", function(client,request)
        local buf = "";
		buf = buf.."<h2>Temperature is: "..getTemp().." C</h2>";
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)