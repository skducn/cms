<!-- #include file="upfile_class.asp" -->


<%
dim upfile

dim SaveFilename

'�����ϴ�����

set upfile=new upfile_class

'ȡ���ϴ�����,��������ϴ�10M ���㷽��Ϊ 10240000/1000000=10.24M

upfile.GetData (10240000)

'�о��Ƿ����

if upfile.isErr then

select case upfile.err

case 1

Response.Write "��û���ϴ�����ѽ???�ǲ��Ǹ����??"

case 2

Response.Write "���ϴ����ļ��������ǵ�����,���10M"

end select

else

'ִ�б����ļ�����

upfile.SaveToFile "img","c:\"&upfile.file("img").filename

'ִ���Զ������ļ����룬SaveFilenameΪ������ļ���

SaveFilename=upfile.AutoSave("img","c:\")

'���ٶ���

set upfile=nothing

end if

%>


<form name="form1" method="post" action="" enctype="multipart/form-data">

<input type="text" value="1" name="name">

<input type=file name="img">

<input type=submit name="submit" value="�ύ">

</form>



