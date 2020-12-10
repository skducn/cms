<%		

' 1，获取服务器ip
Function getServerIp()
	getServerIp = Request.ServerVariables("Local_Addr")
End Function


' 2，获取客户端ip 
Function getClientIp()
	getClientIp = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
	if getClientIp =  "" Then 
		getClientIp = Request.ServerVariables("REMOTE_ADDR")
	end if 		
End Function


'3，退出系统
Function exitIndex()
	if session("userName") = "" then
		Session.Abandon()
		response.Redirect "index.html"
	end if
End Function

'----------------------- 退出 from admMain.asp
Function bMain()
if request("action")="exit" or session("userName") = "" then
Session.Abandon()
response.Redirect "../index.html"
end if 
End Function


Public Function getFolderSlt
Dim Path
getFolderSlt = split(server.mappath(Request.ServerVariables("SCRIPT_NAME")),"slt")(0)
End Function


'----------------------- 获取当前文件的路径
'getCurrentPath("main.asp") , 返回 d:\51\test\
Public Function getCurrentPath(currentFile)
getCurrentPath = split(server.mappath(Request.ServerVariables("SCRIPT_NAME")),currentFile)(0)
End Function



Sub TimeDelaySeconds(DelaySeconds)
SecCount = 0
Sec2 = 0
While SecCount < DelaySeconds + 1
Sec1 = Second(Time())
If Sec1 <> Sec2 Then
Sec2 = Second(Time())
SecCount = SecCount + 1
End If
Wend
End Sub


'----------------------- 遍历目录及所有文件 无连接 , 有_blank
sub ListFolderContents1(path,pjtId)   
	dim fs, folder, file, item, url
	set fs = CreateObject("Scripting.FileSystemObject")
	set folder = fs.GetFolder(path)
	for each item in folder.SubFolders
		ListFolderContents(item.Path)
	next
	for each item in folder.Files
		response.write "<a href='mp4.asp?videoName="&item.Name&"&pjtId="&pjtId&"' target='_blank'>"
		Response.Write(item.Name & "<br>" )
		response.write "</a>"
	
	next
end sub
	
'----------------------- 遍历目录及所有文件 无连接 ， 无_blank
sub ListFolderContents2(path,pjtId)
	dim fs, folder, file, item, url
	set fs = CreateObject("Scripting.FileSystemObject")
	set folder = fs.GetFolder(path)
	for each item in folder.SubFolders
		ListFolderContents(item.Path)
	next
	for each item in folder.Files
		response.write "<a href='../mp4.asp?videoName="&item.Name&"&pjtId="&pjtId&"' target='_blank'>"
		Response.Write("<br>" & item.Name)
		response.write "</a>"
	
	next
end sub

'----------------------- 遍历目录及所有文件 有链接点击后下载文件
sub ListFolderContents3(path)
     dim fs, folder, file, item, url
     set fs = CreateObject("Scripting.FileSystemObject")
     set folder = fs.GetFolder(path)
     Response.Write("<li><b>" & folder.Name & "</b> - " _
       & folder.Files.Count & " files, ")
     if folder.SubFolders.Count > 0 then
       Response.Write(folder.SubFolders.Count & " directories, ")
     end if
     Response.Write(Round(folder.Size / 1024) & " KB total." _
       & vbCrLf)
     Response.Write("<ul>" & vbCrLf)
     for each item in folder.SubFolders
       ListFolderContents(item.Path)
     next
     for each item in folder.Files
       url = MapURL(item.path)
       Response.Write("<li><a href=""" & url & """>" & item.Name & "</a> - " _
         & item.Size & " bytes, " _
         & "last modified on " & item.DateLastModified & "." _
         & "</li>" & vbCrLf)
     next
     Response.Write("</ul>" & vbCrLf)
     Response.Write("</li>" & vbCrLf)
end sub

function MapURL(path)
dim rootPath, url
'Convert a physical file path to a URL for hypertext links.
rootPath = Server.MapPath("/")
url = Right(path, Len(path) - Len(rootPath))
MapURL = Replace(url, "/", "/")
end function 
   
   
   
'----------------------- 目录是否存在
Function CheckDir(FolderPath)
'folderpath=Server.MapPath(".")&"\"&folderpath   ' 返回当前文件所在目录路径
Set fso = Server.CreateObject("Scripting.FileSystemObject")
If fso.FolderExists(FolderPath) then
	CheckDir = True  '存在
Else
	CheckDir = False  '不存在
End if
Set fso = nothing
End Function


'----------------------- 创建目录
Function CreateFolder(strFolderName) 
SET FSO=Server.CreateObject("Scripting.FileSystemObject") 
IF (FSO.FolderExists(strFolderName) = False) THEN 
	FSO.CreateFolder(strFolderName) 
END IF 
SET FSO=NOTHING 
END Function



'----------------------- 检查目录是否存在，不存在则创建
Function autoCreateFolder(strFolderName)
Set fso = Server.CreateObject("Scripting.FileSystemObject")
If not fso.FolderExists(strFolderName) then
	fso.CreateFolder(strFolderName) 
End if
Set fso = nothing
End Function



	
	
'----------------------- 文件是否存在
Function CheckFile(FilePath) 
Dim fso
' Filepath=Server.MapPath(FilePath)
Set fso = Server.CreateObject("Scripting.FileSystemObject")
If fso.FileExists(FilePath) then
  CheckFile = True  '存在
Else
  CheckFile = False  '不存在
End if
Set fso = nothing
End Function


'----------------------- 对特殊字符处理，用于excel等文件名等，如将文件名中". / \ ? [ ] : | *" 字符替换成"_" 
Function strTo_(strSource)
strSource = replace(strSource, "." ,"_")
strSource = replace(strSource, "/" ,"_")
strSource = replace(strSource, "\" ,"_")
strSource = replace(strSource, "?" ,"_")
strSource = replace(strSource, "[" ,"_")
strSource = replace(strSource, "]" ,"_")
strSource = replace(strSource, ":" ,"_")
strSource = replace(strSource, "|" ,"_")
strSource = replace(strSource, "*" ,"_")
strTo_ = strSource	
End Function







'*****************************************
'=适用版本：scscms V2.0
'=功    能：多种影音播放器转换
'=日    期：2013-08-08 08:08:08
'=技术支持：http://www.scscms.com/
'=过 程 名：Showmediacontent(mediaurl,w,h)  http://www.scscms.com/scs_img/flv.swf
'*****************************************
Function Showmediacontent(mediaurl,w,h)
    Dim mediacontent,Str
    Str=Lcase(mediaurl)
    If Instr(Str,".swf")<>0 Then
        mediacontent="<object codeBase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0"" classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" width="""&w&""" height="""&h&"""><param name=""movie"" value="""&mediaurl&"""><param name=""quality"" value=""high""><param name=""wmode"" value=""opaque""><embed src="""&mediaurl&""" quality=""high"" wmode=""transparent""  pluginspage=""http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash"" type=""application/x-shockwave-flash"" width="""&w&""" height="""&h&"""></embed></object>"
    ElseIf Instr(Str,".flv")<>0 Or Instr(Str,".mp4")<>0 Then

        Scs_script=Scs_script&"check_plugins('Flash');"&vbcrlf
        mediacontent="<object id=""vcastr3"" data=""/common/vcastr3.swf"" width="""&w&""" height="""&h&""" type=""application/x-shockwave-flash""><param name=""movie"" value=""/common/vcastr3.swf""/><param name=""allowFullScreen"" value=""true"" /><param name=""FlashVars"" value=""xml=<vcastr><channel><item><source>"&mediaurl&"</source></item></channel></vcastr>"" /></object>"& vbcrlf
    ElseIf  Instr(Str,".avi")<>0 Or Instr(Str,".wmv")<>0 Or Instr(Str,".asf")<>0 Or Instr(Str,".mov")<>0 Or Instr(Str,".mpg")<>0 Or Instr(Str,".mpeg")<>0 Then
        mediacontent="<object classid=""CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95"" class=""object"" id=""MediaPlayer"" width="""&w&""" height="""&h&"""><param name=""wmode"" value=""Opaque""><param name=""ShowStatusBar"" value=""1""><param name=""AutoStart"" value="""&mediaurl&"""><param name=""Filename"" value="""&mediaurl&"""><embed type=""application/x-oleobject"" codebase=""http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701"" flename=""mp"" src="""&mediaurl&""" width="""&w&""" height="""&h&"""></embed></object>"
    ElseIf Instr(Str,".rm")<>0 Or Instr(Str,".ram")<>0 Then
        Scs_script=Scs_script&"check_plugins('RealPlayer');"&vbcrlf
        mediacontent="<object classid=""clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA"" class=""object"" id=""RAOCX"" width="""&w&""" height="""&h-30&"""><param name=""autostart"" value=""true""><param name=""src"" value="""&mediaurl&"""><param name=""console"" value=""clip1""><param name=""controls"" value=""imagewindow""></object><br><object classid=""clsid:cfcdaa03-8be4-11cf-b84b-0020afbbccfa"" id=""video2"" width="""&w&""" height=""30""><param name=""autostart"" value=""true""><param name=""src"" value="""&mediaurl&"""><param name=""autostart"" value=""-1""><param name=""controls"" value=""controlpanel""><param name=""console"" value=""clip1""></object>"
    ElseIf Instr(Str,".mp3")<>0 Or Instr(Str,".wav")<>0 Or Instr(Str,".mid")<>0 Or Instr(Str,".wma")<>0 Then
        mediacontent="<embed src="""&mediaurl&""" width='"&w&"' height='"&h&"' type='application/x-mplayer2' loop='-1' showcontrols='1' ShowDisplay='0' ShowStatusBar='1' autostart='1'></embed>"
    Else
        mediacontent="<img src="""&mediaurl&""" onload=""javascript:DrawImage(this);"" onclick=""window.open(this.src);"" alt='点击将在新窗口查看全图'>"
    End If
    Showmediacontent=mediacontent
End Function
'flv.swf 是专门播放flv与mp4格式的，需要下载。mediaurl:视频地址,w:视频宽度,h:视频高度
'Response.write Showmediacontent("http://www.xxx.com/up/3.rm",400,300) '调用例子



'----------------------- 按钮颜色
' 颜色码对照表 http://www.sioe.cn/yingyong/yanse-rgb-16/
Function btnColor(color)
if color = "green" then
	btnColor =  "rgb(46,139,87)"  '海洋绿
elseif color = "CherryRed" then
	btnColor =  "rgb(255, 79, 115)"  '樱桃粉红色
elseif color = "SeaGreen" then
	btnColor =  "rgb(46,139,87)"  '海洋绿
elseif color = "SpringGreen" then
	btnColor =  "rgb(60,179,113)"  '春天的绿色
elseif color = "LightSeaGreen" then
	btnColor =  "rgb(32,178,170)"  '浅海洋绿	
elseif color = "GemBlue" then
	btnColor =  "rgb(1,188,255)"  '宝石蓝	
elseif color = "adsukiBean" then
	btnColor =  "rgb(155, 79, 115)"  '赤豆紫	
end if 
End Function



'-----------------------  初始化当前用户平台公共备忘录状态及用户昵称  
Function initialUserPlatformStatus()
dim rs1
Set rs1 = Server.CreateObject("Adodb.Recordset")
rs1.Open "Select * From tbl_platform where platformUser='"&session("userNickname")&"' order by platformId desc",conn,3,3
do while not rs1.eof
rs1("platformStatus") = "1"
rs1("platformUser") = ""
rs1.update
rs1.movenext
loop
rs1.close
set rs1 = nothing
End Function



'----------------------- 初始化当前平台的公共备忘录编辑状态
Function clearPlatformStatus()
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_platform where platformId="&platformId&"",conn,3,3
if session("userNickname") = rs("platformUser")  then  
rs("platformStatus") = "1"
rs("platformUser") = ""
rs.update
end if 
rs.close
End Function

%>

