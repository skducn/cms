function saveSuccess()
{   	
	$.notify({
		title: "&nbsp;&nbsp;",
		message: "����ɹ�",
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
	message: "���±��ⲻ��Ϊ�գ�",
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
	message: "�������ݲ���Ϊ��",
	icon: 'fa fa-remove' 
	},{
	type: "danger"
	});	
	addForm.cContent.focus();
	return false;
	}

	$.notify({
	title: "&nbsp;&nbsp;",
	message: "�ύ�ɹ�",
	icon: 'fa fa-check' 
	},{
	type: "success"
	});
}



function checkShare()
{   	
$.notify({
title: "&nbsp;&nbsp;",
message: "�ѹ���",
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
message: "��ȡ������",
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
	title: "��ܰ��ʾ�� ",
	message: "��ݼ����Ʋ���Ϊ�գ�",
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
	title: "��ܰ��ʾ�� ",
	message: "��ݼ���ַURL����Ϊ�գ�",
	icon: 'fa fa-remove' 
	},{
	type: "danger"
	});	
	addForm1.keyLink.focus();
	return false;
	}
	
		$.notify({
		title: "&nbsp;&nbsp;",
		message: "����ɹ�",
		icon: 'fa fa-check' 
	},{
		type: "success"
	});   

}