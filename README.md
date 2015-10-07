#Płytka startowa funpam pod ESP8266-12
<div style="text-align:center">
<img align="center" src="https://cloud.githubusercontent.com/assets/13647476/9096517/de5f1716-3bbd-11e5-8946-27052cb7e4be.jpg"/></div>
##Wprowadzenie
Moduły ESP8266 to układy które komunikują się ze światem zewnętrznym za pomocą WIFI. Wykorzystany wewnątrz procesor jest na tyle mocny, że bez problemu można tworzyć układy do pomiaru temperatury, wilgotności, sterujące portami itp. 

Płytka startowa funpam ESP8266 jest przeznaczona dla osób, które chcą szybko i niewielkim kosztem rozpocząć pracę z popularnymi modułami WIFI ESP8266-12. Zamiast tracić czas i nerwy, budując układ "na pająka", uruchom swój układ w 5 minut i poczuj czystą przyjemność tworzenia. A gdy stwierdzisz że to co zrobiłeś jest użyteczne, umieść w obudowie i masz gotowe urządzenie! Przygotowaliśmy również garść informacji jak rozpocząć pracę z modułami ESP8266 oraz kilka przykładów zastosowań. Wszystko znajdziecie pod tym linkiem: http://www.pamjgora.pl/wiki/FUNPAM

###Opis złącz
Złącze   | Przeznaczenie
-------- | -------------
JP1      | Podłączone do portu GPIO00. Zwarte pozwala przejść w tryb wgrywania firmware
JP2      | Podłączone do portu GPIO02. Dedykowane pod magistralę 1Wire
JP3      | UART. Port Szeregowy toleruje napięcia +5V i +3,3V. Rozstaw nóżek zgodny z modułem FTDI232.
JP4, JP5 | Podłączone bezpośrednio do UART modułu ESP2866. Akceptuje tylko napięcia +3.3V
JP6      | Porty GPIO, poziomy logiczne +5V
JP7      | Porty GPIO, poziomy logiczne +3.3V
JP8      | Podłączony do GPIO04. Przeznaczony do podłączenia przycisku, przełącznika itp.
JP9      | Port analogowo cyfrowy

###Zasilanie
Płytkę zasila się przez złącze microUSB (+5V). Wystarczy standardowy zasilacz, można też podłączyć ją bezpośrednio do wejścia USB w komputerze.

Więcej szczegółów [tutaj](http://www.pamjgora.pl/wiki/Płytka_FUNPAM).

##Jak rozpocząć przygodę z płytkami funpam i modułami ESP8266
### Masz jak na razie tylko dobre chęci
* Zaopatrz się w moduł ESP8266-12 i płytkę startową funpam. Sprawdź ofertę sklepu [www.pamjgora.pl](http://www.pamjgora.pl/sklep/index.php/produkt/plytka-startowa-do-modulu-esp8266-012).
* [Zacznij tworzyć!](http://www.pamjgora.pl/wiki/FUNPAM)

###Masz już moduły ESP8266-12, potrzebujesz tylko płytki startowej.
* Poszukaj w naszej ofercie [płytek bez wlutowanego modułu ESP2866](http://www.pamjgora.pl/sklep/index.php/produkt/plytka-startowa-do-modulu-esp8266-012). 
* Przylutuj swój moduł
* [Wgraj firmware](http://www.pamjgora.pl/wiki/Za%C5%82adowanie_nowego_firmware)
* [Zacznij tworzyć!](http://www.pamjgora.pl/wiki/FUNPAM)

