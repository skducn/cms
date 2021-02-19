<%OPTION EXPLICIT%>
<%Server.ScriptTimeOut=5000%>

<html>
<head>
<title>文件上传</title>
<meta http-equiv="Content-Type" content="text/html;charset=gb2312">
<meta http-equiv="Content-Language" Content="zh-CN">

</head>

<body leftmargin="10" topmargin="10" bgcolor="#FFFFFF">

<!-- #include file="upload_5xsoft.inc" -->

<%
dim upload,file,formName,iCount,FolderNameNew
dim GuFolderPath,fso,GuFolder0,GuFileSize0,GuFileExt0,GuAutoName

set upload=new upload_5xsoft  '建立上传对象

	GuFolder0=""  '设定默认上传的目录，必须以“/”结束，可以为空
	GuFileSize0=2048  '设定默认允许上传的最大文件，单位:K，1024K=1M
	GuFileExt0="bmp|gif|jpg|jpeg|png|swf|rar|zip|txt"  '设定默认允许上传的文件类型
	GuAutoName="1"  '设定上传成功后的文件名是否自动重新命名或是使用原来的名称，1为是，0为否

	'Response.write upload.Version&"<br><br>"  '显示上传类的版本


if upload.form("GuFolderPath")<>"" then
	GuFolderPath=upload.form("GuFolderPath")
	call FolderNameCheck(GuFolderPath)
	GuFolderPath=upload.form("GuFolderPath")
	if right(GuFolderPath,1)<>"/" then GuFolderPath=GuFolderPath&"/"

elseif upload.form("GuFolderPath")="" and GuFolder0<>"" then
	GuFolderPath=GuFolder0
	call FolderNameCheck(GuFolderPath)
	GuFolderPath=GuFolder0
	if right(GuFolderPath,1)<>"/" then GuFolderPath=GuFolderPath&"/"

else
	GuFolderPath=""

end if


	iCount=0
'for each formName in upload.objForm  '列出所有form数据
'	Response.write formName&"="&upload.form(formName)&"<br>"
'next

	'Response.write "<br><br>"


for each formName in upload.objFile  '列出所有上传了的文件

	set file=upload.file(formName)

	if file.FileSize>0 then

		dim FileExtF,FileExtY,FileExtOK,ii,jj
		FileExtF=split(File.FileName,".")
		for jj=0 to ubound(FileExtF)
		next
		FileExtY=0
		FileExtOK=split(GuFileExt0,"|")
		
		for ii=0 to ubound(FileExtOK)
		if FileExtOK(ii)=FileExtF(jj-1) then
			FileExtY=1
		exit for
		end if
		next

		if FileExtY=0 then
			Htmend "上传失败，不允许上传的文件类型"

		elseif file.FileSize>GuFileSize0*1024 then
			Htmend "上传失败，单个文件大小超过限制，最大"&GuFileSize0&"*1024 字节，1K=1024字节"

		else
			dim FileNameOK
			if GuAutoName="1" then
				FileNameOK=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&iCount&"."&FileExtF(jj-1)
			else
				FileNameOK=file.FileName
			end if

			file.SaveAs Server.mappath(GuFolderPath&FileNameOK)  '保存文件
			'Response.write file.FilePath&file.FileName&"(大小:"&file.FileSize&" 字节) => "&GuFolderPath&FileNameOK&" 成功! <br>"
			iCount=iCount+1

		end if

	else
		Htmend "上传失败，请选择要上传的文件"

	end if

	set file=nothing

next

	set upload=nothing

	Htmend iCount&" 个文件上传成功!"


Sub FolderNameCheck(FolderNameNew)

	dim Letters,i,c
	Letters="+=:;,[]<>\|*?"
	for i=1 to len(FolderNameNew)
		c=mid(FolderNameNew,i,1)
		if inStr(Letters,c)<>0 then
		Htmend "上传失败，文件夹名称含有特殊字符"
	end if
	next

	GuFolderPath=server.MapPath(GuFolderPath)
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	if fso.FolderExists(GuFolderPath)=false then
		fso.CreateFolder(GuFolderPath)
	end if
	Set fso=nothing

End sub


Sub HtmEnd(Msg)
 set upload=nothing
 response.write "<br>"&Msg&" <br><br><input type=""button"" value="" 返 回 "" onclick=""javascript:history.back();""></body></html>"
 response.end
End sub
%>



</body> 
</html>

