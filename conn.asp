<%
	dim conn
	dim connstr
	dim db
	db ="/db/cms.mdb"
	Set conn = Server.CreateObject("ADODB.Connection")

	'connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(db)  '2003版本的Access数据链接字符串：
	'如果你的服务器采用较老版本Access驱动，请用下面连接方法
	'connstr="driver={Microsoft Access Driver (*.mdb)};dbq=" & Server.MapPath(db)
	'connstr = "provider=microsoft.ace.oledb.12.0;Data Source=" & Server.MapPath(db)   '2007版本的Access数据链接字符串应为：
	connstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath(db)

	conn.Open connstr
%>
