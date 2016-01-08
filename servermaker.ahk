#Include ./lib/INet.ahk

global thiserror=0 ; Global various

loop{
inputbox, server_i, 서버주소 입력
inputcheck(server_i)
	if(thiserror=0)
		break
}

loop{
inputbox, id_i, 아이디 입력
inputcheck(id_i)
	if(thiserror=0)
		break
}

loop{
inputbox, pw_i, 비밀번호 입력
inputcheck(pw_i)
	if(thiserror=0)
		break
}

loop{
inputbox, port_i, 포트 입력 (기본값 21),,,,,,,,,21
inputcheck(port_i)
	if(thiserror=0)
		break
}

;정보 받은 토대로 FTP서비스 접근되면 저장
Server = %server_i%
User = %id_i%
Pwd = %pw_i%
Port = %port_i%
INetOpen()
hFTP := INetConnect(Server, Port, User, Pwd, "ftp")

;정보 받은 토대로 ini파일 작성
if(hFTP)
{
IniWrite, %server_i%, ftp.ini,Server,Server
IniWrite, %id_i%, ftp.ini,Server,User
IniWrite, %pw_i%, ftp.ini,Server,Pwd
IniWrite, %port_i%, ftp.ini,Server,Port
INetCloseHandle(hFTP)
INetClose()
msgbox, 서버등록이 완료되었습니다.
IfNotExist, .\send.txt
	FileAppend,,send.txt
}else{
	INetClose()
	msgbox, 알려주신 정보로 FTP접근에 실패했습니다.`n따라서 해당 정보는 저장하지 않습니다.`nServer = %Server%`nUser = %User%`nPort = %port% 가 맞는지 확인해 주세요.
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
		msgbox, 빈내용입니다. 다시 입력하세요
		thiserror = 1
		}
	}
}