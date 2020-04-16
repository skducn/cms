<!--#include file="menu.asp"-->

<title>新建文章 | <%=cstCompany%></title>

<%
set rs4 = server.createobject("adodb.recordset") 
rs4.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on'",conn,3,3
if rs4.eof then
	response.Redirect("index.html")
end if 
rs4.close%>


<!-- Select2 -->
<script src="731/dist/js/select2/select2.full.min.js"></script>
<script>
$(function () {
//Initialize Select2 Elements
$(".select2").select2();
$(".select4").select4();
});
</script>

<script language="JavaScript">
<!-- 功能：二级联动，选择类别，然后选择标签
<%
'二级数据保存到数组
Dim count2,rsClass2,sqlClass2
set rsClass2=server.createobject("adodb.recordset")
sqlClass2="select * from tblTag where tagState='on' order by tagName" 
rsClass2.open sqlClass2,conn,1,1
%>
var subval2 = new Array();
//数组结构：一级根值,二级根值,二级显示值
<%
count2 = 0
do while not rsClass2.eof
%>
subval2[<%=count2%>] = new Array('<%=rsClass2("sortId")%>','<%=rsClass2("tagId")%>','<%=rsClass2("tagName")%>')
<%
count2 = count2 + 1
rsClass2.movenext
loop
rsClass2.close
%>
function changeselect1(locationid)
{
if (document.addForm.tagIdOld.value == "")
{
document.addForm.tagIdOld.value= 0;
}
document.addForm.tagIdOld.length = 0;
document.addForm.tagIdOld.options[0] = new Option('/ ','0');
for (i=0; i<subval2.length; i++)
{
if (subval2[i][0] == locationid)
{document.addForm.tagIdOld.options[document.addForm.tagIdOld.length] = new Option(subval2[i][2],subval2[i][1]);}
}
}
//-->
</script>

<script language="javascript">  
function CheckShortAdd()
{   
  
    if (addForm1.keyName.value == "")
  {
  	$.notify({
		title: "温馨提示： ",
		message: "快捷键名称不能为空！",
		icon: 'fa fa-check' 
	},{
		type: "warning"
	});		
	  addForm1.keyName.focus();
	  return false;
  }
  
	if (addForm1.keyLink.value == "")
  {
	  $.notify({
		title: "温馨提示： ",
		message: "快捷键地址URL不能为空！",
		icon: 'fa fa-check' 
	},{
		type: "warning"
	});	
	  addForm1.keyLink.focus();
	  return false;
  }
	
	$.notify({
		title: "&nbsp;&nbsp;",
		message: "保存成功",
		icon: 'fa fa-check' 
	},{
		type: "success"
	});   
}

function CheckPost()
{
       	  
  if (addForm.sortId.value == "")
  {	      
	$.notify({
		title: "&nbsp;&nbsp;",
		message: "文章类别不能为空！",
		icon: 'fa fa-remove' 
	},{
		type: "danger"
	});			  	  
	  addForm.sortId.focus();
	  return false;
  }
  
    if (addForm.cName.value == "")
  {
  	$.notify({
		title: "&nbsp;&nbsp;",
		message: "文章标题不能为空！",
		icon: 'fa fa-remove' 
	},{
		type: "danger"
	});		
	  addForm.cName.focus();
	  return false;
  }
  
	if (addForm.cContent.value == "")
  {
	  $.notify({
		title: "&nbsp;&nbsp;",
		message: "文章内容不能为空",
		icon: 'fa fa-remove' 
	},{
		type: "danger"
	});	
	  addForm.cContent.focus();
	  return false;
  }

		$.notify({
		title: "&nbsp;&nbsp;",
		message: "提交成功",
		icon: 'fa fa-check' 
	},{
		type: "success"
	});
}
</script>

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
		rs("keyLink") = "http://"+keyLink 
	end if
	rs("KeySort") = 2
	rs("keyWay") = "新建文章"
	rs.update 
	rs.close
	set rs = nothing  
	Response.Redirect("articleAdd-"&request("sortId")&"-"&request("tagId")&".html")
end if
%>

<!-- 新建文章 -->

<%
if request("action") = "save" then

	'cName =replace(request("cName"),"'","")    'asp在access中不支持'和[ 符号
   ' cName=replace(replace(request("cName"),"'","") ,"[","")    'asp在access中不支持'和[ 符号
	set rs = server.createobject("adodb.recordset")	
	rs.open "select * from tblContent where cName='"&replace(replace(request("cName"),"'","") ,"[","") &"' and userName='"&session("userName")&"' order by cId DESC",conn,3,3
	if rs.eof then 
		if request("tagNameNew") <> "" then	
			' 提交标签，查找系统中是否有同名的		
			set rs1 = server.createobject("adodb.recordset")	
			rs1.open "select * from tblTag where sortId="&request("sortId")&" and tagName='"&request("tagNameNew")&"' order by tagId desc ",conn,3,3 
			if rs1.recordcount = 0 then
				'标签不同名，新增
				rs1.addnew
				rs1("sortId") = request("sortId")
				rs1("tagState") = "on"
				rs1("tagName") = request("tagNameNew")
				rs1("tagShare") = "off"
				rs1("tagCrtDate") = now
				rs1.update
				' 获取刚才新增的id
				set rs2 = server.createobject("adodb.recordset")	
				rs2.open "select * from tblTag where sortId="&request("sortId")&" and tagName='"&request("tagNameNew")&"' order by tagId desc ",conn,3,3 
			
				'新增文章
				set rs3 = server.createobject("adodb.recordset")	
				rs3.open "select * from tblContent ",conn,3,3 
				rs3.addnew
				rs3("sortId") = request("sortId")
				rs3("tagId") = rs2("tagId")
				rs3("cState") = "on"
				rs3("cName") = replace(replace(request("cName"),"'","") ,"[","") 
				rs3("cContent") = request("cContent")
				rs3("userName") = session("userName")
				rs3("cShare") = "off"
				rs3("cCrtDate") = now
				rs3.update					 
			
				rs2.close
				rs1.close
				response.Redirect("article-"&rs3("cId")&"-"&request("sortId")&".html") 
			else
				'标签同名，直接新增文章
				set rs3 = server.createobject("adodb.recordset")	
				rs3.open "select * from tblContent ",conn,3,3 
				rs3.addnew
				rs3("sortId") = request("sortId")
				rs3("tagId") = rs1("tagId")
				rs3("cState") = "on"
				rs3("cName") = replace(replace(request("cName"),"'","") ,"[","") 
				rs3("cContent") = request("cContent")
				rs3("userName") = session("userName")
				rs3("cShare") = "off"
				rs3("cCrtDate") = now
				rs3.update					 
				response.Redirect("article-"&rs3("cId")&"-"&request("sortId")&".html") 					
			end if 													
		else 		
			'自定义新标签为空
			set rs2 = server.createobject("adodb.recordset")	
			rs2.open "select * from tblContent ",conn,3,3 
			rs2.addnew
			rs2("sortId") = request("sortId")
			rs2("tagId") = request("tagId")
			if request("tagIdOld") = "" then
				rs2("tagId") = 0
			else
				rs2("tagId") = request("tagIdOld")
			end if 
			rs2("cState") = "on"
			rs2("cName") = replace(replace(request("cName"),"'","") ,"[","") 
			rs2("cContent") = request("cContent")
			rs2("userName") = session("userName")
			rs2("cShare") = "off"
			rs2("cCrtDate") = now
			rs2.update
			set rs3 = server.createobject("adodb.recordset")	
			rs3.open "select * from tblContent where sortId="&int(request("sortId"))&" and userName='"&session("userName")&"' and cName='"&rs2("cName")&"' order by cId DESC",conn,3,3
			response.Redirect("article-"&rs3("cId")&"-"&request("sortId")&".html") 		
		end if 
	else
		 response.Write("<script>;alert('此文章已存在！');</script>") 
 		 response.Write("<script>;window.location.href='articleAdd-"&request("sortId")&"-"&request("tagId")&".html';</script>") 

	             
    end if
	rs.close
	set rs = nothing
end if 
%>


<!-- ******************************************************************************************************************************************************************** -->	

<div class="content-wrapper">	
	<div class="card">		
														
		<div class="row">
			<div class="col-md-6">
				<h3 class="card-title"> 新建文章</h3>
			</div>
			<div class="col-md-6" align="right">	
				
					<%set rs7 = server.CreateObject("adodb.recordset")
							rs7.open "select * from tblKey where userId="&session("userId")&" and keySort=2 order by keyId",conn,3,3 
							do while not rs7.eof %>
								<a href="<%=rs7("keyLink")%>" class="btn btn-success" data-toggle="tooltip" data-original-title="<%=rs7("keyLink")%>" target="_blank"><i class="fa fa-location-arrow"></i>&nbsp;<%=rs7("keyName")%></a>										
							<%rs7.movenext
							loop
						rs7.close%>	
						
				<button type="button" class="btn btn-dark" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"> </i> 快捷键</button>					
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"><br><br><br><br><br><br><br><br>
					<div class="modal-dialog" role="document">
						<div class="modal-content">	
							
							<form action="articleAddSaveShort.html" method="post" name="addForm1"  class="login-form" onSubmit="return CheckShortAdd()" >		
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">×</span>
									</button>
									<h4 class="modal-title" align="left" id="myModalLabel">新增快捷键</h4>
								</div>
								<div class="modal-body">
									<div class="form-group" align="left">
										<label class="control-label">快捷名称</label>
										<input class="form-control" type="text" name="keyName" placeholder="baidu">
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
									<input type="hidden" name="sortId" value="<%=request("sortId")%>">			
									<input type="hidden" name="tagId" value="<%=request("tagId")%>">			
							</form>										
						</div>
					</div>
				</div>
									
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>
			</div>
		</div>
				
		<hr>
		<form class="form-horizontal" method="post" name="addForm" onSubmit="return CheckPost()" action="articleAddSave.html">  
								         							
		<div class="form-group">
			<!-- 类别 -->	
			<label class="col-md-1 control-label" for="select">类别/标签 *</label>
						
			
			
			
					<div class="col-md-2">
					  <select name="sortId" class="form-control select2" onChange="changeselect1(this.value)">
					 
						<%'遍历类别名	
						set rs6 = server.CreateObject("adodb.recordset")
						
						if request("sortId") = 0 then %>
							 <option value=""> &nbsp;<请选择> </option>
<%							rs6.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on' ",conn,3,3	
							do while not rs6.eof
							response.write"<option value="&rs6("sortId")&">"&rs6("sortName")&"</option>"
							rs6.movenext
							loop	
						else				
						rs6.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on'  order by sortName,sortId asc",conn,3,3		
							do while not rs6.eof
								if rs6("sortId") = cint(request("sortId")) then
									response.write"<option value="&rs6("sortId")&" selected=selected>"&rs6("sortName")&"</option>"
								else
									response.write"<option value="&rs6("sortId")&">"&rs6("sortName")&"</option>"
	
								end if 
							rs6.movenext
							loop
						end if 		
											
						rs6.close
						set rs6 = nothing
						%>							
						</select> 
					</div>	
					
					<label class="col-md-1 control-label" for="select">标签</label>	
					<div class="col-md-2">
					<%if request("tagId") = 0 then%>	
					<select name="tagIdOld" class="form-control select4">
				 <option value="0" selected="selected"> / </option>
				</select>
				<%else%>
					<select name="tagIdOld" class="form-control select4" >
					<% set rs33 = server.createobject("adodb.recordset")							
					rs33.open "select * from tblTag where sortId="&request("sortId")&" and tagState='on' order by tagName asc",conn,3,3
					if rs33.eof then%>
						<option value="0" selected="selected">/</option>
					<%else%>
		<option value="0" selected="selected">/</option>
						<%do while not rs33.eof%>
							<option value="<%=rs33("tagId")%>" 
								<%if rs33("tagId")=cint(request("tagId")) then %>
									selected
								<%end if%>>
						<%=rs33("tagName")%></option>												
						<%rs33.movenext
						loop
					end if
					rs33.close%>
					</select>																
				<%end if %>
					</div>
			
			
			
				 
					
			<!-- 自定义标签 -->	
			<div class="col-md-2">
				<%set rs1 = server.CreateObject("adodb.recordset")	
				if request("sortId") <> "" and request("tagId") <> "" then			
					rs1.open "select * from tblTag where sortId="&request("sortId")&" and tagId="&request("tagId")&" and tagState='on' order by tagId desc",conn,3,3				
					%>								
						<input name="tagNameNew" type="text"  value="" class="form-control"  size="12" maxlength="15" placeholder="自定义新标签">							
					<% 							
				else
					rs1.open "select * from tblTag order by tagId desc",conn,3,3	%>
					<input name="tagNameNew" type="text"  value="" class="form-control"  size="12" maxlength="15" placeholder="自定义新标签">				
				<%end if 																									
				rs1.close
				set rs1 = nothing %>						  
			</div>
			
					
		</div>
														
		<!-- 文章标题 -->				
		<div class="form-group">
			<label class="col-md-1 control-label" for="inputPassword">文章标题 *（1<20）</label>
			<div class="col-md-6">
				<input name="cName" class="form-control" type="text" size="20" maxlength="20" >                         
			</div>		
			
				<div class="col-md-4" align="right">
					<button class="btn btn-primary" type="submit"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;提交</button>		
			</div>			
		</div>

		<!-- 文章内容 -->	
		<div class="form-group">
			<label class="col-md-1 control-label" for="inputPassword">内容 *</label>
			<div class="col-md-10">
			<script type="text/plain" id="cContent" style="width:100%; height:400px" name="cContent"></script>	
			<script>var editor_a = UE.getEditor('cContent');</script>
			</div>
		</div>
				
		<div class="form-group" align="center">									
			<button class="btn btn-primary" type="submit" ><i class="fa fa-fw  fa-check-circle"></i>&nbsp;提交</button>						
		</div>

		</form>
	
		<!-- top按钮 -->
		<hr>
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-10" align="right">
				<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>
				<a id='DD'></a>
			</div>
		</div>
				 
	</div>
</div>
</body>
</html>

