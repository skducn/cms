<!--#include file="bFrame.asp"-->

<%=bMain%>

<title><%=cstCompany%> | �༭���</title>

<%sortId = request("sortId")  %>


<!--  ��ȡ��ǰ�û��������ȥ�ر��� -->

<%
dim jsSortName,rs8
jsSortName = ""
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblSort where sortId<>"&sortId&" and userName='"&session("userName")&"'",conn,3,3
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
			
	var gnl=confirm("ȷ��Ҫ����?");
	if (gnl==true){
		return true;}
	else{
		return false;}
	 
}
 
</script>

<!--  �༭���	-->

<% 
if request.form("sub")="sub" then
	sortId = request.form("sortId")
	sortName = request.form("sortName")
	sortState = request.form("sortState")
	sortShare = request.form("sortShare")
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblSort where sortId="&sortId&"",conn,3,3
	rs("sortName") = sortName
	rs("sortState") = sortState
	rs("sortShare") = sortShare
	if sortShare = "on" then
		set rs3 = server.createobject("adodb.recordset")
		rs3.open "select * from tblUser where userId="&session("userId")&"",conn,3,3
		rs3("userShare") = "on"
		rs3.update
		rs3.close
	end if 
	rs("sortLatestDate") = now
	rs.update
	rs.close
	set rs = nothing
	' �رյ���𣬲���������
	if sortState = "off" then
		set rs1 = server.CreateObject("ADODB.RecordSet")
		rs1.Open "select * from tblContent where sortId="&sortId&" order by cId desc",conn,3,3
		do while not rs1.eof
			rs1("cState") = "off"
			rs1.update
		rs1.movenext
		loop
		rs1.close
	else
		set rs2 = server.CreateObject("ADODB.RecordSet")
		rs2.Open "select * from tblContent where sortId="&sortId&" order by cId,sortId desc",conn,3,3
		do while not rs2.eof
			rs2("cState") = "on"
			rs2.update
		rs2.movenext
		loop
		rs2.close	
	end if 
	
	' ��𡢹���״̬�Զ�������Ӧ���±�ǩ ���ر������ر������б�ǩ
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblTag where sortId="&sortId&"",conn,3,3
	if not rs.eof then	
		if sortState = "off" then
			do while not rs.eof
				rs("tagState") = "off"
			rs.movenext
			loop		
		else
			do while not rs.eof
				rs("tagState") = "on"
			rs.movenext
			loop	
		end if 
		
		rs.movefirst
		
		if sortShare = "off" then
			do while not rs.eof
				rs("tagShare") = "off"
			rs.movenext
			loop		
		else
			do while not rs.eof
				rs("tagShare") = "on"
			rs.movenext
			loop	
		end if 
		
		rs.movefirst
		
		' �رյı�ǩ������������
		if sortState = "off" then
			set rs3 = server.CreateObject("ADODB.RecordSet")
			rs3.Open "select * from tblContent where tagId="&rs("tagId")&" order by cId,sortId,tagId desc",conn,3,3
			do while not rs3.eof
				rs3("cState") = "off"
				rs3.update
			rs3.movenext
			loop
			rs3.close		
		end if 
	
	end if 
	response.Redirect("bSortEdit-"&sortId&".html")

end if 
%>


<%

set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tblSort where sortId="&sortId&"",conn,3,3
if rs.eof then
	response.Redirect("../index.html")
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
				<div class="card-header">�༭���</div>
				<div class="card-body">

					<form method="post" name="addForm" onSubmit="return CheckPost()">   

					<div class="form-group">
						<label for="inputAddress">������� * ��4-8��</label>
						<input type="text" name="sortName" id="sortName"  maxlength="8" class="form-control"  value="<%=rs("sortName")%>" >
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="exampleFormControlInput1">���״̬</label>
							<% if rs("sortState") = "on" then %>
									<div class="radio">
										<label><input type="radio" name="sortState" value="on" checked> <span class="badge badge-info">����</span></label>
										<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortState"  value="off"> <span class="badge badge-danger">�ر�</span></label>	
									</div>
								<% elseif rs("sortState") = "off" then %>
									<div class="radio">
										<label><input type="radio" name="sortState" value="on" > <span class="badge badge-info">����</span></label>
										<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortState"  value="off" checked> <span class="badge badge-danger">�ر�</span></label>	
									</div>
								<% elseif rs("sortState") = "ban" then %>
									<div class="radio">
										<label><input type="radio" name="sortState" value="ban" checked> <span class="badge badge-dark">�ѽ�ֹ������ϵ����Ա��</span></label>
									</div>
								<%end if %>
						</div>
					
						<div class="form-group col-md-6">
							<label for="inputPassword4">����״̬ </label>
							<% if rs("sortShare") = "on" then %>
								<div class="radio">
									<label><input type="radio" name="sortShare" value="on" checked> <span class="badge badge-info">����</span></label>
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortShare"  value="off"> <span class="badge badge-danger">�ر�</span></label>	
								</div>
							<% elseif rs("sortShare") = "off" then %>
								<div class="radio">
									<label><input type="radio" name="sortShare" value="on" > <span class="badge badge-info">����</span></label>
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortShare"  value="off" checked> <span class="badge badge-danger">�ر�</span></label>	
								</div>
							<% elseif rs("sortShare") = "ban" then %>
								<div class="radio">
									<label><input type="radio" name="sortShare" value="ban" checked><span class="badge badge-dark">�ѽ�ֹ������ϵ����Ա��</span></label>
								</div>
							<%end if %>						
						</div>
					</div>
					
					<%if rs("sortState") = "ban" then %>
						<div class="form-group">
							<label for="inputAddress">��ֹ����</label>
							<textarea name="sortAdminReason" cols="5" rows=5"" class="form-control" value="" disabled="disabled"><%=rs("sortAdminReason")%></textarea>

						</div>					
					<%end if %>
					
					
					<br>
					<div align="center">
					<button type="submit" class="btn btn-primary" >����</button></div>
					<input type="hidden" name="sub" value="sub">
					<input name="sortId" type="hidden" value="<%=rs("sortId")%>" />	
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
						if rs.eof then
							response.write "��"
						else
							do while not rs.eof%>
							<tr>

									<%
							if rs("sortState") = "off" then
								if rs("sortShare") = "off" then%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-danger">�ر�</span></td><td><span class="badge badge-danger">�ر�</span></td>
								<%else%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-danger">�ر�</span></td><td><span class="badge badge-info">����</span></td>
								<%end if
							else 
								if rs("sortShare") = "off" then%>
									<td><a href="bSortEdit-<%=rs("sortId")%>.html"><%=rs("sortName")%></a></td><td><span class="badge badge-info">����</span></td><td><span class="badge badge-danger">�ر�</span>	</td>																	
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

<%
rs.close
set rs = nothing
%>

</div>
</body>
</html>



