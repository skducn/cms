<!--#include file="../conn.asp"-->
<!--#include file="../constant.asp"-->
<!--#include file="../function.asp"-->
<!--#include file="../md5.asp"-->

<% bMain()%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="icon" href="../favicon.ico">

<link href="js/style.css" rel="stylesheet" >
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="js/fontawesome/fontawesome-all.min.css" rel="stylesheet" >


</head>

<body>

	<!-- Pre Loader-->
	<div class="loader-wrapper">
	<div class="spinner">
	<svg viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
	<circle class="length" fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="28"></circle>
	</svg>
	<svg viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
	<circle fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="28"></circle>
	</svg>
	<svg viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
	<circle fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="28"></circle>
	</svg>
	<svg viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
	<circle fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="28"></circle>
	</svg>
	</div>
	</div>
	<!-- Pre Loader-->

<section>
<!-- SIDEBAR -->
<aside class="sidebar">
<nav class="navbar navbar-dark bg-primary">
<a class="navbar-brand m-0 py-2 brand-title" href="#"><%=cstCompany%> ��̨</a>
<span></span>
<a class="navbar-brand py-2 material-icons toggle-sidebar" href="#">menu</a>
</nav>
			
	

	<nav class="navigation" >
	<ul>
		<li class="active"><a href="bMain.html" title="Dashboard"><span class="nav-icon material-icons">public</span> �Ǳ���</a></li>
		<li title="Theme Settings"><a href="theme-setting.html"><span class="nav-icon material-icons ">color_lens</span>���ⱳ��</a>
		</li>				  				                 
	</ul>

	<!-- ��Ա����(���ܡ��չ�) -->
	<%if session("userPower") <> "5" then %>
	  <label><span>��Ա����</span></label>
	  <ul>
		  <li>
			<a href="bUserAdd.html"><span class="nav-icon material-icons ">person_add</span>������Ա</a>                
		  </li>
		  <li class="Form Stuff">
			<a href="#" title=""><span class="nav-icon material-icons ">perm_identity</span>�༭��Ա <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
			<ul class="sub-nav">
				<%						
				Set rs1 = Server.CreateObject("Adodb.Recordset")
				if session("userPower") = "1" then
					rs1.Open "select * from tblUser where userPower<>'1' and userPower<>'5' order by userId DESC",conn,3,3 
				else
					rs1.Open "select * from tblUser where userPower='5' and groupId="&session("groupId")&" order by userId asc",conn,3,3 
				end if 
				
				if rs1.eof then
					response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����Ա"
				else
					do while not rs1.eof %>
						<!-- ������Ա�� -->
						<li>
						<a href="bUserEdit-<%=rs1("userId")%>.html"  title=<%=rs1("userPhone")%>><i class="fa fa-circle-o text-yellow"></i> <%=rs1("userNickName")%>
						<% if rs1("userState") = "off" then
								 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
							end if %></a>
						</li>
					<%rs1.movenext
					loop
				end if 
				rs1.close
				set rs1 = nothing %>
			</ul>
		  </li>
	  </ul>
	<%end if %>
	
	<!-- Ⱥ�����(����) -->
	<%if session("userPower") = "1" then %>
	  <label><span>Ⱥ�����</span></label>
	  <ul>
		  <li>
			<a href="bGroupAdd.html"><span class="nav-icon material-icons ">group_add</span>����Ⱥ��</a>                
		  </li>
		  <li class="Form Stuff">
			<a href="#" title=""><span class="nav-icon material-icons ">group</span>�༭Ⱥ�� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
			<ul class="sub-nav">
				<%						
				Set rs1 = Server.CreateObject("Adodb.Recordset")
				rs1.Open "select * from tblGroup  order by groupId ",conn,3,3 			
				if rs1.eof then
					response.write "��Ⱥ��"
				else
					do while not rs1.eof %>
						<li>
						<a  href="bGroupEdit-<%=rs1("groupId")%>.html"><i class="fa fa-circle-o text-yellow"></i> <%=rs1("groupName")%>						
						<% if rs1("groupState") = "off" then
								 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
							end if %></a>
						</li>
					<%rs1.movenext
					loop
				end if 
				rs1.close
				set rs1 = nothing %>
			</ul>
		  </li>
	  </ul>
	<%end if %>


	<%if session("userPower") <> "1" then %>

              <label><span>������</span></label>
              <ul>
                  <li>
                    <a href="bSortAdd.html"><span class="nav-icon material-icons ">library_add</span> �½����</a>
                  </li>
                  <li>
                    <a href="#" title=""><span class="nav-icon material-icons ">edit</span> �༭��� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
                    <ul class="sub-nav">
                        <%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' order by sortName,sortId DESC",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class='badge badge-info'>�����</span>"
						else
							do while not rs1.eof %>
								<!-- ��������� -->
								<li>
									<a href="bSortEdit-<%=rs1("sortId")%>.html"><i class="fa fa-circle-o text-red"></i> <%=rs1("sortName")%> 
									<% if rs1("sortState") = "off" and rs1("sortShare") = "on" then
										  %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span>&nbsp;&nbsp;<span class="badge badge-info">����</span><%
										elseif rs1("sortState") = "off" and rs1("sortShare") = "on" then
										  %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
									    elseif rs1("sortState") = "ban" and rs1("sortShare") = "on" then 
										  %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-light">��ֹ</span>&nbsp;&nbsp;<span class="badge badge-info">����</span><%
										elseif rs1("sortState") = "ban" and rs1("sortShare") = "off" then
										  %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-light">��ֹ</span><%
										elseif rs1("sortShare") = "on" then 
										  %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-info">����</span><%
										elseif rs1("sortState") = "off" then 
										  %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
										end if %>
									</a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
                    </ul>
                  </li>
				  
				  <%if session("userPower") <> "5" then %>
				   <li>
                    <a href="#" title=""><span class="nav-icon material-icons ">widgets</span> <span class="badge badge-info">������Ա��� </span><span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
                    <ul class="sub-nav">
                        <%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblUser where groupId="&session("groupId")&" and userPower='5' and userState='on' order by userId ",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>����Ա</i>"
						else
							do while not rs1.eof %>
								<!-- ������Ա -->
								<li>

									<a href="#"><%=rs1("userNickName")%> <i class="fa fa-angle-right pull-right"></i></a>
									<ul class="sub-nav">
										<!-- ����� -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tblSort where groupId="&rs1("groupId")&" and userName='"&rs1("userName")&"' order by sortName,sortId ",conn,3,3 
										if rs2.eof then
											 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-info">�����</span><%
										else
											do while not rs2.eof %>		
												<!-- ��������� -->
												<li>
													<a href="bSortTagEdit-<%=rs2("sortId")%>-<%=rs1("userName")%>.html">&nbsp;&nbsp;<%=rs2("sortName")%>
													<% if rs2("sortState") = "off" then
														 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
													   elseif rs2("sortState") = "ban" then
														 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-light">��ֹ</span><%
													end if %>
													</a>
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
                  </li>
				  <%end if %>
				  
              </ul>
			  
			  
			       <label title="Applications and Pages"><span>��ǩ����</span></label>
              <ul>
                  <li>
                    <a href="#" title="eCommerce12"><span class="nav-icon material-icons ">note_add</span> �½���ǩ <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
					  <ul class="sub-nav">
                        <%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' and sortState='on' order by sortName,sortId DESC",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class='badge badge-info'>�����</span>"
						else
							do while not rs1.eof %>
								<!-- ���� -->
								<li>
								<a href="bTagAdd-<%=rs1("sortId")%>.html"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("sortName")%></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
                    </ul>
                  </li>
                  <li>
                    <a href="#" title=""><span class="nav-icon material-icons ">edit</span> �༭��ǩ <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
                    <ul class="sub-nav">
                        <%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' and sortState='on' order by sortName,sortId ",conn,3,3 
						if rs1.eof then
							 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-info">�����</span><%
						else
							do while not rs1.eof %>
								<!-- ��Ŀ�� -->
								<li>
									<a href="#"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("sortName")%> <i class="fa fa-angle-right pull-right"></i></a>
									<ul class="sub-nav">
										<!-- ƽ̨�� -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tblTag where sortId="&rs1("sortId")&" order by tagName,sortId ",conn,3,3 
										if rs2.eof then
											 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-info">�ձ�ǩ</span><%
										else
											do while not rs2.eof%>		
												<!-- ������ǩ�� -->
												<li>
													<a href="bTagEdit-<%=rs1("sortId")%>-<%=rs2("tagId")%>.html"><i>&nbsp;&nbsp;<%=rs2("tagName")%> </i>
													
													
													<% if rs2("tagState") = "off" and rs2("tagShare") = "on" then
													  %>&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span>&nbsp;&nbsp;<span class="badge badge-info">����</span><%
													elseif rs2("tagState") = "off" and rs2("tagShare") = "on" then
													  %>&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
													elseif rs2("tagState") = "ban" and rs2("tagShare") = "on" then 
													  %>&nbsp;&nbsp;<span class="badge badge-light">��ֹ</span>&nbsp;&nbsp;<span class="badge badge-info">����</span><%
													elseif rs2("tagState") = "ban" and rs2("tagShare") = "off" then
													  %>&nbsp;&nbsp;<span class="badge badge-light">��ֹ</span><%
													elseif rs2("tagShare") = "on" then 
													  %>&nbsp;&nbsp;<span class="badge badge-info">����</span><%
													elseif rs2("tagState") = "off" then 
													  %>&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
													end if %>
													
													</a>
													
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
                  </li>
				 
              </ul>
		<%end if %>	  

			<%if session("userPower") <> "1" then%>
              <label title="Knowlage Center"></label>
              <ul>
                 
						 <li><a href="../dashboard.html"><span class="nav-icon material-icons">keyboard_return</span> ����</a></li>
					
				 
              </ul>
			  <%end if %>
           

		<%if session("userPower") = "1" then %>
              <label title="Knowlage Center"></label>            

			 <%	
			  set rs = server.CreateObject("ADODB.RecordSet")
			  rs.Open "select * from tblKey where userId="&session("userId")&" order by keyName",conn,3,3
			  do while not rs.eof%>
              <ul>
                  <li><a href="<%=rs("keyLink")%>" target="_blank"><span class="nav-icon material-icons">link</span><%=rs("keyName")%></a></li>
				  
              </ul>			  
		
			  <%rs.movenext
			  loop
			  rs.close
			  set rs = nothing 
			 %>

		<%end if %>
		
		 </nav>
          </aside>

          <!--RIGHT CONTENT AREA-->
          <div class="content-area">

            <header class="header sticky-top">
              <nav class="navbar navbar-light bg-white px-sm-4 ">
                <a class="navbar-brand py-2 d-md-none  m-0 material-icons toggle-sidebar" href="#">menu</a>
                <ul class="navbar-nav flex-row ml-auto">
             
               
                  <li class="nav-item ml-sm-3 user-logedin dropdown">
  				  <%	
				  set rs = server.CreateObject("ADODB.RecordSet")
				  rs.Open "select * from tblUser where userName='"&session("userName")&"'",conn,3,3
				  %>
                    <a href="#" id="userLogedinDropdown" data-toggle="dropdown" class="nav-link weight-400 dropdown-toggle"><img src="<%=rs("userHead")%>" class="mr-2 rounded-circle" width="30"> <%=rs("userNickName")%></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userLogedinDropdown">
                      <a class="dropdown-item" href="profile.html">������Ϣ</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="../indexExit.html" onClick="return confirm('�Ƿ������˳�ϵͳ��')"><i class="fa fa-sign-out fa-lg"></i> �˳�</a>
                    </div>
                  </li>
                  
                </ul>
              </nav>
            </header>
			<%rs.close
			set rs = nothing%>


<!-- top��ť cd-top-arrow.svg��ͷ-->
<link href="../js/topButton/zzsc.css" rel="stylesheet" type="text/css" />
<script src="../js/topButton/jquery.min.js"></script>
<script src="../js/topButton/zzsc.js"></script> 


<script src="js/lib/moment.min.js"></script>
<script src="js/lib/jquery.min.js"></script>
<script src="js/lib/popper.min.js"></script>
<script src="js/bootstrap/bootstrap.min.js"></script>
<script src="js/chosen-js/chosen.jquery.js"></script>
<script src="js/custom.js"></script>
<script src="js/fullcalendar/fullcalendar.js"></script>
<script src="js/daterangepicker/daterangepicker.min.js"></script>





