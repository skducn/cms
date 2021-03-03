<!--#include file="menu.asp"-->
<!--#include file="ajaxMain.asp"-->



<!-- 新增快捷键 -->

<%
if request("action")="saveShort" then
	set rs = server.CreateObject("adodb.recordset")
	rs.open "select * from tblKey where userId="&session("userId")&"",conn,3,3
	rs.addnew
	rs("userId") = session("userId")
	rs("keyName") = request("keyName")
	keyLink = request("keyLink")
	if instr(keyLink,"http://")>0 or  instr(keyLink,"https://")>0 then
		rs("keyLink") = keyLink
	else
		rs("keyLink") = "http://" + keyLink 
	end if
	rs("KeySort") = 3
	rs("keyWay") = "查看文章"
	rs.update 
	rs.close
	set rs = nothing  
	Response.Redirect("article-"&request("cId")&"-"&request("sortId")&".html")
end if
%>
	

<!-- 共享文章 -->

<% 
if request("action")="share" then 
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblContent where cId="&request("cId")&"",conn,3,3
	if rs.eof then
		response.end 
	else
		rs("cShare") = "on"
		rs("cShareDate") = now()
		rs.update
	end if 
	rs.close
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblUser where userId="&session("userId")&"",conn,3,3
	rs("userShare") = "on"
	rs.update
	rs.close
	set rs = nothing 
end if 
%> 	
 
<!-- 取消共享文章 -->

<% 
if request("action")="noshare" then 
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblContent where cId="&request("cId")&"",conn,3,3
	if rs.eof then
		response.end 
	else
		rs("cShare") = "off"
		rs("cShareDate") = Null
		rs.update
	end if 
	rs.close
	set rs = nothing 
end if 
%> 	

<!-- 防打开未共享的文章 -->

<%set rs = server.createobject("adodb.recordset")
rs.open "select * from tblContent where cId="&int(request("cId"))&"",conn,3,3
if session("userName") <> rs("userName") and rs("cShare")= "off" then
	set rs1 = server.createobject("adodb.recordset")
	rs1.open "select * from tblSort where sortId="&rs("sortId")&"",conn,3,3
		if session("userPower") <>5 then
		
		elseif rs1("sortShare") = "off" then
			response.Redirect("index.html")	
		end if 
	rs1.close
end if 
rs.close
%>

  
<div class="content-wrapper">
<div class="row">
<div class="col-md-12">
<div class="card">
<div class="card-body">

<!-- 用于页面百分比显示2/3 , 放在这里百分比在最高浮层 -->
<div id="percentageCounter"><h1>0%</h1></div>	

	<%set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblContent where cId="&int(request("cId"))&"",conn,3,3	
	if rs.eof then
		' 安全处理，方式url修改无效id
		Response.Write("<script>window.open('index.html','_parent')</script>")
	else%>	
		<title><%=rs("cName")%> | <%=cstProject%></title>				
		
		<div class="row">
		
			<div class="col-md-2">
					<!-- 面包削-->
				<% set rs1 = server.createobject("adodb.recordset")
				rs1.open "select * from tblSort where sortId="&rs("sortId")&"" ,conn,3,3      	
				if rs("tagId")="0" then%>
				<i class="fa fa-home fa-lg"></i> &rsaquo; <%=rs1("sortName")%>
				<%else
				set rs2 = server.createobject("adodb.recordset")			
				rs2.open "select * from tblTag where tagId="&rs("tagId")&"" ,conn,3,3
				%> <i class="fa fa-home fa-lg"></i> &rsaquo; <%=rs1("sortName")%> &rsaquo;
				<a href="searchTag-<%=rs2("tagId")%>.html"><%=rs2("tagName")%></a>
				<%rs2.close 
				set rs2 = nothing 
				end if
				rs1.close
				set rs1 = nothing
				%>	
			</div>

			
		
			<div class="col-md-10" align="right">							
				<%set rs7 = server.CreateObject("adodb.recordset")
				rs7.open "select * from tblKey where userId="&session("userId")&" and keySort=3 order by keyId",conn,3,3 
				do while not rs7.eof %>
				
					<a style="color:white" class=" btn shortkeyb" href="<%=rs7("keyLink")%>" class="btn btn-success" data-toggle="tooltip" data-original-title="<%=rs7("keyLink")%>" target="_blank"><i class="fa fa-location-arrow"></i>&nbsp;<%=rs7("keyName")%></a>										
				<%rs7.movenext
				loop
				rs7.close%>	
																		
				<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"> </i> 快捷键</button>									
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"><br><br><br><br><br><br><br><br>
					<div class="modal-dialog" role="document">
						<div class="modal-content">								
							<form action="articleSaveShort.html" method="post" name="addForm1"  class="login-form" onSubmit="return shortcutKeyCheck()" >		
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">×</span>
									</button>
									<h4 class="modal-title" align="left" id="myModalLabel">新增快捷键</h4>
								</div>
								<div class="modal-body">
									<div class="form-group" align="left">
										<label class="control-label"><h5>快捷名称</h5></label>
										<input class="form-control" type="text" name="keyName" placeholder="baidu">
									</div>
									<div class="form-group" align="left">
										<label class="control-label"><h5>快捷网址URL</h5></label>
										<input class="form-control" type="text" name="keyLink" placeholder="http://www.baidu.com">
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
									<button class="btn btn-primary " type="submit">提交</button>
								</div>	
									<input type="hidden" name="cId" value="<%=request("cId")%>">			
									<input type="hidden" name="sortId" value="<%=request("sortId")%>">			
							</form>										
						</div>
					</div>
				</div>
				
				<div class="btn-group">	
				<% if session("userName")= rs("userName") then %>																																																								
					<a class="btn btn-primary" target="_blank" href="articleAdd-<%=rs("sortId")%>-<%=rs("tagId")%>.html" data-toggle="tooltip" data-original-title="新建"><i class="fa fa-plus"></i></a>								
					<a class="btn btn-info" href="articleEdit-<%=request("cId")%>.html" data-toggle="tooltip" data-original-title="编辑"><i class="fa fa-edit"></i></a>
					<a class="btn btn-warning" href="#" onClick="ajaxSort();" data-toggle="tooltip" data-original-title="转移"><i class="fa fa-truck"></i></a>
					<% if rs("cShare") = "on" then%>
						<a class="btn btn-default" onClick="checkNoShare()" href="articleNoshare-<%=request("cId")%>-<%=request("sortId")%>.html"  data-toggle="tooltip" data-original-title="取消共享"><i class="fa fa-reply"></i></a>
					<%else%>
						<a class="btn btn-success" onClick="checkShare()" href="articleShare-<%=request("cId")%>-<%=request("sortId")%>.html"  data-toggle="tooltip" data-original-title="共享"><i class="fa fa-share"></i></a>
					<%end if
				end if %>	
				</div>
							
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>
			</div> 
		</div> <!-- row end -->
	
											
		<hr> 					

		<div class="row">
		
			<div class="col-md-2">
				<%set rs9 = server.CreateObject("ADODB.RecordSet")
				rs9.Open "select * from tblUser where userName='"&rs("userName")&"'",conn,3,3%>		
				
				<div class="pull-left image"><img class="img-circle" src="<%=rs9("userHead")%>" alt="User Image"></div>
				<p></p>				<p></p>				<p></p><p></p>				<p></p>				<p></p><p></p>				<p></p>				<p></p><p></p>				<p></p>				<p></p>
				<h3><b><font color="#CC6600">&nbsp;&nbsp;<%=rs9("userNickName")%></font></b></h3>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;<%=rs9("userTitle")%></p>	
				<%rs9.close%>	
				
			
				
			
				
			</div>
			

		
			<div class="col-md-10">						
				<h3 class="card-title"><%=rs("cName")%></h3>		
						
				<%if rs("cLatestDate") <> "" then%>
					创建于：<%=rs("cLatestDate")%>
				<%else%>
					创建于：<%=rs("cCrtDate")%>								
				<%end if %>									
			</div>
							
		
					
			<!-- 文章转移 三联动 -->	
			<% if session("userName")= rs("userName") then %>																								
				<div id="ajaxSortDiv"></div>
				<div id="ajaxTagDiv"></div>
				<div id="ajaxInfoDiv"></div>						
			<%end if %>	
		</div> <!-- row end -->					
						
		<!-- 文章内容 -->
		<br><%=rs("cContent")%><br>
																		
						
						
					
			</a><a id='DD'></a>		
						
	<%
	end if
	rs.close
	set rs = nothing 
	%>											
</div>
</div>			
</div>
</div>	
</div>	



</body>
</html>

<!-- top -->
<a href="#0" class="cd-top">Top</a>

<!-- 表格 -->
<script  src="js/table/custom.js"></script>


<!-- 左侧菜单，放在每个页面底部-->
<script src="js/menu/jquery-2.1.4.min.js"></script>
<script src="js/menu/bootstrap.min.js"></script>
<script src="js/menu/plugins/pace.min.js"></script>
<script src="js/menu/main.js"></script>
<script src="js/shortcutKey/bootstrap-notify.min.js"></script>