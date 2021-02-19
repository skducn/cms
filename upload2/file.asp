<!-- #include file="upfile_class.asp" -->


<%
dim upfile

dim SaveFilename

'建立上传对象

set upfile=new upfile_class

'取得上传数据,限制最大上传10M 计算方法为 10240000/1000000=10.24M

upfile.GetData (10240000)

'判决是否出错

if upfile.isErr then

select case upfile.err

case 1

Response.Write "你没有上传数据呀???是不是搞错了??"

case 2

Response.Write "你上传的文件超出我们的限制,最大10M"

end select

else

'执行保存文件代码

upfile.SaveToFile "img","d:\"&upfile.file("img").filename

'执行自动保存文件代码，SaveFilename为保存的文件名

SaveFilename=upfile.AutoSave("img","d:\")

'销毁对像

set upfile=nothing

end if

%>





