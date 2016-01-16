#Include ./lib/INet.ahk

inputcheck("Server", "서버주소 입력")
inputcheck("User", "아이디 입력")
inputcheck("Pwd", "비밀번호 입력")
inputcheck("Port", "포트 입력 (기본값 21)")

INetOpen()
hFTP := INetConnect(Server, Port, User, Pwd, "ftp")

;정보 받은 토대로 ini파일 작성
if(hFTP)
{
IniWrite, %Server%, ftp.ini,Server,Server
IniWrite, %User%, ftp.ini,Server,User
IniWrite, %Pwd%, ftp.ini,Server,Pwd
IniWrite, %Port%, ftp.ini,Server,Port
INetCloseHandle(hFTP)
INetClose()
msgbox, 서버등록이 완료되었습니다.
IfNotExist, .\send.txt
	FileAppend,,send.txt
}else{
	INetClose()
	msgbox, 알려주신 정보로 FTP접근에 실패했습니다.`n따라서 해당 정보는 저장하지 않습니다.`nServer = %Server%`nUser = %User%`nPort = %port% 가 맞는지 확인해 주세요.
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
		msgbox, 빈내용입니다. 다시 입력하세요
		goto, check
		}
	}
}
