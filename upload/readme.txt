asp上传头像

1，将upload目录放在网站的根目录

2，在文件中加载js, 如demo.asp中。
<!--  上传头像	-->	
<script type="text/javascript" src="../upload/js/swfobject.js"></script>
<script type="text/javascript" src="../upload/js/fullAvatarEditor.js"></script>

3，文件中 需要传入当前userId号，如： ../upload/Upload.asp?userId=<%=session("userId")%>
<!--  上传头像 -->
<script type="text/javascript">
	swfobject.addDomLoadEvent(function () {var swf = new fullAvatarEditor("swfContainer", {
	id: 'swf',upload_url: '../upload/Upload.asp?userId=<%=session("userId")%>',src_upload:2}, function (msg) {switch(msg.code){
	//case 1 : alert("页面成功加载了组件！");break;
	//case 2 : alert("已成功加载默认指定的图片到编辑面板。");break;
	case 3 :
	if(msg.type == 0){alert("温馨提示","摄像头已准备就绪且用户已允许使用", function () {}, {type: 'success', confirmButtonText: '确定'});}
	else if(msg.type == 1){alert("温馨提示","摄像头已准备就绪但用户未允许使用!", function () {}, {type: 'warning', confirmButtonText: '确定'});}
	else{alert("温馨提示","摄像头被占用!", function () {}, {type: 'warning', confirmButtonText: '确定'});}
	break;
	case 5 : 
	if(msg.type == 0){if(msg.content.sourceUrl){alert("原图已成功保存至服务器，url为：\n" +　msg.content.sourceUrl);
	alert("温馨提示","原图已成功保存至服务器，url为：\n" +　msg.content.sourceUrl, function () {}, {type: 'success', confirmButtonText: '确定'});}
	//alert("头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls);
	}break;}});
	document.getElementById("upload").onclick=function(){swf.call("upload");};});
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5f036dd99455cb8adc9de73e2f052f72' type='text/javascript'%3E%3C/script%3E"));
</script>

4，调用upload/Upload.asp
需要conn.asp 链接数据库，将生成的图片名称写入数据库。

5，fullAvatarEditor.js 中可设置2个文件的加载路径。
var file= '../upload/fullAvatarEditor.swf';		//flash文件的路径
var expressInstall= '../upload/expressInstall.swf';	//expressInstall.swf的路径