<!--#include file="bFrame.asp"-->
<%=bMain%>

<title><%=cstCompany%> | 编辑群组</title>

<% groupId = request("groupId")%>


<!-- 权限验证 -->
<%
set rs = server.CreateObject("adodb.recordset")
rs.Open "select * from tblGroup where groupId="&groupId&"",conn,3,3
if rs.eof  then
	response.Redirect("../index.html")
end if 
rs.close
%>

<!--  获取所有群组名 -->

<%
dim arr_groupName,rs8
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblGroup where groupId<>"&groupId&"",conn,3,3

Do While Not rs8.Eof
If arr_groupName = "" Then
arr_groupName = rs8("groupName")
Else
arr_groupName = arr_groupName&","&rs8("groupName")
End If
rs8.Movenext
loop
 
rs8.close
set rs8 = nothing 
%>

<script language="javascript">
function CheckPost()
{	
	// 群组名称不能为空
	if (addForm.groupName.value == "" ){
		alert("温馨提示，群组名称不能为空！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.groupName.focus();
		return false;}	
		
	// 群组(去重)
	var arr = addForm.arr_groupName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.groupName.value == arr[i]){
			alert("温馨提示，群组已存在！", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.groupName.focus();
			return false;}}
	
	var gnl=confirm("确定要保存?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
 
</script>

<!--  编辑项目	-->

<% 
if request.form("sub")="sub" then
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblGroup where groupId="&request("groupId")&"",conn,3,3	
	rs("groupName") = request("groupName")
	rs("groupState") = request("groupState")
	rs.update
	rs.close
	set rs = nothing 
	response.Redirect("bGroupEdit-"&request("groupId")&".html")
end if 
%>


<div class="content-wrapper">

<div class="row page-tilte align-items-center">
	<div class="col-md-auto">
		<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
		<h1 class="weight-300 h3 title">群组管理</h1>
		<p class="text-muted m-0 desc">Group management</p>
	</div> 
	<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
		<div class="controls d-flex justify-content-center justify-content-md-end"></div>
	</div>
</div> 

<div class="content">
	<div class="row">
	
	<div class="col-lg-6 ">
	<div class="card mb-4">
		<div class="card-header">编辑群组</div>
		<div class="card-body">
		
	
		<form method="post" name="addForm" onSubmit="return CheckPost()">   			
		
		<%
	
		set rs = server.CreateObject("ADODB.RecordSet")
		rs.Open "select * from tblGroup where groupId="&groupId&"",conn,3,3
		%>
		
		<div class="col-xs-3">
			<div class="form-group">
			<label>群组名称 *（1<7）</label>
				<input type="text" name="groupName" maxlength="6" class="form-control" value="<%=rs("groupName")%>">
			</div>
		</div>
		
		<div class="col-xs-3">
			<div class="form-group">
				<label>群组状态</label>				
				<% if rs("groupState") = "on" then %>
					<div class="radio">
						<label><input type="radio" name="groupState" value="on" checked> <span class="badge badge-info">开启</span></label>
						<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="groupState"  value="off"> <span class="badge badge-danger">关闭</span></label>	
					</div>																								
				<% elseif rs("groupState") = "off" then %>
					<div class="radio">
						<label><input type="radio" name="groupState" value="on" > <span class="badge badge-info">开启</span></label>
						<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="groupState"  value="off" checked> <span class="badge badge-danger">关闭</span></label>
					</div>
				<%end if %>	
								
			</div>
		</div>
					
			<input type="hidden" name="sub" value="sub">
			<input type="hidden" name="arr_groupName" value="<%=arr_groupName%>">

		<div align="center">
			<button type="submit" class="btn btn-primary" href="#">保存</button>
		</div>
		</form>
		</div>	<!-- "card-body" --> 		
	</div><!-- "card mb-4" --> 	
	</div><!-- col-lg-6 --> 	
	
	
	<div class="col-lg-6">
	<div class="card mb-4">
	<div class="card-header">				
		<div class="alert alert-primary" role="alert">群组列表</div>
		<div class="card-body">	
			<table class="table table-striped m-0">
			<thead>
			<tr>
			<th>群组</th>
			<th>状态</th>
			</tr>
			</thead><tbody>
			<% set rs = server.CreateObject("ADODB.RecordSet")	
			rs.Open "select * from tblGroup ",conn,3,3
			if rs.eof then
				response.write "无群组"
			else
				do while not rs.eof %>
					<tr>		
					<td><a href="bGroupEdit-<%=rs("groupId")%>.html"><%=rs("groupName")%></a></td>
					<%if rs("groupState") = "on" then%>
					<td><span class="badge badge-info">开启</span></td>
					<%else%>
					<td><span class="badge badge-danger">关闭</span></td>
					<%end if %>					
					</tr>
				<%
				rs.movenext
				loop
			end if 
			rs.close
			set rs = nothing%>																			
			</tbody>
			</table>
		</div>	
	</div>	<!-- "card-header" --> 		
	</div><!-- "card mb-4" --> 	
	</div><!-- col-lg-6 --> 	
			
			
	</div>
</div>
<!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Slimscroll -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="../plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="../plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="../plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="../plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="../plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="../plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>

</body>
</html>


