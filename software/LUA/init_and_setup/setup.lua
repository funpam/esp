-- ESP2866 WWW configurator  
-- compile this file before run
-- It creates new WIFI with ssid like "ESP_XXXXX" standard password is: "1234567890" (you can change this in the code)
-- Copyright [2015] [werar@go2.pl https://github.com/werar]
-- Licensed under the Apache License, Version 2.0 (the "License")  http://www.apache.org/licenses/LICENSE-2.0



function writeConf(params)
  file.open("conf.txt","w")
  file.writeline(params.sid)
  file.writeline(params.password)
--file.writeline(params.thinkSpeakIP)
--file.writeline(params.thinkSpeakKey)
  file.close()
  print("Saved to conf.txt");
  
end


-- read config parameters from conf.txt file
function readConf()
    conf={}
    if(file.open("conf.txt", "r")) then 
     local _line=file.readline()
     if(_line~=nil) then conf.sid=string.gsub(_line,"\n","") end
     _line=file.readline()
     if(_line~=nil) then conf.password=string.gsub(_line,"\n","") end
     --_line=file.readline()
     --if(_line~=nil) then conf.thinkSpeakIP=string.gsub(_line,"\n","") end
     --_line=file.readline()
     --if(_line~=nil) then conf.thinkSpeakKey=string.gsub(_line,"\n","") end
    file.close()
	end
    return conf
end

-- helper for http
function addHttpInput(parametrName,inputValue,labelName)
 local out = labelName..":  <input type=\"text\" name=\""..parametrName.."\""
		if(inputValue ~= nil) then
		  out = out.." value=\""..inputValue.."\""
		end
		out = out.."><br><br>"
		return out
end

-- main program
gpio.mode(5,gpio.OUTPUT) --LED2
wifi.setmode(wifi.SOFTAP) --access point
cfg={}
cfg.ssid="ESP_"..node.chipid() --SSID 
cfg.pwd="1234567890" --password 
wifi.ap.config(cfg)
tmr.delay(1000)
srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then 
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
        end
        local _GET = {}
        if (vars ~= nil)then 
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do 
                _GET[k] = v 
				print("parameters:"..k.." "..v)
            end 
			
		if(_GET.sid ~= nil and _GET.password ~= nil) then
		  writeConf(_GET);
		else
		   buf = buf.."<h2>Wypelnij wszystkie pola</h2>"
		  _GET=readConf()
		end	
		else
			_GET=readConf()
        end
		
	    buf = buf.."<h2>Settings</h2><form src=\"/\">"
		buf = buf..addHttpInput("sid",_GET.sid,"WIFI SID")
		buf = buf..addHttpInput("password",_GET.password,"WIFI password")
		--buf = buf..addHttpInput("thinkSpeakIP",_GET.thinkSpeakIP,"thinkSpeak IP")
		--buf = buf..addHttpInput("thinkSpeakKey",_GET.thinkSpeakKey,"thinkSpeak Key")
		buf = buf.."<BR><input type=\"submit\" value=\"Save\">"
		buf = buf.."</form>";
	
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)