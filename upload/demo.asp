<!--#include file="bFrame.asp"-->
<!--#include file="../md5.asp"-->
<!--#include file="../common/constant.asp"-->

<!--  �ϴ�ͷ��	-->	
<script type="text/javascript" src="../upload/js/swfobject.js"></script>
<script type="text/javascript" src="../upload/js/fullAvatarEditor.js"></script>

<%=bMain%>

<title><%=cstCompany%> | �����˺�</title>        


<!--  ��ȡ�����û����ǳƣ��������û��б��� -->

<%
dim ArrNickName,rs8
ArrNickName = ""
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblUser where userId<>"&session("userId")&"",conn,3,3
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

	' ��֤ԭʼ����
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&session("userId")&"",conn,3,3
	dbUserPass = rs("userPass")
	rs.close
	
%>

<script language="javascript">
function CheckPost()
{		

	//	ԭʼ����
	var dbUserPass = addForm.dbUserPass.value
	var userPass = addForm.userPass.value
	var userPass = hex_md5(userPass)

	if ( addForm.userPass.value != "" && userPass != dbUserPass){
		alert("��ܰ��ʾ��ԭʼ�������", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userPass.focus();
		return false;}
		
		
	if (addForm.userPass.value.length > 0 && addForm.userPass.value.length < 6){
		alert("��ܰ��ʾ��ԭʼ���볤�ȷ�Χ 6 - 15���ַ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userPass.focus();
		return false;}
		
	//	ԭʼ����
	if (addForm.userPass.value.length > 0 && addForm.userPass.value.length < 6){
		alert("��ܰ��ʾ��ԭʼ���볤�ȷ�Χ 6 - 15���ַ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userPass.focus();
		return false;}
		
	//	�µ�����
	if (addForm.userPass.value.length >= 6 && addForm.userNewPass.value.length < 6){
		alert("��ܰ��ʾ���µ����볤�ȷ�Χ 6 - 15���ַ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userPass.focus();
		return false;}
	
	//	ȷ������, �µ�������ȷ������Ƚ�
	if (addForm.userNewPass.value != addForm.userConfirmPass.value){
		alert("��ܰ��ʾ���µ�������ȷ�����벻һ�£�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userConfirmPass.focus();
		return false;}
		
	// �ǳ�
	var arr = addForm.arrNickName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userNickName.value == arr[i] || addForm.userNickName.value == ""){
			alert("��ܰ��ʾ���ǳ��Ѵ��ڻ�Ϊ�գ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.userNickName.focus();
			return false;}}
			
	//����
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //������ʽ
	var obj = document.getElementById("userEmail"); //Ҫ��֤�Ķ���
	if(!reg.test(obj.value))
	{ //������֤��ͨ������ʽ����
		alert("��ܰ��ʾ��������֤ʧ�ܣ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		return false;��
	}
	
		var gnl=confirm("ȷ��Ҫ�ύ?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
 
</script>

<!--  ��������	-->	

<% if request("action")="reset" then  
	userId = request("userId")
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&userId&" and "&session("userPower")&"=3",conn,3,3
	if not rs.eof then
		rs("userPass") = LCase(md5("123456"))
		rs.update
	end if 
	rs.close
	set rs = nothing
	response.Write("<script>;alert('����������');window.location.href='profile.html';</script>")
end if %>

<!--  �ϴ�ͼƬ���༭�û�	-->
<% if request("action")="save" then 

' �ύ	
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&request("userId")&"",conn,3,3	
	rs("userEmail") = request("userEmail")
	rs("userNickname") = request("userNickname")
	rs("userPhone") = request("userPhone")
	 if request("userPass") <> "" then
		rs("userPass") = LCase(md5(request("userNewPass")))
		response.Write("<script>;alert('������³ɹ�');window.location.href='profile.html';</script>")	
	end if 
	rs.update
	rs.close
	set rs = nothing 	
	response.Redirect("profile.html")
end if 
%>




<div class="content-wrapper">

	<div class="row page-tilte align-items-center">
	  <div class="col-md-auto">
		<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
		<h1 class="weight-300 h3 title">�����˺�</h1>
		<p class="text-muted m-0 desc">Tell about your self here</p>
	  </div> 
	  <div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
		<div class="controls d-flex justify-content-center justify-content-md-end">
		  
		</div>
	  </div>
	</div> 

		  
	<div class="content">
		  
		  <div class="row">
			  <div class="col-lg-4 mb-4">
				  
				  <div class="card h-100">
					  <div class="card-body">
						  <%
							set rs = server.CreateObject("ADODB.RecordSet")
							rs.Open "select * from tblUser where userId="&session("userId")&"",conn,3,3
						
							%>
						  <div class="mx-5 my-4 px-4" align="center">
							  <img src="<%=rs("userHead")%>" class="img-thumbnail img-fluid rounded-circle">
						  </div>

						  <div class="text-center">
							<h5 class="weight-400"><%=rs("userNickName")%></h5>
						

							<button class="btn btn-info px-4 rounded mx-1"><%=rs("userTitle")%></button>

						  </div>

						  <hr class="my-4 dashed">

						  <p><span class="weight-400">Phone : </span><span class="text-muted"><%=rs("userPhone")%></span></p>
						  <p><span class="weight-400">Email : </span><span class="text-muted"><%=rs("userEmail")%></span></p>
							
					  </div>
				  </div>

			  </div>
			  <div class="col-lg-8">
				  
				  <div class="card mb-4">
					<div class="card-header p-0">
					  <ul class="nav nav-tabs active-thik nav-primary border-0" id="myTab" role="tablist">
						
						<li class="nav-item">
						  <a class="nav-link px-4 py-3 active rounded-0" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">������Ϣ</a>
						</li>
						
							<li class="nav-item">
						  <a class="nav-link px-4 py-3  rounded-0" id="setting-tab" data-toggle="tab" href="#setting" role="tab" aria-controls="setting" aria-selected="false">��������</a>
						</li>
						
					  </ul>
					</div>
					<div class="card-body">

						<div class="tab-content" id="myTabContent">
						  
						  <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">

							  <h5 class="weight-400">Summary</h5>

							  <p>��</p>

							  <h5 class="weight-400 mt-5">Basic Info</h5>

							  <p>��</p>
						  </div>
						  
						  <div class="tab-pane fade show " id="setting" role="tabpanel" aria-labelledby="setting-tab">


            
			<form  action="profileSave.html" method="post"  name="addForm" onSubmit="return CheckPost()" >	

<div class="content">
	<div class="row">
		<div class="col-lg-12 ">
			<div class="card mb-4">
				<div class="card-body">
				
				
					
					<div class="form-group col-md-12" align="center">
						<!--  �ϴ�ͷ�� -->
						<div id="swfContainer" align="center"></div>	
					</div>
					
					
					<div class="form-row">
						<div class="form-group col-md-6">
						<label for="exampleFormControlInput1">�˺�</label>
						<input type="text" name="userName"   maxlength="15" class="form-control" value="<%=rs("userName")%>" disabled="disabled">
						</div>
					</div>
	
					<div class="form-row">
						<div class="form-group col-md-6">
							<label >���� * ��<32��</label>
							<input type="text" name="userEmail" id="userEmail" maxlength="32" class="form-control" value="<%=rs("userEmail")%>" >
						</div>		
						
						<div class="form-group col-md-6">
							<label for="inputPassword4">�ֻ��ţ�11��</label>
							<input type="text" name="userPhone" id="userPhone" maxlength="11" class="form-control" value="<%=rs("userPhone")%>">													
						</div>									
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="inputPassword4">�ǳƣ�0-10��</label>
							<input type="text" name="userNickName"  maxlength="10" class="form-control" value="<%=rs("userNickName")%>" >
						</div>
						<div class="form-group col-md-6">
							<label for="inputPassword4">ְ�� * </label>
							<input type="text" name="userTitle" id="userTitle" maxlength="10" class="form-control" value="<%=rs("userTitle")%>" disabled="disabled">													
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-4">
							<label>ԭʼ���루6-15��</label>
							<input type="password" name="userPass"  maxlength="15" class="form-control" >
						</div>
						<div class="form-group col-md-4">
							<label>�µ����루6-15��</label>
							<input type="password" name="userNewPass" id="userNewPass" maxlength="15" class="form-control" >													
						</div>
						<div class="form-group col-md-4">
							<label>ȷ�����루6-15��</label>
							<input type="password" name="userConfirmPass" id="userConfirmPass" maxlength="15" class="form-control" >													
						</div>
						
					
					
					
					</div>
					
			
                  	
				  
					</div>	
						
<!--  �ϴ�ͷ�� -->
<script type="text/javascript">
	swfobject.addDomLoadEvent(function () {var swf = new fullAvatarEditor("swfContainer", {
	id: 'swf',upload_url: '../upload/Upload.asp?userId=<%=session("userId")%>',src_upload:2}, function (msg) {switch(msg.code){
	//case 1 : alert("ҳ��ɹ������������");break;
	//case 2 : alert("�ѳɹ�����Ĭ��ָ����ͼƬ���༭��塣");break;
	case 3 :
	if(msg.type == 0){alert("��ܰ��ʾ","����ͷ��׼���������û�������ʹ��", function () {}, {type: 'success', confirmButtonText: 'ȷ��'});}
	else if(msg.type == 1){alert("��ܰ��ʾ","����ͷ��׼���������û�δ����ʹ��!", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});}
	else{alert("��ܰ��ʾ","����ͷ��ռ��!", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});}
	break;
	case 5 : 
	if(msg.type == 0){if(msg.content.sourceUrl){alert("ԭͼ�ѳɹ���������������urlΪ��\n" +��msg.content.sourceUrl);
	alert("��ܰ��ʾ","ԭͼ�ѳɹ���������������urlΪ��\n" +��msg.content.sourceUrl, function () {}, {type: 'success', confirmButtonText: 'ȷ��'});}
	//alert("ͷ���ѳɹ���������������urlΪ��\n" + msg.content.avatarUrls);
	}break;}});
	document.getElementById("upload").onclick=function(){swf.call("upload");};});
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5f036dd99455cb8adc9de73e2f052f72' type='text/javascript'%3E%3C/script%3E"));
</script>
		
					
						<div align="center">
							<input type="submit" value="�ύ" class="btn btn-primary" />
						</div>
							<br>
 						<input type="hidden" name="sub" value="sub">
						<input type="hidden" name="userId"  value="<%=session("userId")%>" />	
						<input type="hidden" name="arrNickName" value="<%=ArrNickName%>">
						<input type="hidden" name="dbUserPass" value="<%=dbUserPass%>">


				</div>
			</div>
		</div>
					
	</div>
</div>
</form>


                          </div> 
						  
						</div>
					</div>

			  </div>
		  </div>

		  


	</div>

</div>
</div>
</section>



  </body>
</html>