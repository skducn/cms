<%OPTION EXPLICIT%>
<!--#include FILE="upfile_class.asp"-->
<%
dim upfile,formPath,ServerPath,FSPath,formName,FileName,oFile,rs,conn
set upfile=new upfile_class ''�����ϴ�����
upfile.NoAllowExt="asp;exe;htm;html;aspx;cs;vb;js;"	'�����ϴ����͵ĺ�����
upfile.GetData (10240000)   'ȡ���ϴ�����,��������ϴ�10M
%>
<html>
<head>
<title>�ļ��ϴ�</title>
<style type="text/css">
<!--
.p9{ font-size: 9pt; font-family: ���� }
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body leftmargin="20" topmargin="20" class="p9">
<p class="tx1"><font color="#0000FF" size="4"><%=upfile.Version%> </font></p>
<hr size=1 noshadow width=300 align=left><%
if upfile.isErr then  '�������
    select case upfile.isErr
	case 1
	Response.Write "��û���ϴ�����ѽ???�ǲ��Ǹ����??"
	case 2
	Response.Write "���ϴ����ļ��������ǵ�����,���10M"
	end select
	else
	'�����ķ��������ý��ϰ汾Access�����������������ӷ���	'connstr="driver={Microsoft Access Driver (*.mdb)};dbq=" & Server.MapPath("dbbase.mdb")	conn="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("dbase.mdb")
	set rs=Server.CreateObject("adodb.recordset")
	rs.Open "select * from FileInfo",conn,1,3
	FSPath=GetFilePath(Server.mappath("upfile.asp"),"\")'ȡ�õ�ǰ�ļ��ڷ�����·��
	ServerPath=GetFilePath(Request.ServerVariables("HTTP_REFERER"),"/")'ȡ������վ�ϵ�λ��
%>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" class="p9" style="border-collapse: collapse">
  <tr bgcolor="#CCCCCC"> 
    <td height="25" valign='middle'>�������ļ���</td>
    <td  valign='middle'>����С(�ֽ�)��</td>
    <td  valign='middle'>���ϴ�����</td>
    <td  valign='middle'>��״̬��</td>
  </tr>  
<%
	for each formName in upfile.file '�г������ϴ��˵��ļ�
	   set oFile=upfile.file(formname)
	   FileName=upfile.form(formName)'ȡ���ı����ֵ
	   if not FileName>"" then  FileName=oFile.filename'���û�������µ��ļ���,����ԭ�����ļ���
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
    <td height="20"  valign='middle'>��<%=oFile.FilePath&oFile.FileName%>��</td>
    <td  valign='middle'>��<%=oFile.filesize%>��</td>
    <td  valign='middle'>��<A HREF="<%if upfile.isAllowExt(oFile.FileExt) then Response.Write serverpath&"readdbfile.asp?id="&rs("id")%>"><%=FileName%></A>��</td>
    <td  valign='middle'>��<%
    if upfile.isAllowExt(oFile.FileExt) then 
		Response.Write "�ϴ��ɹ�"
		else
		Response.Write "�������ϴ�������"
	end if
		%>��</td>

  </tr><%
	 set oFile=nothing
	next
%>
  <tr> 
    <td colspan="3" height="25" valign='middle'>��һ���ϴ���<%=upfile.file.Count%>���ļ�</td>
  </tr>
<%
rs.Close
set rs=nothing
end if
set upfile=nothing  'ɾ���˶���
%>
</table>
<p></p>

</p>[<a href="upfiletodb.asp">����</a>]
  <table align="center" class="p9">
    <tr>
      <td height="50" align="middle">��Ȩ���С�2002-2003�������޾� <A href="mailto:yjlrb@21cn.com">yjlrb@21cn.com</a> <br>
        <a href="http://www.25cn.com">http://www.25cn.com </a>���� 
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