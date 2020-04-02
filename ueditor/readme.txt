asp网站中使用百度ueditor教程
http://www.cnblogs.com/cdxkyz/p/4007782.html

UEditor官网 1.4.3
https://ueditor.baidu.com/website/download.html


设置最大上传附件
IIS7.X
打开 IIS 控制台
双击 ASP，展开限制属性，修改 “最大请求实体主体限制”为需要的值（如51200000 即 50M） > ASP 文件中也有上传文件大小的限制，不过先验证的限制是 IIS 中设置的，所以如果 IIS 中设置最大 256K，那么就算 ASP 中设置了最大 10M，那么超过 256K 的文件也无法上传，而且 ASP 没法给出错误信息。