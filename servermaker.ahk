#Include ./lib/INet.ahk

inputcheck("Server", "�����ּ� �Է�")
inputcheck("User", "���̵� �Է�")
inputcheck("Pwd", "��й�ȣ �Է�")
inputcheck("Port", "��Ʈ �Է� (�⺻�� 21)")

INetOpen()
hFTP := INetConnect(Server, Port, User, Pwd, "ftp")

;���� ���� ���� ini���� �ۼ�
if(hFTP)
{
IniWrite, %Server%, ftp.ini,Server,Server
IniWrite, %User%, ftp.ini,Server,User
IniWrite, %Pwd%, ftp.ini,Server,Pwd
IniWrite, %Port%, ftp.ini,Server,Port
INetCloseHandle(hFTP)
INetClose()
msgbox, ��������� �Ϸ�Ǿ����ϴ�.
IfNotExist, .\send.txt
	FileAppend,,send.txt
}else{
	INetClose()
	msgbox, �˷��ֽ� ������ FTP���ٿ� �����߽��ϴ�.`n���� �ش� ������ �������� �ʽ��ϴ�.`nServer = %Server%`nUser = %User%`nPort = %port% �� �´��� Ȯ���� �ּ���.
}

inputcheck(a,b){
	check:
	if(a=="Port")
	inputbox, %a%, %b%,,,,,,,,,21
	else
	inputbox, %a%, %b%
	
	If Errorlevel
	{
		ExitApp
	}
	else
	{
		if(a==NULL)
		{
		msgbox, �󳻿��Դϴ�. �ٽ� �Է��ϼ���
		goto, check
		}
	}
}
