  $('#demoExit').click(function(){
	swal({
		title: "�Ƿ��˳�ϵͳ?",
		text: "",
		type: "warning",
		showCancelButton: true,
		confirmButtonText: "ȷ��",
		cancelButtonText: "������˼",
		closeOnConfirm: false,
		closeOnCancel: false
	}, function(isConfirm) {
		if (isConfirm) {
			swal("�ټ�", "Bye Bye", "success");
			setTimeout("window.location.href='indexExit.html';",1000); 
			
		} else {
			swal("����...", "", "success");
		}
	});
  });
  $('#demoExit1').click(function(){
	swal({
		title: "�Ƿ��˳�ϵͳ?",
		text: "",
		type: "warning",
		showCancelButton: true,
		confirmButtonText: "ȷ��",
		cancelButtonText: "������˼",
		closeOnConfirm: false,
		closeOnCancel: false
	}, function(isConfirm) {
		if (isConfirm) {
			swal("�ټ�", "Bye Bye", "success");
			setTimeout("window.location.href='indexExit.html';",1000); 
			
		} else {
			swal("����...", "", "success");
		}
	});
  });