#NoEnv  
SendMode Input  
SetWorkingDir %A_ScriptDir%  
#Include %A_ScriptDir%\Funktiot.ahk

; Poistetaan aikaisemmat tiedostot
Puhdistus()

; Ladataan asetukset .ini -tiedostosta
IniRead, SD, Lapsisoitin.ini, asetukset, FlickFetch
IniRead, autoareena, Lapsisoitin.ini, asetukset, AvaaAreena
IniRead, areenaurl, Lapsisoitin.ini, asetukset, AreenaOsoite
IniRead, autotv7, Lapsisoitin.ini, asetukset, AvaaTv7
IniRead, tv7url, Lapsisoitin.ini, asetukset, TV7Osoite
IniRead, VLC, Lapsisoitin.ini, asetukset, VLC
IniRead, unille, Lapsisoitin.ini, asetukset, Unille

; Jos ei Flickfechiä löydy, yritä etsiä sitä kotihakemistosta
IfNotExist, SD
	SD = C:\Users\%A_Username%\AppData\Local\FlickFetch\

; Käynnistä Yle-Areena
If (autoareena = true)
	Run %areenaurl%

If (autotv7 = true)
	Run %tv7url%

; Popup kysymykset
Gui, New
Gui, Add, Link,, <a href="http://areena.yle.fi/tv">Yle-Areena</a> ja <a href="http://www.tv7.fi/vod/">TV7</a> -lapsisoitin
Gui, Add, Text,, Liitä riveille videoiden osoitteet. 
Gui, Add, Edit,w230 vyy
Gui, Add, Edit,w230 vkaa
Gui, Add, Edit,w230 vkoo
Gui, Add, Edit,w230 vnee
Gui, Add, Edit,w230 vvii
Gui, Add, Edit,w230 vkuu
Gui, Add, Edit,w230 vsei
Gui, Add, Button, gOK, OK
Gui, Add, Button, gLopeta x195 y240, Lopeta
Gui, Show, w250 h270, Lapsisoitin
return

Lopeta:
ExitApp

OK:
Gui, Submit

if (yy = "" && kaa = "" && koo = "" && nee = "" && vii = "" && kuu = "" && sei = "")
	; Jos kentät ovat tyhjät, käytä leikepöytää
	FileAppend, %clipboard%, %A_ScriptDir%\tmp\urlit.txt
	FileReadLine, yy, %A_ScriptDir%\tmp\urlit.txt, 1
	FileReadLine, kaa, %A_ScriptDir%\tmp\urlit.txt, 2
	FileReadLine, koo, %A_ScriptDir%\tmp\urlit.txt, 3
	FileReadLine, nee, %A_ScriptDir%\tmp\urlit.txt, 4
	FileReadLine, vii, %A_ScriptDir%\tmp\urlit.txt, 5
	FileReadLine, kuu, %A_ScriptDir%\tmp\urlit.txt, 6
	FileReadLine, sei, %A_ScriptDir%\tmp\urlit.txt, 7
	FileDelete, %A_ScriptDir%\tmp\urlit.txt

; Lisätään tiedot urlit.txt -tiedostoon (FlickFetch-hakemistoon)
Kumpi(yy,1)
Kumpi(kaa,2)
Kumpi(koo,3)
Kumpi(nee,4)
Kumpi(vii,5)
Kumpi(kuu,6)
Kumpi(sei,7)

; Poistetaan mahdolliset autoplayt (urlit.txt -tiedostosta)
FileRead, TheText, %A_ScriptDir%\tmp\urlit.txt
StringReplace, NewText, TheText, ?autoplay=true, , All
FileDelete, %A_ScriptDir%\tmp\urlit.txt
FileAppend, %NewText%, %A_ScriptDir%\tmp\urlit.txt

; Käynnistetään FlickFetch lataamaan urlit.txt -tiedoston videot (ellei ole tyhjä)
FileGetSize, urlitiedosto, %A_ScriptDir%\tmp\urlit.txt
if (urlitiedosto > 15)
	Run, %SD%FlickFetch.exe --in %A_ScriptDir%\tmp\urlit.txt --cfg %A_ScriptDir%\flickfetch.cfg --center --exist again --closeifnoerrors --out %A_ScriptDir%\Lataukset
	; Odotetaan kunnes ohjelmat ovat ladattu
	sleep 2000
	WinWaitClose, ahk_exe FlickFetch.exe

; Poistetaan tekstitykset download-hakemistosta
FileDelete, %A_ScriptDir%\Lataukset\*.srt
FileDelete, %A_ScriptDir%\Lataukset\*.txt

; Käynnistetään VLC soittamaan DL-kansio (fullscreen ja lopuksi pois päältä)
Run, C:\Program Files\VideoLAN\VLC\vlc.exe %A_ScriptDir%\Lataukset --fullscreen --play-and-exit

; Odotetaan kunnes videot on näytetty
sleep 2000
WinWaitClose, ahk_exe vlc.exe
Puhdistus()

; Kone unille
If (Unille = true)
	DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

ExitApp

GuiClose:
ExitApp

GuiEscape:
ExitApp