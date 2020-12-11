<!--#include file="conn.asp"-->
<!--#include file="function.asp"-->
<!--#include file="constant.asp"-->
<%exitIndex()%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/favicon.ico" /> 
<link rel="stylesheet" type="text/css" href="js/main.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">



</head>



<!-- ******************************************************************************************************************************************************************** -->	
<body class="sidebar-mini fixed" onLoad="createQrcode()">
<div class="wrapper">
	<header class="main-header hidden-print"><a class="logo" href="dashboard.html">CMS</a>	
	    <nav class="navbar navbar-static-top"><a class="sidebar-toggle" href="#" data-toggle="offcanvas"></a>
	
	
			<div class="navbar-custom-menu">
			  
		    	<ul class="top-nav">		
				<%i=0
				set rs1 = server.createobject("adodb.recordset")	
				rs1.open "select top 10 * from tblContent where cShareDate <> Null and userName<>'"&session("userName")&"' order by cId desc ",conn,3,3 				
				do while not rs1.eof			
					if datediff("d",rs1("cShareDate"),date())  < 5 then				
						i=i+1				
					end if 			
				rs1.movenext
				loop
				rs1.close %>
			
				<!-- 组员共享文章 -->
				
				<% if i <> 0 then%>			
				<li class="dropdown notification-menu">
					<a class="dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-bell-o fa-lg"></i>&nbsp;<span class="label label-danger"><%=i%></span></a>					
					<ul class="dropdown-menu">
						<li class="not-head">最近5天组员共享文章</li>				  
						<%set rs1 = server.createobject("adodb.recordset")	
						rs1.open "select top 10 * from tblContent where cShareDate <> Null and userName<>'"&session("userName")&"' order by cShareDate desc ",conn,3,3 					
						do while not rs1.eof
							set rs2 = server.createobject("adodb.recordset")	
							rs2.open "select * from tblUser where userName='"&rs1("userName")&"'",conn,3,3  
							if datediff("d",rs1("cShareDate"),date()) < 5 then
								%>					
								<li><a class="media" href="articleOther-<%=rs1("cId")%>-<%=rs1("sortId")%>.html">
								<span class="media-left media-icon"><span class="fa-stack fa-lg">
								<%if rs2("userPower") = 3 then%>
									<i class="fa fa-circle fa-stack-2x text-danger"></i><i class="fa fa-file-text-o fa-stack-1x fa-inverse"></i></span></span>
								<%else%>
									<i class="fa fa-circle fa-stack-2x text-info"></i><i class="fa fa-file-text fa-stack-1x fa-inverse"></i></span></span>
								<%end if %>
								<div class="media-body"><span class="block"><%=rs1("cName")%></span><span class="text-muted block"><%=rs2("userNickName")%></span></div></a></li>						
							<%end if 
							rs2.close
						rs1.movenext
						loop
						rs1.close%>			
					</ul>
				</li>
					
				<%end if %>
				
				<li class="app-search">								
					<!-- search -->           				
					<form method="POST"  action="searchSearch.html" >
				
					<input name="s_name" class="form-search " type="text" placeholder=" 搜一搜"  size="30" maxlength="30">	
					
					<button class="app-search__button"><i class="fa fa-search"></i></button>
				
					</form>
				</li>
				  
				<!-- 设置、个人信息、退出-->
				  
				<li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user fa-lg"></i></a>
					<ul class="dropdown-menu settings-menu">
						<li><a href="/backstage/bMain.html"><i class="fa fa-cog fa-lg"></i> 设置</a></li>
					    <li><a href="/backstage/profile.html"><i class="fa fa-user fa-lg"></i> 个人信息</a></li>
					    <li><a href="#" id="demoExit1"><i class="fa fa-sign-out fa-lg"></i>  <span>退出</span></a></li>		
				 	</ul>
				</li>			  
            	</ul>
			</div>
    	</nav>
	</header>
	
	
    <!-- 左侧菜单 -->
	
	<aside class="main-sidebar hidden-print">
    <section class="sidebar">
    <div class="user-panel">		  
		<%set rs = server.CreateObject("ADODB.RecordSet")
		rs.Open "select * from tblUser where userId="&session("userId")&"",conn,3,3%>									
		<div class="pull-left image"><img class="img-circle" src="<%=rs("userHead")%>" alt="User Image"></div>
		<div class="pull-left info">
			<p><%=rs("userNickName")%></p>
			<p class="designation"><%=rs("userTitle")%></p>
		</div>
		<%rs.close%>	
	</div>
			  		  			
				 
		  		  
		<!-- Sidebar Menu-->
		<ul class="sidebar-menu">
			<li class="active"><a href="dashboard.html"><i class="fa fa-dashboard"></i><span>我的面板</span></a></li>
				  
			<!-- 遍历类别 -->
			<%set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on' order by sortName,sortId asc",conn,3,3
			do while not rs1.eof %>									
			<li class="treeview"><a href="#"><i class="fa fa-circle-o"></i><span><%=rs1("sortName")%></span><i class="fa fa-angle-right"></i></a>
			<ul class="treeview-menu">
				<!-- 遍历标签 -->					
				<% set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tblTag where sortId="&rs1("sortId")&" and tagState='on' order by tagName asc",conn,3,3		
				do while not rs2.eof%>
					<li class="treeview"><a href="#"><span> <%=rs2("tagName") %></span><i class="fa fa-angle-right"></i></a>
					<ul class="treeview-menu">                                     
						 <!-- 遍历标签下的文章 -->
						<%set rs3 = server.createobject("adodb.recordset")       
						rs3.open "select * from tblContent where tagId="&rs2("tagId")&" order by cName asc",conn,3,3
						do while not rs3.eof  
							if rs3("tagId")=rs2("tagId") then ' 当sub_id是字符类，则使用cstr转换数字为字符串，如cstr(rs7("sub_id")) %> 		  			 
								<li><span><a href="article-<%=rs3("cId")%>-<%=rs3("sortId")%>.html"  target="_blank">&nbsp;<%=rs3("cName")%></a></span></li>							
							<%end if
						rs3.movenext
						loop 
						rs3.close%>						 
					</ul> 
					</li>
				<%rs2.movenext
				loop		
				rs2.close%>
								
				<!-- 遍历类别下的文章 -->		
				<%set rs4 = server.createobject("adodb.recordset")   	  	  
				rs4.open "select * from tblContent where sortId="&rs1("sortId")&" order by cName asc",conn,3,3
				if not rs4.eof then
					dim i
					i=0			
					do while not rs4.eof 
						if rs4("tagId")>"0" then
							redim preserve cId(i),cName(i),cContent(i),cCrtDate(i),tagId(i),sortId(i)
						else
							i=i+1
							redim preserve cId(i),cName(i),cContent(i),cCrtDate(i),tagId(i),sortId(i)
							cId(i)=rs4("cId")
							sortId(i)=rs4("sortId")
							cName(i)=rs4("cName")
							cContent(i)=rs4("cContent")
							cCrtDate(i)=rs4("cCrtDate")
							tagId(i)=rs4("tagId")
						end if
					rs4.movenext
					loop  
						for i=1 to ubound(cId)%>
						<li>&nbsp;&nbsp;&nbsp;<span><a href="article-<%=cId(i)%>-<%=sortId(i)%>.html" target="_blank"><%=cName(i)%></a></span></li>
						<%next
				end if
				rs4.close%>	
			</ul>
			</li>
		<%
		rs1.movenext
		loop	
		rs1.close
		set rs4 = nothing 
		set rs3 = nothing 
		set rs2 = nothing 
		set rs1 = nothing 
		%>

	
		<% 
		'每次检查用户是否有共享文章? 更新usershare的状态
		countShare = 0
		set rs1 = server.createobject("adodb.recordset")   	  	  
		rs1.open "select * from tblUser where userId="&session("userId")&" and userShare='on' and userState='on' order by userId desc",conn,3,3
		do while not rs1.eof
			set rs2 = server.createobject("adodb.recordset")   	  	  
			rs2.open "select * from tblSort where userName='"&rs1("userName")&"' order by sortName,sortId asc",conn,3,3
			do while not rs2.eof
				if rs2("sortShare") = "on" and rs2("sortState")="on" then
					countShare = 1
				else
					set rs3 = server.createobject("adodb.recordset")   	  	  
					rs3.open "select * from tblTag where sortId="&rs2("sortId")&" order by tagName,sortId asc",conn,3,3
					if not rs3.eof then
						if rs3("tagState")="on" and rs3("tagShare")="on" then
							countShare = 1						
						else 					
							do while not rs3.eof				
								set rs4 = server.createobject("adodb.recordset")   	  	  
								rs4.open "select * from tblContent where (sortId="&rs2("sortId")&" or tagId="&rs3("tagId")&") and cShare='on' and cState='on' order by cId desc",conn,3,3
								if rs4.recordcount > 0 then
									countShare = 1
								end if 				
							rs3.movenext				
							loop		
							rs3.close	
						end if 
					end if 
				end if 	
			rs2.movenext
			loop
			rs2.close
		rs1.movenext
		loop
		rs1.close
		if countShare = 0 then
			set rs1 = server.createobject("adodb.recordset")   	  	  
			rs1.open "select * from tblUser where userId="&session("userId")&" order by userId desc",conn,3,3
			rs1("userShare") = "off"
			rs1.update
			rs1.close		
		end if 
					
		
		'共享
		
		set rs1 = server.createobject("adodb.recordset")   	  	  
		rs1.open "select * from tblUser where userShare='on' and userState='on' and groupId="&session("groupId")&" order by userId desc",conn,3,3
		do while not rs1.eof%>					
			<li class="treeview"><a href="#">
			<i class="fa fa-share text-success" data-toggle="tooltip" data-original-title="用户共享"></i><span> <%=rs1("userNickName")%></span><i class="fa fa-angle-right"></i></a>
			<ul class="treeview-menu">

					<!-- 共享类别（包含隶属的标签和文章） -->
					<% set rs5 = server.createobject("adodb.recordset")   	  	  
					rs5.open "select * from tblSort where userName='"&rs1("userName")&"' and sortShare='on' and sortState='on' order by sortName,sortId asc",conn,3,3
					if not rs5.eof then
						do while not rs5.eof %>	
						<li class="treeview"><a href="#">&omicron;&nbsp;<%=rs5("sortName")%></span><i class="fa fa-angle-right"></i></a>
						<ul class="treeview-menu">																	
								<% 	
								set rs6 = server.createobject("adodb.recordset")   	  	  
								rs6.open "select * from tblTag where sortId="&rs5("sortId")&" and tagShare='on' order by tagName,tagId asc",conn,3,3
								if rs6.eof then														
									
									set rs7 = server.createobject("adodb.recordset")   	  	  
									rs7.open "select * from tblContent where sortId="&rs5("sortId")&" and tagId=0 order by cName,cId asc",conn,3,3
									do while not rs7.eof%>							
									<li>	<span><a href="articleOther-<%=rs7("cId")%>-<%=rs5("sortId")%>.html" target="_blank">&omicron;&nbsp;<%=rs7("cName")%></a>				</span></li>
									<%rs7.movenext
									loop
									rs7.close
								else									
									do while not rs6.eof%>	
									<li class="treeview"><a href="#"><i class="fa fa-th-list"></i><span><%=rs6("tagName")%></span><i class="fa fa-angle-right"></i></a>
									<ul class="treeview-menu">	
										<%
											set rs7 = server.createobject("adodb.recordset")   	  	  
											rs7.open "select * from tblContent where sortId="&rs5("sortId")&" and tagId="&rs6("tagId")&" order by cName,cId asc",conn,3,3
											do while not rs7.eof%>							
											<li><span><a href="articleOther-<%=rs7("cId")%>-<%=rs5("sortId")%>.html" target="_blank"><%=rs7("cName")%></a></span></li>
											<%rs7.movenext
											loop
											rs7.close
										%>
									</ul></li>																		
								<% rs6.movenext
								loop
								rs6.close
								end if%>					 	  											
						 </ul>	
						 </li>		
						<% rs5.movenext
						loop
					
					end if %>
					
					<!-- 共享标签（包含隶属中的文章） -->	
					<% set rs15 = server.createobject("adodb.recordset")   	  	  
					rs15.open "select * from tblSort where userName='"&rs1("userName")&"' and sortShare='off' order by sortName,sortId asc",conn,3,3
					if not rs15.eof then
						do while not rs15.eof 
								set rs16 = server.createobject("adodb.recordset")   	  	  
								rs16.open "select * from tblTag where sortId="&rs15("sortId")&" and tagShare='on' and tagState='on' order by tagName,tagId asc",conn,3,3
								if rs16.eof then																							
								else									
									do while not rs16.eof%>	
									<li class="treeview"><a href="#"><i class="fa fa-th-list"></i><span><%=rs16("tagName")%></span><i class="fa fa-angle-right"></i></a>
									<ul class="treeview-menu">	
										<%
											set rs17 = server.createobject("adodb.recordset")   	  	  
											rs17.open "select * from tblContent where sortId="&rs15("sortId")&" and tagId="&rs16("tagId")&" order by cName,cId asc",conn,3,3
											do while not rs17.eof%>							
											<li>	<span><a href="articleOther-<%=rs17("cId")%>-<%=rs15("sortId")%>.html" target="BoardList"><%=rs17("cName")%></a>				</span></li>
											<%rs17.movenext
											loop
											rs17.close
										%>
									</ul></li>	
								<% rs16.movenext
								loop
								rs16.close
								end if				 	  																			
						rs15.movenext
						loop
					
					end if %>
					
																						
					<!-- 共享文章 -->	
					<% set rs11 = server.createobject("adodb.recordset")   	  	  
					rs11.open "select * from tblContent where cState='on' and cShare='on' and userName='"&rs1("userName")&"' order by cName,cId asc",conn,3,3
					if not rs11.eof then 
						do while not rs11.eof %>
							
							<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><a href="articleOther-<%=rs11("cId")%>-<%=rs11("sortId")%>.html"  target="BoardList">&middot;&nbsp;<%=rs11("cName")%></a></span></li>
							
						<% 
						rs11.movenext
						loop
					end if 
					rs11.close%>													
			</ul>
			</li>
		<%rs1.movenext
		loop
		rs1.close
		set rs11 = nothing
		set rs10 = nothing
		set rs9 = nothing
		set rs8 = nothing
		set rs7 = nothing
		set rs6 = nothing
		set rs5 = nothing
		set rs4 = nothing
		set rs3 = nothing
		%>		
		

		  <li><a href="#" id="demoExit"><i class="fa fa-sign-out fa-lg"></i>  <span>退出</span></a></li>
			
	
		</ul>
		</ul>
	</section>
	</aside>


<!-- 百度编辑器--> 
<script src="ueditor/ueditor.config.js"></script>
<script src="ueditor/ueditor.all.min.js"> </script>	
<script src="ueditor/lang/zh-cn/zh-cn.js"></script> 

<!-- 退出弹框效果 -->
<script src="js/exit/jquery-2.1.4.min.js"></script>	
<script type="text/javascript" src="js/exit/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="js/exit/sweetalert.min.js"></script>
<script type="text/javascript" src="js/exit/custom.js"></script>

<!-- top按钮 cd-top-arrow.svg箭头-->
<link href="js/topButton/zzsc.css" rel="stylesheet" type="text/css" />
<script src="js/topButton/jquery.min.js"></script>
<script src="js/topButton/zzsc.js"></script> 

<!-- 快捷鍵列表 -->
<link href="js/shortcutKey/custom.css" rel="stylesheet" type="text/css" />


<!-- 表单提交校验 -->
<script src="js/check.js"></script>

<!-- 表格 -->
<script  src="js/table/jquery.dataTables.min.js"></script>
<script  src="js/table/dataTables.bootstrap.min.js"></script>


