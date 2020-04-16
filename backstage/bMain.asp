<!--#include file="bFrame.asp"-->
<%=bMain%>

<%if session("userPower") = 1 then%>
	<title><%=cstCompany%> | 超管设置</title>
<%elseif session("userPower") = 3 then%>
	<title><%=cstCompany%> | 管理员设置</title>
<%else%>
	<title><%=cstCompany%> | 用户设置</title>
<%end if %>


<script language="javascript">
function CheckPost()
{
	// 快捷名称
	if (addForm.keyName.value == ""){
		alert("温馨提示，快捷名称不能为空！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.keyName.focus();
		return false;}	
	// 快捷链接
	if (addForm.keyLink.value == ""){
		alert("温馨提示，快捷链接不能为空！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.keyLink.focus();
		return false;}
	
	var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
 
</script>


<!-- 删除文章 -->

<%
if request("action")="del" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblKey where keyId="&request("keyId")&"",conn,3,3
	if rs.eof then
		response.Write("<script>;alert('"&cstWarn&"快捷键不存在！');window.location.href='bMain.html,'_parent'';</script>") 
	else
		rs.delete
		rs.update
	end if 
	rs.close
	set rs = nothing
	Response.Write("<script>window.open('bMain.html','_parent')</script>")
	response.end 
end if
%>

<!--  新增快捷键	-->

<% 
if request.form("sub")="sub" then
	keyLink = request.form("keyLink")
	keyName = request.form("keyName")
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblKey where keyName='"&keyName&"' and userId="&session("userId")&"",conn,3,3	
	if rs.eof then
		rs.addnew
		rs("userId") = session("userId")
		rs("keyName") = keyName
		rs("keyWay") = "我的面板"
		if request.form("keyName") = "case" then
			keyLink = Request.ServerVariables("LOCAL_ADDR")
		end if 
		if instr(keyLink,"http://")>0 or  instr(keyLink,"https://")>0 then
			rs("keyLink") = keyLink
		else
			rs("keyLink") = "http://" + keyLink 
		end if 	
	else	
		if instr(keyLink,"http://")>0 or  instr(keyLink,"https://")>0 then
			rs("keyLink") = keyLink
		else
			rs("keyLink") = "http://" + keyLink 
		end if 
	end if 
	rs.update
	response.Write("<script>;window.location.href='bMain.html';</script>")	
	rs.close
	set rs = nothing 
end if 
%>


<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title">仪表盘</h1>
			<p class="text-muted m-0 desc">Dashboard</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end">
			</div>
		</div>
	</div> 
	
	<!--  新增快捷键 -->
	
	<div class="row">
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header">						
					<div class="alert alert-primary" role="alert">我的面板之新增快捷键 / 所有页面之编辑快捷键</div>
					<div class="card-body">	
						<form method="post" name="addForm" onSubmit="return CheckPost()">   
						<div class="form-row">
							<div class="form-group col-md-4">
								<label>快捷名称 *（1-15）</label>
								<input type="text" name="keyName" maxlength="15" class="form-control"  placeholder="百度" />
							</div>
			
							<div class="form-group col-md-8">
								<label>快捷链接 *</label>
								<input type="text" name="keyLink"  maxlength="100" class="form-control"  placeholder="www.baidu.com">
							</div>
						</div>
						<br>
						<div align="center">
							<button type="submit" class="btn btn-primary" href="#"><i class="fa fa-check"></i>&nbsp;提交</button>
						</div>
						<input type="hidden" name="sub" value="sub">
						</form>
						<br><br>
						<%
						set rs = server.CreateObject("adodb.recordset")
						rs.open "select * from tblKey where userId="&session("userId")&" order by keySort,keyName asc",conn,3,3	
						do while not rs.eof %>
						<div class="form-row">
							<div class="form-group col-md-1">
								<a href="bMain-del-<%=rs("keyId")%>.html"  onClick="return confirm('温馨提示，是否删除“<%=rs("keyName")%>（<%=rs("keyLink")%>）”快捷键？')"><i class="fa fa-lg fa-trash"></i></a>					
							</div>
							<div class="form-group col-md-11">
								<% =rs("keyWay")%> - <a href="<%=rs("keyLink")%>" target="_blank"><%=rs("keyName")%></a>（<% =rs("keyLink")%>）
							</div>
						</div>					
						<%
						rs.movenext
						loop
						rs.close
						set rs = nothing 
						%>
					</div>
					
						<!-- top按钮 -->
						<hr>
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-10" align="right">
								<a href="#top"><button type="text" class="btn btn-info"  data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>
								<a id='DD'></a>
							</div>
						</div>
			
				</div>
			</div>
			
			
		</div>
		
	<!--  超级管理员 -->

	<%if session("userPower") = 1 then%>
			
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header">						
					<div class="alert alert-primary" role="alert">群组</div>
					<div class="card-body">				
						<%
						varGroupCount = 0
						set rs70 = server.CreateObject("adodb.recordset")
						rs70.open "select * from tblGroup where groupState='on' ",conn,3,3	
						do while not rs70.eof
							groupId = rs70("groupId")
							varGroupCount = varGroupCount + 1			
						%>
						<div class=" col-lg-12">
							<span class="badge badge-primary"><%=varGroupCount%></span><a data-toggle="collapse" href="#collapseExample<%=rs70("groupId")%>" role="button" aria-expanded="false" aria-controls="collapseExample<%=rs70("groupId")%>" >
							<%=rs70("groupName")%></a>	
							<div class="collapse" id="collapseExample<%=rs70("groupId")%>">
								<div>							
									<%									
									' 获取组下面的成员	
									varSerial = 0
									set rs0 = server.CreateObject("adodb.recordset")
									rs0.open "select * from tblUser where userPower='3' and groupId="&groupId&" and userState='on' order by userId asc",conn,3,3	
									do while not rs0.eof	
										varSerial = varSerial + 1 %>
															
										<div class="col-lg-12">									
											<span class="badge badge-info"><%=varSerial%></span>										
											<a data-toggle="collapse" href="#collapseExample<%=rs0("userId")%>99" role="button" aria-expanded="false" aria-controls="collapseExample<%=rs0("userId")%>99" class="">
											<%=rs0("userNickName")%>&nbsp;(<%=rs0("userName")%>)</a>
											<div class="collapse " id="collapseExample<%=rs0("userId")%>99">																																		
												<%' 获取每个成员各自的类别
												set rs = server.CreateObject("adodb.recordset")
												rs.open "select * from tblSort where groupId="&groupId&" and  userName='"&rs0("userName")&"' order by sortName asc",conn,3,3	
												if not rs.eof then					
													sortId = rs("sortId")	
													%>
													<div class="row">
													<div class="col-lg-12 ">
													<div class="card mb-2">				
													<div class="mb-1">
													<table class="table m-0">
													<thead class="thead-light">
													<tr>										
													<th>类别名称</th>
													<th>标签名称</th>
													<th>文章数</th>
													</tr></thead><tbody>
													<%
													if rs.recordcount <> 0 then
														do while not rs.eof and rs0("userPower") = "3"
															' 遍历类别下类根文章数量 （不包括标签下的）
															set rs4 = server.CreateObject("adodb.recordset")
															rs4.open "select * from tblContent where sortId="&rs("sortId")&" and tagId=0 and userName='"&rs0("userName")&"'",conn,3,3									
															sortCount = rs4.recordcount
															rs4.close %>
															<tr>					
														
															<td><%=rs("sortName")%>
															<% if rs("sortState") = "off" and rs("sortShare") = "on" then
															  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
															elseif rs("sortState") = "off" and rs("sortShare") = "on" then
															  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
															elseif rs("sortState") = "ban" and rs("sortShare") = "on" then 
															  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
															elseif rs("sortState") = "ban" and rs("sortShare") = "off" then
															  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span><%
															elseif rs("sortShare") = "on" then 
															  %>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
															elseif rs("sortState") = "off" then 
															  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
															end if %>
															</td>
															<td>/</td>
															<td>
													<div class="media align-items-center">
														<%if sortCount <> 0 then%>
															<button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#basicModal<%=rs("sortId")%>0"> <%=sortCount%></button>
														<%end if %>
													</div>
														<%sortId = rs("sortId")%>
													</td>
													</tr>
													<div class="modal fade" id="basicModal<%=sortId%>0" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
														<div class="modal-dialog" role="document">
															<div class="modal-content">
																<div class="modal-header">
																	<%
																	set rs3 = server.CreateObject("adodb.recordset")
																	rs3.open "select * from tblSort where sortId="&sortId&"",conn,3,3								
																	%>
																	<h5 class="modal-title" id="exampleModalLabel"><%=rs3("sortName")%> - /</h5>
																	<%rs3.close%>
																	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="material-icons ">close</span></button>
																</div>
																<div class="modal-body">
																	<%						
																	set rs6 = server.CreateObject("adodb.recordset")
																	rs6.open "select * from tblContent where sortId="&sortId&" and tagId=0  order by cName asc",conn,3,3		
																	if rs6.recordcount <> 0 then
																	y=1
																	do while not rs6.eof 											
																		response.write y&"，"%>
																		<a href="../article-<%=rs6("cId")%>-<%=sortId%>.html" target="_blank"><%=rs6("cName") %></a> <br>						
																	<% y=y+1																	
																	rs6.movenext
																	loop					
																	end if 
																	rs6.close
																	%>
																</div>
																<div class="modal-footer">										
																<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
																</div>
															</div><!--modal-content-->
														</div><!--modal-dialog-->
													</div><!--modal-fade-->	
													
													<% ' 遍历类别下标签中文章数量 （不包括类根）
													x = 0
													set rs1 = server.CreateObject("adodb.recordset")
													rs1.open "select * from tblTag where sortId="&rs("sortId")&" order by tagName,tagId asc",conn,3,3	
													if rs1.recordcount <>0 then								
														do while not rs1.eof	
															set rs4 = server.CreateObject("adodb.recordset")
															rs4.open "select * from tblContent where sortId="&rs("sortId")&" and tagId="&rs1("tagId")&" and userName='"&rs0("userName")&"'",conn,3,3	
															tagCount = rs4.recordcount
															rs4.close%>
															<tr>					
															
															<td></td>												
															<td><%=rs1("tagName")%>
																<% if rs1("tagState") = "off" and rs1("tagShare") = "on" then
																  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
																elseif rs1("tagState") = "off" and rs1("tagShare") = "on" then
																  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
																elseif rs1("tagState") = "ban" and rs1("tagShare") = "on" then 
																  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
																elseif rs1("tagState") = "ban" and rs1("tagShare") = "off" then
																  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span><%
																elseif rs1("tagShare") = "on" then 
																  %>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
																elseif rs1("tagState") = "off" then 
																  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
																end if %>
															</td>
															<td>
																<div class="media align-items-center">
																	<%if tagCount <> 0 then%>
																	<button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#basicModal<%=rs1("sortId")%><%=rs1("tagId")%>"><%=tagCount%></button>
																	<%end if %>
																</div>
																<% 
																sortId = rs1("sortId")
																tagId = rs1("tagId")%>
															</td>														
															</tr>
									
															<div class="modal fade" id="basicModal<%=sortId%><%=tagId%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
																<div class="modal-dialog" role="document">
																	<div class="modal-content">
																		<div class="modal-header">
																			<%
																			set rs3 = server.CreateObject("adodb.recordset")		
																			rs3.open "select * from tblSort where sortId="&sortId&"",conn,3,3		
																			sortName = rs3("sortName")
																			rs3.close
																			set rs3 = server.CreateObject("adodb.recordset")		
																			rs3.open "select * from tblTag where tagId="&tagId&" ",conn,3,3		
																			tagName = rs3("tagName")
																			rs3.close
																			set rs3 = nothing
																			set rs6 = server.CreateObject("adodb.recordset")
																			rs6.open "select * from tblContent where sortId="&sortId&" and tagId="&tagId&" order by cName asc",conn,3,3		
																			%>
																			<h5 class="modal-title" id="exampleModalLabel"><%=sortName%> - <%=tagName%> (<%=rs6.recordcount%>)</h5>
																			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="material-icons ">close</span></button>
																		</div>
																		<div class="modal-body">				
																			<% y=1
																			do while not rs6.eof 
																				response.write y&"，"%>
																				<a href="../article-<%=rs6("cId")%>-<%=sortId%>.html" target="_blank"><%=rs6("cName") %></a> <br>					
																			<% y=y+1
																			rs6.movenext
																			loop										
																			rs6.close
																			set rs6 = nothing 
																			%>
																		</div>
																			
																		<div class="modal-footer"><button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button></div>
																	</div><!-- modal-content -->
																</div><!-- modal-dialog -->
															</div><!-- modal-fade -->		
											
															<%
															rs1.movenext
															loop						
														end if 
														rs1.close
														
													rs.movenext
													loop
													%>
											</tbody>
													</table>
								</div><!-- card-body --> 
							</div><!-- card mb-4 --> 
						</div><!-- col-lg-6 --> 
					</div><!-- row --> <%
					end if 
				end if 
				rs.close
				%>	
														
				</div> <!-- collapse -->			
		</div><!-- card mb-1 col-lg-6 -->
		
		<% rs0.movenext
		loop
		rs0.close
		%>
		
		
					
								
				
								</div>
							</div>
						</div>
						<%
						rs70.movenext
						loop
						rs70.close
						set rs70 = nothing %>		
					</div>
					
						<!-- top按钮 -->
						<hr>
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-10" align="right">
								<a href="#top"><button type="text" class="btn btn-info"  data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>
								<a id='DD'></a>
							</div>
						</div>
						
				</div>
				
				
			</div>
		</div>						
		
	
	
	
										
											
	<%elseif session("userPower") = 3 then %>											
			
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-header">							
					<div class="alert alert-primary" role="alert">成员</div>
					<div class="card-body">	
						<%
						set rs0 = server.CreateObject("adodb.recordset")
						rs0.open "select * from tblUser where userName='"&session("userName")&"' order by userId asc",conn,3,3	
						groupId = rs0("groupId")
						rs0.close
						' 获取组下面的成员	
						varSerial = 0
						set rs0 = server.CreateObject("adodb.recordset")
						rs0.open "select * from tblUser where userPower='5' and groupId="&groupId&" and userState='on' order by userId asc",conn,3,3	
						do while not rs0.eof	
							varSerial = varSerial + 1 %>	
	
			<div class=" col-lg-12">
				<a data-toggle="collapse" href="#collapseExample<%=rs0("userId")%>" role="button" aria-expanded="false" aria-controls="collapseExample<%=rs0("userId")%>" class=" text-dark  py-2">
				<span class="badge badge-info"><%=varSerial%>.</span>&nbsp;&nbsp;<%=rs0("userName")%></a>&nbsp;&nbsp;(<%=rs0("userNickName")%>)
				
				<div class="collapse" id="collapseExample<%=rs0("userId")%>">	<br>												
								
				<%' 获取每个成员各自的类别
				set rs = server.CreateObject("adodb.recordset")
				rs.open "select * from tblSort where groupId="&groupId&" and  userName='"&rs0("userName")&"' order by sortName asc",conn,3,3	
				if not rs.eof then					
					sortId = rs("sortId")	%>
						<div class="row">
						<div class="col-lg-12 ">
							<div class="card mb-4">				
								<div class="card-body">
				<table class="table m-0">
				<thead class="thead-light">
				<tr>
			
				<th>类别名称</th>
				<th>标签名称</th>
				<th>文章数</th>
				</tr></thead><tbody>
					<%
					if rs.recordcount <> 0 then 
						do while not rs.eof and rs0("userPower") = "5"
							' 遍历类别下类根文章数量 （不包括标签下的）
							set rs4 = server.CreateObject("adodb.recordset")
							rs4.open "select * from tblContent where sortId="&rs("sortId")&" and tagId=0 and userName='"&rs0("userName")&"'",conn,3,3									
							sortCount = rs4.recordcount
							rs4.close %>
							<tr>					
						
							<td><a href="bSortTagEdit-<%=rs("sortId")%>-<%=rs0("userName")%>.html"><%=rs("sortName")%></a>
					
								<% if rs("sortState") = "off" and rs("sortShare") = "on" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs("sortState") = "off" and rs("sortShare") = "on" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
									    elseif rs("sortState") = "ban" and rs("sortShare") = "on" then 
										  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs("sortState") = "ban" and rs("sortShare") = "off" then
										  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span><%
										elseif rs("sortShare") = "on" then 
										  %>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs("sortState") = "off" then 
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
								end if %>
							</td>
							<td>/</td>
							<td>
								<div class="media align-items-center">
									<%if sortCount <> 0 then%>
										<button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#basicModal<%=rs("sortId")%>0"> <%=sortCount%></button>
									<%end if %>
								</div>
								<%sortId = rs("sortId")%>
							</td>
							</tr>
							<div class="modal fade" id="basicModal<%=sortId%>0" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<%
											set rs3 = server.CreateObject("adodb.recordset")
											rs3.open "select * from tblSort where sortId="&sortId&"",conn,3,3								
											%>
											<h5 class="modal-title" id="exampleModalLabel"><%=rs3("sortName")%> - /</h5>
											<%rs3.close%>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="material-icons ">close</span></button>
										</div>
										<div class="modal-body">
											<%						
											set rs6 = server.CreateObject("adodb.recordset")
											rs6.open "select * from tblContent where sortId="&sortId&" and tagId=0  order by cName asc",conn,3,3		
											if rs6.recordcount <> 0 then																							
												y=1
												do while not rs6.eof 											
													response.write y&"，"%>
													<a href="../article-<%=rs6("cId")%>-<%=sortId%>.html" target="_blank"><%=rs6("cName") %></a> <br>						
												<% y=y+1	
												 rs6.movenext
												loop			
											end if 
											rs6.close
											%>
										</div>
										<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
										</div>
									</div><!--modal-content-->
								</div><!--modal-dialog-->
							</div><!--modal-fade-->	
			
										
							<% ' 遍历类别下标签中文章数量 （不包括类根）
							x = 0
							set rs1 = server.CreateObject("adodb.recordset")
							rs1.open "select * from tblTag where sortId="&rs("sortId")&" order by tagName,tagId asc",conn,3,3	
							if rs1.recordcount <>0 then								
								do while not rs1.eof	
									set rs4 = server.CreateObject("adodb.recordset")
									rs4.open "select * from tblContent where sortId="&rs("sortId")&" and tagId="&rs1("tagId")&" and userName='"&rs0("userName")&"'",conn,3,3	
									tagCount = rs4.recordcount
									rs4.close%>
									<tr>					
									
									<td></td>												
									<td><%=rs1("tagName")%>									
										<% if rs1("tagState") = "off" and rs1("tagShare") = "on" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs1("tagState") = "off" and rs1("tagShare") = "on" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
									    elseif rs1("tagState") = "ban" and rs1("tagShare") = "on" then 
										  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs1("tagState") = "ban" and rs1("tagShare") = "off" then
										  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span><%
										elseif rs1("tagShare") = "on" then 
										  %>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs1("tagState") = "off" then 
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
										end if %>
									</td>
									<td>
										<div class="media align-items-center">
											<%if tagCount <> 0 then%>
											<button type="button" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#basicModal<%=rs1("sortId")%><%=rs1("tagId")%>"> <%=tagCount%></button>
											<%end if %>
										</div>
										<% 
										sortId = rs1("sortId")
										tagId = rs1("tagId")%>
									</td>														
									</tr>
									
									<div class="modal fade" id="basicModal<%=sortId%><%=tagId%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<%
													set rs3 = server.CreateObject("adodb.recordset")		
													rs3.open "select * from tblSort where sortId="&sortId&"",conn,3,3		
													sortName = rs3("sortName")
													rs3.close
													set rs3 = server.CreateObject("adodb.recordset")		
													rs3.open "select * from tblTag where tagId="&tagId&" ",conn,3,3		
													tagName = rs3("tagName")
													rs3.close
													set rs3 = nothing
													set rs6 = server.CreateObject("adodb.recordset")
													rs6.open "select * from tblContent where sortId="&sortId&" and tagId="&tagId&" order by cName asc",conn,3,3		
													%>
													<h5 class="modal-title" id="exampleModalLabel"><%=sortName%> - <%=tagName%> (<%=rs6.recordcount%>)</h5>
													<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="material-icons ">close</span></button>
												</div>
												<div class="modal-body">				
													<% 
														y=1
											do while not rs6.eof 											
												response.write y&"，"%>
												<a href="../article-<%=rs6("cId")%>-<%=sortId%>.html" target="_blank"><%=rs6("cName") %></a> <br>						
											<% y=y+1	
											 rs6.movenext
											loop								
													rs6.close
													set rs6 = nothing 
													%>
												</div>
												<div class="modal-footer"><button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button></div>
											</div><!-- modal-content -->
										</div><!-- modal-dialog -->
									</div><!-- modal-fade -->		
											
								<%
								rs1.movenext
								loop						
							end if 
							rs1.close							
						rs.movenext
						loop %>
						
						</tbody>
				</table></div><!-- card-body --> 
							</div><!-- card mb-4 --> 
						</div><!-- col-lg-6 --> 
					</div><!-- row --> <%
					end if 
				end if 
				rs.close
				%>															
								</div> <!-- collapse -->			
							</div><!-- card mb-1 col-lg-6 -->
							<% rs0.movenext
							loop
							rs0.close
							%>		
						</div>
						
							<!-- top按钮 -->
							<hr>
							<div class="row">
								<div class="col-md-2"></div>
								<div class="col-md-10" align="right">
									<a href="#top"><button type="text" class="btn btn-info"  data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>
									<a id='DD'></a>
								</div>
							</div>	
						
					</div>
				</div>									
		</div>		
						
	
	<%else%>
	
		<!-- 用户仪表盘-->

	
			<div class="col-lg-6 ">
				<div class="card mb-4">
					<div class="card-header">类别标签</div>
					<div class="card-body">
						<table class="table m-0">
                        <thead class="thead-light">
						<tr>
						<th>类别名称</th>
						<th>标签名称</th>
						<th>文章数</th>
						</tr>
						</thead><tbody>
						<% 
						set rs = server.CreateObject("adodb.recordset")
						rs.open "select * from tblSort where userName='"&session("userName")&"' order by sortName asc",conn,3,3		
						if rs.recordcount <> 0 then
							do while not rs.eof 
								set rs4 = server.CreateObject("adodb.recordset")
								rs4.open "select * from tblContent where sortId="&rs("sortId")&" and tagId=0 and userName='"&session("userName")&"'",conn,3,3									
								sortCount = rs4.recordcount
								rs4.close%>																			
								<tr>					
								<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a>
								<% if rs("sortState") = "off" and rs("sortShare") = "on" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs("sortState") = "off" and rs("sortShare") = "on" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
									    elseif rs("sortState") = "ban" and rs("sortShare") = "on" then 
										  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs("sortState") = "ban" and rs("sortShare") = "off" then
										  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span><%
										elseif rs("sortShare") = "on" then 
										  %>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs("sortState") = "off" then 
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
								end if %>
										
								</td>
								<td>/</td>
								<td><a href="bMain-articleList-<%=rs("sortId")%>.html"><%=sortCount%></a></td>
								</tr>
								<% x = 0
								set rs1 = server.CreateObject("adodb.recordset")
								rs1.open "select * from tblTag where sortId="&rs("sortId")&" order by tagName,tagId asc",conn,3,3		
								if rs1.recordcount <> 0 then						
									do while not rs1.eof	
									set rs4 = server.CreateObject("adodb.recordset")
									rs4.open "select * from tblContent where sortId="&rs("sortId")&" and tagId="&rs1("tagId")&" and userName='"&session("userName")&"'",conn,3,3									
									tagCount = rs4.recordcount
									rs4.close %>
									<tr>					
									<td></td>												
									<td><%=rs1("tagName")%>
						
									
									<% if rs1("tagState") = "off" and rs1("tagShare") = "on" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs1("tagState") = "off" and rs1("tagShare") = "on" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
									    elseif rs1("tagState") = "ban" and rs1("tagShare") = "on" then 
										  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs1("tagState") = "ban" and rs1("tagShare") = "off" then
										  %>&nbsp;&nbsp;<span class="badge badge-dark">禁止</span><%
										elseif rs1("tagShare") = "on" then 
										  %>&nbsp;&nbsp;<span class="badge badge-info">共享</span><%
										elseif rs1("tagState") = "off" then 
										  %>&nbsp;&nbsp;<span class="badge badge-danger">关闭</span><%
									end if %>
								
									</td>
									<td><a href="bMainArticleList-<%=rs("sortId")%>-<%=rs1("tagId")%>.html"><%=tagCount%></a></td>														
									</tr>
									<%
									rs1.movenext
									loop									
								end if 
								rs1.close
							rs.movenext
							loop
						end if 
						rs.close%>															
						</tbody>
						</table>
					</div><!-- "card-body" --> 	
				</div><!-- "card mb-4" --> 	
				
	

			<!-- 文章 -->
			
				
		
				<div class="card mb-4">
					<div class="card-header">文章 （禁止的类别或标签，将不能进行共享)</div>
					<div class="card-body">
						<% 
						if request("action") = "articleList" then 
							sortId = request("sortId")
							tagId = request("tagId")	
							set rs = server.CreateObject("adodb.recordset")
							if tagId = "" then
								rs.open "select * from tblContent where sortId="&sortId&" and tagId=0  order by cName asc",conn,3,3		
								if rs.recordcount <> 0 then
								do while not rs.eof %>
									<a href="../article-<%=rs("cId")%>-<%=sortId%>.html" target="_blank"><%=rs("cName") %></a> <br>						
								<% rs.movenext
								loop					
								end if 
							else
								rs.open "select * from tblContent where sortId="&sortId&" and tagId="&tagId&"  order by cName asc",conn,3,3		
								if rs.recordcount <> 0 then
									do while not rs.eof %>
										<a href="../article-<%=rs("cId")%>-<%=sortId%>.html" target="_blank"><%=rs("cName") %></a> <br>					
									<% rs.movenext
									loop					
								end if
							end if 
						end if %>
					</div><!-- card-body --> 
				</div><!-- card mb-4 --> 
			</div><!-- col-lg-6 --> 
			
	
	
	
	12121
	
	
	<%end if %>

</div><!-- row --> 

	

<script src="../731/dist/js/jquery-3.2.1.min.js"></script>
<script src="../731/dist/js/bootstrap.min.js"></script>
<script src="../731/dist/js/plugins/pace.min.js"></script>



</body>
</html>
