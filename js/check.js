function saveSuccess()
{   	
	$.notify({
		title: "&nbsp;&nbsp;",
		message: "保存成功",
		icon: 'fa fa-check' 
	},{
		type: "success"
	});
}

function articleCheck()
{
	if (addForm.cName.value == "")
	{
	$.notify({
	title: "&nbsp;&nbsp;",
	message: "文章标题不能为空！",
	icon: 'fa fa-remove' 
	},{
	type: "danger"
	});		
	addForm.cName.focus();
	return false;
	}
  
	if (addForm.cContent.value == "")
	{
	$.notify({
	title: "&nbsp;&nbsp;",
	message: "文章内容不能为空",
	icon: 'fa fa-remove' 
	},{
	type: "danger"
	});	
	addForm.cContent.focus();
	return false;
	}

	$.notify({
	title: "&nbsp;&nbsp;",
	message: "提交成功",
	icon: 'fa fa-check' 
	},{
	type: "success"
	});
}



function checkShare()
{   	
$.notify({
title: "&nbsp;&nbsp;",
message: "已共享",
icon: 'fa fa-check' 
},{
type: "success"
});
setTimeout(parent.parent.location.reload(),100000);
}



function checkNoShare()
{   	
$.notify({
title: "&nbsp;&nbsp;",
message: "已取消共享",
icon: 'fa fa-check' 
},{
type: "success"
});
setTimeout(parent.parent.location.reload(),100000);
}



function shortcutKeyCheck()
{   
  
	if (addForm1.keyName.value == "")
	{
	$.notify({
	title: "温馨提示： ",
	message: "快捷键名称不能为空！",
	icon: 'fa fa-remove' 
	},{
	type: "danger"
	});		
	addForm1.keyName.focus();
	return false;
	}
  
	if (addForm1.keyLink.value == "")
	{
	$.notify({
	title: "温馨提示： ",
	message: "快捷键地址URL不能为空！",
	icon: 'fa fa-remove' 
	},{
	type: "danger"
	});	
	addForm1.keyLink.focus();
	return false;
	}
	
		$.notify({
		title: "&nbsp;&nbsp;",
		message: "保存成功",
		icon: 'fa fa-check' 
	},{
		type: "success"
	});   

}