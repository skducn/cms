<%OPTION EXPLICIT%><html>
<head>
<style type="text/css">
<!--
.p9{ font-size: 9pt; font-family: 宋体 }
td {font-size: 9pt}
.tx {height: 16px; width: 30px; border-color: black black #000000; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 1px; border-left-width: 0px; font-size: 9pt; background-color: #eeeeee; color: #0000FF}
.tx2 {height: 16px;border-top-width: 0px; border-right-width: 0px; border-bottom-width: 1px; border-left-width: 0px; font-size: 9pt; color: #0000FF; border-left-color:#000000; border-right-color:#000000; border-top-color:#000000; border-bottom-color:#000000}
.bt {border-left:1px solid #C0C0C0; border-top:1px solid #C0C0C0; font-size: 9pt; border-right-width: 1; border-bottom-width: 1; height: 16px; width: 80px; background-color: #EEEEEE; cursor: hand; border-right-style:solid; border-bottom-style:solid}
.tx1 { width: 400 ;height: 20px; font-size: 9pt; border: 1px solid; border-color: black black #000000; color: #0000FF}
-->
</style>
<script language="vbscript">
function addfile()
dim str
str="<table>"
if not IsNumeric (window.form1.filenum.value) then window.form1.filenum.value =1
for i=1 to window.form1.filenum.value
str=str&"<tr><td valign='middle'>文件"&i&":</td><td><input type='file' name='file"&i&"' class='tx1' value size='20'>　　保存为<input type='text' name='file"&i&"' size='20' class='tx2'></td></tr>"
next
window.uptd.innerHTML =str&"</table>"
end function
</script>
<title>无惧上传类</title>
</head>
<body bgcolor="#ffffff" class="p9" onload="addfile()">
<form method="post" name="form1" action="savetodb.asp" enctype="multipart/form-data">
  <table border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td><div align="center"><font color="#0000ff" size="5">无惧上传示例(保存到数据库)</font></div></td>
    </tr>
    <tr> 
      <td><table width="750" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#111111" style="BORDER-COLLAPSE: collapse">
          <tr> 
            <td height="27" colspan="2">上传 
              <input name="filenum" class="tx2" value="1" size="4">
              个文件　　 
              <input type="button" name="Button" class="bt" onclick="addfile" value="设 定">
            </td>
          </tr>
          <tr> 
            <td> <div id="uptd"> </div></td>
          </tr>
          <tr> 
            <td height="30" colspan="2" align="middle"> 
              <input type="submit" name="Button" class="bt" value="上 传">
              　　 
              <input type="reset" name="Button" class="bt" value="重 置">
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
  <table align="center">
    <tr>
      <td height="50" align="middle">版权所有　2002-2003　　梁无惧 <A href="mailto:yjlrb@21cn.com">yjlrb@21cn.com</a> <br>
        <a href="http://www.25cn.com">http://www.25cn.com </a>　　 
      </td>
    </tr>
    </table>

<table align="center" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" class="p9" style="border-collapse: collapse">
  <tr bgcolor="#CCCCCC"> 
    <td height="25" valign='middle'>　原文件路径　</td>
    <td  valign='middle'>　大小(字节)　</td>
    <td  valign='middle'>　保存名称　</td>
    <td  valign='middle'>　操作　</td>
  </tr>  
<%
dim conn,rs,i,ServerPath
conn="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("dbase.mdb")
set rs=Server.CreateObject("adodb.recordset")
rs.Open "select * from FileInfo",conn,1,3
if not (rs.BOF and rs.EOF) then
	ServerPath=GetFilePath(Request.ServerVariables("HTTP_REFERER"),"/")'取得在网站上的位置
	for i=1 to rs.RecordCount
	 %>
<tr> 
    <td height="20"  valign='middle'>　<%=rs("FilePath")%>　</td>
    <td  valign='middle'>　<%=rs("filesize")%>　</td>
    <td  valign='middle'>　<A HREF="<%=serverpath&"readdbfile.asp?id="&rs("id")%>"><%=rs("FileName")%></A>　</td>
    <td  valign='middle'>　<A HREF="<%=serverpath&"deldbfile.asp?id="&rs("id")%>">删除</A>　</td>
  </tr><%
	rs.MoveNext 
	next
%>
  <tr> 
    <td colspan="3" height="25" valign='middle'>　一共有<%=rs.RecordCount%>个文件</td>
  </tr>
<%
	rs.Close
	set rs=nothing
	end if
%>
</table>
</form>
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