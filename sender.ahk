#Include ./lib/INet.ahk

iniread, server, ftp.ini, Server, Server
iniread, User, ftp.ini, Server, User
iniread, Pwd, ftp.ini, Server, Pwd
iniread, port, ftp.ini, Server, Port

IfNotExist, .\send.txt
{
   msgbox, send.txt ������ ���׿� �� send.txt������ �����մϴ�.
   FileAppend,,send.txt
}

INetOpen()
hFTP := INetConnect(Server, Port, User, Pwd, "ftp")

if(hFTP)
{
   if(FtpPutFile(hFTP, "send.txt")) ;�ؽ�Ʈ������ ������.
   Msgbox ���� ���ε� ����
   else
      Msgbox ���� ���ε� ���� : %A_LastError%

   INetCloseHandle(hFTP)
}
INetClose()