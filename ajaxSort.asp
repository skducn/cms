<!--#include file="conn.asp"-->


<div class="col-md-2">
<br />
	<select name="sortId"  onChange="ajaxTag(this.value)" class="form-control">
	<% 
	response.charset="gb2312"
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on' order by sortName,sortId asc",conn,3,3
%>	<option  value="" selected> 移动到类别 ...</option>
	<%do while not rs.eof%>
	<option value="<%=rs("sortId")%>" ><%=rs("sortName")%></option>
	<%
	rs.movenext
	loop
	rs.close
	set rs = nothing%>
	</select>
	
</div>	






