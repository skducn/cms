function dashboardCheck()
{
	// 快捷名称
	if (addForm.keyName.value == ""){
		alert("温馨提示，快捷名称不能为空！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.keyName.focus();
		return false;}	
	// 快捷链接
	if (addForm.keyLink.value == ""){
		alert("温馨提示，快捷链接不能为空！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.keyLink.focus();
		return false;}
	
	var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
