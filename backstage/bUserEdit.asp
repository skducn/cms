<!--#include file="bFrame.asp"-->
<%=bMain%>

<title>�༭��Ա | <%=cstProject%>��̨</title>


<% userId = request("userId")%>



<script language="javascript">

function resetPass(userId,userName)
{	
	confirm("�Ƿ���������Ϊ 123456", function (isConfirm) {
	if (isConfirm) {
		//after click the confirm
			window.location.href="bUserEdit.asp?action=reset&userId=" + parseInt(userId) + "&userName=" + userName;} 
	else {
		//after click the cancel 
	}}, {confirmButtonText: 'ȷ��', cancelButtonText: 'ȡ��', width: 400});				
}
	
		
function CheckPost()
{		

	// �ǳ�
	var arr = addForm.arrNickName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userNickName.value == arr[i] || addForm.userNickName.value == ""){
			alert("��ܰ��ʾ���ǳƲ���Ϊ�ջ��Ѵ��ڣ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.userNickName.focus();
			return false;}}
			
	//����
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //������ʽ
	var obj = document.getElementById("userEmail"); //Ҫ��֤�Ķ���
	if(!reg.test(obj.value))
	{ //������֤��ͨ������ʽ����
		alert("��ܰ��ʾ��������֤ʧ��", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		return false;��
	}
	
		var gnl=confirm("ȷ��Ҫ����?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
 
</script>




<!--  Ȩ�޹���, ����Աֻ�ܲ������ڳ�Ա	-->	

<%
'�ǳ��ܣ�����Ƿ���userId�򱨴��˳�ϵͳ�����������userId��������Ա��
if session("userPower") = "5" then
	response.Write("<script>;alert('�Ƿ���������ǰ��Աδ��Ȩ��');window.location.href='../index.html';</script>")
else
	if session("userPower") <> "1" and session("userId") <> userId then
		set rs = server.CreateObject("ADODB.RecordSet")
		rs.Open "select * from tblUser where userId="&userId&" and userPower<>'"&session("userPower")&"' and groupId="&session("groupId")&"",conn,3,3
		if rs.eof then
			rs.close
			set rs = nothing 
			response.Redirect("../index.html")
		else
			if rs.recordcount = 0 then
				rs.close
				set rs = nothing 
				response.Write("<script>;alert('�Ƿ�����');window.location.href='../index.html';</script>")
			end if 
		end if 
	else
		' ���ܣ� �������Ƿ���userId�򱨴��˳�ϵͳ��
		set rs = server.CreateObject("ADODB.RecordSet")
		rs.Open "select * from tblUser where userId="&userId&"",conn,3,3
		if rs.eof then
			rs.close
			set rs = nothing 
			response.Redirect("../index.html")
		end if 
	end if 
end if 
%>

<!-- ɾ����Ա -->

<%
if request("action")="del" then					
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblUser where userId="&userId&"",conn,3,3
		set rs1 = server.createobject("adodb.recordset")
		rs1.open "select * from tblKey where userId="&userId&"",conn,3,3
		do while not rs1.eof
		' 1��ɾ����ݼ�	
			rs1.delete
			rs1.update
		rs1.movenext
		loop
		rs1.close
		set rs1 = nothing
	
		set rs2 = server.createobject("adodb.recordset")
		rs2.open "select * from tblContent where userName='"&rs("userName")&"'",conn,3,3
		do while not rs2.eof
			set rs3 = server.createobject("adodb.recordset")
			rs3.open "select * from tblTag where sortId="&rs2("sortId")&"",conn,3,3
			do while not rs3.eof
			' 2��ɾ����ǩ	
				rs3.delete
				rs3.update		
			rs3.movenext
			loop
			rs3.close
			set rs3 = nothing
			set rs4 = server.createobject("adodb.recordset")
			rs4.open "select * from tblSort where sortId="&rs2("sortId")&" or userName='"&rs("userName")&"'",conn,3,3
			do while not rs4.eof
			' 3��ɾ�����			
				rs4.delete
				rs4.update		
			rs4.movenext
			loop	
			rs4.close
			set rs4 = nothing
			' 4��ɾ������
			rs2.delete
			rs2.update	
		rs2.movenext
		loop
		rs2.close
		set rs2 = nothing
	
	' ɾ���û�		
	rs.delete
	rs.update			
	rs.close
	set rs = nothing
	response.Redirect("bUserAdd.html")
	response.end 

end if
%>

<!--  ��������	-->	

<% if request("action")="reset" then  
	userId = request("userId")
	userName = request("userName")
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&cint(userId)&" and userName='"&userName&"'",conn,3,3
	if not rs.eof then
		rs("userPass") = LCase(md5("123456"))
		rs.update
	end if 
	rs.close
	set rs = nothing
	response.Redirect("bUserEdit-"&userId&".html")
end if %>

<!--  �༭��Ա	-->

<% 
if request.form("sub")="sub" then	
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&request.form("userId")&"",conn,3,3
	rs("userName") = request.form("userName")
	rs("userNickName") = request.form("userNickName")
	rs("userTitle") = request.form("userTitle")
	rs("userEmail") = request.form("userEmail")
	rs("userPhone") = request.form("userPhone")
	rs("userState") = request.form("userState")
	rs("userInfo") = request.form("userInfo")
	rs.update
	rs.close
	set rs = nothing 
	response.Redirect("bUserEdit-"&userId&".html")
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


<form method="post" name="addForm" onSubmit="return CheckPost()">   

<div class="content">
	<div class="row">
		<div class="col-lg-12">
			<div class="card mb-4">
				<div class="card-header">�༭��Ա</div>
				<div class="card-body">
					<%
					userId = request("userId")
					set rs = server.CreateObject("ADODB.RecordSet")
					rs.Open "select * from tblUser where userId="&userId&"",conn,3,3
					%>			
										
					<div class="form-group col-md-6" align="center">
						<img src="<%=rs("userHead")%>" class="img-thumbnail img-fluid rounded-circle">								
						<br><br>
					</div>
																				
				
					<div class="form-row">
						<div class="form-group col-md-6">		
						<div align="center">
						<% if rs("userPower") <> "1" and session("userId") <> cint(userId) then %>
							<% if rs("userState") = "on" then %>
								<div class="radio">
									<label><input type="radio" name="userState" value="on" checked> <span class="badge badge-info">����</span></label>
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="userState"  value="off"> <span class="badge badge-danger">�ر�</span></label>	
								</div>																								
							<% elseif rs("userState") = "off" then %>
								<div class="radio">
									<label><input type="radio" name="userState" value="on" > <span class="badge badge-info">����</span></label>
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="userState"  value="off" checked> <span class="badge badge-danger">�ر�</span></label>
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="bUserEditDel-<%=userId%>.html"  onClick="return confirm('�Ƿ�ɾ������Ա��ȷ����')" >  <i class="fa fa-lg fa-trash"></i>&nbsp;ɾ��</a></label>
								</div>
 
	
								
							<%end if %>						
						<%else %>							
							<input name="userState" type="hidden" value="<%=rs("userState")%>" />											
						<%end if %>
						</div>
						</div>
					</div>
					
			
					
					<div class="form-row">
						<div class="form-group col-md-3">
						<label for="exampleFormControlInput1">��Ա����6-15��</label>
						<input type="text" name="userName"   maxlength="15" class="form-control" value="<%=rs("userName")%>">
						</div>		
						
						<div class="form-group col-md-3">
						<% if rs("userPower") <> "1" then %>					
							<label for="inputPassword4">��ʼ������&nbsp;��<a href="javascript:;" onClick="resetPass('<%=userId%>','<%=rs("userName")%>');">��������</a>��</label><br>
							<input name="" type="password"  maxlength="15" class="form-control"  placeholder="******" disabled="disabled">

							
						<%end if %>
						</div>
															
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-3">
						<label for="inputPassword4">�ǳƣ�1-15��*</label>
						<input type="text" name="userNickName"  maxlength="15" class="form-control" value="<%=rs("userNickName")%>" >
						</div>
						
						<div class="form-group col-md-3">
						<label for="exampleFormControlInput1">ְ�ƣ�<15��</label>
						<input type="text" name="userTitle"   maxlength="15" class="form-control" value="<%=rs("userTitle")%>">
						</div>
					</div>
							
					
					<!-- ���򣺹���Աֻ�ܱ༭������ͨ��Ա״̬�����ܱ༭�Լ���״̬ -->
					<div class="form-row">
						<div class="form-group col-md-3">
						<label for="inputPassword4">���� *</label>
						<input type="text" name="userEmail" id="userEmail" maxlength="32" class="form-control" value="<%=rs("userEmail")%>" onKeyUp="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'')">
						</div>
						
						<div class="form-group col-md-3">
						<label for="inputPassword4">�ֻ��ţ�11��</label>
						<input type="text" name="userPhone" id="userPhone" maxlength="11" class="form-control" value="<%=rs("userPhone")%>">
						</div>
					</div>	
					
					<div class="form-row">
						<div class="form-group col-md-6">
						<label for="inputPassword4">������Ϣ</label>
						<textarea class="form-control" name="userInfo" rows="15" placeholder="���˼��"><%=rs("userInfo")%></textarea>	
						</div>

					</div>	
					
					
					<div class="form-row">
						<div class="form-group col-md-6">
		
						<br><div align="center">
						<input type="submit" value="����" class="btn btn-primary" /></div>
 						<input type="hidden" name="sub" value="sub">
						<input name="userId" type="hidden" value="<%=userId%>" />	
						<input type="hidden" name="arrNickName" value="<%=ArrNickName%>">
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
	
	    

	</div>
</div>
</form>

</div>



</body>
</html>



<%
rs.close
set rs = nothing
%>
