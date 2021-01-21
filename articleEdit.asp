<!--#include file="menu.asp"-->
<!--#include file="ajaxMain.asp"-->

<title>编辑文章 | <%=cstCompany%></title>


<!-- 权限验证 -->
<%
set rs = server.CreateObject("adodb.recordset")
rs.open "select * from tblContent where cId="&request("cId")&"",conn,3,3 
if rs.eof  then
	response.Redirect("index.html")
end if 
if rs("userName")<> session("userName") then
	response.Redirect("index.html")
end if 

%>

<!-- 删除文章 -->

<%
if request("action")="del" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tblContent where cId="&request("cId")&" and userName='"&session("userName")&"'",conn,3,3
	if rs.eof then
		response.Write("<script>;alert('文章已不存在！');window.location.href='main.html,'_parent'';</script>") 
	else
		rs.delete
		rs.update
	end if 
	rs.close
	set rs = nothing
	Response.Write("<script>window.open('dashboard.html','_parent')</script>")
	response.end 
end if
%>


<!-- 新增快捷键 -->

<%
if request("action")="saveShort" then
	set rs = server.CreateObject("adodb.recordset")
	rs.open "select * from tblKey where userId="&session("userId")&"",conn,3,3
	rs.addnew
	rs("userId") = session("userId")
	rs("keyName") = request("keyName")
	keyLink = request("keyLink")
	if instr(keyLink,"http://")>0 or  instr(keyLink,"https://")>0 then
		rs("keyLink") = keyLink
	else
		rs("keyLink") = "http://" + keyLink 
	end if
	rs("KeySort") = 1
	rs("keyWay") = "编辑文章"
	rs.update 
	rs.close
	set rs = nothing  
	Response.Redirect("articleEdit-"&request("cId")&".html")
end if
%>


<!-- 保存文章 -->

<%
if request("action")="save" then

	set rs = server.CreateObject("adodb.recordset")
	rs.open "select * from tblContent where cId="&request("cId")&"",conn,3,3
	rs("cName") = request("cName")
	rs("cContent") = request("cContent")
	rs("sortId") = request("sortId")
	rs("cLatestDate") = now()
	'如果没有子目录，文章移动到根目录下
	if request("tagId") = "0" or request("tagId") = 0 then
	  rs("tagId") = "0"
	  rs.update 
	elseif instr(request("tagId"),",")>0 then
		'mystr = split(request("tagId"),",") 
		set rs1 = server.CreateObject("adodb.recordset")
		rs1.open "select * from tblTag where tagId="&split(request("tagId"),",") (1) &"",conn,3,3
		rs("tagId") = split(request("tagId"),",") (1) 
		rs.update 
		rs1.close
		set rs1 = nothing 
	else
		'如果子目录已存在，文章移动到存在的目录下
		set rs1 = server.CreateObject("adodb.recordset")
		rs1.open "select * from tblTag where tagId="&request("tagId")&"",conn,3,3
		rs("tagId") = request("tagId")
		rs.update 
		rs1.close
		set rs1 = nothing 
	end if  
	rs.close
	set rs = nothing  
	Response.Redirect("article-"&request("cId")&"-"&request("sortId")&".html")
end if
%>



<div class="content-wrapper">
	<div class="row">
		<div class="col-md-12">
			<div class="card">								
							
			
				<%set rs = server.CreateObject("adodb.recordset")
				rs.open "select * from tblContent where cId="&request("cId")&"",conn,3,3 %>
				
				
				<div class="row">
					<div class="col-md-6">
						<h3 class="card-title">编辑文章</h3>
					</div>
					<div class="col-md-6" align="right">
						<%set rs7 = server.CreateObject("adodb.recordset")
							rs7.open "select * from tblKey where userId="&session("userId")&" and keySort=1 order by keyId",conn,3,3 
							do while not rs7.eof %>
								<a href="<%=rs7("keyLink")%>" class="btn btn-success" data-toggle="tooltip" data-original-title="<%=rs7("keyLink")%>" target="_blank"><i class="fa fa-location-arrow"></i>&nbsp;<%=rs7("keyName")%></a>										
							<%rs7.movenext
							loop
						rs7.close%>										
						
						<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"> </i> 快捷键</button>					
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"><br><br><br><br><br><br><br><br>
							<div class="modal-dialog" role="document">
								<div class="modal-content">	
										
									<form action="articleEditSaveShort.html" method="post" name="addForm1"  class="login-form" onSubmit="return shortcutKeyCheck()" >		
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">×</span>
											</button>
											<h4 class="modal-title" align="left" id="myModalLabel">新增快捷键</h4>
										</div>
										<div class="modal-body">
											<div class="form-group" align="left">
												<label class="control-label">快捷名称</label>
												<input class="form-control" type="text" name="keyName" placeholder="baidu" > 
											</div>
											<div class="form-group" align="left">
												<label class="control-label">快捷网址URL</label>
												<input class="form-control" type="text" name="keyLink" placeholder="http://www.baidu.com">
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
											<button class="btn btn-primary " type="submit">提交</button>
										</div>	
											<input type="hidden" name="cId" value="<%=request("cId")%>">			
									</form>										
								</div>
							</div>
						</div>
						
			
						<a class='btn btn-primary' href='articleAdd-<%=rs("sortId")%>-<%=rs("tagId")%>.html' data-toggle="tooltip" data-original-title="新建文章" target="_blank"><i class='fa fa-plus'></i> 新建</a>&nbsp;<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i> 到页底</a>
					</div>
				</div>
				
				<hr>
				
				<form class="form-horizontal" method="post" name="addForm" onSubmit="return articleCheck()" action="articleEditSave.html"> 
								
				<div class="form-group">
					<label class="col-md-1 control-label" for="select">类别</label>
					<div class="col-md-2">
					  <select name="sortId" class="form-control select2" onChange="changeselect1(this.value)">
					  
						<%'遍历类别名	
						set rs6 = server.CreateObject("adodb.recordset")
						rs6.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on'  order by sortName,sortId asc",conn,3,3
						do while not rs6.eof
							if rs("sortId") = rs6("sortId") then
								response.write"<option value="&rs6("sortId")&" selected=selected>"&rs6("sortName")&"</option>"
							else
								response.write"<option value="&rs6("sortId")&">"&rs6("sortName")&"</option>"
							end if 
						rs6.movenext
						loop							
						rs6.close
						set rs6 = nothing
						%>							
						</select> 
					</div>	
					
					<label class="col-md-1 control-label" for="select">标签</label>	
					<div class="col-md-2">
					<select name="tagId" class="form-control select4" >
					<% set rs33 = server.createobject("adodb.recordset")							
					rs33.open "select * from tblTag where sortId="&rs("sortId")&" and tagState='on' order by tagName asc",conn,3,3
					if rs33.eof then%>
						<option value="0" selected="selected">/</option>
					<%else%>
		<option value="0" selected="selected">/</option>
						<%do while not rs33.eof%>
							<option value="<%=rs33("tagId")%>" 
								<%if rs33("tagId")=rs("tagId") then %>
									selected
								<%end if%>>
						<%=rs33("tagName")%></option>												
						<%rs33.movenext
						loop
					end if
					rs33.close%>
					</select>																
					</div>
				
				</div>
					
		
				<div class="form-group">
					<label class="col-md-1 control-label" for="select">文章标题 *（1<20）</label>
					<div class="col-md-3">
					<%  'asp在access中不支持'和[ 符号%>
					<input class="form-control"  name="cName" type="text" value="<%=replace(rs("cName"),""""," ") %>" size="20" maxlength="20">
					</div>
					
					<div class="col-md-7" align="right">				
						<a href="#" class="btn btn-danger" id="demoSwal" data-toggle="tooltip" data-original-title="请谨慎操作哦！"><i class="fa fa-lg fa-trash"></i>&nbsp;删除</a>&nbsp;				
						<button class="btn btn-primary" type="submit"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;保存</button>							
					</div>
				</div>
							
								
			
	
				<div class="form-group">
					<label class="col-md-1 control-label" for="select">内容 *</label>
					<div class="col-md-10">
						<script type="text/plain" id="myEditor" style="width:100%; height:400px" name="cContent"><%=rs("cContent")%></script>
						<script type="text/javascript"> var editor= UE.getEditor('myEditor'); </script>
					</div>
				</div>
								
				<div class="form-group">
					<div align="center">
						<input type="hidden" name="sub" value="sub">
						<input type="hidden" name="cId" value="<%=request("cId")%>">			
						<button class="btn btn-primary" type="submit"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;保存</button>
					</div>
				</div>
				
				</form>	
		
	

		
		
	</div>	</div>	
	
	
	
	</div>
	
	
	
		


<%
rs.close
set rs = nothing
%>

	
	
	
	
</div>	

<script type="text/javascript">

  $('#demoSwal').click(function(){
	swal({
		title: "是否要删除此文章?",
		text: "删除后无法恢复哦!",
		type: "warning",
		showCancelButton: true,
		confirmButtonText: "我要干掉它!",
		cancelButtonText: "容我再想想...",
		closeOnConfirm: false,
		closeOnCancel: false
	}, function(isConfirm) {
		if (isConfirm) {
			swal("英明的决定", "就这样被干掉了耶!", "success");
			setTimeout("window.location.href='articleEditdel-<%=request("cId")%>.html';",1000); 
		} else {
			swal("谢谢主人", "哎呦喂，吓死宝宝了，差点被干掉 :)", "error");
			setTimeout("window.location.href='articleEdit-<%=request("cId")%>.html';",1000); 			
		}
	});
  });
</script>



<div class="jdc-side" style="display: block;">
	<div class="mod_hang_qrcode mod_hang_top">
		<a href="#" class="mod_hang_qrcode_btn"><i class="jdcfont"></i></a>
	</div>
	<div class="el-dialog__wrapper" style="display: none;">
		<div class="el-dialog el-dialog--small" style="top: 15%;">
			<div class="el-dialog__header">
				<span class="el-dialog__title"></span>
				<div type="button" class="el-dialog__headerbtn">
					<i class="el-dialog__close el-icon el-icon-close"></i>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>


<!-- top -->
<a href="#0" class="cd-top">Top</a>


<!-- 左侧菜单，放在每个页面底部-->
<script src="js/menu/jquery-2.1.4.min.js"></script>
<script src="js/menu/bootstrap.min.js"></script>
<script src="js/menu/plugins/pace.min.js"></script>
<script src="js/menu/main.js"></script>
<script  src="js/shortcutKey/bootstrap-notify.min.js"></script>

<!-- 下拉框效果 -->
<script src="js/dropDownList/select2.full.min.js"></script>

<!-- 功能：二级联动，选择类别，然后选择标签 -->
<script>
$(function () {
//Initialize Select2 Elements
$(".select2").select2();
$(".select4").select2();
});
<%
'二级数据保存到数组
Dim count2,rsClass2,sqlClass2
set rsClass2=server.createobject("adodb.recordset")
sqlClass2="select * from tblTag where tagState='on' order by tagName" 
rsClass2.open sqlClass2,conn,1,1 %>
var subval2 = new Array();
//数组结构：一级根值,二级根值,二级显示值
<% count2 = 0
do while not rsClass2.eof %>
subval2[<%=count2%>] = new Array('<%=rsClass2("sortId")%>','<%=rsClass2("tagId")%>','<%=rsClass2("tagName")%>')
<% count2 = count2 + 1
rsClass2.movenext
loop
rsClass2.close %>
function changeselect1(locationid)
{ if (document.addForm.tagIdOld.value == ""){document.addForm.tagIdOld.value= 0;}
document.addForm.tagIdOld.length = 0;
document.addForm.tagIdOld.options[0] = new Option('/ ','0');
for (i=0; i<subval2.length; i++){
if (subval2[i][0] == locationid){document.addForm.tagIdOld.options[document.addForm.tagIdOld.length] = new Option(subval2[i][2],subval2[i][1]);}}}
</script>
