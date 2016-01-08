#Include ./lib/INet.ahk

Gui, Font, S13
Gui, Add, Text, x42 y300 w300 h20 vtimer, 시간표시 대기중
Gui, Add, Text, x42 y330 w110 h40 , 제작자 :
Gui, Font, Underline cBlue
Gui, Add, Text, x112 y330 w220 h40 gPanel2, http://helloitstory.tistory.com
Gui, Font
Gui, Font, S13
Gui, Add, Text, x12 y9 w440 h200 vPanel, 정보를 기다리는중~~
Gui, Show, w479 h379, Server

iniread, server, ftp.ini, Server, Server
iniread, User, ftp.ini, Server, User
iniread, Pwd, ftp.ini, Server, Pwd
iniread, port, ftp.ini, Server, Port

IfNotExist, .\down
FileCreateDir, .\down

Loop{
   INetOpen()
      hFTP := INetConnect(Server, Port, User, Pwd, "ftp")
      
      if(hFTP)
      {
         if(FtpGetFile(hFTP, "send.txt",".\down\result.txt",,1))
         {
            FileRead, A, .\down\result.txt
            GuiControl,,Panel,받아온 A값은 : %A%
            Gui, Submit, nohide
            
            GuiControl,,timer,(%A_Hour%시 %A_Min%분 %A_Sec%초에 받아왔습니다)
            Gui, Submit, nohide
         }
         else
            Msgbox 파일 다운로드 오류 : %A_LastError%

         INetCloseHandle(hFTP)
      }
      INetClose()
   sleep,5000
}
Panel2:
run, http://helloitstory.tistory.com
return

GuiClose:
ExitApp