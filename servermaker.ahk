#Include ./lib/INet.ahk

global thiserror=0 ; Global various

loop{
inputbox, server_i, �����ּ� �Է�
inputcheck(server_i)
	if(thiserror=0)
		break
}

loop{
inputbox, id_i, ���̵� �Է�
inputcheck(id_i)
	if(thiserror=0)
		break
}

loop{
inputbox, pw_i, ��й�ȣ �Է�
inputcheck(pw_i)
	if(thiserror=0)
		break
}

loop{
inputbox, port_i, ��Ʈ �Է� (�⺻�� 21),,,,,,,,,21
inputcheck(port_i)
	if(thiserror=0)
		break
}

;���� ���� ���� FTP���� ���ٵǸ� ����
Server = %server_i%
User = %id_i%
Pwd = %pw_i%
Port = %port_i%
INetOpen()
hFTP := INetConnect(Server, Port, User, Pwd, "ftp")

;���� ���� ���� ini���� �ۼ�
if(hFTP)
{
IniWrite, %server_i%, ftp.ini,Server,Server
IniWrite, %id_i%, ftp.ini,Server,User
IniWrite, %pw_i%, ftp.ini,Server,Pwd
IniWrite, %port_i%, ftp.ini,Server,Port
INetCloseHandle(hFTP)
INetClose()
msgbox, ��������� �Ϸ�Ǿ����ϴ�.
IfNotExist, .\send.txt
	FileAppend,,send.txt
}else{
	INetClose()
	msgbox, �˷��ֽ� ������ FTP���ٿ� �����߽��ϴ�.`n���� �ش� ������ �������� �ʽ��ϴ�.`nServer = %Server%`nUser = %User%`nPort = %port% �� �´��� Ȯ���� �ּ���.
}

inputcheck(a){
	thiserror=0
	If Errorlevel
	{
		ExitApp
	}
	else
	{
		if(a==NULL)
		{
		msgbox, �󳻿��Դϴ�. �ٽ� �Է��ϼ���
		thiserror = 1
		}
	}
}