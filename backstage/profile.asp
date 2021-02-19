<!-- #include file="bFrame.asp"-->
<!-- #include file="upload_5xsoft.inc" -->
<script type="text/javascript" src="js/md5.js"></script>
<%=bMain%>
<title>个人信息 | <%=cstProject%>后台 </title>        



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

'验证原始密码
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


// 昵称
var arr = addForm.arrNickName.value
arr = arr.split(",") 
for(var i=0;i<arr.length;i++){
	if (addForm.userNickName.value == arr[i] || addForm.userNickName.value == ""){
		alert("温馨提示：\n      昵称不能为空或已存在！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userNickName.focus();
		return false;}}
		

if ( addForm.userPass.value != "" && userPass != dbUserPass){
	alert("温馨提示：\n      原密码错误！", function () {}, {type: 'warning', confirmButtonText: '确定'});
	addForm.userPass.focus();
	return false;}
	

if (addForm.userPass.value.length > 0 && addForm.userPass.value.length < 6){
	alert("温馨提示：\n      原密码长度范围 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
	addForm.userPass.focus();
	return false;}
	
//	原始密码
if (addForm.userPass.value.length > 0 && addForm.userPass.value.length < 6){
	alert("温馨提示：\n      原密码长度范围 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
	addForm.userPass.focus();
	return false;}
	
//	新的密码
if (addForm.userPass.value.length >= 6 && addForm.userNewPass.value.length < 6){
	alert("温馨提示：\n      新密码错误，长度范围 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
	addForm.userPass.focus();
	return false;}

//	确认密码, 新的密码与确认密码比较
if (addForm.userNewPass.value != addForm.userConfirmPass.value){
	alert("温馨提示：\n      新密码与新密码确认不一致！", function () {}, {type: 'warning', confirmButtonText: '确定'});
	addForm.userConfirmPass.focus();
	return false;}
		
			//邮箱
var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //正则表达式
var obj = document.getElementById("userEmail"); //要验证的对象
if(!reg.test(obj.value))
{ //正则验证不通过，格式不对
	alert("温馨提示：\n      邮箱验证失败", function () {}, {type: 'warning', confirmButtonText: '确定'});
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

<% if request.querystring("action")="reset" then  
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


<!--  个人设置（上传头像）-->

<% if request.querystring("action")="save" then 

'上传头像功能
dim upload,file,formName,iCount,FolderNameNew
dim GuFolderPath,fso,GuFolder0,GuFileSize0,GuFileExt0,GuAutoName
set upload=new upload_5xsoft  '建立上传对象
GuFolder0=""  '设定默认上传的目录，必须以“/”结束，可以为空
GuFileSize0=2048  '设定默认允许上传的最大文件，单位:K，1024K=1M
GuFileExt0="bmp|gif|jpg|jpeg|png|swf|rar|zip|txt"  '设定默认允许上传的文件类型
GuAutoName="1"  '设定上传成功后的文件名是否自动重新命名或是使用原来的名称，1为是，0为否
'Response.write upload.Version&"<br><br>"  '显示上传类的版本
if upload.form("GuFolderPath")<>"" then
	GuFolderPath=upload.form("GuFolderPath")
	call FolderNameCheck(GuFolderPath)
	GuFolderPath=upload.form("GuFolderPath")
	if right(GuFolderPath,1)<>"/" then GuFolderPath=GuFolderPath&"/"
elseif upload.form("GuFolderPath")="" and GuFolder0<>"" then
	GuFolderPath=GuFolder0
	call FolderNameCheck(GuFolderPath)
	GuFolderPath=GuFolder0
	if right(GuFolderPath,1)<>"/" then GuFolderPath=GuFolderPath&"/"
else
	GuFolderPath=""
end if
	iCount=0
for each formName in upload.objFile  '列出所有上传了的文件
	set file=upload.file(formName)
	if file.FileSize>0 then
		dim FileExtF,FileExtY,FileExtOK,ii,jj
		FileExtF=split(File.FileName,".")
		for jj=0 to ubound(FileExtF)
		next
		FileExtY=0
		FileExtOK=split(GuFileExt0,"|")		
		for ii=0 to ubound(FileExtOK)
		if FileExtOK(ii)=FileExtF(jj-1) then
			FileExtY=1
		exit for
		end if
		next
		if FileExtY=0 then
			Htmend "上传失败，不允许上传的文件类型"
		elseif file.FileSize>GuFileSize0*1024 then
			Htmend "上传失败，单个文件大小超过限制，最大"&GuFileSize0&"*1024 字节，1K=1024字节"
		else
			dim FileNameOK
			if GuAutoName="1" then
				FileNameOK=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&iCount&"."&FileExtF(jj-1)
			else
				FileNameOK=file.FileName
			end if

			file.SaveAs Server.mappath(GuFolderPath&"img/"&FileNameOK)  '保存文件
			'Response.write file.FilePath&file.FileName&"(大小:"&file.FileSize&" 字节) => "&GuFolderPath&FileNameOK&" 成功! <br>"
			iCount=iCount+1
		end if
	else
		FileNameOK = "default.jpg"     '默认文件名
	end if
	set file=nothing
next

Sub FolderNameCheck(FolderNameNew)
	dim Letters,i,c
	Letters="+=:;,[]<>\|*?"
	for i=1 to len(FolderNameNew)
		c=mid(FolderNameNew,i,1)
		if inStr(Letters,c)<>0 then
		Htmend "上传失败，文件夹名称含有特殊字符"
	end if
	next

	GuFolderPath=server.MapPath(GuFolderPath)
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	if fso.FolderExists(GuFolderPath)=false then
		fso.CreateFolder(GuFolderPath)
	end if
	Set fso=nothing
End sub

Sub HtmEnd(Msg)
 set upload=nothing
response.write "<script language='javascript'>"
response.write "alert('"&MSG&"');"
response.write "</script>"
response.Redirect("profile.html")	
End sub



' 提交	
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblUser where userId="&upload.form("userId")&"",conn,3,3	
	rs("userHead") = "/backstage/img/"&FileNameOK 
	rs("userEmail") = upload.form("userEmail") 
	rs("userNickname") = upload.form("userNickname") 
	rs("userPhone") = upload.form("userPhone") 
	rs("userInfo") = upload.form("userInfo") 
	if rs("userPass") = LCase(md5(upload.form("userPass"))) then
		rs("userPass") = LCase(md5(upload.form("userNewPass")))
		response.Write("<script>;alert('密码更新成功');window.location.href='profile.html';</script>")	
	end if 
	rs.update
	rs.close
	set rs = nothing 	
	response.Redirect("profile.html")	
	set upload=nothing
end if 
%>




<div class="content-wrapper">  <!-- div1 -->
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title">个人信息</h1>
			<p class="text-muted m-0 desc">Information</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end">	</div>
		</div>
	</div> 

		  
<div class="content"> <!-- div2 -->
	<div class="row"> <!-- div3 -->
		<div class="col-lg-4 mb-4"> <!-- div4 -->
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
					<h4 class="weight-400"><%=rs("userNickName")%></h4>
					<%=rs("userTitle")%>
					</div>
				
					<hr class="my-4 dashed">
				
					<p><span class="weight-400">个人简介：</span></p>
					<p><%=replace(rs("userInfo"),chr(13),"<BR>")%></p>
				</div>
			</div>
		</div>
		<div class="col-lg-8">
				  
	
<form method="post"  name="addForm"  onSubmit="return CheckPost()" enctype="multipart/form-data" action="profileSave.html">
			

<div class="content">
	<div class="row">
		<div class="col-lg-12 ">
			<div class="alert alert-primary" role="alert">个人设置</div>
			<div class="card mb-4">
				<div class="card-body">			
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="exampleFormControlInput1">头像</label><br>
							<input name="FileName" type="FILE" class="tx1" size="23">
						</div>
						<div class="form-group col-md-6" align="right">
							<input type="submit" value="提交" class="btn btn-primary" />
						</div>
						
							
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-6">
						<label for="exampleFormControlInput1">用户名</label>
						<input type="text" name="userName"   maxlength="15" class="form-control" value="<%=rs("userName")%>" disabled="disabled">
						</div>
						
						<div class="form-group col-md-6">
							<label for="inputPassword4">职称 </label>
							<input type="text" name="userTitle" id="userTitle" maxlength="10" class="form-control" value="<%=rs("userTitle")%>" disabled="disabled">													
						</div>
						
						<div class="form-group col-md-4">
							<label for="inputPassword4">昵称 *（0-10）</label>
							<input type="text" name="userNickName"  maxlength="10" class="form-control" value="<%=rs("userNickName")%>" >
						</div>
					
						<div class="form-group col-md-4">
							<label for="inputPassword4">手机号（11）</label>
							<input type="text" name="userPhone" id="userPhone" maxlength="11" class="form-control" value="<%=rs("userPhone")%>">													
						</div>							
			
						<div class="form-group col-md-4">
							<label >邮箱 * （<32）</label>
							<input type="text" name="userEmail" id="userEmail" maxlength="32" class="form-control" value="<%=rs("userEmail")%>" >
						</div>		
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-4">
							<label>原密码（6-15）</label>
							<input type="password" name="userPass"  maxlength="15" class="form-control" >
						</div>
						<div class="form-group col-md-4">
							<label>新密码（6-15）</label>
							<input type="password" name="userNewPass" id="userNewPass" maxlength="15" class="form-control" >													
						</div>
						<div class="form-group col-md-4">
							<label>新密码确认（6-15）</label>
							<input type="password" name="userConfirmPass" id="userConfirmPass" maxlength="15" class="form-control" >													
						</div>																					
					</div>	
					
					<div class="form-row">
						<div class="form-group col-md-12">
				
						<label for="exampleFormControlTextarea1">个人简介 *</label>
						<textarea class="form-control" name="userInfo" rows="15" required><%=rs("userInfo")%></textarea>
						</div>
					</div>																  			
			
					<div class="form-row">
						<div class="form-group col-md-12" align="center">
						<input type="hidden" name="userId"  value="<%=session("userId")%>" />	
						<input type="hidden" name="arrNickName" value="<%=ArrNickName%>">
						<input type="hidden" name="dbUserPass" value="<%=dbUserPass%>">
						<input type="submit" value="提交" class="btn btn-primary" />
						</div>
					</div> 	
									
				</div>		
			</div>
		</div>
	</div>				
 </div> 
</form>


</div><!-- div4 -->
</div><!-- div3 -->
</div><!-- div3 -->
</div><!-- div1 -->

</body>
</html>