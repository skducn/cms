function CheckShortAdd()
{   
  
    if (addForm1.keyName.value == "")
  {
  	$.notify({
		title: "温馨提示： ",
		message: "快捷键名称不能为空！",
		icon: 'fa fa-check' 
	},{
		type: "warning"
	});		
	  addForm1.keyName.focus();
	  return false;
  }
  
	if (addForm1.keyLink.value == "")
  {
	  $.notify({
		title: "温馨提示： ",
		message: "快捷键地址URL不能为空！",
		icon: 'fa fa-check' 
	},{
		type: "warning"
	});	
	  addForm1.keyLink.focus();
	  return false;
  }

}