<!--#include file="menu.asp"-->

<title>搜一搜 | <%=cstCompany%></title>

<div class="content-wrapper">
	<div class="row">	



		  
<!--  搜索，条件只能搜索类别和标签开启的文章 -->		

<%if request("action")="search" then
	s_name = request("s_name")	
	if s_name = "" then 
		response.write("<script language=JavaScript>history.back();</script>") 
		response.end 
	end if 
	s_named=LCase(s_name)   '''将字符串全部转小写     's_named=UCase(s_namex)   ''' 将字符串全部转大写
	s_named=replace(s_named,"'","’")    'asp在access中不支持'和[ 符号
	s_named=replace(s_named,"[","’")    'asp在access中不支持'和[ 符号	
	set rs = server.createobject("adodb.recordset") 
	rs.open "select * from tblContent where userName='"&session("userName")&"' and cState='on' and cName like '%"&s_named&"%' order by cName asc",conn,3,3
	if rs.recordcount = 0  then	%>
		<div class="col-md-12">
			<div class="card">
					<h1><i class="fa fa-exclamation-circle"></i> 很抱歉，没有找到&nbsp;“<%=s_name%>”</h1><br>
				<p>请缩减关键字继续查询...</p>
				<%
				set rs4 = server.createobject("adodb.recordset") 
				rs4.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on'",conn,3,3
				if not rs4.eof then%>
				<p><a class='btn btn-primary' href='articleAdd-0-0.html'><i class='fa fa-plus'></i>&nbsp;新建文章</a></p>
				<%end if %>
			</div>
		</div>
		<%response.end 			
	end if 	
	i = rs.recordcount	
	redim arrayCid(i),arraySortName(i),arrayTagName(i),arrayAuthor(i),arrayTitle(i),arrayCrtDate(i),arrayDate(i),arrayShare(i),arrayShareDate(i),arraySortId(i),arrayTagId(i)		
	x = 0
	do while not rs.eof
		if 	rs("tagId") = 0 then
			set rs1 = server.createobject("adodb.recordset") 
			rs1.open "select * from tblSort where sortId="&rs("sortId")&" ",conn,3,3
			if rs1("sortState") = "on" then	
				arraySortId(x) = rs("sortId")
				arrayTagId(x) = rs("tagId")
				arrayCid(x) = rs("cId")			
				arraySortName(x) = rs1("sortName")
				arrayTagName(x) = ""
				arrayTitle(x) = replace(rs("cName"),s_named,"<font color='#ff3399'>"&s_named&"</font>")		
				arrayCrtDate(x) = rs("cCrtDate")
				if rs("cLatestDate") <> "" then
					arrayDate(x) = rs("cLatestDate")			
				end if 			
				if rs("cShare")	= "on" then			
					arrayShare(x) = "已共享"
				else
					arrayShare(x) = rs("cShare")									
				end if 				
				arrayShareDate(x) = rs("cShareDate")				
				arrayAuthor(x) = rs("userName")
				x = x + 1			
			end if 
			rs1.close
		else
			set rs1 = server.createobject("adodb.recordset") 
			rs1.open "select * from tblSort where sortId="&rs("sortId")&" ",conn,3,3
			if rs1("sortState") = "on" then
				set rs2 = server.createobject("adodb.recordset") 
				rs2.open "select * from tblTag where sortId="&rs1("sortId")&" ",conn,3,3
				do while not rs2.eof
					if rs2("tagState") = "on" and rs2("tagId") = rs("tagId") then
						arraySortId(x) = rs("sortId")
						arrayTagId(x) = rs("tagId")
						arrayCid(x) = rs("cId")			
						arrayTitle(x) = replace(rs("cName"),s_named,"<font color='#ff3399'>"&s_named&"</font>")								
						arraySortName(x) = rs1("sortName")
						arrayTagName(x) = rs2("tagName")
						arrayCrtDate(x) = rs("cCrtDate")
						if rs("cLatestDate") <> "" then
							arrayDate(x) = rs("cLatestDate")						
						end if 			
						if rs("cShare")	= "on" then			
							arrayShare(x) = "已共享"
						else
							arrayShare(x) = rs("cShare")									
						end if				
						arrayShareDate(x) = rs("cShareDate")	
						arrayAuthor(x) = rs("userName")
						x = x + 1	
						
					end if 
				rs2.movenext
				loop	
			end if 
			rs1.close
		end if 
	rs.movenext
	loop %>
	
	<div class="col-md-12">
		<div class="card">							
			<div class="row">
				<div class="col-md-6">
					<h3 class="card-title">搜索 <%=s_name%> 记录数：<%=ubound(arrayTitle)%>条</h3>
				</div>
				<div class="col-md-6" align="right">
					<a class='btn btn-primary' href='articleAdd-0-0.html' data-toggle="tooltip" data-original-title="新建文章">新建<i class='fa fa-plus'></i></a>		
					<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底">到页底<i class="fa fa-arrow-circle-down"></i></a>		
				</div>
			</div>
			
			<table class="table table-hover table-bordered" id="search_record">
				<thead><tr>
				<th style="width: 8%">类别</th>
				<th style="width: 8%">标签</th>
				<th style="width: 30%">文章名称3</th>
				<th style="width: 8%">创建者</th>
				<th style="width: 13%">创建时间</th>
				<th style="width: 13%">更新时间</th>
				<th style="width: 7%">共享状态</th>
				<th style="width: 13%">共享时间</th>
				</tr>
				</thead>
				<tbody>			
				<%for i=0 to ubound(arrayTitle)-1 %>
					<tr>						
						<td><a href="searchSort-<%=arraySortId(i)%>.html"><%response.write arraySortName(i)%></a></td>
						<td><a href="searchTag-<%=arrayTagId(i)%>.html"><%response.write arrayTagName(i)%></a></td>
						<td><a href="searchResult-<%=arrayCid(i)%>.html"><%response.write arrayTitle(i)%></a></td>
						<td><%response.write arrayAuthor(i)%></td>
						<td><%response.write arrayCrtDate(i)%></td>
						<td><%response.write arrayDate(i)%></td>
						<td><%if arrayShare(i) <> "off" then
								response.write arrayShare(i)
							end if %>
						</td>
						<td><%response.write arrayShareDate(i)%></td>						
					</tr>
				<% next %>						
				</tbody>
			</table>
				
			<!-- 两个top按钮 -->
			<hr>
			<div class="row">
				<div class="col-md-2">
				</div>
				<div class="col-md-10" align="right">
					<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶">回页顶<i class="fa fa-arrow-circle-up"></i></button></a>
					<a id='DD'></a>
				</div>
			</div>
		</div>
	</div>
			
	
<%	
rs.close
set rs = nothing
end if 
%>

</div>	
</div>

</body>
</html>

<!-- 表格 -->
<script  src="js/table/custom.js"></script>

 <!-- 左侧菜单，放在每个页面底部-->
<script src="js/menu/jquery-2.1.4.min.js"></script>
<script src="js/menu/bootstrap.min.js"></script>
<script src="js/menu/plugins/pace.min.js"></script>
<script src="js/menu/main.js"></script>
<script  src="js/shortcutKey/bootstrap-notify.min.js"></script>
