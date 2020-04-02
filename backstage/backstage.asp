<!--#include file="admFrame.asp"-->
<%=returnAdmMain%>
<%
if session("userName") <> "admin" then
Session.Abandon()
response.Redirect "../index.asp"
end if 
%>

<title><%=cstCompany%> | 后台</title>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>测试用例执行一览表
	<small></small>
	</h1>
	
	<ol class="breadcrumb">
	<li><a href="admMain.asp"><i class="fa fa-align-justify"></i> Home</a></li>
	</ol>
	</section>

	<% if request("action") = "save" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
	rs("userMemo") = request("userMemo")
	rs.update
	rs.close
	set rs = nothing
	end if %>

	<form id="form1" name="form1" method="post" action="admMain.asp?action=save">

	<!-- Main content -->
    <section class="content">
	
	
		<!-- Small boxes (Stat box) -->
	<div class="row">
	
		<!-- 显示 执行用例情况（规则：当100%时可点击创建测试报告） -->
	  	<%
		set rs7 = server.createobject("adodb.recordset")
		rs7.open "select * from tbl_user  order by userId desc",conn,3,3
		do while not rs7.eof
					
			varNoResult = 0 
			set rs = server.createobject("adodb.recordset")
			rs.open "select * from tbl_project where pjtStatus='1' order by pjtId desc",conn,3,3
			do while not rs.eof
				set rs1 = server.createobject("adodb.recordset")
				rs1.open "select * from tbl_platform where plat_pjtId="&rs("pjtId")&" and platformStatus<>'2' and plat_rptStatus is null order by platformId desc",conn,3,3
				do while not rs1.eof
					set rs2 = server.createobject("adodb.recordset")
					rs2.open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' order by caseId desc",conn,3,3
					varRecord = rs2.recordcount
					if varRecord <> 0 then
						do while not rs2.eof
							if rs2("caseResult") <> "empty" or rs2("caseStatus") <> "1" then
								varNoResult = varNoResult + 1
							end if 
						rs2.movenext
						loop %>
	
						<div class="col-xs-4">
						
						 <!-- /.info-box -->
						 <% var1 = int(varNoResult/varRecord*100)%>
						 <% if var1 < 30 then %> 
							  <div class="info-box bg-red">
						 <% elseif  var1 < 80 then %> 
							  <div class="info-box bg-yellow">
						 <% else %> 
							  <div class="info-box bg-green">	
						 <%end if %>
							<span class="info-box-icon"><h3><%=rs7("userNickName")%></h3></span>
									<div class="info-box-content">
									   <span class="info-box-number"><%=rs("pjtName")%>&nbsp;&nbsp;<%=rs1("platformName")%></span>
									  <span class="info-box-text"><%=varNoResult%> / <%=varRecord%>，完成度：<b><%=var1%> %</b></span>
										
									  <div class="progress">
										<div class="progress-bar" style="width: <%=var1%>%"></div>
									  </div>
										  <span class="progress-description">										
										
									<%
									Set rs70 = Server.CreateObject("Adodb.Recordset")
									Set rs78 = Server.CreateObject("Adodb.Recordset")
									Set rs79 = Server.CreateObject("Adodb.Recordset")
									rs70.Open "select * from tbl_label where lbl_pjtId="&rs("pjtId")&" and lbl_platformId="&rs1("platformId")&" order by lblId asc",conn,3,3 
									rs78.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' and caseStage=1 order by caseId asc",conn,3,3 
									rs79.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' and caseStage=2 order by caseId asc",conn,3,3 
									if rs78.recordcount > 0 then %>
										<a href="../excTestcaseTa.asp?pjtId=<%=rs("pjtId")%>&platformId=<%=rs1("platformId")%>&lblId=<%=rs70("lblId")%>&caseStage=1" class="text-black">  执行用例 </a> 
									<%elseif rs79.recordcount > 0 then%>
										<a href="../excTestcaseTa.asp?pjtId=<%=rs("pjtId")%>&platformId=<%=rs1("platformId")%>&lblId=<%=rs70("lblId")%>&caseStage=2" class="text-black">  执行用例 </a>												
									<%else%>
										<a href="../excTestcaseTa.asp?pjtId=<%=rs("pjtId")%>&platformId=<%=rs1("platformId")%>&lblId=<%=rs70("lblId")%>&caseStage=3" class="text-black">  执行用例 </a>
									<% end if %>
									
											 <% if var1 = 100 then 
													set rs9 = server.createobject("adodb.recordset")
													rs9.open "select * from tbl_report where rpt_pjtId="&rs("pjtId")&" and rpt_platformId="&rs1("platformId")&" order by rptId desc",conn,3,3 
													if rs9.recordcount = 0 then
														response.write "&nbsp;&nbsp;《报告未创建》"				
													else
														if rs9("rptStatus") = "undone" then 			
															response.write "&nbsp;&nbsp;《报告待审核》"															
														end if 
													end if 
											 end if %>
										  </span>
									</div><!-- /.info-box-content -->
								</div>
							</div><!-- /.col -->
					<% end if 
					varNoResult = 0
				rs1.movenext
				loop
			rs.movenext
			loop%>
			<!-- 不同用户之间换行 -->
			<div class="row">
			<div class="col-xs-12"></div>
			</div>
						
		<%rs7.movenext
		loop%>		
	</div><!-- /.row -->

	
	<div class="row">
		<div class="col-xs-12">
		<%
		set rs8 = server.createobject("adodb.recordset")
		rs8.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
		userMemo = rs8("userMemo")		
		rs8.close
		set rs8 = nothing
		%>
		<label>管理员的备忘录</label>
		<script type="text/plain" id="userMemo" style="width:100%; height:400px" name="userMemo"><%=userMemo%></script>	
		<script>var editor_a = UE.getEditor('userMemo');</script>
		</div>
	</div>
	<br>
	<button type="submit" class="btn btn-primary pull-right" style="margin-right: 5px;"  href="#"><i class="fa fa-angellist"></i> &nbsp;保存备忘录</button>
	<br><br>
	
    </section>
    <!-- /.content -->
	
	</form>


  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript::;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript::;">
              <i class="menu-icon fa fa-user bg-yellow"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>

                <p>New phone +1(800)555-1234</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript::;">
              <i class="menu-icon fa fa-envelope-o bg-light-blue"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>

                <p>nora@example.com</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript::;">
              <i class="menu-icon fa fa-file-code-o bg-green"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>

                <p>Execution time 5 seconds</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript::;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="label label-danger pull-right">70%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript::;">
              <h4 class="control-sidebar-subheading">
                Update Resume
                <span class="label label-success pull-right">95%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-success" style="width: 95%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript::;">
              <h4 class="control-sidebar-subheading">
                Laravel Integration
                <span class="label label-warning pull-right">50%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript::;">
              <h4 class="control-sidebar-subheading">
                Back End Framework
                <span class="label label-primary pull-right">68%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-primary" style="width: 68%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Allow mail redirect
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Other sets of options are available
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Expose author name in posts
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Allow the user to show his name in blog posts
            </p>
          </div>
          <!-- /.form-group -->

          <h3 class="control-sidebar-heading">Chat Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Show me as online
              <input type="checkbox" class="pull-right" checked>
            </label>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Turn off notifications
              <input type="checkbox" class="pull-right">
            </label>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Delete chat history
              <a href="javascript::;" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
            </label>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
  
</div>
<!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
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


