<%
	dim conn
	dim connstr
	dim db
	db ="/db/cms.mdb"
	Set conn = Server.CreateObject("ADODB.Connection")

	'connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(db)  '2003�汾��Access���������ַ�����
	'�����ķ��������ý��ϰ汾Access�����������������ӷ���
	'connstr="driver={Microsoft Access Driver (*.mdb)};dbq=" & Server.MapPath(db)
	'connstr = "provider=microsoft.ace.oledb.12.0;Data Source=" & Server.MapPath(db)   '2007�汾��Access���������ַ���ӦΪ��
	connstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath(db)

	conn.Open connstr
%>
