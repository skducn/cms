asp�ϴ�ͷ��

1����uploadĿ¼������վ�ĸ�Ŀ¼

2�����ļ��м���js, ��demo.asp�С�
<!--  �ϴ�ͷ��	-->	
<script type="text/javascript" src="../upload/js/swfobject.js"></script>
<script type="text/javascript" src="../upload/js/fullAvatarEditor.js"></script>

3���ļ��� ��Ҫ���뵱ǰuserId�ţ��磺 ../upload/Upload.asp?userId=<%=session("userId")%>
<!--  �ϴ�ͷ�� -->
<script type="text/javascript">
	swfobject.addDomLoadEvent(function () {var swf = new fullAvatarEditor("swfContainer", {
	id: 'swf',upload_url: '../upload/Upload.asp?userId=<%=session("userId")%>',src_upload:2}, function (msg) {switch(msg.code){
	//case 1 : alert("ҳ��ɹ������������");break;
	//case 2 : alert("�ѳɹ�����Ĭ��ָ����ͼƬ���༭��塣");break;
	case 3 :
	if(msg.type == 0){alert("��ܰ��ʾ","����ͷ��׼���������û�������ʹ��", function () {}, {type: 'success', confirmButtonText: 'ȷ��'});}
	else if(msg.type == 1){alert("��ܰ��ʾ","����ͷ��׼���������û�δ����ʹ��!", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});}
	else{alert("��ܰ��ʾ","����ͷ��ռ��!", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});}
	break;
	case 5 : 
	if(msg.type == 0){if(msg.content.sourceUrl){alert("ԭͼ�ѳɹ���������������urlΪ��\n" +��msg.content.sourceUrl);
	alert("��ܰ��ʾ","ԭͼ�ѳɹ���������������urlΪ��\n" +��msg.content.sourceUrl, function () {}, {type: 'success', confirmButtonText: 'ȷ��'});}
	//alert("ͷ���ѳɹ���������������urlΪ��\n" + msg.content.avatarUrls);
	}break;}});
	document.getElementById("upload").onclick=function(){swf.call("upload");};});
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5f036dd99455cb8adc9de73e2f052f72' type='text/javascript'%3E%3C/script%3E"));
</script>

4������upload/Upload.asp
��Ҫconn.asp �������ݿ⣬�����ɵ�ͼƬ����д�����ݿ⡣

5��fullAvatarEditor.js �п�����2���ļ��ļ���·����
var file= '../upload/fullAvatarEditor.swf';		//flash�ļ���·��
var expressInstall= '../upload/expressInstall.swf';	//expressInstall.swf��·��