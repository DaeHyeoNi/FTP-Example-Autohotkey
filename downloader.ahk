if !fileexist("ftp.ini"){
   msgbox, FTP ���������� ftp.ini�� �����ϴ�. ���� severmaker�� �������Ϻ��� ���弼��.
   exitapp
}

#Include ./lib/INet.ahk

Gui, Font, S13
Gui, Add, Text, x42 y250 w300 h60 vtimer, �ð�ǥ�� �����
Gui, Add, Text, x42 y330 w110 h40 , ������ :
Gui, Font, Underline cBlue
Gui, Add, Text, x112 y330 w220 h40 gPanel2, http://helloitstory.tistory.com
Gui, Font
Gui, Font, S13
Gui, Add, Text, x12 y9 w440 h220 vPanel, ������ ��ٸ�����~~
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
            GuiControl,,Panel,�޾ƿ� A���� : %A%
            Gui, Submit, nohide
            
            GuiControl,,timer,�������� : %User%@%Server%:%Port% `n(%A_Hour%�� %A_Min%�� %A_Sec%�ʿ� �޾ƿԽ��ϴ�)
            Gui, Submit, nohide
         }
         else
            Msgbox ���� �ٿ�ε� ���� : %A_LastError%

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