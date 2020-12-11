<!--#include file="bFrame.asp"-->
<%=bMain%>

<title><%=cstCompany%> | 新建标签</title>

<% sortId = request("sortId")%>

<!--  获取当前用户所有标签，去重遍历 -->

<%
dim jsTagName
jsTagName = ""
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblTag where sortId="&sortId&"",conn,3,3
Do While Not rs8.Eof
If jsTagName = "" Then
jsTagName = rs8("tagName")
Else
jsTagName = jsTagName&","&rs8("tagName")
End If
rs8.Movenext
loop
rs8.close
set rs8 = nothing 
%>

<script language="javascript">
function CheckPost()
{
	//	标签
	if (addForm.tagName.value == "" || addForm.tagName.value.length < 4){
		alert("温馨提示，标签名称账号长度范围 4 - 8个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.tagName.focus();
		return false;}
		
	// 标签(去重)
	var arr = addForm.jsTagName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.tagName.value == arr[i]){
			alert("温馨提示，标签名称已存在！", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.tagName.focus();
			return false;}}
			
	var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;}
	else{
		return false;}
	 
}
 
</script>


<!--  新建版本	-->

<% 
if request.form("sub")="sub" then
	sortId = request.form("sortId")
	tagName = request.form("tagName")
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblTag where sortId="&sortId&"",conn,3,3
	rs.addnew
	rs("sortId") = sortId
	rs("tagName") = request.form("tagName")
	rs("tagState") = "on"
	rs("tagShare") = "off"
	rs("tagCrtDate") = now
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("bTagAdd-"&sortId&".html")
end if 
%>





<div class="content-wrapper">

<div class="row page-tilte align-items-center">
	<div class="col-md-auto">
		<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
		<h1 class="weight-300 h3 title">标签管理</h1>
		<p class="text-muted m-0 desc">Tag management</p>
	</div> 
	<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
		<div class="controls d-flex justify-content-center justify-content-md-end"></div>
	</div>
</div> 

<%
set rs1 = server.CreateObject("ADODB.RecordSet")
rs1.Open "select * from tblSort where sortId="&sortId&" order by sortName,sortId ",conn,3,3
sortName = rs1("sortName")
rs1.close
set rs1 = nothing
%>
				  
<div class="content">
	<div class="row">
		<div class="col-lg-6 ">
			<div class="card mb-4">
				<div class="card-header">新建标签（<%response.write "所属于 " + sortName %>）</div>
				<div class="card-body">
			
				
					<form method="post" name="addForm" onSubmit="return CheckPost()">   
					
					<div class="form-group">
						<label for="inputAddress">标签名称 *（4-8）</label>
						<input type="text" name="tagName" id="tagName"  maxlength="8" class="form-control"  placeholder="" >
					</div>
					
					<br>	
					<div align="center">	
					<button type="submit" class="btn btn-primary" href="#">提交</button></div>
					<input type="hidden" name="sub" value="sub">
    				<input name="sortId" type="hidden" value="<%=sortId%>" />
					<input type="hidden" name="jsTagName" value="<%=jsTagName%>">

					</form>

					</div>
				</div>
			</div>
						
						
				<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-header">
			       		<div class="alert alert-primary" role="alert">标签列表</div>
					<div class="card-body">				
						<table class="table table-striped m-0">
						<thead>
						<tr>
						<th>标签名称</th>
						<th>标签状态</th>
						<th>共享状态</th>
						</tr>
						</thead>
						<tbody>
						<%set rs = server.CreateObject("ADODB.RecordSet")
						rs.Open "select * from tblTag where sortId="&sortId&" order by tagName,tagId",conn,3,3
						do while not rs.eof%>
							<tr>
							<%
							if rs("tagState") = "off" then
								if rs("tagShare") = "off" then%>
									<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td><td><span class="badge badge-danger">关闭</span></td><td><span class="badge badge-danger">关闭</span></td>
								<%else%>
									<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td><td><span class="badge badge-danger">关闭</span></td><td><span class="badge badge-info">开启</span></td>
								<%end if
							else 
								if rs("tagShare") = "off" then%>
									<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td><td><span class="badge badge-info">开启</span></td><td><span class="badge badge-danger">关闭</span>	</td>																	
								<%else%>
									<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td><td><span class="badge badge-info">开启</span></td><td><span class="badge badge-info">开启</span>	</td>
								<%end if 
							end if%>												
							</tr>						
						<%
						rs.movenext
						loop						
						%>																					
						</tbody>
						</table>	
					</div>										
					</div> <!-- card-body --> 					
				</div><!-- "card mb-4" --> 	
			</div><!-- col-lg-6 --> 	
				
	</div>
</div>

</div>
</body>
</html>



