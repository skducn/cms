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

    <link rel="icon" href="../cosmo/assets/images/favicon.ico">

    <!-- Messgaes CSS -->
    <link href="../cosmo/assets/css/pages/messages.css" rel="stylesheet">

    <!-- Base CSS -->
    <link rel="stylesheet" href="../cosmo/assets/css/basestyle/style.css">

    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Date Range Picker -->
    <link rel="stylesheet" type="text/css" href="../cosmo/assets/css/daterangepicker/daterangepicker.css" />

    <!-- Full Calendar Icons -->
    <link href="../cosmo/assets/css/fullcalendar/fullcalendar.css" rel="stylesheet">
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



      <section class="wrapper">


          <!-- SIDEBAR -->
          <aside class="sidebar">
            <nav class="navbar navbar-dark bg-primary">
              <a class="navbar-brand m-0 py-2 brand-title" href="#">CMS private</a>
              <span></span>
              <a class="navbar-brand py-2 material-icons toggle-sidebar" href="#">menu</a>
            </nav>
			
	

            <nav class="navigation" >
              <ul>
                  <li class="active"><a href="bMain.asp" title="Dashboard"><span class="nav-icon material-icons">public</span> �Ǳ���</a></li>
                  <li title="Theme Settings"><a href="theme-setting.asp"><span class="nav-icon material-icons ">color_lens</span>���ⱳ��</a>
                  </li>
				  
				  
               
              </ul>

			<!-- �û�����(���ܡ��չ�) -->
			<%if session("userPower") <> "5" then %>
              <label><span>�û�����</span></label>
              <ul>
                  <li>
                    <a href="bUserAdd.asp"><span class="nav-icon material-icons ">extension</span>�����û�</a>                
                  </li>
                  <li class="Form Stuff">
                    <a href="#" title=""><span class="nav-icon material-icons ">assignment</span>�༭�û� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
                    <ul class="sub-nav">
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
										 %>&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
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
                    <a href="bSortAdd.asp"><span class="nav-icon material-icons ">shopping_cart</span> �½����</a>
                  </li>
                  <li>
                    <a href="#" title=""><span class="nav-icon material-icons ">widgets</span> �༭��� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
                    <ul class="sub-nav">
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
										  %>&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
									    elseif rs1("sortState") = "ban" then
										  %>&nbsp;&nbsp;<span class="badge badge-danger">��ֹ</span><%
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
                    <a href="#" title=""><span class="nav-icon material-icons ">widgets</span> <span class="badge badge-info">�����û���� </span><span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
                    <ul class="sub-nav">
                        <%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblUser where groupId="&session("groupId")&" and userPower='5' and userState='on' order by userId ",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>���û�</i>"
						else
							do while not rs1.eof %>
								<!-- �����û� -->
								<li>
									<a href="#"><%=rs1("userNickName")%> <i class="fa fa-angle-left pull-right"></i></a>
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
													<a href="bSortTagEdit.asp?sortId=<%=rs2("sortId")%>&userName=<%=rs1("userName")%>">&nbsp;&nbsp;<%=rs2("sortName")%>
													<% if rs2("sortState") = "off" then
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
				  <%end if %>
				  
              </ul>
			  
			  
			       <label title="Applications and Pages"><span>��ǩ����</span></label>
              <ul>
                  <li>
                    <a href="#" title="eCommerce"><span class="nav-icon material-icons ">shopping_cart</span> ��ӱ�ǩ <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
					  <ul class="sub-nav">
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
                  </li>
                  <li>
                    <a href="#" title=""><span class="nav-icon material-icons ">widgets</span> �༭��ǩ <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
                    <ul class="sub-nav">
                        <%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' and sortState='on' order by sortName,sortId ",conn,3,3 
						if rs1.eof then
							 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="badge badge-info">�����</span><%
						else
							do while not rs1.eof %>
								<!-- ��Ŀ�� -->
								<li>
									<a href="#"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("sortName")%> <i class="fa fa-angle-left pull-right"></i></a>
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
													<a href="bTagEdit.asp?sortId=<%=rs1("sortId")%>&tagId=<%=rs2("tagId")%>"><i>&nbsp;&nbsp;<%=rs2("tagName")%> </i>
													<% if rs2("tagState") = "off" then
															 %>&nbsp;&nbsp;<span class="badge badge-danger">�ر�</span><%
														elseif rs2("tagState") = "ban" then
															 %>&nbsp;&nbsp;<span class="badge badge-danger">��ֹ</span><%
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
                  </li>
				 
              </ul>
		<%end if %>	  

			<%if session("userPower") <> "1" then%>
              <label title="Knowlage Center"></label>
              <ul>
                  <li><a href="../main.asp" title="Documentation"><span class="nav-icon material-icons">school</span> ������ҳ</a></li>
              </ul>
			  <%end if %>
           

		<%if session("userPower") = "1" then %>
              <label title="Knowlage Center"></label>
              <ul>
                  <li><a href="../cosmo.html" title="Documentation" target="_blank"><span class="nav-icon material-icons">school</span>cosmoadmin.com</a></li>
              </ul>
              <ul>
                  <li><a href="../cosmo/index.html" title="Documentation" target="_blank"><span class="nav-icon material-icons">school</span>cosmo</a></li>
              </ul>

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
                    <a href="#" id="userLogedinDropdown" data-toggle="dropdown" class="nav-link weight-400 dropdown-toggle"><img src="<%=rs("userHead")%>" class="mr-2 rounded" width="28"><%=rs("userNickName")%></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userLogedinDropdown">
                      <a class="dropdown-item" href="profile.asp">�����˺�</a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" href="../index.asp">�˳�</a>
                    </div>
                  </li>
                  
                </ul>
              </nav>
            </header>
			<%rs.close
			set rs = nothing%>


<script src="../cosmo/assets/js/lib/moment.min.js"></script>
<script src="../cosmo/assets/js/lib/jquery.min.js"></script>
<script src="../cosmo/assets/js/lib/popper.min.js"></script>
<script src="../cosmo/assets/js/bootstrap/bootstrap.min.js"></script>
<script src="../cosmo/assets/js/chosen-js/chosen.jquery.js"></script>
<script src="../cosmo/assets/js/custom.js"></script>

<script src="../cosmo/assets/js/fullcalendar/fullcalendar.js"></script>
<script src="../cosmo/assets/js/daterangepicker/daterangepicker.min.js"></script>


<!--  BeAlert����alert	-->	
<link rel="stylesheet" href="../beAlert/BeAlert.css">
<script src="../beAlert/jquery.min.js"></script>
<script src="../beAlert/BeAlert.js"></script>


