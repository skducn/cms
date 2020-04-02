<!--#include file="../conn.asp"-->
<!--#include file="../common/constant.asp"-->
<!--#include file="../common/function.asp"-->

<%=bMain%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<!-- Font Awesome--> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
 <!-- DataTables -->
<link rel="stylesheet" href="../plugins/datatables/dataTables.bootstrap.css">
<!-- Theme style -->
<link rel="stylesheet" href="../dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins  folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="../dist/css/skins/_all-skins.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="../plugins/iCheck/flat/blue.css">
<!-- Morris chart -->
<link rel="stylesheet" href="../plugins/morris/morris.css">
<!-- jvectormap -->
<link rel="stylesheet" href="../plugins/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Date Picker -->
<link rel="stylesheet" href="../plugins/datepicker/datepicker3.css">
<!-- Daterange picker -->
<link rel="stylesheet" href="../plugins/daterangepicker/daterangepicker-bs3.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<link rel="stylesheet" href="../css/input.css">


<script src="../ueditor/ueditor.config.js"></script>
<script src="../ueditor/ueditor.all.min.js"></script>	
<script src="../ueditor/lang/zh-cn/zh-cn.js"></script> 

<script>
//重写alert 
window.alert = function(name){
    var iframe = document.createElement("IFRAME");
    iframe.style.display="none";
    iframe.setAttribute("src", 'data:text/plain,');
    document.documentElement.appendChild(iframe);
    window.frames[0].window.alert(name);
    iframe.parentNode.removeChild(iframe);
}
//重写confirm 不显示ip地址  
var wConfirm = window.confirm;  
window.confirm = function (message) {  
    try {  
        var iframe = document.createElement("IFRAME");  
        iframe.style.display = "none";  
        iframe.setAttribute("src", 'data:text/plain,');  
        document.documentElement.appendChild(iframe);  
        var alertFrame = window.frames[0];  
        var iwindow = alertFrame.window;  
        if (iwindow == undefined) {  
            iwindow = alertFrame.contentWindow;  
        }  
        var result = iwindow.confirm(message);  
        iframe.parentNode.removeChild(iframe);  
        return result;  
    }  
    catch (exc) {  
        return wConfirm(message);  
    }  
}
</script>

</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

<header class="main-header">
	<!-- Logo -->
	<a href="bMain.asp" class="logo">
	<!-- mini logo for sidebar mini 50x50 pixels -->
	<span class="logo-mini"><%=cstCompany%></span>
	<!-- logo for regular state and mobile devices -->
	<span class="logo-lg"><strong><%=cstCompany%></strong></span>    </a>
	<!-- Header Navbar: style can be found in header.less -->
	<nav class="navbar navbar-static-top" role="navigation">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button"><span class="sr-only">Toggle navigation</span></a>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">      
				<!-- User Account: style can be found in dropdown.less -->
				<li class="dropdown user user-menu">
					<%
					Set rs = Server.CreateObject("Adodb.Recordset")
					rs.Open "select * from tblUser where userName='"&session("userName")&"'",conn,3,3 %>
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					<img src="../<%=rs("userHead")%>" class="user-image" alt="User Image">
					<span class="hidden-xs"><%=rs("userNickName")%></span>
					</a>
					<ul class="dropdown-menu">
						<!-- User image -->
						<li class="user-header">
							<img src="../<%=rs("userHead")%>" class="img-circle" alt="User Image">
							<p> <%=rs("userTitle")%>             
							<small></small>
							</p>
						</li>
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-left">
							<a href="bUserEdit.asp?userId=<%=session("userId")%>" class="btn btn-default btn-flat">个人设置</a>
							</div>
							<div class="pull-right">
							<a href="bMain.asp?action=exit" class="btn btn-default btn-flat">退出</a>
							</div>
						</li>
					</ul>
				</li>
				<li><a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a></li>
			</ul>
		</div>
	</nav>
</header>

  
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<div class="user-panel">
			<div class="pull-left image"><img src="../<%=rs("userHead")%>" class="user-image" alt="User Image"></div>	
			<div class="pull-left info">
				<p><%=rs("userNickName")%></p>
				<%rs.close
				set rs = nothing%>
				<i class="fa fa-circle text-success"></i> Online
			</div>
		</div>

	  

	  
	  
		<ul class="sidebar-menu">
        	<li class="header">管理菜单</li>
		
	
		<!-- 组管理 -->
		
      	<%if session("userPower") = "1" then %>		
			<li class="treeview">
				<a href="#"><i class="fa fa-briefcase text-red"></i> <span>组管理</span><i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu">
					<!-- 新建组 -->
					<li><a href="bGroupAdd.asp"><i class="fa fa-edit text-red"></i><span>新建组</span></a></li>
					<!-- 编辑组 -->
					<li class="treeview">
						<a href="#"><i class="fa fa-edit text-red"></i><span>编辑组</span><i class="fa fa-angle-left pull-right"></i></a>				
						<ul class="treeview-menu">
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tblGroup order by groupId asc",conn,3,3 
							if rs1.eof then
								response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>无组</i>"
							else
								do while not rs1.eof %>
									<!-- 遍历 -->
									<li>
										<a href="bGroupEdit.asp?groupId=<%=rs1("groupId")%>"><i class="fa fa-circle-o text-red"></i> <%=rs1("groupName")%> 
										<% if rs1("groupState") = "off" then
											response.write "<span class='label pull-right bg-red'>"			
											response.write "已关闭"
											response.write "</span>"
										end if %></a>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li> <!-- 编辑项目 over-->
				
				</ul>
			</li>
		<%end if %>
		
		<!-- 组管理 over-->
			
			
			
		<!-- 用户管理(超管、普管) -->
		<%if session("userPower") <> "5" then %>
		<li class="treeview">
			<a href="#"><i class="fa fa-briefcase text-yellow"></i> <span>用户管理</span><i class="fa fa-angle-left pull-right"></i></a>
			<ul class="treeview-menu">
				<li><a href="bUserAdd.asp"><i class="fa fa-edit text-yellow"></i><span>新增用户</span></a></li>
				<!-- 编辑用户 -->
				<li class="treeview">
					<a href="#"><i class="fa fa-edit text-yellow"></i><span>编辑用户</span><i class="fa fa-angle-left pull-right"></i></a>				
					<ul class="treeview-menu">
						<%						
						Set rs1 = Server.CreateObject("Adodb.Recordset")
						if session("userPower") = "1" then
							rs1.Open "select * from tblUser where userPower<>'1' and userPower<>'5' order by userId DESC",conn,3,3 
						else
							rs1.Open "select * from tblUser where userPower='5' and groupId="&session("groupId")&" order by userId asc",conn,3,3 
						end if 
						
						if rs1.eof then
							response.write "无用户"
						else
							do while not rs1.eof %>
								<!-- 遍历用户名 -->
								<li>
								<a href="bUserEdit.asp?userId=<%=rs1("userId")%>"><i class="fa fa-circle-o text-yellow"></i> <%=rs1("userNickName")%>
								<% if rs1("userState") = "off" then
										response.write "<span class='label pull-right bg-red'>"			
										response.write "已关闭"
										response.write "</span>"
									end if %></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- .treeview编辑用 over-->
				
				<!-- 用户类别标签管理 -->
				<li class="treeview">
					<a href="#">
					<i class="fa fa-edit text-yellow"></i><span>用户类别标签管理</span>
					<i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblUser where groupId="&session("groupId")&" and userPower='5' and userState='on' order by userId ",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>无用户</i>"
						else
							do while not rs1.eof %>
								<!-- 遍历用户 -->
								<li>
									<a href="#"><i class="fa fa-circle-o text-yellow"></i> <%=rs1("userNickName")%> <i class="fa fa-angle-left pull-right"></i></a>
									<ul class="treeview-menu">
										<!-- 大类别 -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tblSort where groupId="&rs1("groupId")&" and userName='"&rs1("userName")&"' order by sortName,sortId ",conn,3,3 
										if rs2.eof then
											response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-yellow'>无类别</i>"
										else
											do while not rs2.eof %>		
												<!-- 遍历大类别 -->
												<li>
													<a href="bSortTagEdit.asp?sortId=<%=rs2("sortId")%>&userName=<%=rs1("userName")%>"><i class="fa fa-circle-o text-yellow"></i> <%=rs2("sortName")%> 
													<% if rs2("sortState") = "off" then
														response.write "<span class='label pull-right bg-red'>"			
														response.write "已关闭"
														response.write "</span>"
													end if %></a>
												</li>																										
											<%rs2.movenext
											loop						
										end if 
										rs2.close
										set rs2 = nothing%>
									</ul>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- 用户类别标签管理 over-->
				
			</ul>
		</li> 
		<%end if%>
		<!-- 用户管理 over-->
		
		
		<%if session("userPower") <> "1" then %>
		
		<!-- 大类别管理 -->
			 		
		<li class="treeview">
			<a href="#"><i class="fa fa-briefcase text-red"></i> <span>大类别管理</span><i class="fa fa-angle-left pull-right"></i></a>
			<ul class="treeview-menu">
				<!-- 新建类别 -->
				<li><a href="bSortAdd.asp"><i class="fa fa-edit text-red"></i><span>新建类别</span></a></li>
				<!-- 编辑类别 -->
				<li class="treeview">
					<a href="#"><i class="fa fa-edit text-red"></i><span>编辑类别</span><i class="fa fa-angle-left pull-right"></i></a>				
					<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' order by sortName,sortId DESC",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>无类别</i>"
						else
							do while not rs1.eof %>
								<!-- 遍历类别名 -->
								<li>
									<a href="bSortEdit.asp?sortId=<%=rs1("sortId")%>"><i class="fa fa-circle-o text-red"></i> <%=rs1("sortName")%> 
									<% if rs1("sortState") = "off" then
										response.write "<span class='label pull-right bg-red'>"			
										response.write "已关闭"
										response.write "</span>"
									    elseif rs1("sortState") = "ban" then
										response.write "<span class='label pull-right bg-red'>"			
										response.write "已禁止"
										response.write "</span>"
									end if %></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- 编辑类别over-->							
			</ul>
		</li>
		
		<!-- 大类别管理 over-->
		
	
		
		<!-- 标签管理 -->
		
		<li class="treeview">
			<a href="#"><i class="fa fa-briefcase text-aqua"></i> <span>标签管理</span><i class="fa fa-angle-left pull-right"></i></a>
			<ul class="treeview-menu">				
				<!-- 新建标签 -->
				<li class="treeview">
					<a href="#"><i class="fa fa-edit text-aqua"></i><span>新建标签</span><i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' and sortState='on' order by sortName,sortId DESC",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>无类别</i>"
						else
							do while not rs1.eof %>
								<!-- 遍历 -->
								<li>
								<a href="bTagAdd.asp?sortId=<%=rs1("sortId")%>"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("sortName")%></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- 新建类别 over-->
				
				<!-- 编辑标签 -->
				<li class="treeview">
					<a href="#">
					<i class="fa fa-edit text-aqua"></i><span>编辑标签</span>
					<i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' and sortState='on' order by sortName,sortId ",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>无类别</i>"
						else
							do while not rs1.eof %>
								<!-- 项目名 -->
								<li>
									<a href="#"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("sortName")%> <i class="fa fa-angle-left pull-right"></i></a>
									<ul class="treeview-menu">
										<!-- 平台名 -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tblTag where sortId="&rs1("sortId")&" order by tagName,sortId ",conn,3,3 
										if rs2.eof then
											response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>无标签</i>"
										else
											do while not rs2.eof 	%>		
												<!-- 遍历标签名 -->
												<li>
													<a href="bTagEdit.asp?sortId=<%=rs1("sortId")%>&tagId=<%=rs2("tagId")%>"><i class="fa fa-circle-o text-aqua"></i> <%=rs2("tagName")%> 
													<% if rs2("tagState") = "off" then
														response.write "<span class='label pull-right bg-red'>"			
														response.write "已关闭"
														response.write "</span>"
														elseif rs2("tagState") = "ban" then
														response.write "<span class='label pull-right bg-red'>"			
														response.write "已禁止"
														response.write "</span>"
													end if %></a>
												</li>																										
											<%rs2.movenext
											loop						
										end if 
										rs2.close
										set rs2 = nothing%>
									</ul>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- 查看编辑版本 over-->
			</ul>
		</li> 
		<!-- 标签管理 over-->
		
		<%end if %>
				
		
		
		<%if session("userPower") <> "1" then %>
	        <li><a href="../main.asp"><i class="fa fa-mail-reply"></i> <span>返回首页</span></a></li>
		<%else%>
    	    <li><a href="../index.asp"><i class="fa fa-mail-reply"></i> <span>退出</span></a></li>
			  <li><a href="../pages/UI/icons.html"> <span>AdminLTE</span></a></li>
		<%end if %>
		
		</ul>
	</section>
</aside>