<!--#include file="conn.asp"-->
<!--#include file="common/function.asp"-->
<!--#include file="common/constant.asp"-->
<!--#include file="md5.asp"-->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit" />
<meta charset="utf-8">
<link rel="shortcut icon" href=" /favicon.ico" /> 
<title>快速登录 | <%=cstCompany%></title>
<link rel="stylesheet" type="text/css" href="731/dist/css/main.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<script src="731/dist/js/jquery-2.1.4.min.js"></script>
<script src="731/dist/js/bootstrap.min.js"></script>
<script src="731/dist/js/plugins/pace.min.js"></script>
<script src="731/dist/js/main.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/sweetalert.min.js"></script> 
<script language="javascript">  
function CheckPost()
{	  
     if (addForm.userPass.value == "") 
	 {
		$.notify({
			title: "&nbsp;&nbsp;",
			message: "密码不能为空！",
			icon: 'fa fa-remove' 
		},{
			type: "danger"
		});
	  addForm.userPass.focus();
	  return false;
  }
}
</script>

<%if request("action") = "login" then
userPass = md5(request("userPass")) 
userName = request("userName2")
latestLoginIp = request("latestLoginIp")
Set rs = Server.CreateObject("Adodb.Recordset")						
rs.Open "select * from tblUser where userPass='"&userPass&"' and latestLoginIp='"&latestLoginIp&"' and userState='on'",conn,3,3
if not rs.eof then	
rs("latestDate") = now()	
rs.update   	
session("userId") = rs("userId")    
session("userName") = rs("userName")    
session("userNickName") = rs("userNickName")
session("groupId") = rs("groupId")			
session("userPower") = rs("userPower")	
if rs("userPower") = "1" then 	'超级管理员				
response.redirect "/backstage/bMain.html"      		    			
else					
response.redirect "dashboard.html"     			
end if	
else
response.Write("<script>;alert('很抱歉，密码错误！');window.location.href='index.html';</script>")  
end if    
rs.close
set rs = nothing
conn.close
set conn = nothing
end if%>

<!-- ******************************************************************************************************************************************************************** -->	
<body onLoad="document.getElementById('inputTxt').focus()">

<section class="material-half-bg"><div class="cover"></div></section>
<section class="lockscreen-content">

<div class="logo">
<h1 align="center"><i class="fa fa-book"></i> 测试知识库</h1>
</div>
	
	
	<form action="lockLogin.html" method="post" name="addForm"  class="login-form" onSubmit="return CheckPost()" >
		<%
		Set rs4 = Server.CreateObject("Adodb.Recordset")						
		rs4.Open "select * from tblUser where latestLoginIp='"&getClientIp()&"'",conn,3,3
		if not rs4.eof then		
		%>
		<div class="lock-box">
			<img src="<%=rs4("userHead")%>" class="img-circle user-image img-thumbnail  ">	
			<h3 class="text-center user-name"><%=rs4("userNickname")%></h3>
			<p class="text-center text-muted"><%=rs4("userTitle")%></p>
			<br>
			<div class="form-group">			
				<input class="form-control" name="userPass" type="password" placeholder="password" id="inputTxt">
				<input name="latestLoginIp" type="hidden" value="<%=getClientIp()%>" >
				<input name="userName2" type="hidden" value="<%=rs4("userName")%>" >
			</div>
			<div class="form-group btn-container">
				<button class="btn btn-primary btn-block" id="button2" type="submit"><h4><i class="fa fa-unlock fa-lg"></i> 快速登录</h4></button>
			</div>
		 	<p><a href="indexClear-<%=rs4("userName")%>.html">我不是 <%=rs4("userNickname")%> ? 重新登录</a></p>
		 </div>
		 
		<%
		else
			response.Redirect("index.html")		
		end if 
		rs4.close
		set rs4 = nothing%>
	</form>
		
</section>
</body>
</html>