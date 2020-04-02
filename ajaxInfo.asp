<!--#include file="conn.asp"-->

<div class="col-md-6">
<br />
	<%
	response.charset = "gb2312"  
	tagId = request("tagId")
	if instr(tagid,"sortId")>0 then
		sortId1 = replace(tagid,"sortId","") 
	end if 

	set rs = server.createobject("adodb.recordset") 
	rs.open "select * from tblContent where cId="&request("cId")&"",conn,3,3

	if instr(tagId,"sortId")>0 then
		rs("tagId") = 0
		rs("sortId")= cint(sortId1)
		rs.update
		set rs2 = server.createobject("adodb.recordset") 
		rs2.open "select * from tblSort where sortId="&rs("sortId")&"",conn,3,3
		'response.write "<font color=blue>"
		'response.write "转移成功 至【"&rs2("sortName")&"】，"
		'response.write "</font>"
	

		rs2.close
		set rs2 = nothing
		Response.Write("<script>window.open('main.asp','_parent')</script>")

	else
		set rs1 = server.createobject("adodb.recordset") 
		rs1.open "select * from tblTag where tagId="&tagId&"",conn,3,3
		rs("tagId") = rs1("tagId")
		rs("sortId")= rs1("sortId")	
		rs.update
		set rs2 = server.createobject("adodb.recordset") 
		rs2.open "select * from tblSort where sortId="&rs1("sortId")&"",conn,3,3		
		'response.write "转移成功 至【"&rs2("sortName")&" - "&rs1("tagName")&"】，"
		
		rs2.close
		set rs2 = nothing
		rs1.close
		set rs1 = nothing	
	end if 
	rs.close
	set rs = nothing
	'response.Write("<a href='dashboard.html' target='_parent'> 请刷新</a>") 
	
	%>
	<a class="btn btn-warning icon-btn" href="article-<%=request("cId")%>-<%=cint(sortId1)%>.html" target="_parent"> <i class="fa fa-fw  fa-refresh"></i>&nbsp;刷新</a>
		 
</div>
