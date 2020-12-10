  $('#demoExit').click(function(){
	swal({
		title: "是否退出系统?",
		text: "",
		type: "warning",
		showCancelButton: true,
		confirmButtonText: "确定",
		cancelButtonText: "容我三思",
		closeOnConfirm: false,
		closeOnCancel: false
	}, function(isConfirm) {
		if (isConfirm) {
			swal("再见", "Bye Bye", "success");
			setTimeout("window.location.href='indexExit.html';",1000); 
			
		} else {
			swal("继续...", "", "success");
		}
	});
  });
  $('#demoExit1').click(function(){
	swal({
		title: "是否退出系统?",
		text: "",
		type: "warning",
		showCancelButton: true,
		confirmButtonText: "确定",
		cancelButtonText: "容我三思",
		closeOnConfirm: false,
		closeOnCancel: false
	}, function(isConfirm) {
		if (isConfirm) {
			swal("再见", "Bye Bye", "success");
			setTimeout("window.location.href='indexExit.html';",1000); 
			
		} else {
			swal("继续...", "", "success");
		}
	});
  });