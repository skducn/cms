<%OPTION EXPLICIT%>
<!--#include FILE="upfile_class.asp"-->
<%
dim upfile,formPath,ServerPath,FSPath,formName,FileName,oFile,rs,conn
set upfile=new upfile_class ''建立上传对象
upfile.NoAllowExt="asp;exe;htm;html;aspx;cs;vb;js;"	'设置上传类型的黑名单
upfile.GetData (10240000)   '取得上传数据,限制最大上传10M
%>
<html>
<head>
<title>文件上传</title>
<style type="text/css">
<!--
.p9{ font-size: 9pt; font-family: 宋体 }
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body leftmargin="20" topmargin="20" class="p9">
<p class="tx1"><font color="#0000FF" size="4"><%=upfile.Version%> </font></p>
<hr size=1 noshadow width=300 align=left><%
if upfile.isErr then  '如果出错
    select case upfile.isErr
	case 1
	Response.Write "你没有上传数据呀???是不是搞错了??"
	case 2
	Response.Write "你上传的文件超出我们的限制,最大10M"
	end select
	else
	'如果你的服务器采用较老版本Access驱动，请用下面连接方法	'connstr="driver={Microsoft Access Driver (*.mdb)};dbq=" & Server.MapPath("dbbase.mdb")	conn="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("dbase.mdb")
	set rs=Server.CreateObject("adodb.recordset")
	rs.Open "select * from FileInfo",conn,1,3
	FSPath=GetFilePath(Server.mappath("upfile.asp"),"\")'取得当前文件在服务器路径
	ServerPath=GetFilePath(Request.ServerVariables("HTTP_REFERER"),"/")'取得在网站上的位置
%>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" class="p9" style="border-collapse: collapse">
  <tr bgcolor="#CCCCCC"> 
    <td height="25" valign='middle'>　本地文件　</td>
    <td  valign='middle'>　大小(字节)　</td>
    <td  valign='middle'>　上传到　</td>
    <td  valign='middle'>　状态　</td>
  </tr>  
<%
	for each formName in upfile.file '列出所有上传了的文件
	   set oFile=upfile.file(formname)
	   FileName=upfile.form(formName)'取得文本域的值
	   if not FileName>"" then  FileName=oFile.filename'如果没有输入新的文件名,就用原来的文件名
	   if upfile.isAllowExt(oFile.FileExt) then
			rs.AddNew 
			rs("FileData")=upfile.FileData(formname)
			rs("FileName")=FileName
			rs("FilePath")=oFile.FilePath&oFile.FileName
			rs("FileMIME")=oFile.FileMIME
			rs("FileExt")=oFile.FileExt
			rs("FileSize")=oFile.FileSize
			rs.Update
		end if
	 %>
<tr> 
    <td height="20"  valign='middle'>　<%=oFile.FilePath&oFile.FileName%>　</td>
    <td  valign='middle'>　<%=oFile.filesize%>　</td>
    <td  valign='middle'>　<A HREF="<%if upfile.isAllowExt(oFile.FileExt) then Response.Write serverpath&"readdbfile.asp?id="&rs("id")%>"><%=FileName%></A>　</td>
    <td  valign='middle'>　<%
    if upfile.isAllowExt(oFile.FileExt) then 
		Response.Write "上传成功"
		else
		Response.Write "不允许上传的类型"
	end if
		%>　</td>

  </tr><%
	 set oFile=nothing
	next
%>
  <tr> 
    <td colspan="3" height="25" valign='middle'>　一共上传了<%=upfile.file.Count%>个文件</td>
  </tr>
<%
rs.Close
set rs=nothing
end if
set upfile=nothing  '删除此对象
%>
</table>
<p></p>

</p>[<a href="upfiletodb.asp">返回</a>]
  <table align="center" class="p9">
    <tr>
      <td height="50" align="middle">版权所有　2002-2003　　梁无惧 <A href="mailto:yjlrb@21cn.com">yjlrb@21cn.com</a> <br>
        <a href="http://www.25cn.com">http://www.25cn.com </a>　　 
      </td>
    </tr>
    </table>

</body>
</html>

<%
function GetFilePath(FullPath,str)
  If FullPath <> "" Then
    GetFilePath = left(FullPath,InStrRev(FullPath, str))
    Else
    GetFilePath = ""
  End If
End function
%>