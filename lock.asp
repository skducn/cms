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
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="shortcut icon" href=" /favicon.ico" /> 
<title>���ٵ�¼ | <%=cstProject%></title>
<link href="css/fontawesome.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/solid.css" rel="stylesheet">
</head>
<style>
input::-webkit-input-placeholder {
/* placeholder��ɫ  */
color: #aab2bd;
/* placeholder�����С  */
font-size: 12px;
/* placeholderλ��  */
text-align: left;
}
</style>
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
	if rs("userPower") = "1" then 	'��������Ա				
	response.redirect "/backstage/bMain.html"      		    			
	else					
	response.redirect "dashboard.html"     			
	end if	
	else
	response.Write("<script>;alert('�ܱ�Ǹ���������');window.location.href='index.html';</script>")  
	end if    
	rs.close
	set rs = nothing
	conn.close
	set conn = nothing
end if%>


<body onLoad="document.getElementById('inputTxt').focus()">
<div class="signupform">
	<div class="container">
		<!-- main content -->
		<div class="agile_info">
			<div class="w3l_form">
				<div class="left_grid_info">
					<h1><%=cstTitle%></h1>
					<p><%=cstIntro%></p>
					<img src="./images/index.jpg" alt="" >	
				</div>
			</div>
			<div class="w3_info">
				<h2>��ӭʹ��<%=cstProject%></h2>
				<p>���¼�����˺�</p>
				
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
						<label>����</label>
					<div class="input-group">
						<span class="fa fa-lock" aria-hidden="true"></span>
						<input type="Password" name="userPass" placeholder="������..." required="" id="inputTxt" maxlength="30"> 
					</div> 
						<input name="latestLoginIp" type="hidden" value="<%=getClientIp()%>" >
						<input name="userName2" type="hidden" value="<%=rs4("userName")%>" >		
						<button class="btn btn-danger btn-block" type="submit">���ٵ�¼</button>   
						<p class="account" align="right"><a href="indexClear-<%=rs4("userName")%>.html" class="lock11">�Ҳ���<%=rs4("userNickname")%>���л��˺�</a></p>
						<%
						else
						response.Redirect("index.html")		
						end if 
						rs4.close
						set rs4 = nothing%>
					</div>
				</form>
	
				<p class="account">�����¼��ͬ�����Ͽ�<a href="#">CMSʹ�ù淶</a></p>
				<p class="account1">��û���˺ţ�<a href="mailto:h.jin@zy-healthtech.com">�����˺�</a></p>
			</div>
		</div>
		<!-- //main content -->
	</div>
</div>
</body>
</html>