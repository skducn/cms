<!--#include file="bFrame.asp"-->
<%=bMain%>

<title>������Ա | <%=cstProject%>��̨</title>

<!--  ��ȡ������Ա���ǳƣ�ȥ�ر��� -->

<%
dim ArrNickName,rs8
ArrNickName = ""
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblUser",conn,3,3
Do While Not rs8.Eof
If ArrNickName = "" Then
ArrNickName = rs8("userNickName")
Else
ArrNickName = ArrNickName&","&rs8("userNickName")
End If
rs8.Movenext
loop
rs8.close
set rs8 = nothing 
%>

<script language="javascript">
function CheckPost()
{
    // ��Ա���� - ������Ա
	// �˺�
	if (addForm.userName.value == "" || addForm.userName.value.length < 6){
		alert("��ܰ��ʾ���˺ų��ȷ�Χ 6 - 15���ַ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userName.focus();
		return false;}	
	// ����
	if (addForm.userPass.value == "" || addForm.userPass.value.length < 6){
		alert("��ܰ��ʾ�����볤�ȷ�Χ�� 6 - 15���ַ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userPass.focus();
		return false;}
	// �ǳ�(ȥ��)
	var arr = addForm.arrNickName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userNickName.value == arr[i]){
			alert("��ܰ��ʾ���ǳ��Ѵ��ڣ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.userNickName.focus();
			return false;}}
	// ������֤
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //������ʽ
����var obj = document.getElementById("userEmail"); //Ҫ��֤�Ķ���
��  if(!reg.test(obj.value)){
		alert("��ܰ��ʾ��������֤ʧ�ܣ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
��������return false;}
	
	var gnl=confirm("ȷ��Ҫ�ύ?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
 
</script>



<!--  ɾ��User	-->	

<% if request("action")="del" then  
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&request("userId")&"",conn,3,3
	if not rs.eof then
	'rs.delete
	'rs.update
	end if 
end if %>


<!--  ������Ա	-->

<% 
if request.form("sub")="sub" then
	groupId = request.form("groupId")
	userName = request.form("userName")
	userPass = request.form("userPass")
	userNickName = request.form("userNickName")
	userTitle = request.form("userTitle")
	userEmail = request.form("userEmail")
	userPower = request.form("userPower")	
	userPhone = request.form("userPhone")	
	userInfo = request.form("userInfo")	
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser",conn,3,3	
	rs.addnew
	rs("groupId") = groupId
	rs("userName") = userName
	rs("userPass") = LCase(md5(userPass))
	rs("userPower") = userPower
	if request("userNickName") = "" then
		rs("userNickName") = userName
	else
		rs("userNickName") = userNickName
	end if 
	rs("userTitle") = userTitle
	rs("userEmail") = userEmail
	rs("userPhone") = userPhone
	rs("userHead") = "/backstage/img/default.jpg"
	rs("userState") = "on"
	rs("userInfo") = userInfo
	rs("userCrtDate") = now
	rs.update
	'response.Write("<script>;alert('�����ɹ�');window.location.href='bUserAdd.asp';</script >")
	response.Write("<script>;window.location.href='bUserAdd.html';</script>")	
	rs.close
	set rs = nothing 
end if 
%>



<div class="content-wrapper">

<div class="row page-tilte align-items-center">
	<div class="col-md-auto">
		<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
		<h1 class="weight-300 h3 title">��Ա����</h1>
		<p class="text-muted m-0 desc">User management</p>
	</div> 
	<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
		<div class="controls d-flex justify-content-center justify-content-md-end"></div>
	</div>
</div> 

<div class="content">
	<div class="row">
		<div class="col-lg-6 ">
			<div class="card mb-4">
				<div class="card-header">������Ա</div>
				<div class="card-body">
					
					<div class="form-group col-md-12" align="center">
						
				     <img src="img/default.jpg" width="100" height="100">
						<br><br>
					</div>
			
					<form method="post" name="addForm" onSubmit="return CheckPost()">   

					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="exampleFormControlInput1">�˺� *��6-15��</label>
							<input type="text" name="userName"   maxlength="15" class="form-control"  placeholder="username" onKeyUp="value=value.replace(/[^0-9a-zA-Z]/g,'')"/>
						</div>
					
						<div class="form-group col-md-6">
							<label for="inputPassword4">���� *��6-15��</label>
							<input type="password" name="userPass" maxlength="15" class="form-control"  placeholder="password">
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="inputAddress">�ǳƣ�0-10��</label>
							<input type="text" name="userNickName"   maxlength="10" class="form-control"  placeholder="nickname">
						</div>
						
						<div class="form-group col-md-6">
							<label for="inputAddress">ְ�ƣ�0-10��</label>
							<input type="text" name="userTitle"   maxlength="10" class="form-control" value="" placeholder="jobtitle">
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="inputAddress">���� * ��<32��</label>
							<!-- <input type="text" name="userEmail" id="userEmail"  maxlength="32" class="form-control"  placeholder="name@yz-healthtech.com" onKeyUp="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'')"> -->
							<input type="text" name="userEmail" id="userEmail"  maxlength="32" class="form-control"  placeholder="name@zy-healthtech.com"> 
						</div>
						<div class="form-group col-md-6">
							<label for="inputAddress">�ֻ��ţ�11��</label>
							<input type="text" name="userPhone" id="userPhone"  maxlength="11" class="form-control" placeholder="cellphone">
						</div>
					</div>
					
					<%if session("userPower") = "1" then %>
						<div class="form-row">
							<div class="form-group col-md-6">
							<label>Ⱥ��</label>
								<select class="form-control" name="groupId" >
								<%
								set rs = server.CreateObject("ADODB.RecordSet")
								rs.Open "select * from tblGroup where groupState='on'",conn,3,3
								do while not rs.eof%>
								<option value=<%=rs("groupId")%>><%=rs("groupName")%></option>
								<%rs.movenext
								loop
								rs.close
								set rs = nothing%>
								</select>						
							</div>
							<div class="form-group col-md-6">
								<label>Ȩ��</label>
								<select class="form-control" name="userPower" >
								<option value="3">����Ա</option>
								</select>	
							</div>	
						</div>				
					<%else%>
						<label>Ȩ��</label>
						<select class="form-control" name="userPower" >						
						<option value="5">��ͨ��Ա</option>
						</select>						
						<input name="groupId" type="hidden" value="<%=session("groupId")%>" />
					<%end if %>
					<br>
					
					<div class="form-row">
						<div class="form-group col-md-12">
							<label for="exampleFormControlInput1">������Ϣ</label>
							<textarea class="form-control" name="userInfo" rows="15" placeholder="���˼��"></textarea>						
						</div>
					
						
					</div>
					
					<br>
					<div align="center">
					<button type="submit" class="btn btn-primary" href="#">�ύ</button>
					</div>
					<input type="hidden" name="sub" value="sub">
					<input type="hidden" name="arrNickName" value="<%=ArrNickName%>">

					</form>

					</div>
				</div>
			</div>
														
			<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-header">		
					
						<div class="alert alert-primary" role="alert">����Ա�б�</div>
						<div class="card-body">	
							<table class="table table-striped m-0">
							<thead>
							<tr>
							<% set rs = server.CreateObject("ADODB.RecordSet")	
							if session("userPower") = "1" then  %>
								<th>��Ա��</th>
								<th>�ǳ�</th>
								<th>Ⱥ��</th>
								<th>״̬</th>
								</tr>
								</thead><tbody>
								<%							
								
								rs.Open "select * from tblUser where userPower='3' order by userPower,userId desc",conn,3,3
								if not rs.eof then
									do while not rs.eof 							
										set rs1 = server.CreateObject("ADODB.RecordSet")
										rs1.Open "select * from tblGroup where groupId="&rs("groupId")&" order by groupId",conn,3,3
										%>
										<tr>
										<td><a href="bUserEdit-<%=rs("userId")%>.html"><%=rs("userName")%></a></td>
										<td><%=rs("userNickName")%></td>
										<td><%=rs1("groupName")%></td>
										<%if rs("userState") = "on" then%>
											<td><span class="badge badge-info">����</span></td>
										<%else%>
											<td><span class="badge badge-danger">�ر�</span></td>
										<%end if %>					
										</tr>
										<%
										rs1.close
										set rs1 = nothing 
									rs.movenext
									loop
								end if %>																			
								</tbody>
								</table>
							<%else%>
								<th>��Ա��</th>
								<th>�ǳ�</th>
								<th>�ֻ���</th>
								<th>״̬</th>
								</tr>
								</thead><tbody>
								<%															
								rs.Open "select * from tblUser where userPower='5' and groupId="&session("groupId")&" order by userPower,userId asc",conn,3,3
								if not rs.eof then
									do while not rs.eof %>
										<tr>
										<td><a href="bUserEdit-<%=rs("userId")%>.html"><%=rs("userName")%></a></td>
										<td><%=rs("userNickName")%></td>
										<td><%=rs("userPhone")%></td>
										<%if rs("userState") = "on" then%>
											<td><span class="badge badge-info">����</span></td>
										<%else%>
											<td><span class="badge badge-danger">�ر�</span></td>
										<%end if %>																				
										</tr>
									<%
									rs.movenext
									loop
								end if %>																			
								</tbody>
								</table>							
							<%end if
							rs.close
							set rs = nothing %>
						</div>	
						</div>		
				</div><!-- "card mb-4" --> 	
			</div><!-- col-lg-6 --> 	
			
			
	</div>
</div>

</div>
</body>
</html>


