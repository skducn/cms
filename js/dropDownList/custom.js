$(function () {
//Initialize Select2 Elements
$(".select2").select2();
$(".select4").select2();
});


<!-- ���ܣ�����������ѡ�����Ȼ��ѡ���ǩ
<%
'�������ݱ��浽����
Dim count2,rsClass2,sqlClass2
set rsClass2=server.createobject("adodb.recordset")
sqlClass2="select * from tblTag where tagState='on' order by tagName" 
rsClass2.open sqlClass2,conn,1,1
%>
var subval2 = new Array();
//����ṹ��һ����ֵ,������ֵ,������ʾֵ
<%
count2 = 0
do while not rsClass2.eof
%>
subval2[<%=count2%>] = new Array('<%=rsClass2("sortId")%>','<%=rsClass2("tagId")%>','<%=rsClass2("tagName")%>')
<%
count2 = count2 + 1
rsClass2.movenext
loop
rsClass2.close
%>
function changeselect1(locationid)
{
if (document.addForm.tagIdOld.value == "")
{
document.addForm.tagIdOld.value= 0;
}
document.addForm.tagIdOld.length = 0;
document.addForm.tagIdOld.options[0] = new Option('/ ','0');
for (i=0; i<subval2.length; i++)
{
if (subval2[i][0] == locationid)
{document.addForm.tagIdOld.options[document.addForm.tagIdOld.length] = new Option(subval2[i][2],subval2[i][1]);}
}
}
//-->