<!--#include file="conn.asp"-->
<!--#include file="function.asp"-->
<!--#include file="constant.asp"-->
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

<link rel="stylesheet" href="js/index.css">



</head>


</head>


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
<body>


<h1>CMS knowledge base 知识库</h1>

<div class="main-agileinfo">
	<form action="lockLogin.html" method="post" >
	<%
		Set rs4 = Server.CreateObject("Adodb.Recordset")						
		rs4.Open "select * from tblUser where latestLoginIp='"&getClientIp()&"'",conn,3,3
		if not rs4.eof then		
		%>
		<div class="lock-box">
		<img src="<%=rs4("userHead")%>" class="img-circle user-image">	
		   
			<h3 class="text-center user-name"><%=rs4("userNickname")%></h3>
			<p class="text-center text-muted"><%=rs4("userTitle")%></p>
		
		
		
		<input type="password" name="userPass" class="password" placeholder="密码" required="required">
		<input name="latestLoginIp" type="hidden" value="<%=getClientIp()%>" >
		<input name="userName2" type="hidden" value="<%=rs4("userName")%>" >		
		<input type="submit" value="快速登录">
		<p><a href="indexClear-<%=rs4("userName")%>.html" class="lock11">我不是 <%=rs4("userNickname")%> ? 重新登录</a></p>
		<%
		else
			response.Redirect("index.html")		
		end if 
		rs4.close
		set rs4 = nothing%>
		</div>
	</form>
</div>




</body>
</html>