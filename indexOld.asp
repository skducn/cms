<!--#include file="conn.asp"-->

<!--#include file="md5.asp"-->




<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76" href="assets/img/CN.png">
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>登录 | <%=cstCompany%></title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
<link rel="stylesheet" type="text/css" href="js/main.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

	<script src="./backstage/uphead2/jquery.min.js"></script>
	
	<link href="./backstage/uphead2/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="./backstage/uphead2/cropper/cropper.min.css" rel="stylesheet">
	<link href="./backstage/uphead2/sitelogo/sitelogo.css" rel="stylesheet">
	
	<script src="./backstage/uphead2/cropper/cropper.min.js"></script>
	<script src="./backstage/uphead2/sitelogo/sitelogo.js"></script>
	<script src="./backstage/uphead2/bootstrap/js/bootstrap.min.js"></script>
	

</head>
<script src="js/exit/jquery-2.1.4.min.js"></script>
<script src="js/menu/bootstrap.min.js"></script>
<script src="js/menu/pace.min.js"></script>
<script src="js/menu/main.js"></script>
<script src="js/shortcutKey/bootstrap-notify.min.js"></script>
<script src="js/exit/sweetalert.min.js"></script>
<script language="javascript">  
function CheckPost()
{	  
     if (addForm.userName.value == "" || addForm.userPass.value == "") 
	 {
		$.notify({
			title: "&nbsp;&nbsp;",
			message: "用户名或密码不能为空！",
			icon: 'fa fa-info-circle' 
		},{
			type: "danger"
		});
	  addForm.userName.focus();
	  return false;
  }
}
</script>

<!-- 登录 -->
<% 
if request("action")="login" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblUser where userName='"&request("userName")&"' and userPass='"&LCase(md5(request("userPass"))) &"' and userState='on' ",conn,3,3
	if not rs.eof then
		rs("latestLoginIp") = getClientIp() 	
		rs("latestDate") = now()	
		rs.update
		session("userId") = rs("userId")    
		session("userName") = rs("userName")    
		session("userNickName") = rs("userNickName")
		session("groupId") = rs("groupId")	
		session("userPower") = rs("userPower")
		'(1超级管理员，3管理员，5个人用户)
		if rs("userPower") = "1" then 							
			response.redirect "/backstage/bMain.html"      		    			
		else
			response.redirect "dashboard.html"     			
		end if	
	else
		response.redirect "index.html"  
	end if     
	rs.close
	set rs = nothing
end if
%>

<!-- 清除登录IP -->	
<%if request("action") = "clear" then
	Set rs = Server.CreateObject("Adodb.Recordset")						
	rs.Open "select * from tblUser where userName='"&request("userName")&"'",conn,3,3
	if not rs.eof then	   
		rs("latestLoginIp") = ""
		rs.update
	end if    
	rs.close
	set rs = nothing
	Session.Abandon()
	response.Redirect("index.html")
end if%>



<!-- ******************************************************************************************************************************************************************** -->	
<body>	 	

			 
<section class="material-half-bg"><div class="cover"></div></section>		
<section class="login-content">
		
	<div class="login-box">
		<!-- 用户登录 -->	
		<form action="indexLogin.html" method="post" name="addForm"  class="login-form" onSubmit="return CheckPost()" >
		<h2 class="login-head"><i class="fa fa-book"></i> 知识库</h2>		
			<div class="form-group">
				<h4>用户名</h4>
				<input class="form-control" type="text" name="userName"  placeholder="USERNAME" autofocus>
			</div>
			<div class="form-group">
				<h4>密码</h4>
				<input class="form-control" type="password" name="userPass" placeholder="PASSWORD">
			</div>
			<div class="form-group">
				<div class="utility">
					<div class="animated-checkbox"></div>
					<p class="semibold-text mb-0"><a data-toggle="flip">忘记密码？</a></p>
				</div>
			</div>
	
		
		</form>
		
		<!-- 忘记密码了吗？ -->	
		<form class="forget-form" action="index.html">
			<h3 class="login-head"><i class="fa fa-lg fa-fw fa-lock"></i>忘记密码了吗？</h3>
			<div class="form-group">
				<h4>邮箱认证</h4>
				<input class="form-control" type="text" placeholder="Email">
			</div>
			<div class="form-group btn-container">
				<button class="btn btn-primary btn-block" id="button2"><h4><i class="fa fa-unlock fa-lg fa-fw"></i> 重置</h4></button>
			</div>
			<div class="form-group mt-20">
				<p class="semibold-text mb-0"><a data-toggle="flip"><i class="fa fa-angle-left fa-fw"></i>返回登录</a></p>
			</div>
		</form>		
	</div>
	


<body style="overflow:hidden;">

<div class="ibox-content">
	<div class="row">
		<div id="crop-avatar" class="col-md-6">
			<div class="avatar-view" title="Change Logo Picture">
				<img src="logo.jpg" alt="Logo">
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<form class="avatar-form" action="{{url('admin/upload-logo')}}" enctype="multipart/form-data" method="post">
				<div class="modal-header">
					<button class="close" data-dismiss="modal" type="button">&times;</button>
					<h4 class="modal-title" id="avatar-modal-label">Change Logo Picture</h4>
				</div>
				<div class="modal-body">
					<div class="avatar-body">
						<div class="avatar-upload">
							<input class="avatar-src" name="avatar_src" type="hidden">
							<input class="avatar-data" name="avatar_data" type="hidden">
							<label for="avatarInput">图片上传</label>
							<input class="avatar-input" id="avatarInput" name="avatar_file" type="file"></div>
						<div class="row">
							<div class="col-md-9">
								<div class="avatar-wrapper"></div>
							</div>
							<div class="col-md-3">
								<div class="avatar-preview preview-lg"></div>
								<div class="avatar-preview preview-md"></div>
								<div class="avatar-preview preview-sm"></div>
							</div>
						</div>
						<div class="row avatar-btns">
							<div class="col-md-9">
								<div class="btn-group">
									<button class="btn" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"><i class="fa fa-undo"></i> 向左旋转</button>
								</div>
								<div class="btn-group">
									<button class="btn" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"><i class="fa fa-repeat"></i> 向右旋转</button>
								</div>
							</div>
							<div class="col-md-3">
								<button class="btn btn-success btn-block avatar-save" type="submit"><i class="fa fa-save"></i> 保存修改</button>
							</div>
						</div>
					</div>
				</div>
  		</form>
  	</div>
  </div>
</div>

<div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
</body>
</html>
