<!--#include file="menu.asp"-->

<title>��һ�� | <%=cstCompany%></title>

<div class="content-wrapper">
	<div class="row">	


<!-- �������� -->

<%if request("action")="sort" then
	set rs2 = server.createobject("adodb.recordset") 
	rs2.open "select * from tblSort where sortId="&request("sortId")&"" ,conn,3,3
	if rs2.recordcount = 0  then						
		response.write("<script language=JavaScript>history.back();</script>") 
		response.end 	
	end if 	
	set rs = server.createobject("adodb.recordset") 
	rs.open "select * from tblContent where sortId="&request("sortId")&" and cState='on' order by cName asc",conn,3,3 %>
	<div class="col-md-12">
		<div class="card">							
			<div class="row">
				<div class="col-md-6">
					<h3 class="card-title"><%=rs2("sortName")%>  ��¼����<%=rs.recordcount%>��</h3>
				</div>
				<div class="col-md-6" align="right">
					<a class='btn btn-primary' href='articleAdd-0-0.html' data-toggle="tooltip" data-original-title="�½�����"><i class='fa fa-plus'></i> �½�����</a>		
					<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>		
				</div>
			</div>			
			<table class="table table-hover table-bordered" id="sampleTable1">
				<thead><tr>
				<th style="width: 25%">��������</th>
				<th style="width: 15%">������</th>
				<th style="width: 15%">����ʱ��</th>
				<th style="width: 15%">����ʱ��</th>
				<th style="width: 15%">����״̬</th>
				<th style="width: 15%">����ʱ��</th>
				</tr></thead>			
				<tbody>			
				<% do while not rs.eof %>				
					<tr>											
					<td><a href="article-<%=rs("cId")%>-<%=rs("tagId")%>.html"><%=rs("cName")%></a></td>	
					<td><%=rs("userName")%></td>
					<td><%=rs("cCrtDate")%></td>				
					<td><%=rs("cLatestDate")%></td>
					<td><%if rs("cShare") <> "off" then
							response.write "�ѹ���"				
						end if %>
					</td>
					<td><%=rs("cShareDate")%></td>						
					</tr>			
				<% rs.movenext
				loop 
				rs.close
				set rs = nothing
				rs2.close
				set rs2 = nothing %>						
				</tbody>
			</table>
				
			<!-- ����top��ť -->
			<hr>
			<div class="row">
				<div class="col-md-2">
				</div>
				<div class="col-md-10" align="right">
					<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>
					<a id='DD'></a>
				</div>
			</div>		
		</div>
	</div>
	
<% end if %>	
	

<!-- ������ǩ -->

<%if request("action")="tag" then
	set rs2 = server.createobject("adodb.recordset") 
	rs2.open "select * from tblTag where tagId="&request("tagId")&"" ,conn,3,3
	
	set rs = server.createobject("adodb.recordset") 
	rs.open "select * from tblContent where tagId="&request("tagId")&" and cState='on' order by cName asc",conn,3,3 
	
	set rs4 = server.createobject("adodb.recordset") 
	rs4.open "select * from tblSort where sortId="&rs("sortId")&"" ,conn,3,3
	%>

	<div class="col-md-12">
		<div class="card">							
			<div class="row">
				<div class="col-md-6">
					<h3 class="card-title"><%=rs4("sortName")%> - <%=rs2("tagName")%> ��¼����<%=rs.recordcount%>��</h3>
					<%rs4.close
					set rs4 = nothing%>
				</div>
				<div class="col-md-6" align="right">
					<a class='btn btn-primary' href='articleAdd-0-0.html' data-toggle="tooltip" data-original-title="�½�����"><i class='fa fa-plus'></i> �½�����</a>		
					<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>		
				</div>
			</div>			
			<table class="table table-hover table-bordered" id="sampleTable1">
				<thead><tr>
				<th style="width: 25%">��������</th>
				<th style="width: 15%">������</th>
				<th style="width: 15%">����ʱ��</th>
				<th style="width: 15%">����ʱ��</th>
				<th style="width: 15%">����״̬</th>
				<th style="width: 15%">����ʱ��</th>
				</tr>
				</thead>
				<tbody>			
				<% do while not rs.eof %>
					<tr>						
						<td><a href="article-<%=rs("cId")%>-<%=rs("tagId")%>.html"><%=rs("cName")%></a></td>	
						<td><%=rs("userName")%></td>
						<td><%=rs("cCrtDate")%></td>				
						<td><%=rs("cLatestDate")%></td>
						<td><%if rs("cShare") <> "off" then
								response.write "�ѹ���"
							end if %>
						</td>
						<td><%=rs("cShareDate")%></td>						
					</tr>
				<% 
				rs.movenext
				loop 
				rs.close
				set rs = nothing
				rs2.close
				set rs2 = nothing %>						
				</tbody>
			</table>
				
			<!-- ����top��ť -->
			<hr>
			<div class="row">
				<div class="col-md-2">
				</div>
				<div class="col-md-10" align="right">
					<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>
					<a id='DD'></a>
				</div>
			</div>		
		</div>
	</div>

<% end if %>

		  
<!--  ����������ֻ���������ͱ�ǩ���������� -->		

<%if request("action")="search" then
	s_name = request("s_name")	
	if s_name = "" then 
		response.write("<script language=JavaScript>history.back();</script>") 
		response.end 
	end if 
	s_named=LCase(s_name)   '''���ַ���ȫ��תСд     's_named=UCase(s_namex)   ''' ���ַ���ȫ��ת��д
	s_named=replace(s_named,"'","��")    'asp��access�в�֧��'��[ ����
	s_named=replace(s_named,"[","��")    'asp��access�в�֧��'��[ ����	
	set rs = server.createobject("adodb.recordset") 
	rs.open "select * from tblContent where userName='"&session("userName")&"' and cState='on' and cName like '%"&s_named&"%' order by cName asc",conn,3,3
	if rs.recordcount = 0  then	%>
		<div class="col-md-12">
			<div class="card">
					<h1><i class="fa fa-exclamation-circle"></i> �ܱ�Ǹ��û���ҵ�&nbsp;��<%=s_name%>��</h1><br>
				<p>�������ؼ��ּ�����ѯ...</p>
				<%
				set rs4 = server.createobject("adodb.recordset") 
				rs4.open "select * from tblSort where userName='"&session("userName")&"' and sortState='on'",conn,3,3
				if not rs4.eof then%>
				<p><a class='btn btn-primary' href='articleAdd-0-0.html'><i class='fa fa-plus'></i>&nbsp;�½�����</a></p>
				<%end if %>
			</div>
		</div>
		<%response.end 			
	end if 	
	i = rs.recordcount	
	redim arrayCid(i),arraySortName(i),arrayTagName(i),arrayAuthor(i),arrayTitle(i),arrayCrtDate(i),arrayDate(i),arrayShare(i),arrayShareDate(i),arraySortId(i),arrayTagId(i)		
	x = 0
	do while not rs.eof
		if 	rs("tagId") = 0 then
			set rs1 = server.createobject("adodb.recordset") 
			rs1.open "select * from tblSort where sortId="&rs("sortId")&" ",conn,3,3
			if rs1("sortState") = "on" then	
				arraySortId(x) = rs("sortId")
				arrayTagId(x) = rs("tagId")
				arrayCid(x) = rs("cId")			
				arraySortName(x) = rs1("sortName")
				arrayTagName(x) = ""
				arrayTitle(x) = replace(rs("cName"),s_named,"<font color='#ff3399'>"&s_named&"</font>")		
				arrayCrtDate(x) = rs("cCrtDate")
				if rs("cLatestDate") <> "" then
					arrayDate(x) = rs("cLatestDate")			
				end if 			
				if rs("cShare")	= "on" then			
					arrayShare(x) = "�ѹ���"
				else
					arrayShare(x) = rs("cShare")									
				end if 				
				arrayShareDate(x) = rs("cShareDate")				
				arrayAuthor(x) = rs("userName")
				x = x + 1			
			end if 
			rs1.close
		else
			set rs1 = server.createobject("adodb.recordset") 
			rs1.open "select * from tblSort where sortId="&rs("sortId")&" ",conn,3,3
			if rs1("sortState") = "on" then
				set rs2 = server.createobject("adodb.recordset") 
				rs2.open "select * from tblTag where sortId="&rs1("sortId")&" ",conn,3,3
				do while not rs2.eof
					if rs2("tagState") = "on" and rs2("tagId") = rs("tagId") then
						arraySortId(x) = rs("sortId")
						arrayTagId(x) = rs("tagId")
						arrayCid(x) = rs("cId")			
						arrayTitle(x) = replace(rs("cName"),s_named,"<font color='#ff3399'>"&s_named&"</font>")								
						arraySortName(x) = rs1("sortName")
						arrayTagName(x) = rs2("tagName")
						arrayCrtDate(x) = rs("cCrtDate")
						if rs("cLatestDate") <> "" then
							arrayDate(x) = rs("cLatestDate")						
						end if 			
						if rs("cShare")	= "on" then			
							arrayShare(x) = "�ѹ���"
						else
							arrayShare(x) = rs("cShare")									
						end if				
						arrayShareDate(x) = rs("cShareDate")	
						arrayAuthor(x) = rs("userName")
						x = x + 1	
						
					end if 
				rs2.movenext
				loop	
			end if 
			rs1.close
		end if 
	rs.movenext
	loop %>
	
	<div class="col-md-12">
		<div class="card">							
			<div class="row">
				<div class="col-md-6">
					<h3 class="card-title">���� <%=s_name%> ��¼����<%=ubound(arrayTitle)%>��</h3>
				</div>
				<div class="col-md-6" align="right">
					<a class='btn btn-primary' href='articleAdd-0-0.html' data-toggle="tooltip" data-original-title="�½�����"><i class='fa fa-plus'></i> �½�����</a>		
					<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>		
				</div>
			</div>
			
			<table class="table table-hover table-bordered" id="sampleTable3">
				<thead><tr>
				<th style="width: 10%">���</th>
				<th style="width: 10%">��ǩ</th>
				<th style="width: 30%">��������</th>
				<th style="width: 10%">������</th>
				<th style="width: 10%">����ʱ��</th>
				<th style="width: 10%">����ʱ��</th>
				<th style="width: 10%">����״̬</th>
				<th style="width: 10%">����ʱ��</th>
				</tr>
				</thead>
				<tbody>			
				<%for i=0 to ubound(arrayTitle)-1 %>
					<tr>						
						<td><a href="searchSort-<%=arraySortId(i)%>.html"><%response.write arraySortName(i)%></a></td>
						<td><a href="searchTag-<%=arrayTagId(i)%>.html"><%response.write arrayTagName(i)%></a></td>
						<td><a href="searchResult-<%=arrayCid(i)%>.html"><%response.write arrayTitle(i)%></a></td>
						<td><%response.write arrayAuthor(i)%></td>
						<td><%response.write arrayCrtDate(i)%></td>
						<td><%response.write arrayDate(i)%></td>
						<td><%if arrayShare(i) <> "off" then
								response.write arrayShare(i)
							end if %>
						</td>
						<td><%response.write arrayShareDate(i)%></td>						
					</tr>
				<% next %>						
				</tbody>
			</table>
				
			<!-- ����top��ť -->
			<hr>
			<div class="row">
				<div class="col-md-2">
				</div>
				<div class="col-md-10" align="right">
					<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>
					<a id='DD'></a>
				</div>
			</div>
		</div>
	</div>
			
	
<%	
rs.close
set rs = nothing
end if 
%>

</div>	
</div>


<!-- table-->
<script type="text/javascript" src="731/dist/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/dataTables.bootstrap.min.js"></script>

<script type="text/javascript">$('#sampleTable1').DataTable({
//�������±�һ������һ�д�0��ʼ����������ʼ��ʱ����1��Ĭ������
"order": [[ 0, "asc" ]],
"aLengthMenu": [[50, 100, -1], [50, 100, "All"]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}

} );</script>

<script type="text/javascript">$('#sampleTable3').DataTable({
//�������±�һ������һ�д�0��ʼ����������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 3, "desc" ]],
"aLengthMenu": [[50, 100, -1], [50, 100, "All"]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}

} );</script>

  </body>
</html>