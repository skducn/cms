<!--#include file="bFrame.asp"-->
<!--#include file="../md5.asp"-->
<!--#include file="../common/constant.asp"-->

<!--  上传头像	-->	
<script type="text/javascript" src="../upload/js/swfobject.js"></script>
<script type="text/javascript" src="../upload/js/fullAvatarEditor.js"></script>

<%=bMain%>

<title><%=cstCompany%> | 个人账号</title>        


<!--  获取所有用户的昵称，用于新用户中遍历 -->

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

	' 验证原始密码
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&session("userId")&"",conn,3,3
	dbUserPass = rs("userPass")
	rs.close
	
%>

<script language="javascript">
function CheckPost()
{		

	//	原始密码
	var dbUserPass = addForm.dbUserPass.value
	var userPass = addForm.userPass.value
	var userPass = hex_md5(userPass)

	if ( addForm.userPass.value != "" && userPass != dbUserPass){
		alert("温馨提示，原始密码错误！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userPass.focus();
		return false;}
		
		
	if (addForm.userPass.value.length > 0 && addForm.userPass.value.length < 6){
		alert("温馨提示，原始密码长度范围 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userPass.focus();
		return false;}
		
	//	原始密码
	if (addForm.userPass.value.length > 0 && addForm.userPass.value.length < 6){
		alert("温馨提示，原始密码长度范围 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userPass.focus();
		return false;}
		
	//	新的密码
	if (addForm.userPass.value.length >= 6 && addForm.userNewPass.value.length < 6){
		alert("温馨提示，新的密码长度范围 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userPass.focus();
		return false;}
	
	//	确认密码, 新的密码与确认密码比较
	if (addForm.userNewPass.value != addForm.userConfirmPass.value){
		alert("温馨提示，新的密码与确认密码不一致！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userConfirmPass.focus();
		return false;}
		
	// 昵称
	var arr = addForm.arrNickName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userNickName.value == arr[i] || addForm.userNickName.value == ""){
			alert("温馨提示，昵称已存在或为空！", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.userNickName.focus();
			return false;}}
			
	//邮箱
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //正则表达式
	var obj = document.getElementById("userEmail"); //要验证的对象
	if(!reg.test(obj.value))
	{ //正则验证不通过，格式不对
		alert("温馨提示，邮箱验证失败！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		return false;　
	}
	
		var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
 
</script>

<!--  重置密码	-->	

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
	response.Write("<script>;alert('密码已重置');window.location.href='profile.html';</script>")
end if %>

<!--  上传图片及编辑用户	-->
<% if request("action")="save" then 

' 提交	
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&request("userId")&"",conn,3,3	
	rs("userEmail") = request("userEmail")
	rs("userNickname") = request("userNickname")
	rs("userPhone") = request("userPhone")
	 if request("userPass") <> "" then
		rs("userPass") = LCase(md5(request("userNewPass")))
		response.Write("<script>;alert('密码更新成功');window.location.href='profile.html';</script>")	
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
		<h1 class="weight-300 h3 title">个人账号</h1>
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
						  <a class="nav-link px-4 py-3 active rounded-0" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">个人信息</a>
						</li>
						
							<li class="nav-item">
						  <a class="nav-link px-4 py-3  rounded-0" id="setting-tab" data-toggle="tab" href="#setting" role="tab" aria-controls="setting" aria-selected="false">个人设置</a>
						</li>
						
					  </ul>
					</div>
					<div class="card-body">

						<div class="tab-content" id="myTabContent">
						  
						  <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">

							  <h5 class="weight-400">Summary</h5>

							  <p>无</p>

							  <h5 class="weight-400 mt-5">Basic Info</h5>

							  <p>无</p>
						  </div>
						  
						  <div class="tab-pane fade show " id="setting" role="tabpanel" aria-labelledby="setting-tab">


            
			<form  action="profileSave.html" method="post"  name="addForm" onSubmit="return CheckPost()" >	

<div class="content">
	<div class="row">
		<div class="col-lg-12 ">
			<div class="card mb-4">
				<div class="card-body">
				
				
					
					<div class="form-group col-md-12" align="center">
						<!--  上传头像 -->
						<div id="swfContainer" align="center"></div>	
					</div>
					
					
					<div class="form-row">
						<div class="form-group col-md-6">
						<label for="exampleFormControlInput1">账号</label>
						<input type="text" name="userName"   maxlength="15" class="form-control" value="<%=rs("userName")%>" disabled="disabled">
						</div>
					</div>
	
					<div class="form-row">
						<div class="form-group col-md-6">
							<label >邮箱 * （<32）</label>
							<input type="text" name="userEmail" id="userEmail" maxlength="32" class="form-control" value="<%=rs("userEmail")%>" >
						</div>		
						
						<div class="form-group col-md-6">
							<label for="inputPassword4">手机号（11）</label>
							<input type="text" name="userPhone" id="userPhone" maxlength="11" class="form-control" value="<%=rs("userPhone")%>">													
						</div>									
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="inputPassword4">昵称（0-10）</label>
							<input type="text" name="userNickName"  maxlength="10" class="form-control" value="<%=rs("userNickName")%>" >
						</div>
						<div class="form-group col-md-6">
							<label for="inputPassword4">职称 * </label>
							<input type="text" name="userTitle" id="userTitle" maxlength="10" class="form-control" value="<%=rs("userTitle")%>" disabled="disabled">													
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-4">
							<label>原始密码（6-15）</label>
							<input type="password" name="userPass"  maxlength="15" class="form-control" >
						</div>
						<div class="form-group col-md-4">
							<label>新的密码（6-15）</label>
							<input type="password" name="userNewPass" id="userNewPass" maxlength="15" class="form-control" >													
						</div>
						<div class="form-group col-md-4">
							<label>确认密码（6-15）</label>
							<input type="password" name="userConfirmPass" id="userConfirmPass" maxlength="15" class="form-control" >													
						</div>
						
					
					
					
					</div>
					
			
                  	
				  
					</div>	
						
<!--  上传头像 -->
<script type="text/javascript">
	swfobject.addDomLoadEvent(function () {var swf = new fullAvatarEditor("swfContainer", {
	id: 'swf',upload_url: '../upload/Upload.asp?userId=<%=session("userId")%>',src_upload:2}, function (msg) {switch(msg.code){
	//case 1 : alert("页面成功加载了组件！");break;
	//case 2 : alert("已成功加载默认指定的图片到编辑面板。");break;
	case 3 :
	if(msg.type == 0){alert("温馨提示","摄像头已准备就绪且用户已允许使用", function () {}, {type: 'success', confirmButtonText: '确定'});}
	else if(msg.type == 1){alert("温馨提示","摄像头已准备就绪但用户未允许使用!", function () {}, {type: 'warning', confirmButtonText: '确定'});}
	else{alert("温馨提示","摄像头被占用!", function () {}, {type: 'warning', confirmButtonText: '确定'});}
	break;
	case 5 : 
	if(msg.type == 0){if(msg.content.sourceUrl){alert("原图已成功保存至服务器，url为：\n" +　msg.content.sourceUrl);
	alert("温馨提示","原图已成功保存至服务器，url为：\n" +　msg.content.sourceUrl, function () {}, {type: 'success', confirmButtonText: '确定'});}
	//alert("头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls);
	}break;}});
	document.getElementById("upload").onclick=function(){swf.call("upload");};});
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5f036dd99455cb8adc9de73e2f052f72' type='text/javascript'%3E%3C/script%3E"));
</script>
		
					
						<div align="center">
							<input type="submit" value="提交" class="btn btn-primary" />
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