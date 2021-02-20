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
<title>快速登录 | <%=cstProject%></title>

<link href="css/fontawesome.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/solid.css" rel="stylesheet">
  
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


<body>

<div class="signupform">
	<div class="container">
		<!-- main content -->
		<div class="agile_info">
			<div class="w3l_form">
				<div class="left_grid_info">
					<h1>CMS Knowledge base <br>知识库</h1>
					<p>CMS 知识库是自我知识体系记录与管理系统，好记性不如烂笔头，通过日积月累地记录、更新、学习，来完善与提高我们深层次的认知水平，使记录的内容更加准确，如专业业务流程、工具设置技巧、常用公式、优秀代码与文章收藏、自我总结等，对知识的适当储备，在所需时可快速查询与使用，从而养成一种对记录、阅读、持续更新的良好习惯，对知识的理解达到知其然而知其所以然，使之在工作与生活中快速高效地解决问题。作中遇到的问题。</p>
					<img src="./images/index.jpg" alt="">
				</div>
			</div>
			<div class="w3_info">
				<h2>欢迎使用CMS <span class="fa fa-book"></span></h2>
				<p>请登录您的账号</p>
				
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
						<label>密码</label>
					<div class="input-group">
						<span class="fa fa-lock" aria-hidden="true"></span>
						<input type="Password" name="userPass" placeholder="请输入..." required="">
					</div> 
						<input name="latestLoginIp" type="hidden" value="<%=getClientIp()%>" >
						<input name="userName2" type="hidden" value="<%=rs4("userName")%>" >		
						<button class="btn btn-danger btn-block" type="submit">快速登录</button>   
						<p class="account" align="right"><a href="indexClear-<%=rs4("userName")%>.html" class="lock11">我不是“<%=rs4("userNickname")%>”，切换账号</a></p>
						<%
						else
						response.Redirect("index.html")		
						end if 
						rs4.close
						set rs4 = nothing%>
					</div>
				</form>
	
				<p class="account">点击登录，同意与认可<a href="#">CMS使用规范</a></p>
				<p class="account1">我没有账号？<a href="mailto:h.jin@zy-healthtech.com">申请账号</a></p>
			</div>
		</div>
		<!-- //main content -->
	</div>
</div>



</body>
</html>