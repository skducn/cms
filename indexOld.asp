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
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76" href="assets/img/CN.png">
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>登录 | <%=cstCompany%></title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
<link rel="stylesheet" type="text/css" href="js/main.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">


</head>
<script src="js/exit/jquery-2.1.4.min.js"></script>
<script src="js/menu/bootstrap.min.js"></script>
<script src="js/menu/pace.min.js"></script>
<script src="js/menu/main.js"></script>
<script src="js/shortcutKey/bootstrap-notify.min.js"></script>
<script src="js/exit/sweetalert.min.js"></script>
<script language="javascript">  
function CheckPost()
{	  
     if (addForm.userName.value == "" || addForm.userPass.value == "") 
	 {
		$.notify({
			title: "&nbsp;&nbsp;",
			message: "用户名或密码不能为空！",
			icon: 'fa fa-info-circle' 
		},{
			type: "danger"
		});
	  addForm.userName.focus();
	  return false;
  }
}
</script>

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

			 
<section class="material-half-bg"><div class="cover"></div></section>		
<section class="login-content">
		
	<div class="login-box">
		<!-- 用户登录 -->	
		<form action="indexLogin.html" method="post" name="addForm"  class="login-form" onSubmit="return CheckPost()" >
		<h2 class="login-head"><i class="fa fa-book"></i> 知识库</h2>		
			<div class="form-group">
				<h4>用户名</h4>
				<input class="form-control" type="text" name="userName"  placeholder="USERNAME" autofocus>
			</div>
			<div class="form-group">
				<h4>密码</h4>
				<input class="form-control" type="password" name="userPass" placeholder="PASSWORD">
			</div>
			<div class="form-group">
				<div class="utility">
					<div class="animated-checkbox"></div>
					<p class="semibold-text mb-0"><a data-toggle="flip">忘记密码？</a></p>
				</div>
			</div>
			<div class="form-group btn-container">
				<button class="btn btn-primary btn-block" id="button"><h4><i class="fa fa-sign-in fa-lg fa-fw"></i> 登录</h4></button>	
					<p class="semibold-text mb-0"><a href="http://<%=getServerIp()%>:88"><i class="fa fa-area-chart"></i> 测试用例平台</a></p>			
			</div>
		
		</form>
		
		<!-- 忘记密码了吗？ -->	
		<form class="forget-form" action="index.html">
			<h3 class="login-head"><i class="fa fa-lg fa-fw fa-lock"></i>忘记密码了吗？</h3>
			<div class="form-group">
				<h4>邮箱认证</h4>
				<input class="form-control" type="text" placeholder="Email">
			</div>
			<div class="form-group btn-container">
				<button class="btn btn-primary btn-block" id="button2"><h4><i class="fa fa-unlock fa-lg fa-fw"></i> 重置</h4></button>
			</div>
			<div class="form-group mt-20">
				<p class="semibold-text mb-0"><a data-toggle="flip"><i class="fa fa-angle-left fa-fw"></i>返回登录</a></p>
			</div>
		</form>		
	</div>
	
</section>
</body>
</html>
