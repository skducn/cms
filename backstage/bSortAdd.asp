<!--#include file="bFrame.asp"-->
<%=bMain%>

<title><%=cstCompany%> | �½����</title>


<!--  ��ȡ��ǰ�û��������ȥ�ر��� -->

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
	//	���
	if (addForm.sortName.value == "" || addForm.sortName.value.length < 4){
		alert("��ܰ��ʾ����������˺ų��ȷ�Χ 4 - 8���ַ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.sortName.focus();
		return false;}
		
	// ���(ȥ��)
	var arr = addForm.jsSortName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.sortName.value == arr[i]){
			alert("��ܰ��ʾ����������Ѵ��ڣ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.sortName.focus();
			return false;}}
			
	var gnl=confirm("ȷ��Ҫ�ύ?");
	if (gnl==true){
		return true;}
	else{
		return false;}
	 
}
 
</script>


<!--  �½����(js����ȥ���ж�)	-->

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
		<h1 class="weight-300 h3 title">������</h1>
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
				<div class="card-header">�½����</div>
				<div class="card-body">
			
					<form method="post" name="addForm" onSubmit="return CheckPost()">   
					
					<div class="form-group">
						<label for="inputAddress">������� * ��4-8��</label>
						<input type="text" name="sortName" id="sortName"  maxlength="8" class="form-control"  placeholder="" >
					</div>
					<div align="center">
					<button type="submit" class="btn btn-primary" href="#">�ύ</button></div>
					<input type="hidden" name="sub" value="sub">
					<input type="hidden" name="jsSortName" value="<%=jsSortName%>">
					</form>

					</div>
				</div>
			</div>
						
						
						
		
				<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-header">
			       		<div class="alert alert-primary" role="alert">����б�</div>
					<div class="card-body">				
						<table class="table table-striped m-0">
						<thead>
						<tr>
						<th>�������</th>
						<th>���״̬</th>
						<th>����״̬</th>
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
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-danger">�ر�</span></td><td><span class="badge badge-dark">�ر�</span></td>
								<%else%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-danger">�ر�</span></td><td><span class="badge badge-info">����</span></td>
								<%end if
							else 
								if rs("sortShare") = "off" then%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-info">����</span></td><td><span class="badge badge-dark">�ر�</span>	</td>																	
								<%else%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-info">����</span></td><td><span class="badge badge-info">����</span>	</td>
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




