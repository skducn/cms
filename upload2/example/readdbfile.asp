<%
OPTION EXPLICIT
dim conn,rs
conn="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("dbase.mdb")
set rs=Server.CreateObject("adodb.recordset")
rs.Open "select * from FileInfo where id="&Request.QueryString("id"),conn,1,3
if rs.eof and rs.bof then
	Response.Write "û���ҵ����ļ�"
	else
	Response.ContentType =rs("FileMIME")
	if IsNull(rs("FileData")) then 
		Response.Write "�ļ�Ϊ�ջ�û������"
		else
		Response.BinaryWrite rs("FileData")
	end if
end if
rs.Close
set rs=nothing
%>