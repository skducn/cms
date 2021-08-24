<!--#include file="bFrame.asp"-->
<%=bMain%>

<title>新增组员 | <%=cstProject%>后台</title>

<!--  获取所有组员的昵称，去重遍历 -->

<%
dim ArrNickName,rs8
ArrNickName = ""
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblUser",conn,3,3
Do While Not rs8.Eof
If ArrNickName = "" Then
ArrNickName = rs8("userNickName")
Else
ArrNickName = ArrNickName&","&rs8("userNickName")
End If
rs8.Movenext
loop
rs8.close
set rs8 = nothing 
%>

<script language="javascript">
function CheckPost()
{
    // 组员管理 - 新增组员
	// 账号
	if (addForm.userName.value == "" || addForm.userName.value.length < 6){
		alert("温馨提示，账号长度范围 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userName.focus();
		return false;}	
	// 密码
	if (addForm.userPass.value == "" || addForm.userPass.value.length < 6){
		alert("温馨提示，密码长度范围不 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userPass.focus();
		return false;}
	// 昵称(去重)
	var arr = addForm.arrNickName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userNickName.value == arr[i]){
			alert("温馨提示，昵称已存在！", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.userNickName.focus();
			return false;}}
	// 邮箱验证
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //正则表达式
　　var obj = document.getElementById("userEmail"); //要验证的对象
　  if(!reg.test(obj.value)){
		alert("温馨提示，邮箱验证失败！", function () {}, {type: 'warning', confirmButtonText: '确定'});
　　　　return false;}
	
	var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
 
</script>



<!--  删除User	-->	

<% if request("action")="del" then  
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&request("userId")&"",conn,3,3
	if not rs.eof then
	'rs.delete
	'rs.update
	end if 
end if %>


<!--  新增组员	-->

<% 
if request.form("sub")="sub" then
	groupId = request.form("groupId")
	userName = request.form("userName")
	userPass = request.form("userPass")
	userNickName = request.form("userNickName")
	userTitle = request.form("userTitle")
	userEmail = request.form("userEmail")
	userPower = request.form("userPower")	
	userPhone = request.form("userPhone")	
	userInfo = request.form("userInfo")	
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser",conn,3,3	
	rs.addnew
	rs("groupId") = groupId
	rs("userName") = userName
	rs("userPass") = LCase(md5(userPass))
	rs("userPower") = userPower
	if request("userNickName") = "" then
		rs("userNickName") = userName
	else
		rs("userNickName") = userNickName
	end if 
	rs("userTitle") = userTitle
	rs("userEmail") = userEmail
	rs("userPhone") = userPhone
	rs("userHead") = "/backstage/img/default.jpg"
	rs("userState") = "on"
	rs("userInfo") = userInfo
	rs("userCrtDate") = now
	rs.update
	'response.Write("<script>;alert('新增成功');window.location.href='bUserAdd.asp';</script >")
	response.Write("<script>;window.location.href='bUserAdd.html';</script>")	
	rs.close
	set rs = nothing 
end if 
%>



<div class="content-wrapper">

<div class="row page-tilte align-items-center">
	<div class="col-md-auto">
		<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
		<h1 class="weight-300 h3 title">组员管理</h1>
		<p class="text-muted m-0 desc">User management</p>
	</div> 
	<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
		<div class="controls d-flex justify-content-center justify-content-md-end"></div>
	</div>
</div> 

<div class="content">
	<div class="row">
		<div class="col-lg-6 ">
			<div class="card mb-4">
				<div class="card-header">新增组员</div>
				<div class="card-body">
					
					<div class="form-group col-md-12" align="center">
						
				     <img src="img/default.jpg" width="100" height="100">
						<br><br>
					</div>
			
					<form method="post" name="addForm" onSubmit="return CheckPost()">   

					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="exampleFormControlInput1">账号 *（6-15）</label>
							<input type="text" name="userName"   maxlength="15" class="form-control"  placeholder="username" onKeyUp="value=value.replace(/[^0-9a-zA-Z]/g,'')"/>
						</div>
					
						<div class="form-group col-md-6">
							<label for="inputPassword4">密码 *（6-15）</label>
							<input type="password" name="userPass" maxlength="15" class="form-control"  placeholder="password">
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="inputAddress">昵称（0-10）</label>
							<input type="text" name="userNickName"   maxlength="10" class="form-control"  placeholder="nickname">
						</div>
						
						<div class="form-group col-md-6">
							<label for="inputAddress">职称（0-10）</label>
							<input type="text" name="userTitle"   maxlength="10" class="form-control" value="" placeholder="jobtitle">
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="inputAddress">邮箱 * （<32）</label>
							<!-- <input type="text" name="userEmail" id="userEmail"  maxlength="32" class="form-control"  placeholder="name@yz-healthtech.com" onKeyUp="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'')"> -->
							<input type="text" name="userEmail" id="userEmail"  maxlength="32" class="form-control"  placeholder="name@zy-healthtech.com"> 
						</div>
						<div class="form-group col-md-6">
							<label for="inputAddress">手机号（11）</label>
							<input type="text" name="userPhone" id="userPhone"  maxlength="11" class="form-control" placeholder="cellphone">
						</div>
					</div>
					
					<%if session("userPower") = "1" then %>
						<div class="form-row">
							<div class="form-group col-md-6">
							<label>群组</label>
								<select class="form-control" name="groupId" >
								<%
								set rs = server.CreateObject("ADODB.RecordSet")
								rs.Open "select * from tblGroup where groupState='on'",conn,3,3
								do while not rs.eof%>
								<option value=<%=rs("groupId")%>><%=rs("groupName")%></option>
								<%rs.movenext
								loop
								rs.close
								set rs = nothing%>
								</select>						
							</div>
							<div class="form-group col-md-6">
								<label>权限</label>
								<select class="form-control" name="userPower" >
								<option value="3">管理员</option>
								</select>	
							</div>	
						</div>				
					<%else%>
						<label>权限</label>
						<select class="form-control" name="userPower" >						
						<option value="5">普通组员</option>
						</select>						
						<input name="groupId" type="hidden" value="<%=session("groupId")%>" />
					<%end if %>
					<br>
					
					<div class="form-row">
						<div class="form-group col-md-12">
							<label for="exampleFormControlInput1">个人信息</label>
							<textarea class="form-control" name="userInfo" rows="15" placeholder="个人简介"></textarea>						
						</div>
					
						
					</div>
					
					<br>
					<div align="center">
					<button type="submit" class="btn btn-primary" href="#">提交</button>
					</div>
					<input type="hidden" name="sub" value="sub">
					<input type="hidden" name="arrNickName" value="<%=ArrNickName%>">

					</form>

					</div>
				</div>
			</div>
														
			<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-header">		
					
						<div class="alert alert-primary" role="alert">管理员列表</div>
						<div class="card-body">	
							<table class="table table-striped m-0">
							<thead>
							<tr>
							<% set rs = server.CreateObject("ADODB.RecordSet")	
							if session("userPower") = "1" then  %>
								<th>组员名</th>
								<th>昵称</th>
								<th>群组</th>
								<th>状态</th>
								</tr>
								</thead><tbody>
								<%							
								
								rs.Open "select * from tblUser where userPower='3' order by userPower,userId desc",conn,3,3
								if not rs.eof then
									do while not rs.eof 							
										set rs1 = server.CreateObject("ADODB.RecordSet")
										rs1.Open "select * from tblGroup where groupId="&rs("groupId")&" order by groupId",conn,3,3
										%>
										<tr>
										<td><a href="bUserEdit-<%=rs("userId")%>.html"><%=rs("userName")%></a></td>
										<td><%=rs("userNickName")%></td>
										<td><%=rs1("groupName")%></td>
										<%if rs("userState") = "on" then%>
											<td><span class="badge badge-info">开启</span></td>
										<%else%>
											<td><span class="badge badge-danger">关闭</span></td>
										<%end if %>					
										</tr>
										<%
										rs1.close
										set rs1 = nothing 
									rs.movenext
									loop
								end if %>																			
								</tbody>
								</table>
							<%else%>
								<th>组员名</th>
								<th>昵称</th>
								<th>手机号</th>
								<th>状态</th>
								</tr>
								</thead><tbody>
								<%															
								rs.Open "select * from tblUser where userPower='5' and groupId="&session("groupId")&" order by userPower,userId asc",conn,3,3
								if not rs.eof then
									do while not rs.eof %>
										<tr>
										<td><a href="bUserEdit-<%=rs("userId")%>.html"><%=rs("userName")%></a></td>
										<td><%=rs("userNickName")%></td>
										<td><%=rs("userPhone")%></td>
										<%if rs("userState") = "on" then%>
											<td><span class="badge badge-info">开启</span></td>
										<%else%>
											<td><span class="badge badge-danger">关闭</span></td>
										<%end if %>																				
										</tr>
									<%
									rs.movenext
									loop
								end if %>																			
								</tbody>
								</table>							
							<%end if
							rs.close
							set rs = nothing %>
						</div>	
						</div>		
				</div><!-- "card mb-4" --> 	
			</div><!-- col-lg-6 --> 	
			
			
	</div>
</div>

</div>
</body>
</html>


