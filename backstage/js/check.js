function dashboardCheck()
{
	// �������
	if (addForm.keyName.value == ""){
		alert("��ܰ��ʾ��������Ʋ���Ϊ�գ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.keyName.focus();
		return false;}	
	// �������
	if (addForm.keyLink.value == ""){
		alert("��ܰ��ʾ��������Ӳ���Ϊ�գ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.keyLink.focus();
		return false;}
	
	var gnl=confirm("ȷ��Ҫ�ύ?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
