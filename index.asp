<!--#include file="conn.asp"-->
<!--#include file="common/function.asp"-->
<!--#include file="common/constant.asp"-->
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
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76" href="assets/img/CN.png">
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>登录 | <%=cstCompany%></title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
<link rel="stylesheet" href="css/index.css">
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

<!-- ******************************************************************************************************************************************************************** -->	
<body>	 	

<h1>CMS knowledge base</h1>
<div class="main-agileinfo">
	<h2>知识库</h2>
	<form action="indexLogin.html" method="post" >
		<input type="text" name="userName" class="name" placeholder="用户名" required="required" style="border-radius: 6px;">
		<input type="password" name="userPass" class="password" placeholder="密码" required="required">
		<ul>
		<li>
		<input type="checkbox" id="brand1" value="">
		<label for="brand1"><span></span>记住我</label>
		</li>				
		</ul>
		<a href="#">忘记密码？</a><br>
		<input type="submit" value="登录">
	</form>
</div>

<div class="footer-w3l">
	<p class="agile"><a href="http://172.21.200.153:88/" target="_blank">case 测试用例平台</a></p>
</div>

	

<!--背景图片自动更换-->	
<script src="js/jquery.min.js"></script>
<script src="js/supersized.3.2.7.min.js"></script>
<script src="js/supersized-init.js"></script>

</body>
</html>
