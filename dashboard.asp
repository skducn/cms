<!--#include file="menu.asp"-->

<title>�ҵ���� | <%=cstProject%></title>


<!-- ������ݼ� -->

<%
if request("action")="saveShort" then
	x= 0 
	set rs = server.CreateObject("adodb.recordset")
	rs.open "select * from tblKey where userId="&session("userId")&"",conn,3,3
	do while not rs.eof
		if rs("keyName") = request("keyName") or rs("keyLink") = request("keyLink") then
			x= x+1			
		end if 
	rs.movenext
	loop
	
	if x = 0 then
		rs.addnew
		rs("userId") = session("userId")
		rs("keyName") = request("keyName")
		keyLink = request("keyLink")
		if instr(keyLink,"http://")>0 or instr(keyLink,"https://")>0 then
			rs("keyLink") = keyLink
		else
			rs("keyLink") = "http://" + keyLink 
		end if
		rs("keyWay") = "�ҵ����"
		rs.update 
	end if 
	rs.close
	set rs = nothing  
	response.Redirect "dashboard.html"
end if
%>


<!--  ���湤���嵥 -->
<% 
if request("action") = "save" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblUser where userName='"&session("userName")&"'",conn,3,3
	rs("userMemo") = request("userMemo")
	rs.update
	rs.close
	set rs = nothing
	response.Redirect "dashboard.html"
end if 
%>


<div class="content-wrapper">
	<div class="page-title">
		<div>
			<h1>�ҵ����</h1>
			<p>Dashboard<font color="white"><%response.write session.timeout%></font></p>
		</div>
		<div>
			<ul class="breadcrumb">
			<li><i class="fa fa-home fa-lg"></i></li>
			<li><a href="#">�ҵ����</a></li>
			</ul>
		</div>
	</div>
		
		
	<div class="row">
		<div class="col-md-6">
			<div class="card">
				<h3 class="card-title">��ʼ���� ��<a href="/demo/readme.html" target="_blank">ʹ��˵��</a>��</h3>
				<p><%=cstIntro%></p>
				<p>����Ի��<a href="https://baike.baidu.com/item/%E5%AD%A6%E8%80%8C%E4%B8%8D%E6%80%9D%E5%88%99%E7%BD%94%EF%BC%8C%E6%80%9D%E8%80%8C%E4%B8%8D%E5%AD%A6%E5%88%99%E6%AE%86/5176758?fr=aladdin" target="_blank">ѧ����˼���裬˼����ѧ���</a> ����ʱ�̱޲��Լ�����Ҫ��и�����ѧϰ��</p>
				
				<div class="pull-right image" id='qrcode'></div>


	<!-- �������һ���½��ļ��Ĵ����ͱ�ǩ -->
				<div class="buttonJianju">
				<%
				'���û����������ǹرգ���ֹ���ģ�����ʾ�½�����
				set rs1 = server.CreateObject("adodb.recordset")
				rs1.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on' order by sortId desc",conn,3,3	
				if rs1.recordcount <> 0 then 				
					set rs = server.CreateObject("adodb.recordset")
					rs.open "select * from tblContent where userName='"&session("userName")&"' order by cId desc",conn,3,3		
					if rs.recordcount <> 0 then %>								
						<a class="btn btn-primary" href="articleAdd-0-0.html"><i class="fa fa-plus"></i>&nbsp;����</a>			
					<%else%>
						<a class="btn btn-primary" href="articleAdd.html"><i class="fa fa-plus"></i>&nbsp;����</a>		
					<%end if 
					rs.close
					set rs = nothing 
					rs1.close
				end if 
				%>	
				
					

				<a class=" btn btn-info" href="http://<%=getServerIp()%>:88" target="_blank" data-toggle="tooltip" data-original-title="http://<%=getServerIp()%>:88"><i class="fa fa-list"></i>&nbsp;��������</a>
				
				<br>	<br>	<br>
				</div>
			</div>
		</div>
		
		<div class="col-md-6">
			<div class="card">
				<div class="row">
					<div class="col-md-6">
						<h3 class="card-title">��ݼ��б�</h3>
					</div>
					
					<div class="col-md-6" align="right">	
				
						<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"> </i> ��ݼ�</button>					
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"><br><br><br><br><br><br><br><br>
						<div class="modal-dialog" role="document">
						<div class="modal-content">											
							<form action="dashboardSaveShort.html" method="post" name="addForm1"  class="login-form" onSubmit="return shortcutKeyCheck()" >		
							<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">��</span>
							</button>
							<h4 class="modal-title" align="left" id="myModalLabel">������ݼ�</h4>
							</div>
							<div class="modal-body">
							<div class="form-group" align="left">
							<label class="control-label">�������</label>
							<input class="form-control" type="text" name="keyName" placeholder="baidu">
							</div>
							<div class="form-group" align="left">
							<label class="control-label">�����ַURL</label>
							<input class="form-control" type="text" name="keyLink" placeholder="http://www.baidu.com">
							</div>
							</div>
							<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">ȡ��</button>
							<button class="btn btn-primary " type="submit">�ύ</button>
							</div>	
							</form>										
						</div>
						</div>
						</div>																							
						<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>
					</div>
				</div>
							
				
				<div class="buttonJianju">

	
					<%set rs1 = server.CreateObject("adodb.recordset")
				rs1.open "select * from tblKey where userId="&session("userId")&" and keySort=0 order by keyId",conn,3,3	
				do while not rs1.eof %>
				  <a style="color:white" class=" btn shortkeyb" href="<%=rs1("keyLink")%>" target="_blank" data-toggle="tooltip" data-original-title="<%=rs1("keyLink")%>"><i class="fa fa-location-arrow"></i>&nbsp;<%=rs1("keyName")%></a>
				 
				 
				<%rs1.movenext
				loop
				rs1.close
				
				%> 
				</div>
				
			
			</div>
		</div>		  
	</div>
		
		 
	<div class="row">
		<div class="col-md-6">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title">��������</h3>
					<table class="table table-hover table-bordered" id="dashboard_addArticle">
					<thead><tr>
					<th style="width: 20%">�������</th>
					<th style="width: 50%">��������</th>
					<th style="width: 30%">��������</th>
					</tr></thead><tbody>
					<%set rs1 = server.createobject("adodb.recordset")						
					rs1.open "select * from tblContent where userName='"&session("userName")&"' and cState='on' order by cCrtDate desc",conn,3,3
					do while not rs1.eof %>
						<tr>
						<%set rs7 = server.createobject("adodb.recordset")						
						rs7.open "select * from tblSort where userName='"&session("userName")&"' and sortId="&rs1("sortId")&" order by sortId asc",conn,3,3
						if rs7("sortState") = "on" then %>
							<td><%=rs7("sortName")%></td>
							<td><a href="article-<%=rs1("cId")%>-<%=rs1("sortId")%>.html" target="_self" ><%response.write rs1("cName")%></a></td>
							<td><%=rs1("cCrtDate")%></td>
						<%else%> 
							<td></td>
							<td></td>
						<%end if %>
						</tr>
					<%rs1.movenext
					loop
					rs1.close%>
					</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="col-md-6">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title">�ѱ༭����</h3>
					<table class="table table-hover table-bordered" id="dashboard_editArticle">
					<thead><tr>
					<th style="width: 20%">�������</th>
					<th style="width: 50%">��������</th>
					<th style="width: 30%">�༭����</th>
					</tr></thead><tbody>
					<%set rs2 = server.createobject("adodb.recordset")
					rs2.open "select * from tblContent where userName='"&session("userName")&"' and cState='on' and Format(cLatestDate,'yyyymmdd')<>'' order by cLatestDate desc",conn,3,3
					do while not rs2.eof%>
						<tr>
						<%set rs7 = server.createobject("adodb.recordset")						
						rs7.open "select * from tblSort where userName='"&session("userName")&"' and sortId="&rs2("sortId")&" order by sortId asc",conn,3,3
						if rs7("sortState") = "on" then %>
							<td><%=rs7("sortName")%></td>
							<td><a href="article-<%=rs2("cId")%>-<%=rs2("sortId")%>.html" target="_self" ><%response.write rs2("cName")%></a></td>
							<td><%=rs2("cLatestDate")%></td>
						<%else%> 
							<td></td>
							<td></td>
						<%end if %>
						</tr>
					<% rs2.movenext
					loop
					rs2.close%>	
					</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>	
	

	
	<form class="form-horizontal" method="post" name="addForm" onSubmit="return saveSuccess()" action="dashboardSave.html"> 
					
	<div class="row">
		<div class="col-md-12">		
			<div class="card">
	
				<div class="row">
					<div class="col-md-6">
						<h3 class="card-title">�����嵥</h3>
					</div>
					
					<div class="col-md-6" align="right">
						<button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;����</button>
					</div>
				</div>				
																					
				<%set rs = server.createobject("adodb.recordset")
				rs.open "select * from tblUser where userName='"&session("userName")&"'",conn,3,3%>								
				<script type="text/plain" id="userMemo" style="width:100%; height:300px" name="userMemo"><%=rs("userMemo")%></script>	
				<script>var editor_a = UE.getEditor('userMemo');</script>
				<%rs.close
				set rs = nothing%>
				<br />
				<table width="100%" border="0">
					<tr><td><div align="center"><button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;���� �����嵥</button></div></td></tr>
				</table>						
			

			</div>
		</div>	
	</div>
	
	</form>
	
	
	<!-- �鿴���г�Ա�Ĺ����嵥 -->
	<%if session("userPower") = 3 then%>
		<div class="row">
		<%	
		set rs = server.createobject("adodb.recordset")
		rs.open "select * from tblUser where groupId="&session("groupId")&" and userState='on' and userPower='5' order by userId ",conn,3,3
		do while not rs.eof%>				
			<div class="col-md-6">		
				<div class="card">
					<h3 class="card-title"><%=rs("userNickName")%> - �����嵥</h3>							
					<%=rs("userMemo")%>
				</div>
			</div>				
		<%rs.movenext
		loop
		rs.close
		%>
		</div>
	<%end if %>
	


	<!-- ����top��ť -->
	<div class="row">
	<div class="col-md-2">
	</div>
	<div class="col-md-10" align="right">
	</a><a id='DD'></a>
	</div>
	</div>

	<br>
	

</div>	

</body>
</html>	


<!-- top -->
<a href="#0" class="cd-top">Top</a>


<!-- ��� -->
<script  src="js/table/custom.js"></script>


<!-- ���˵�������ÿ��ҳ��ײ�-->
<script src="js/menu/jquery-2.1.4.min.js"></script>
<script src="js/menu/bootstrap.min.js"></script>
<script src="js/menu/plugins/pace.min.js"></script>
<script src="js/menu/main.js"></script>
<script src="js/shortcutKey/bootstrap-notify.min.js"></script>



