<!--#include file="bFrame.asp"-->
<%=bMain%>

<%if session("userPower") = 1 then%>
	<title><%=cstCompany%> | 超管设置</title>
<%elseif session("userPower") = 3 then%>
	<title><%=cstCompany%> | 管理员设置</title>
<%else%>
	<title><%=cstCompany%> | 用户设置</title>
<%end if %>



          
<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title">Modals / Popups</h1>
			<p class="text-muted m-0 desc">Slides &amp; Modals examplaes</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 



	<div class="content">
	
		<div class="card mb-4">
			<a data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample" class="card-header text-dark  py-3">
			<span class="mr-2"></span>)</a>
			<div class="collapse" id="collapseExample">
				<div class="card-body">
									
		<!-- 用户仪表盘-->

		<div class="row">
			<div class="col-lg-6 ">
				<div class="card mb-4">
					<div class="card-header">用户类别标签列表</div>
					<div class="card-body">
							3333333333333333333333
					</div><!-- card-body --> 
				</div><!-- card mb-4 --> 
			</div><!-- col-lg-6 --> 
		</div><!-- row --> 
		
				</div>
			</div>
		</div>
	</div>	

</div>
<section>




  
      

 


      <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Basic Modal</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span class="material-icons ">close</span>
              </button>
            </div>
            <div class="modal-body">
              <p>123Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur et quam velit. Ut pellentesque felis non ante dictum, at bibendum ligula dapibus. Nam vitae purus vulputate, facilisis erat gravida, rutrum magna. Duis eleifend nunc a justo fringilla suscipit. Cras sit amet ornare purus, vitae congue tortor. Fusce lacinia, purus ac semper venenatis, nunc tellus blandit arcu, eget lacinia ante nisl id tellus. Duis vel justo nibh.
				<a href="www.baidu.com" >12321321321312</a><br>
		
			  </p>

              <p>In hac habitasse platea dictumst. Integer a lacus iaculis ipsum consequat pretium a non tortor. Nullam quis consequat libero. Ut iaculis non dui vitae gravida.</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
          </div>
        </div>
      </div>

      

    


  </body>
</html>