<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>Simple demo</title>
		<script type="text/javascript" src="scripts/swfobject.js"></script>
		<script type="text/javascript" src="scripts/fullAvatarEditor.js"></script>


    </head>
    <body>
		<div style="width:630px;margin: 0 auto;">
			<h1 style="text-align:center">富头像上传编辑器演示</h1>
			<div>
				<p id="swfContainer">
				</p>
			</div>
			<p style="text-align:center"><button type="button" id="upload">自定义上传按钮</button></p>
			<p style="text-align:center">提示：本演示使用的上传接口类型为ASP，如要测试上传，请在服务器环境中演示，更多演示请看<a href="http://www.fullavatareditor.com/demo.html">http://www.fullavatareditor.com/demo.html</a></p>
        </div>
		<script type="text/javascript">
            swfobject.addDomLoadEvent(function () {
                var swf = new fullAvatarEditor("swfContainer", {
					    id: 'swf',
						upload_url: 'asp/Upload.asp',
						src_upload:2
					}, function (msg) {
						switch(msg.code)
						{
							case 1 : alert("页面成功加载了组件！");break;
							case 2 : alert("已成功加载默认指定的图片到编辑面板。");break;
							case 3 :
								if(msg.type == 0)
								{
									alert("摄像头已准备就绪且用户已允许使用。");
								}
								else if(msg.type == 1)
								{
									alert("摄像头已准备就绪但用户未允许使用！");
								}
								else
								{
									alert("摄像头被占用！");
								}
							break;
							case 5 : 
								if(msg.type == 0)
								{
									if(msg.content.sourceUrl)
									{
										alert("原图已成功保存至服务器，url为：\n" +　msg.content.sourceUrl);
									}
									alert("头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls.join("\n"));
								}
							break;
						}
					}
				);
				document.getElementById("upload").onclick=function(){
					swf.call("upload");
				};
            });
			var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
			document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5f036dd99455cb8adc9de73e2f052f72' type='text/javascript'%3E%3C/script%3E"));
        </script>
    </body>
</html>