<!--#include file="conn.asp"-->
<!--#include file="function.asp"-->
<!--#include file="constant.asp"-->
<!--#include file="md5.asp"-->


<% 
if request("action")="exit" then
Session.Abandon()
response.Redirect("index.html")
end if 
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>登录 | <%=cstProject%></title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
<link href="css/fontawesome.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/solid.css" rel="stylesheet">
<style>
input::-webkit-input-placeholder {
/* placeholder颜色  */
color: #aab2bd;
/* placeholder字体大小  */
font-size: 12px;
/* placeholder位置  */
text-align: left;
}
</style>
</head>

<!-- 登录 -->
<% 
if request("action")="login" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblUser where userName='"&request("userName")&"' and userPass='"&LCase(md5(request("userPass"))) &"' and userState='on' ",conn,3,3
	if not rs.eof then
		rs("latestLoginIp") = getClientIp() 	
		rs("latestDate") = now()	
		rs.update
		session("userId") = rs("userId")    
		session("userName") = rs("userName")    
		session("userNickName") = rs("userNickName")
		session("groupId") = rs("groupId")	
		session("userPower") = rs("userPower")
		'(1超级管理员，3管理员，5个人用户)
		if rs("userPower") = "1" then 							
			response.redirect "/backstage/bMain.html"      		    			
		else
			response.redirect "dashboard.html"     			
		end if	
	else
		response.redirect "index.html"  
	end if     
	rs.close
	set rs = nothing
end if
%>

<!-- 清除登录IP -->	
<%if request("action") = "clear" then
	Set rs = Server.CreateObject("Adodb.Recordset")						
	rs.Open "select * from tblUser where userName='"&request("userName")&"'",conn,3,3
	if not rs.eof then	   
		rs("latestLoginIp") = ""
		rs.update
	end if    
	rs.close
	set rs = nothing
	Session.Abandon()
	response.Redirect("index.html")
end if%>

<!-- 查询当前登录IP是否登录过，如果之前登录的，则跳转lock.html页面。 -->	
<%
Set rs = Server.CreateObject("Adodb.Recordset")						
rs.Open "select * from tblUser where latestLoginIp='"&getClientIp()&"' and userState='on'",conn,3,3
if not rs.eof then	   
response.Redirect("lock.html")		
end if
rs.close
%>


<body onLoad="document.getElementById('inputTxt').focus()"> 	
<div class="signupform">
	<div class="container">
		<!-- main content -->
		<div class="agile_info">
			<div class="w3l_form">
				<div class="left_grid_info">
					<h1><%=cstTitle%></h1>
					<p><%=cstIntro%></p><br>
					<img src="./images/index.jpg" alt="" >	
					
				</div>
			</div>
			<div class="w3_info ">
				<h2>欢迎使用<%=cstProject%></h2>
				<p>请登录您的账号</p>
				<form action="indexLogin.html" method="post">
					<label>账号</label>
					<div class="input-group">
						<span class="fa fa-user-alt" aria-hidden="true"></span>
						<input type="text" name="userName" placeholder="请输入..." required="" maxlength="20" id="inputTxt"> 
					</div>
					<label>密码</label>
					<div class="input-group">
						<span class="fa fa-lock" aria-hidden="true"></span>
						<input type="Password" name="userPass" placeholder="请输入..." required="" maxlength="30"> 
					</div> 
					<div class="login-check">
						 <label class="checkbox"><input type="checkbox" name="checkbox" checked=""><i> </i> 记住我</label>
					</div>						
						<button class="btn btn-danger btn-block" type="submit">登录</button>                
				</form>
				<p class="account">点击登录，同意与认可<a href="#">CMS使用规范</a></p>
				<p class="account1">我没有账号？<a href="mailto:h.jin@zy-healthtech.com">申请账号</a></p>
				<p class="account1 fa fa-tasks" align="right"> <a href="http://<%=getServerIp()%>:88" target="_blank">测试用例平台</a></p>
			</div>
		</div>
		<!-- //main content -->
	</div>
</div>

<div class="footer-w3l" align="center"></div>
</body>
</html>



