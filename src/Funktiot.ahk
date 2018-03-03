DownloadFile(UrlToFile, SaveFileAs, Overwrite := True, UseProgressBar := True) {
    ;Check if the file already exists and if we must not overwrite it
      If (!Overwrite && FileExist(SaveFileAs))
          Return
    ;Check if the user wants a progressbar
      If (UseProgressBar) {
          ;Initialize the WinHttpRequest Object
            WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
          ;Download the headers
            WebRequest.Open("HEAD", UrlToFile)
            WebRequest.Send()
          ;Store the header which holds the file size in a variable:
            FinalSize := WebRequest.GetResponseHeader("Content-Length")
          ;Create the progressbar and the timer
            Progress, H80, , Downloading..., %UrlToFile%
            SetTimer, __UpdateProgressBar, 100
      }
    ;Download the file
      UrlDownloadToFile, %UrlToFile%, %SaveFileAs%
    ;Remove the timer and the progressbar because the download has finished
      If (UseProgressBar) {
          Progress, Off
          SetTimer, __UpdateProgressBar, Off
      }
    Return
    
    ;The label that updates the progressbar
      __UpdateProgressBar:
          ;Get the current filesize and tick
            CurrentSize := FileOpen(SaveFileAs, "r").Length ;FileGetSize wouldn't return reliable results
            CurrentSizeTick := A_TickCount
          ;Calculate the downloadspeed
            Speed := Round((CurrentSize/1024-LastSize/1024)/((CurrentSizeTick-LastSizeTick)/1000)) . " Kb/s"
          ;Save the current filesize and tick for the next time
            LastSizeTick := CurrentSizeTick
            LastSize := FileOpen(SaveFileAs, "r").Length
          ;Calculate percent done
            PercentDone := Round(CurrentSize/FinalSize*100)
          ;Update the ProgressBar
            Progress, %PercentDone%, %PercentDone%`% Done, Downloading...  (%Speed%), Downloading %SaveFileAs% (%PercentDone%`%)
      Return
}

TV7(tv7Lataus, tv7nimi)
{
  urldownloadtofile , %tv7Lataus% , %A_ScriptDir%\tmp\%tv7nimi%.html
  FileGetSize, urlitiedosto, %A_ScriptDir%\tmp\%tv7nimi%.html
  if (urlitiedosto < 15)
      FileDelete, %A_ScriptDir%\tmp\%tv7nimi%.html
}

Kumpi(osoite,numero)
{
    IfInString, osoite, tv7.fi
    {
    TV7(osoite, numero)
    return
    }
    else
        FileAppend, %osoite%`n, %A_ScriptDir%\tmp\%numero%.txt
        FileGetSize, urlitiedosto, %A_ScriptDir%\tmp\%numero%.txt
        if (urlitiedosto > 15)
        {
            ; Poistetaan mahdollinen autoplay
            FileRead, TheText, %A_ScriptDir%\tmp\%numero%.txt
            StringReplace, NewText, TheText, ?autoplay=true, , All
            FileDelete, %A_ScriptDir%\tmp\%numero%.txt
            FileAppend, %NewText%, %A_ScriptDir%\tmp\%numero%.txt
        }
        else
            FileDelete, %A_ScriptDir%\tmp\%numero%.txt
    Sleep, 1
}

Lataus(numero)
{
    olemassa = %A_ScriptDir%\tmp\%numero%.txt
    olemassahtml = %A_ScriptDir%\tmp\%numero%.html
    If (FileExist(olemassa))
    {
        IniRead, FlickFetch, Lapsisoitin.ini, asetukset, FlickFetch
        Run, %FlickFetch% --in %A_ScriptDir%\tmp\%numero%.txt --cfg %A_ScriptDir%\lapsisoitin.cfg --close --center --exist skip --closeifnoerrors --min --out %A_ScriptDir%\tmp\%numero%\
    }
    If (FileExist(olemassahtml))
    {
        FileRead , page , %A_ScriptDir%\tmp\%numero%.html
        Loop , parse , page , `n
        {
          line := A_LoopField
          outputdebug %line%
          if line contains http://vod.tv7.fi/vod/
          {
            StringGetPos, OutputVar, line, http, L
            StringTrimLeft, MP4, line, OutputVar
            break
          }
        }
      Lopullinen := SubStr(MP4, 1, InStr(MP4, "MP4") + 2)
      DownloadFile(Lopullinen, A_ScriptDir . "\tmp\" . numero . "\" . numero . ".mp4")
    }
}

Ohjelma(numero)
{
    IniRead, VLC, Lapsisoitin.ini, asetukset, VLC
    olemassa = %A_ScriptDir%\tmp\%numero%.txt
    olemassahtml = %A_ScriptDir%\tmp\%numero%.html
    If (FileExist(olemassa)) OR (FileExist(olemassahtml))
    {
        Run, %VLC% %A_ScriptDir%\tmp\%numero%\ --fullscreen --play-and-exit --no-sub-autodetect-file
        Sleep, 2000
        WinWaitClose, ahk_exe Vlc.exe
}
    WinWaitClose, ahk_exe FlickFetch.exe
}

Puhdistus()
{
  ; Tyhjennä tmp-kansio
  FileDelete, %A_ScriptDir%\tmp\1\*.*
  FileDelete, %A_ScriptDir%\tmp\2\*.*
  FileDelete, %A_ScriptDir%\tmp\3\*.*
  FileDelete, %A_ScriptDir%\tmp\4\*.*
  FileDelete, %A_ScriptDir%\tmp\5\*.*
  FileDelete, %A_ScriptDir%\tmp\6\*.*
  FileDelete, %A_ScriptDir%\tmp\7\*.*
  FileDelete, %A_ScriptDir%\tmp\*.txt

  ; Tuhotaan html-tiedostot
  FileDelete, %A_ScriptDir%\tmp\*.html
}
