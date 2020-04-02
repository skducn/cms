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
//��дalert 
window.alert = function(name){
    var iframe = document.createElement("IFRAME");
    iframe.style.display="none";
    iframe.setAttribute("src", 'data:text/plain,');
    document.documentElement.appendChild(iframe);
    window.frames[0].window.alert(name);
    iframe.parentNode.removeChild(iframe);
}
//��дconfirm ����ʾip��ַ  
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
							<a href="bUserEdit.asp?userId=<%=session("userId")%>" class="btn btn-default btn-flat">��������</a>
							</div>
							<div class="pull-right">
							<a href="bMain.asp?action=exit" class="btn btn-default btn-flat">�˳�</a>
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
        	<li class="header">����˵�</li>
		
	
		<!-- ����� -->
		
      	<%if session("userPower") = "1" then %>		
			<li class="treeview">
				<a href="#"><i class="fa fa-briefcase text-red"></i> <span>�����</span><i class="fa fa-angle-left pull-right"></i></a>
				<ul class="treeview-menu">
					<!-- �½��� -->
					<li><a href="bGroupAdd.asp"><i class="fa fa-edit text-red"></i><span>�½���</span></a></li>
					<!-- �༭�� -->
					<li class="treeview">
						<a href="#"><i class="fa fa-edit text-red"></i><span>�༭��</span><i class="fa fa-angle-left pull-right"></i></a>				
						<ul class="treeview-menu">
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tblGroup order by groupId asc",conn,3,3 
							if rs1.eof then
								response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>����</i>"
							else
								do while not rs1.eof %>
									<!-- ���� -->
									<li>
										<a href="bGroupEdit.asp?groupId=<%=rs1("groupId")%>"><i class="fa fa-circle-o text-red"></i> <%=rs1("groupName")%> 
										<% if rs1("groupState") = "off" then
											response.write "<span class='label pull-right bg-red'>"			
											response.write "�ѹر�"
											response.write "</span>"
										end if %></a>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li> <!-- �༭��Ŀ over-->
				
				</ul>
			</li>
		<%end if %>
		
		<!-- ����� over-->
			
			
			
		<!-- �û�����(���ܡ��չ�) -->
		<%if session("userPower") <> "5" then %>
		<li class="treeview">
			<a href="#"><i class="fa fa-briefcase text-yellow"></i> <span>�û�����</span><i class="fa fa-angle-left pull-right"></i></a>
			<ul class="treeview-menu">
				<li><a href="bUserAdd.asp"><i class="fa fa-edit text-yellow"></i><span>�����û�</span></a></li>
				<!-- �༭�û� -->
				<li class="treeview">
					<a href="#"><i class="fa fa-edit text-yellow"></i><span>�༭�û�</span><i class="fa fa-angle-left pull-right"></i></a>				
					<ul class="treeview-menu">
						<%						
						Set rs1 = Server.CreateObject("Adodb.Recordset")
						if session("userPower") = "1" then
							rs1.Open "select * from tblUser where userPower<>'1' and userPower<>'5' order by userId DESC",conn,3,3 
						else
							rs1.Open "select * from tblUser where userPower='5' and groupId="&session("groupId")&" order by userId asc",conn,3,3 
						end if 
						
						if rs1.eof then
							response.write "���û�"
						else
							do while not rs1.eof %>
								<!-- �����û��� -->
								<li>
								<a href="bUserEdit.asp?userId=<%=rs1("userId")%>"><i class="fa fa-circle-o text-yellow"></i> <%=rs1("userNickName")%>
								<% if rs1("userState") = "off" then
										response.write "<span class='label pull-right bg-red'>"			
										response.write "�ѹر�"
										response.write "</span>"
									end if %></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- .treeview�༭�� over-->
				
				<!-- �û�����ǩ���� -->
				<li class="treeview">
					<a href="#">
					<i class="fa fa-edit text-yellow"></i><span>�û�����ǩ����</span>
					<i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblUser where groupId="&session("groupId")&" and userPower='5' and userState='on' order by userId ",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>���û�</i>"
						else
							do while not rs1.eof %>
								<!-- �����û� -->
								<li>
									<a href="#"><i class="fa fa-circle-o text-yellow"></i> <%=rs1("userNickName")%> <i class="fa fa-angle-left pull-right"></i></a>
									<ul class="treeview-menu">
										<!-- ����� -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tblSort where groupId="&rs1("groupId")&" and userName='"&rs1("userName")&"' order by sortName,sortId ",conn,3,3 
										if rs2.eof then
											response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-yellow'>�����</i>"
										else
											do while not rs2.eof %>		
												<!-- ��������� -->
												<li>
													<a href="bSortTagEdit.asp?sortId=<%=rs2("sortId")%>&userName=<%=rs1("userName")%>"><i class="fa fa-circle-o text-yellow"></i> <%=rs2("sortName")%> 
													<% if rs2("sortState") = "off" then
														response.write "<span class='label pull-right bg-red'>"			
														response.write "�ѹر�"
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
				</li> <!-- �û�����ǩ���� over-->
				
			</ul>
		</li> 
		<%end if%>
		<!-- �û����� over-->
		
		
		<%if session("userPower") <> "1" then %>
		
		<!-- �������� -->
			 		
		<li class="treeview">
			<a href="#"><i class="fa fa-briefcase text-red"></i> <span>��������</span><i class="fa fa-angle-left pull-right"></i></a>
			<ul class="treeview-menu">
				<!-- �½���� -->
				<li><a href="bSortAdd.asp"><i class="fa fa-edit text-red"></i><span>�½����</span></a></li>
				<!-- �༭��� -->
				<li class="treeview">
					<a href="#"><i class="fa fa-edit text-red"></i><span>�༭���</span><i class="fa fa-angle-left pull-right"></i></a>				
					<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' order by sortName,sortId DESC",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>�����</i>"
						else
							do while not rs1.eof %>
								<!-- ��������� -->
								<li>
									<a href="bSortEdit.asp?sortId=<%=rs1("sortId")%>"><i class="fa fa-circle-o text-red"></i> <%=rs1("sortName")%> 
									<% if rs1("sortState") = "off" then
										response.write "<span class='label pull-right bg-red'>"			
										response.write "�ѹر�"
										response.write "</span>"
									    elseif rs1("sortState") = "ban" then
										response.write "<span class='label pull-right bg-red'>"			
										response.write "�ѽ�ֹ"
										response.write "</span>"
									end if %></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- �༭���over-->							
			</ul>
		</li>
		
		<!-- �������� over-->
		
	
		
		<!-- ��ǩ���� -->
		
		<li class="treeview">
			<a href="#"><i class="fa fa-briefcase text-aqua"></i> <span>��ǩ����</span><i class="fa fa-angle-left pull-right"></i></a>
			<ul class="treeview-menu">				
				<!-- �½���ǩ -->
				<li class="treeview">
					<a href="#"><i class="fa fa-edit text-aqua"></i><span>�½���ǩ</span><i class="fa fa-angle-left pull-right"></i></a>
					<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' and sortState='on' order by sortName,sortId DESC",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>�����</i>"
						else
							do while not rs1.eof %>
								<!-- ���� -->
								<li>
								<a href="bTagAdd.asp?sortId=<%=rs1("sortId")%>"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("sortName")%></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- �½���� over-->
				
				<!-- �༭��ǩ -->
				<li class="treeview">
					<a href="#">
					<i class="fa fa-edit text-aqua"></i><span>�༭��ǩ</span>
					<i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' and sortState='on' order by sortName,sortId ",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>�����</i>"
						else
							do while not rs1.eof %>
								<!-- ��Ŀ�� -->
								<li>
									<a href="#"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("sortName")%> <i class="fa fa-angle-left pull-right"></i></a>
									<ul class="treeview-menu">
										<!-- ƽ̨�� -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tblTag where sortId="&rs1("sortId")&" order by tagName,sortId ",conn,3,3 
										if rs2.eof then
											response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>�ޱ�ǩ</i>"
										else
											do while not rs2.eof 	%>		
												<!-- ������ǩ�� -->
												<li>
													<a href="bTagEdit.asp?sortId=<%=rs1("sortId")%>&tagId=<%=rs2("tagId")%>"><i class="fa fa-circle-o text-aqua"></i> <%=rs2("tagName")%> 
													<% if rs2("tagState") = "off" then
														response.write "<span class='label pull-right bg-red'>"			
														response.write "�ѹر�"
														response.write "</span>"
														elseif rs2("tagState") = "ban" then
														response.write "<span class='label pull-right bg-red'>"			
														response.write "�ѽ�ֹ"
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
				</li> <!-- �鿴�༭�汾 over-->
			</ul>
		</li> 
		<!-- ��ǩ���� over-->
		
		<%end if %>
				
		
		
		<%if session("userPower") <> "1" then %>
	        <li><a href="../main.asp"><i class="fa fa-mail-reply"></i> <span>������ҳ</span></a></li>
		<%else%>
    	    <li><a href="../index.asp"><i class="fa fa-mail-reply"></i> <span>�˳�</span></a></li>
			  <li><a href="../pages/UI/icons.html"> <span>AdminLTE</span></a></li>
		<%end if %>
		
		</ul>
	</section>
</aside>