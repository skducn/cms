<%OPTION EXPLICIT%>
<html>
<head>
<title>�����ݿ���ɾ���ļ�</title>
<style type="text/css">
<!--
.p9{ font-size: 9pt; font-family: ���� }
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body leftmargin="20" topmargin="20" class="p9">
<%
dim conn,rs
conn="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("dbase.mdb")
set rs=Server.CreateObject("adodb.recordset")
rs.Open "delete * From FileInfo where id="&Request.QueryString("id"),conn,1,3
set rs=nothing
Response.Write "�ѳɹ�ɾ���ļ�"
%>
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