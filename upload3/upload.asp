<%OPTION EXPLICIT%>
<%Server.ScriptTimeOut=5000%>

<html>
<head>
<title>�ļ��ϴ�</title>
<meta http-equiv="Content-Type" content="text/html;charset=gb2312">
<meta http-equiv="Content-Language" Content="zh-CN">

</head>

<body leftmargin="10" topmargin="10" bgcolor="#FFFFFF">

<!-- #include file="upload_5xsoft.inc" -->

<%
dim upload,file,formName,iCount,FolderNameNew
dim GuFolderPath,fso,GuFolder0,GuFileSize0,GuFileExt0,GuAutoName

set upload=new upload_5xsoft  '�����ϴ�����

	GuFolder0=""  '�趨Ĭ���ϴ���Ŀ¼�������ԡ�/������������Ϊ��
	GuFileSize0=2048  '�趨Ĭ�������ϴ�������ļ�����λ:K��1024K=1M
	GuFileExt0="bmp|gif|jpg|jpeg|png|swf|rar|zip|txt"  '�趨Ĭ�������ϴ����ļ�����
	GuAutoName="1"  '�趨�ϴ��ɹ�����ļ����Ƿ��Զ�������������ʹ��ԭ�������ƣ�1Ϊ�ǣ�0Ϊ��

	'Response.write upload.Version&"<br><br>"  '��ʾ�ϴ���İ汾


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
'for each formName in upload.objForm  '�г�����form����
'	Response.write formName&"="&upload.form(formName)&"<br>"
'next

	'Response.write "<br><br>"


for each formName in upload.objFile  '�г������ϴ��˵��ļ�

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
			Htmend "�ϴ�ʧ�ܣ��������ϴ����ļ�����"

		elseif file.FileSize>GuFileSize0*1024 then
			Htmend "�ϴ�ʧ�ܣ������ļ���С�������ƣ����"&GuFileSize0&"*1024 �ֽڣ�1K=1024�ֽ�"

		else
			dim FileNameOK
			if GuAutoName="1" then
				FileNameOK=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&iCount&"."&FileExtF(jj-1)
			else
				FileNameOK=file.FileName
			end if

			file.SaveAs Server.mappath(GuFolderPath&FileNameOK)  '�����ļ�
			'Response.write file.FilePath&file.FileName&"(��С:"&file.FileSize&" �ֽ�) => "&GuFolderPath&FileNameOK&" �ɹ�! <br>"
			iCount=iCount+1

		end if

	else
		Htmend "�ϴ�ʧ�ܣ���ѡ��Ҫ�ϴ����ļ�"

	end if

	set file=nothing

next

	set upload=nothing

	Htmend iCount&" ���ļ��ϴ��ɹ�!"


Sub FolderNameCheck(FolderNameNew)

	dim Letters,i,c
	Letters="+=:;,[]<>\|*?"
	for i=1 to len(FolderNameNew)
		c=mid(FolderNameNew,i,1)
		if inStr(Letters,c)<>0 then
		Htmend "�ϴ�ʧ�ܣ��ļ������ƺ��������ַ�"
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
 response.write "<br>"&Msg&" <br><br><input type=""button"" value="" �� �� "" onclick=""javascript:history.back();""></body></html>"
 response.end
End sub
%>



</body> 
</html>

