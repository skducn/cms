<%OPTION EXPLICIT%>
<html>
<head>
<title>从数据库中删除文件</title>
<style type="text/css">
<!--
.p9{ font-size: 9pt; font-family: 宋体 }
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
Response.Write "已成功删除文件"
%>
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