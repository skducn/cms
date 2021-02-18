<!--#include file="conn.asp"-->


<div class="col-md-2">
<br />
	<%
	response.charset = "gb2312"
	sortId = request.querystring("sortId")
	set rs = server.createobject("adodb.recordset") 
	rs.open "select * from tblTag where sortId="&sortId&" and tagState='on' order by tagName asc",conn,3,3 %>
	<select name="tagId"  onchange="ajaxInfo(this.value)" class="form-control">
	标签 *<option  value="" selected> 移动到标签 ...</option>
	<option value="sortId<%=sortId%>"> / </option>
	<% do while not rs.eof%>
	<option value="<%=rs("tagId")%>"><%=rs("tagName")%></option>
	<%rs.movenext   
	loop%>
	</select>
	
	<%
	rs.close
	set rs = nothing%>
	
</div>




	




