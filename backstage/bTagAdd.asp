<!--#include file="bFrame.asp"-->
<%=bMain%>

<title><%=cstCompany%> | �½���ǩ</title>

<% sortId = request("sortId")%>

<!--  ��ȡ��ǰ�û����б�ǩ��ȥ�ر��� -->

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
	//	��ǩ
	if (addForm.tagName.value == "" || addForm.tagName.value.length < 4){
		alert("��ܰ��ʾ����ǩ�����˺ų��ȷ�Χ 4 - 8���ַ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.tagName.focus();
		return false;}
		
	// ��ǩ(ȥ��)
	var arr = addForm.jsTagName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.tagName.value == arr[i]){
			alert("��ܰ��ʾ����ǩ�����Ѵ��ڣ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.tagName.focus();
			return false;}}
			
	var gnl=confirm("ȷ��Ҫ�ύ?");
	if (gnl==true){
		return true;}
	else{
		return false;}
	 
}
 
</script>


<!--  �½��汾	-->

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
				<div class="card-header">�½���ǩ��<%response.write "������ " + sortName %>��</div>
				<div class="card-body">
			
				
					<form method="post" name="addForm" onSubmit="return CheckPost()">   
					
					<div class="form-group">
						<label for="inputAddress">��ǩ���� *��4-8��</label>
						<input type="text" name="tagName" id="tagName"  maxlength="8" class="form-control"  placeholder="" >
					</div>
					
					<br>	
					<div align="center">	
					<button type="submit" class="btn btn-primary" href="#">�ύ</button></div>
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
							if rs("tagState") = "off" then
								if rs("tagShare") = "off" then%>
									<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td><td><span class="badge badge-danger">�ر�</span></td><td><span class="badge badge-danger">�ر�</span></td>
								<%else%>
									<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td><td><span class="badge badge-danger">�ر�</span></td><td><span class="badge badge-info">����</span></td>
								<%end if
							else 
								if rs("tagShare") = "off" then%>
									<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td><td><span class="badge badge-info">����</span></td><td><span class="badge badge-danger">�ر�</span>	</td>																	
								<%else%>
									<td><a href="bTagEdit-<%=sortId%>-<%=rs("tagId")%>.html"><%=rs("tagName")%></a></td><td><span class="badge badge-info">����</span></td><td><span class="badge badge-info">����</span>	</td>
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



