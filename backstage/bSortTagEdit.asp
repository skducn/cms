<!--#include file="bFrame.asp"-->

<%=bMain%>

<title><%=cstCompany%> | �����û����</title>

<!--  ��ȡ�û��������ȥ�ر��� -->

<%
dim jsSortName
jsSortName = ""
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblSort where sortId<>"&request("sortId")&" and userName='"&request("userName")&"'",conn,3,3
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
		if (addForm.sortName.value == arr[i] || addForm.sortName.value == ""){
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

<!--  ��ȫ����	-->	

<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tblSort where sortId="&request("sortId")&" and userName='"&request("userName")&"'",conn,3,3
if rs.recordcount = 0 then
	rs.close
	set rs = nothing 
	response.Write("<script>;alert('�Ƿ�����');window.location.href='bMain.html';</script>")
end if 
rs.close
%>


<!--  �༭���ͱ�ǩ	-->

<% 
if request.form("sub")="sub" then
	sortId = request.form("sortId")
	sortName = request.form("sortName")
	sortState = request.form("sortState")
	sortAdminReason = request.form("sortAdminReason")
	' �༭���
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblSort where sortId="&sortId&"",conn,3,3
	rs("sortName") = sortName
	rs("sortState") = sortState
	rs("sortAdminReason") = sortAdminReason
	rs("sortLatestDate") = now
	rs.update
	rs.close
	set rs = nothing

	'�༭��ǩ
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblTag where sortId="&sortId&" order by tagName,tagId asc",conn,3,3
	i = 0
	do while not rs.eof 
		rs("tagState") = request.form("tagState"&i)
		rs("tagAdminReason") = request.form("tagAdminReason"&i)
		i = i + 1		
		rs.update	
	rs.movenext
	loop

	response.Write("<script>window.location.href='bSortTagEdit-"&sortId&"-"&request("userName")&".html';</script>")
end if 
%>




<%
sortId = request("sortId")  
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tblSort where sortId="&sortId&"",conn,3,3
set rs2 = server.CreateObject("ADODB.RecordSet")
rs2.Open "select * from tblTag where sortId="&sortId&" order by tagName,tagId asc",conn,3,3
%>


<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title">���&��ǩ����</h1>
			<p class="text-muted m-0 desc">Sort&Tag management</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<form method="post" name="addForm" onSubmit="return CheckPost()">   

	<div class="content">
		<div class="row">
			<div class="col-lg-6 ">
				<div class="card mb-4">
				<% 
				set rs3 = server.CreateObject("ADODB.RecordSet")
				rs3.Open "select * from tblUser where userName='"&rs("userName")&"'",conn,3,3
				userNickName = rs3("userNickName")
				%>
					<div class="card-header text-primary"><%=rs3("userNickName")%>�����</div>
					<%rs3.close
					set rs3 = nothing %>
					<div class="card-body">
				
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
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortState"  value="ban"> <span class="badge badge-dark">��ֹ</span></label>	
										</div>
									<% elseif rs("sortState") = "off" then %>
										<div class="radio">
											<label><input type="radio" name="sortState" value="on" > <span class="badge badge-info">����</span></label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortState"  value="off" checked> <span class="badge badge-danger">�ر�</span></label>	
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortState"  value="ban"> <span class="badge badge-dark">��ֹ</span></label>	
										</div>
									<% elseif rs("sortState") = "ban" then %>
										<div class="radio">
											<label><input type="radio" name="sortState" value="on" > <span class="badge badge-info">����</span></label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortState"  value="off"> <span class="badge badge-danger">�ر�</span></label>	
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sortState" value="ban" checked> <span class="badge badge-dark">��ֹ</span></label>
										</div>
									<%end if %>
							</div>								
						</div>
												

							<label>����ֹԭ�� </label>
							<textarea  name="sortAdminReason" cols="5" rows="3" class="form-control" value=""><%=rs("sortAdminReason")%></textarea> 
																							
																
						
						<br><br>
						<div align="center">
						<button type="submit" class="btn btn-primary" href="#">�ύ</button></div>
						<input type="hidden" name="sub" value="sub">
						<input name="sortId" type="hidden" value="<%=rs("sortId")%>" />						
						<input name="x" type="hidden" value="<%=x%>" />	
						<input name="userName" type="hidden" value="<%=request("userName")%>" />	
						<input type="hidden" name="jsSortName" value="<%=jsSortName%>">

	
						</div>
					</div>
				</div>
				
				
					<div class="col-lg-6">
					<div class="card mb-4">
						<div class="card-header">
						       <div class="alert alert-primary" role="alert">"<%=userNickName%> - <%=rs("sortName")%>"�µı�ǩ�б�</div>
							<div class="card-body">
						
							<% 
						x = 0
						do while not rs2.eof%>			
						
						
							<div class="form-row">
								<div class="form-group col-md-6">
									  <span class="badge-pill badge-primary"><%=x+1%></span>
									  <label>&nbsp;��ǩ���� </label>
									<input type="text" name="tagName<%=x%>" maxlength="8" class="form-control" value="<%=rs2("tagName")%>" disabled="disabled">
								</div>
							
								<div class="form-group col-md-6">
								<label>��ǩ״̬ </label>
									<% if rs2("tagState") = "on" then %>
										<div class="radio">
											<label><input type="radio" name="tagState<%=x%>" value="on" checked> <span class="badge badge-info">����</span></label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagState<%=x%>" value="off"> <span class="badge badge-danger">�ر�</span></label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagState<%=x%>" value="ban"> <span class="badge badge-dark">��ֹ</span></label>	
										</div>
									<% elseif rs2("tagState") = "off" then %>
										<div class="radio">
											<label><input type="radio" name="tagState<%=x%>" value="on" > <span class="badge badge-info">����</span></label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagState<%=x%>" value="off" checked> <span class="badge badge-danger">�ر�</span></label>											
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagState<%=x%>"  value="ban"> <span class="badge badge-dark">��ֹ</span></label>	
										</div>
									<% elseif rs2("tagState") = "ban" then %>
										<div class="radio">
											<label><input type="radio" name="tagState<%=x%>" value="on" > <span class="badge badge-info">����</span></label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagState<%=x%>" value="off"> <span class="badge badge-danger">�ر�</span></label>											
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagState<%=x%>"  value="ban" checked> <span class="badge badge-dark">��ֹ</span></label>	
										</div>
									<%end if %>														
								</div>				
							</div>	
							
								<i class="fa fa-edit text-aqua"></i>&nbsp;<label>��ǩ��ֹ���� </label>
								<textarea name="tagAdminReason<%=x%>" cols="5" rows="3" class="form-control" value=""><%=rs2("tagAdminReason")%></textarea>
								
							<div class="card-header"></div>
							<br>
						<%
						x = x + 1
						rs2.movenext
						loop%>
						
							</div> <!-- card-body --> 					
					</div><!-- "card mb-4" --> 	
				</div><!-- col-lg-6 --> 	
															
		
		</div><!-- row --> 
	</div><!-- content --> 
</form>

</div>

<%
rs.close
set rs = nothing
%>
</body>
</html>





