<!--#include file="menu.asp"-->
<!--#include file="ajaxMain.asp"-->

<!-- ����ҳ��ٷֱ���ʾ1/3 -->
<style>
#percentageCounter {
position: fixed;
bottom: 30px;
left: 56%;
}
h1 {
font-size: +2em;
}

.buttonJianju a{margin: 2px;}
.shortkeyb {
     background-color:#c6c386;

}
</style>


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
		<title><%=rs("cName")%> | <%=cstCompany%></title>		
							
		<div class="row">
			<div class="col-md-6">
				<h3 class="card-title"><%=rs("cName")%></h3>				
			</div>		
			<div class="col-md-6" align="right">
			
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
					<a class="btn btn-primary" target="_blank" href="articleAdd-<%=rs("sortId")%>-<%=rs("tagId")%>.html" data-toggle="tooltip" data-original-title="�½�"><i class="fa fa-plus"></i></a>								<a class="btn btn-info " href="articleEdit-<%=request("cId")%>.html" data-toggle="tooltip" data-original-title="�༭"><i class="fa fa-edit"></i></a>
					<a class="btn btn-warning" href="#" onClick="ajaxSort();" data-toggle="tooltip" data-original-title="ת��"><i class="fa fa-truck"></i></a>
					<% if rs("cShare") = "on" then%>
						<a class="btn btn-default " href="articleNoshare-<%=request("cId")%>-<%=rs("sortId")%>.html" data-toggle="tooltip" data-original-title="ȡ������"><i class="fa fa-reply"></i></a>						<%else%>
						<a class="btn btn-success " href="articleShare-<%=request("cId")%>-<%=rs("sortId")%>.html" data-toggle="tooltip" data-original-title="����"><i class="fa fa-share"></i></a>
					<%end if
				end if %>	
				</div>
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>
			</div>
		</div> <!-- row end -->
		
					
		<hr><br>

		<div class="row">
			<div class="col-md-9">								
				<!-- �����-->
				<% set rs1 = server.createobject("adodb.recordset")
				rs1.open "select * from tblSort where sortId="&rs("sortId")&"" ,conn,3,3      	
				if rs("tagId")="0" then%>
				<i class="fa fa-home fa-lg"></i> / <%=rs1("sortName")%>
				<%else
				set rs2 = server.createobject("adodb.recordset")			
				rs2.open "select * from tblTag where tagId="&rs("tagId")&"" ,conn,3,3
				%> <i class="fa fa-home fa-lg"></i> / <%=rs1("sortName")%> - 
				<a href="searchTag-<%=rs2("tagId")%>.html"><%=rs2("tagName")%></a>
				<%rs2.close 
				set rs2 = nothing 
				end if
				rs1.close
				set rs1 = nothing
				%>																						
			</div>							
							
			<div class="col-md-3" align="right">
				����ʱ�䣺
				<%if rs("cLatestDate") <> "" then%>
				<%=rs("cLatestDate")%>
				<%else%>
				<%=rs("cCrtDate")%>								
				<%end if %>
			</div>
				
			<!-- ����ת�� ������ -->			
			<% if session("userName")= rs("userName") then %>					
				<div id="ajaxSortDiv"></div>
				<div id="ajaxTagDiv"></div>
				<div id="ajaxInfoDiv"></div>						
			<%end if %>								
		</div> <!-- row end -->
			
		<!-- �������� -->
		<br><%=rs("cContent")%><br>
					
		<% if session("userName")= rs("userName") then %>
			<hr><br>
			<div class="row">
				<div class="col-md-6">
					<div class="btn-group">	
					<a class="btn btn-primary" href="articleAdd-<%=rs("sortId")%>-<%=rs("tagId")%>.html" data-toggle="tooltip" data-original-title="�½�"><i class="fa fa-plus"></i></a>
					<a class="btn btn-info" href="articleEdit-<%=request("cId")%>.html" data-toggle="tooltip" data-original-title="�༭"><i class="fa fa-edit"></i></a>
					<a class="btn btn-warning" href="#" onClick="ajaxSort();" data-toggle="tooltip" data-original-title="ת��"><i class="fa fa-truck"></i></a>
					<% if rs("cShare") = "on" then%>
						<a class="btn btn-default" href="articleNoshare-<%=request("cId")%>-<%=request("sortId")%>.html" data-toggle="tooltip" data-original-title="ȡ������"><i class="fa fa-reply"></i></a>
					<%else%>
						<a class="btn btn-success" href="articleShare-<%=request("cId")%>-<%=request("sortId")%>.html" data-toggle="tooltip" data-original-title="����"><i class="fa fa-share"></i></a>
					<%end if %>
					</div>
				</div>				
				</a><a id='DD'></a>				
			</div>	<!-- row end -->
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
		

<!-- table-->
<script type="text/javascript" src="731/dist/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">$('#sampleTable').DataTable();</script>
<script type="text/javascript">$('#sampleTable2').DataTable();</script>
	

<!-- �Ҳ�̶�top -->
<link rel=stylesheet href="top_QRcode/css/common.css">
<link rel=stylesheet href="top_QRcode/css/jdc-side-panel.css">
<div class="jdc-side" style="display: block;">
<div class="mod_hang_qrcode mod_hang_top"><a href="#" class="mod_hang_qrcode_btn"><i class="jdcfont">��</i><span>���ض���</span></a></div>
<div class="el-dialog__wrapper" style="display: none;">
<div class="el-dialog el-dialog--small" style="top: 15%;">
<div class="el-dialog__header"><span class="el-dialog__title"></span>
<div type="button" class="el-dialog__headerbtn"><i class="el-dialog__close el-icon el-icon-close"></i></div>
</div>
</div>
</div>
</div>


<!-- ����ҳ��ٷֱ���ʾ3/3  -->
<script>
$(window).scroll(function(){
//Window Math
var scrollTo = $(window).scrollTop(),
docHeight = $(document).height(),
windowHeight = $(window).height();
scrollPercent = (scrollTo / (docHeight-windowHeight)) * 100;
scrollPercent = scrollPercent.toFixed(0);
if (scrollPercent>0) {
  $('#percentageCounter h1').text(scrollPercent+"%");
}
}).trigger('scroll');
</script>

</body>
</html>