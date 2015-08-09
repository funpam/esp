-- Blink LED2 on funpam board
-- 
-- Copyright [2015] [werar@go2.pl https://github.com/werar]
--Licensed under the Apache License, Version 2.0 (the "License")  http://www.apache.org/licenses/LICENSE-2.0

--very simple example 
function blinkLed(pin) 
    gpio.write(pin,gpio.HIGH)
	tmr.delay(1000000)
    gpio.write(pin,gpio.LOW)
    tmr.delay(1000000)	
end

--PWM version. Firmware must to have PWM module included (not used in basic example)
function blinkLedPWM(pin)  
    pwm.setduty(pin, 512)
	pwm.setup(pin,1,512)
	pwm.start(pin)
end

 
-- main program
local _led2Port=5; --5 means GPIO14
gpio.mode(_led2Port,gpio.OUTPUT) --set GPIO14 as output

-- use timer0 to periodically call function 
tmr.alarm(0, 1000, 1, function() blinkLed(_led2Port) end )