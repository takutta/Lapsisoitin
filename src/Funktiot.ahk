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
  FileRead , page , %A_ScriptDir%\tmp\%tv7nimi%.html
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
  DownloadFile(Lopullinen, A_ScriptDir . "\Lataukset\" . tv7nimi ".mp4")
}

Kumpi(osoite,numero)
{
    IfInString, osoite, tv7.fi
    {
    TV7(osoite, numero)
    return
    }
    else
    FileAppend, %osoite%`n, %A_ScriptDir%\tmp\urlit.txt
    Sleep, 1
}

Puhdistus()
{
  ; Tuhotaan ladatut videot
  FileDelete, %A_ScriptDir%\Lataukset\*.flv
  FileDelete, %A_ScriptDir%\Lataukset\*.mp4
  FileDelete, %A_ScriptDir%\Lataukset\*.srt
  FileDelete, %A_ScriptDir%\Lataukset\*.txt
  ; Tuhotaan urlit.txt -tiedosto
  FileDelete, %A_ScriptDir%\tmp\urlit.txt

  ; Tuhotaan html-tiedostot
  FileDelete, %A_ScriptDir%\tmp\*.html
}
