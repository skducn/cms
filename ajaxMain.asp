<script type="text/javascript">

function ajaxSort(){
	var xmlhttp;
	if (window.XMLHttpRequest)
		{xmlhttp=new XMLHttpRequest();}
	else
		{xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}
		 xmlhttp.onreadystatechange=function()
		{if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{document.getElementById("ajaxSortDiv").innerHTML=xmlhttp.responseText;    }}
		url="ajaxSort.asp?cId=<%=request("cId")%>&sortId=<%=request("sortId")%>&userName=<%=session("userName")%>" +"&sid" + escape( Math.random())
		xmlhttp.open("POST",url,true);
		xmlhttp.send();}


function ajaxTag(str){
	var xmlhttp;    
	if (str=="")
		{document.getElementById("txtHint").innerHTML="";
		return;}
	if (window.XMLHttpRequest)
		{xmlhttp=new XMLHttpRequest();}
	else
		{xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}
		xmlhttp.onreadystatechange=function()
		{if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{document.getElementById("ajaxTagDiv").innerHTML=xmlhttp.responseText;}}
		url = "ajaxTag.asp?sortId=" + str + "&sid" + escape( Math.random())
		xmlhttp.open("POST",url,true);
		xmlhttp.send();}


function ajaxInfo(str2){
	var xmlhttp2;    
	if (str2==""){
		document.getElementById("txtHint2").innerHTML="";
		return;}
	if (window.XMLHttpRequest)
		{xmlhttp2=new XMLHttpRequest();  }
	else
		{xmlhttp2=new ActiveXObject("Microsoft.XMLHTTP");  }
		xmlhttp2.onreadystatechange=function()
		{if (xmlhttp2.readyState==4 && xmlhttp2.status==200)
		{document.getElementById("ajaxInfoDiv").innerHTML=xmlhttp2.responseText;    }  }
		url="ajaxInfo.asp?tagId=" + str2 + "&cId=<%=request("cId")%>" + "&sortId=<%=request("sortId")%>" + "&sid" + escape( Math.random())
		xmlhttp2.open("POST",url,true);
		xmlhttp2.send();}


</script>
