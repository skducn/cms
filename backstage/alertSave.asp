<!--#include file="bFrame.asp"-->


<!--  BeAlert����alert	-->	
<link rel="stylesheet" href="../beAlert/BeAlert.css">
<script src="../beAlert/jquery.min.js"></script>
<script src="../beAlert/BeAlert.js"></script>


<%=bMain%>

<title><%=cstCompany%> | �༭�û�</title>

   
        
</script>

<script type="text/javascript">
   	function alertSave()
	{	
          alert("Hello world!", "welcome to my world :)", function () {
                //after click the confirm button, will run this callback function
            }, {type: 'success', confirmButtonText: 'OK'});
      }����
    /*��window.onload����myfun()*/��
    ��
    // ��Ҫ����
    window.onload = alertSave;
</script>




</body>
</html>


