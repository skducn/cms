<!--#include file="bFrame.asp"-->
<%=bMain%>


<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.4.8/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
<!-- if using RTL (Right-To-Left) orientation, load the RTL CSS file after fileinput.css by uncommenting below -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/4.4.8/css/fileinput-rtl.min.css" media="all" rel="stylesheet" type="text/css" /-->
<title><%=cstCompany%> | �༭��</title>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>
	�����
	<small>Group panel</small>
	</h1>
	<ol class="breadcrumb">
	<li><a href="bMain.asp"><i class="fa fa-align-justify"></i> Home</a></li>
	</ol>
	</section>



<!--  �༭��	-->

<% if request("action")="save" then 
	groupId = request("groupId")
	groupName = request("groupName")
	groupState = request("groupState")
	
	'����ȥ��
	dim isRepeat
	isRepeat = 0
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tblGroup where groupId<>"&groupId&" ",conn,3,3
	do while not rs1.eof
		if rs1("groupName") = groupName then
		    isRepeat = 1
		end if 
	rs1.movenext
	loop
	rs1.close
	set rs1 = nothing
	
	if isRepeat = 0  then
		set rs = server.CreateObject("ADODB.RecordSet")
		rs.Open "select * from tblGroup where groupId="&groupId&"",conn,3,3
		rs("groupName") = groupName
		rs("groupState") = groupState
		rs.update
		rs.close
		set rs = nothing 
		response.Write("<script>;alert('����ɹ�');window.location.href='bGroupEdit.asp?groupId="&groupId&"';</script>")
	else
		response.Write("<script>;alert('��ܰ��ʾ���༭ʧ�ܣ������ظ���');window.location.href='bGroupEdit.asp?groupId="&groupId&"';</script>")
	end if 		
end if 
%>

<form role="form" action="bGroupEdit.asp?action=save" method="post" >

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-danger box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title">�༭��</h3>
				</div>
				<%
				groupId = request("groupId")
				set rs = server.CreateObject("ADODB.RecordSet")
				rs.Open "select * from tblGroup where groupId="&groupId&"",conn,3,3
				%>
				<div class="box-body">
					

					
					<div class="col-xs-3">
						<div class="form-group">
						<label>������ *</label>
						<input type="text" name="groupName" maxlength="15" class="form-control" value="<%=rs("groupName")%>">
						</div>
					</div>
				
				    <div class="col-xs-3"> </div>

					<div class="col-xs-3">
						<div class="form-group">
							<label>��״̬</label>
							<% if rs("groupState") = "on" then %>
								<div class="radio">
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="groupState" value="on" checked>����</label></div>
								<div class="radio">	<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="groupState"  value="off">�ر�</label>	
								</div>																								
							<% elseif rs("groupState") = "off" then %>
								<div class="radio">
									<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="groupState" value="on" >����</label></div>
								<div class="radio">	<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="groupState"  value="off" checked>�ر�</label>
								</div>
							<%end if %>
						</div>
					</div>
				
		
					<div class="col-xs-12">
					<br>
						<button type="submit" class="btn btn-danger pull-right" style="margin-right: 5px;"  href="#">����</button>
						<br><br>
						<input name="groupId" type="hidden" value="<%=groupId%>" />						
					</div>
						
				</div>
			</div>	 
		</div> <!-- /.col -->
	</div><!-- /.row -->
	

					
</section><!-- /.content -->

</form>

</div>
<!-- ./wrapper -->



<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- file input -->
<script src="../css_fileinput/fileinput.js" type="text/javascript"></script>


<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="../plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="../plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="../plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="../plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="../plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="../plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>




</body>
</html>


