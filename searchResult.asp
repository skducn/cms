<!--#include file="menu.asp"-->
<!--#include file="ajaxMain.asp"-->


<div class="content-wrapper">
<div class="row">
<div class="col-md-12">
<div class="card">
<div class="card-body">		
<!-- ����ҳ��ٷֱ���ʾ2/3 , ��������ٷֱ�����߸��� -->
<div id="percentageCounter"><h1>0%</h1></div>	
		
	<%set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblContent where cId="&int(request("cId"))&"",conn,3,3
	if rs.eof then
		' ��ȫ������ʽurl�޸���Чid
		Response.Write("<script>window.open('index.html','_parent')</script>")
	else%>	
		<title><%=rs("cName")%> | <%=cstProject%></title>		
							
		<div class="row">
				<div class="col-md-4">		
						
				<!-- �����-->
				<% set rs1 = server.createobject("adodb.recordset")
				rs1.open "select * from tblSort where sortId="&rs("sortId")&"" ,conn,3,3      	
				if rs("tagId")="0" then%>
				<i class="fa fa-home fa-lg"></i> &rsaquo; <%=rs1("sortName")%>
				<%else
				set rs2 = server.createobject("adodb.recordset")			
				rs2.open "select * from tblTag where tagId="&rs("tagId")&"" ,conn,3,3
				%> <i class="fa fa-home fa-lg"></i> &rsaquo; <%=rs1("sortName")%> &rsaquo;
				<a href="searchTag-<%=rs2("tagId")%>.html"><%=rs2("tagName")%></a>
				<%rs2.close 
				set rs2 = nothing 
				end if
				rs1.close
				set rs1 = nothing
				%>												
			</div>		
			<div class="col-md-8" align="right">
			
								<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"> </i> ��ݼ�</button>									
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"><br><br><br><br><br><br><br><br>
					<div class="modal-dialog" role="document">
						<div class="modal-content">								
							<form action="articleSaveShort.html" method="post" name="addForm1"  class="login-form" onSubmit="return CheckShortAdd()" >		
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">��</span>
									</button>
									<h4 class="modal-title" align="left" id="myModalLabel">������ݼ�</h4>
								</div>
								<div class="modal-body">
									<div class="form-group" align="left">
										<label class="control-label"><h5>�������</h5></label>
										<input class="form-control" type="text" name="keyName" placeholder="baidu">
									</div>
									<div class="form-group" align="left">
										<label class="control-label"><h5>�����ַURL</h5></label>
										<input class="form-control" type="text" name="keyLink" placeholder="http://www.baidu.com">
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">ȡ��</button>
									<button class="btn btn-primary " type="submit">�ύ</button>
								</div>	
									<input type="hidden" name="cId" value="<%=request("cId")%>">			
									<input type="hidden" name="sortId" value="<%=request("sortId")%>">			
							</form>										
						</div>
					</div>
				</div>
			
				<div class="btn-group">																			
				<% if session("userName")= rs("userName") then %>	
					<a class="btn btn-primary" target="_blank" href="articleAdd-<%=rs("sortId")%>-<%=rs("tagId")%>.html" data-toggle="tooltip" data-original-title="�½�">�½�<i class="fa fa-plus"></i></a>								<a class="btn btn-info " href="articleEdit-<%=request("cId")%>.html" data-toggle="tooltip" data-original-title="�༭">�༭<i class="fa fa-edit"></i></a>
					<a class="btn btn-warning" href="#" onClick="ajaxSort();" data-toggle="tooltip" data-original-title="ת��">ת��<i class="fa fa-truck"></i></a>
					<% if rs("cShare") = "on" then%>
						<a class="btn btn-default " href="articleNoshare-<%=request("cId")%>-<%=rs("sortId")%>.html" data-toggle="tooltip" data-original-title="������">������<i class="fa fa-reply"></i></a>						<%else%>
						<a class="btn btn-success " href="articleShare-<%=request("cId")%>-<%=rs("sortId")%>.html" data-toggle="tooltip" data-original-title="����">����<i class="fa fa-share"></i></a>
					<%end if
				end if %>	
				</div>
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��">��ҳ��<i class="fa fa-arrow-circle-down"></i></a>
			</div>
		</div> <!-- row end -->
		
					
		<hr>
		
		
		<div class="row">
				
			<div class="col-md-12">						
				<h3 class="card-title"><%=rs("cName")%></h3>		
				<%if rs("cLatestDate") <> "" then%>
					�����ڣ�<%=rs("cLatestDate")%>
				<%else%>
					�����ڣ�<%=rs("cCrtDate")%>								
				<%end if %>																					
					
			<!-- ����ת�� ������ -->	
			<% if session("userName")= rs("userName") then %>																								
				<div id="ajaxSortDiv"></div>
				<div id="ajaxTagDiv"></div>
				<div id="ajaxInfoDiv"></div>						
			<%end if %>	
			</div>
		</div> <!-- row end -->	
			
		<!-- �������� -->
		<br><%=rs("cContent")%><br>
					
		<% if session("userName")= rs("userName") then %>
			<hr>
			<div class="row">
				<div class="col-md-6">
					<div class="btn-group">	
					<a class="btn btn-primary" href="articleAdd-<%=rs("sortId")%>-<%=rs("tagId")%>.html" data-toggle="tooltip" data-original-title="�½�">�½�<i class="fa fa-plus"></i></a>
					<a class="btn btn-info" href="articleEdit-<%=request("cId")%>.html" data-toggle="tooltip" data-original-title="�༭">�༭<i class="fa fa-edit"></i></a>
					<a class="btn btn-warning" href="#" onClick="ajaxSort();" data-toggle="tooltip" data-original-title="ת��">ת��<i class="fa fa-truck"></i></a>
					<% if rs("cShare") = "on" then%>
						<a class="btn btn-default" href="articleNoshare-<%=request("cId")%>-<%=request("sortId")%>.html" data-toggle="tooltip" data-original-title="������">������<i class="fa fa-reply"></i></a>
					<%else%>
						<a class="btn btn-success" href="articleShare-<%=request("cId")%>-<%=request("sortId")%>.html" data-toggle="tooltip" data-original-title="����">����<i class="fa fa-share"></i></a>
					<%end if %>
					</div>
				</div>				
				</a>			
			</div>	
		<%end if 
	end if
	rs.close
	set rs = nothing 
	%>					
</div>
</div>
</div>
</div>
</div>	
		





</body>
</html>

<!-- top -->
<a href="#0" class="cd-top">Top</a>


<!-- ����ҳ��ٷֱ���ʾ1/3 -->
<link href="js/percent/percent.css" rel="stylesheet" type="text/css" />
<script src="js/percent/percent.js"></script>


<!-- ���˵�������ÿ��ҳ��ײ�-->
<script src="js/menu/jquery-2.1.4.min.js"></script>
<script src="js/menu/bootstrap.min.js"></script>
<script src="js/menu/plugins/pace.min.js"></script>
<script src="js/menu/main.js"></script>
<script src="js/shortcutKey/bootstrap-notify.min.js"></script>