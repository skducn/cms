<!--#include file="bFrame.asp"-->
<!--#include file="../common/constant.asp"-->
<%=bMain%>

<title><%=cstCompany%> | �༭��ǩ</title>


<%
tagId = request("tagId") 
sortId = request("sortId") 
%>
<!--  ��ȡ��ǰ�û����б�ǩ��ȥ�ر��� -->

<%
dim jsTagName
jsTagName = ""
set rs8 = server.CreateObject("ADODB.RecordSet")
rs8.Open "select * from tblTag where tagId<>"&tagId&" and sortId="&sortId&"",conn,3,3
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
		
	// ��ǩ(ȥ��)
	var arr = addForm.jsTagName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.tagName.value == arr[i]){
			alert("��ܰ��ʾ����ǩ�����Ѵ��ڣ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.tagName.focus();
			return false;}}
			
	var gnl=confirm("ȷ��Ҫ����?");
	if (gnl==true){
		return true;}
	else{
		return false;}
	 
}
 
</script>

	
<!--  �༭��ǩ	-->

<% 
if request.form("sub")="sub" then
	tagId = request.form("tagId")
	tagName = request.form("tagName")
	tagState = request.form("tagState")
	sortId = request.form("sortId")
	tagShare = request.form("tagShare")
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tblTag where tagId="&tagId&"",conn,3,3
	rs("tagName") = tagName
	rs("tagState") = tagState
	rs("tagShare") = tagShare
	if tagShare = "on" then
		set rs3 = server.createobject("adodb.recordset")
		rs3.open "select * from tblUser where userId="&session("userId")&"",conn,3,3
		rs3("userShare") = "on"
		rs3.update
		rs3.close
	end if 
	rs("tagLatestDate") = now
	rs.update
	rs.close	
	set rs = nothing  	
	response.Redirect("bTagEdit-"&sortId&"-"&tagId&".html")
end if 

set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tblTag where tagId="&tagId&"",conn,3,3

%>


<div class="content-wrapper">

<div class="row page-tilte align-items-center">
	<div class="col-md-auto">
		<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
		<h1 class="weight-300 h3 title">��ǩ����</h1>
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
				<div class="card-header">�༭��ǩ��<%response.write "������ " + sortName %>��</div>
				<div class="card-body">
			
					<form method="post" name="addForm" onSubmit="return CheckPost()">   

					<div class="form-group">
						<label for="inputAddress">��ǩ���� * ��<8��</label>
						<input type="text" name="tagName" id="tagName"  maxlength="8" class="form-control"  value="<%=rs("tagName")%>" >
					</div>
					
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="exampleFormControlInput1">��ǩ״̬</label>
							<% if rs("tagState") = "on" then %>
									<div class="radio">
										<label><input type="radio" name="tagState" value="on" checked> <span class="badge badge-info">����</span></label>
										<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagState"  value="off"> <span class="badge badge-danger">�ر�</span></label>	
									</div>
								<% elseif rs("tagState") = "off" then %>
									<div class="radio">
										<label><input type="radio" name="tagState" value="on" > <span class="badge badge-info">����</span></label>
										<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagState"  value="off" checked> <span class="badge badge-danger">�ر�</span></label>	
									</div>		
								<% elseif rs("tagState") = "ban" then %>
									<div class="radio">
										<label><input type="radio" name="tagState" value="ban" checked disabled="disabled"> <span class="badge badge-dark">��ֹ������ϵ����Ա��</span></label>

									</div>										
								<%end if %>
						</div>
					
						<div class="form-group col-md-6">
							<label for="inputPassword4">����״̬ </label>
							<% if rs("tagShare") = "on" then %>
								<div class="radio">
									<label><input type="radio" name="tagShare" value="on" checked> <span class="badge badge-info">����</span></label>
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagShare"  value="off"> <span class="badge badge-danger">�ر�</span></label>	
								</div>
							<% elseif rs("tagShare") = "off" then %>
								<div class="radio">
									<label><input type="radio" name="tagShare" value="on" > <span class="badge badge-info">����</span></label>
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="tagShare"  value="off" checked> <span class="badge badge-danger">�ر�</span></label>
								</div>				
							<%end if %>						
						</div>
					</div>
					
					<%if rs("tagState") = "ban" then %>
						<div class="form-group">
							<label for="inputAddress">��ֹ����</label>
							<textarea name="tagAdminReason" cols="5" rows=5"" class="form-control" value="" disabled="disabled"><%=rs("tagAdminReason")%></textarea>

						</div>					
					<%end if%>
			
					
					<br>
					<div align="center">
					<button type="submit" class="btn btn-primary" href="#">����</button></div>
					<input type="hidden" name="sub" value="sub">
					<input name="sortId" type="hidden" value="<%=rs("sortId")%>" />
					<input name="tagId" type="hidden" value="<%=tagId%>" />
					<input type="hidden" name="jsTagName" value="<%=jsTagName%>">


					</form>

					</div>
				</div>
			</div>
			
			<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-header">
			       		<div class="alert alert-primary" role="alert">��ǩ�б�</div>
					<div class="card-body">				
						<table class="table table-striped m-0">
						<thead>
						<tr>
						<th>��ǩ����</th>
						<th>��ǩ״̬</th>
						<th>����״̬</th>
						</tr>
						</thead>
						<tbody>
						<%set rs = server.CreateObject("ADODB.RecordSet")
						rs.Open "select * from tblTag where sortId="&sortId&" order by tagName,tagId",conn,3,3
						do while not rs.eof%>
							<tr>
							<%
							if rs("tagState") = "on" then %>
								<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td>
								<td><span class="badge badge-info">����</span></td>
								<%if rs("tagShare") = "on" then%>
									<td><span class="badge badge-dinfo">����</span></td>	
								<%else%>
									<td><span class="badge badge-danger">�ر�</span></td>	
								<%end if %>
							<%elseif rs("tagState") = "off" then%>
								<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td>
								<td><span class="badge badge-danger">�ر�</span></td>
								<%if rs("tagShare") = "on" then%>
									<td><span class="badge badge-info">����</span></td>	
								<%else%>
									<td><span class="badge badge-danger">�ر�</span></td>	
								<%end if %>
							
							<%elseif rs("tagState") = "ban" then%>
								<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td>
								<td><span class="badge badge-dark">��ֹ</span></td>
								<%if rs("tagShare") = "on" then%>
									<td><span class="badge badge-info">����</span></td>	
								<%else%>
									<td><span class="badge badge-danger">�ر�</span></td>	
								<%end if %>
							<%end if %>
							
							
																	
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

<%
rs.close
set rs = nothing
%>

</div>
</body>
</html>



