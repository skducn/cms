<!--#include file="bFrame.asp"-->
<%=bMain%>

<title><%=cstCompany%> | 新建类别</title>


<!--  获取当前用户所有类别，去重遍历 -->

<%
dim jsSortName,rs8
jsSortName = ""
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblSort where userName='"&session("userName")&"'",conn,3,3
Do While Not rs8.Eof
If jsSortName = "" Then
jsSortName = rs8("sortName")
Else
jsSortName = jsSortName&","&rs8("sortName")
End If
rs8.Movenext
loop
rs8.close
set rs8 = nothing 
%>

<script language="javascript">
function CheckPost()
{
	//	类别
	if (addForm.sortName.value == "" || addForm.sortName.value.length < 4){
		alert("温馨提示，类别名称账号长度范围 4 - 8个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.sortName.focus();
		return false;}
		
	// 类别(去重)
	var arr = addForm.jsSortName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.sortName.value == arr[i]){
			alert("温馨提示，类别名称已存在！", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.sortName.focus();
			return false;}}
			
	var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;}
	else{
		return false;}
	 
}
 
</script>


<!--  新建类别(js中已去重判断)	-->

<% 
if request.form("sub")="sub" then
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblSort",conn,3,3	
	rs.addnew
	rs("groupId") = session("groupId")
	rs("sortState") = "on"
	rs("sortName") = request.form("sortName")
	rs("userName") = session("userName")
	rs("sortShare") = "off"
	rs("sortCrtDate") = now
	rs.update
	response.Redirect("bSortAdd.html")
	rs.close
	set rs = nothing 
end if 
%>


<div class="content-wrapper">

<div class="row page-tilte align-items-center">
	<div class="col-md-auto">
		<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
		<h1 class="weight-300 h3 title">类别管理</h1>
		<p class="text-muted m-0 desc">Sort management</p>
	</div> 
	<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
		<div class="controls d-flex justify-content-center justify-content-md-end"></div>
	</div>
</div> 

<div class="content">
	<div class="row">
		<div class="col-lg-6 ">
			<div class="card mb-4">
				<div class="card-header">新建类别</div>
				<div class="card-body">
			
					<form method="post" name="addForm" onSubmit="return CheckPost()">   
					
					<div class="form-group">
						<label for="inputAddress">类别名称 * （4-8）</label>
						<input type="text" name="sortName" id="sortName"  maxlength="8" class="form-control"  placeholder="" >
					</div>
					<div align="center">
					<button type="submit" class="btn btn-primary" href="#">提交</button></div>
					<input type="hidden" name="sub" value="sub">
					<input type="hidden" name="jsSortName" value="<%=jsSortName%>">
					</form>

					</div>
				</div>
			</div>
						
						
						
		
				<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-header">
			       		<div class="alert alert-primary" role="alert">类别列表</div>
					<div class="card-body">				
						<table class="table table-striped m-0">
						<thead>
						<tr>
						<th>类别名称</th>
						<th>类别状态</th>
						<th>共享状态</th>
						</tr>
						</thead>
						<tbody>
						<% dim serial
						set rs = server.CreateObject("ADODB.RecordSet")
						rs.Open "select * from tblSort where groupId="&session("groupId")&" and userName='"&session("userName")&"' order by sortName,sortId asc",conn,3,3	
						if not rs.eof then
							do while not rs.eof%>
							<tr>

									<%
							if rs("sortState") = "off" then
								if rs("sortShare") = "off" then%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-danger">关闭</span></td><td><span class="badge badge-dark">关闭</span></td>
								<%else%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-danger">关闭</span></td><td><span class="badge badge-info">开启</span></td>
								<%end if
							else 
								if rs("sortShare") = "off" then%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-info">开启</span></td><td><span class="badge badge-dark">关闭</span>	</td>																	
								<%else%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-info">开启</span></td><td><span class="badge badge-info">开启</span>	</td>
								<%end if 
							end if%>									
							</tr>						
						<%
						rs.movenext
						loop	
						end if 					
						%>																					
						</tbody>
						</table>	
					</div>										
					</div> <!-- card-body --> 					
				</div><!-- "card mb-4" --> 	
			</div><!-- col-lg-6 --> 
			
	</div>
</div>

</div>
</body>
</html>




