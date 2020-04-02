<!--#include file="bFrame.asp"-->


<!--  BeAlert美化alert	-->	
<link rel="stylesheet" href="../beAlert/BeAlert.css">
<script src="../beAlert/jquery.min.js"></script>
<script src="../beAlert/BeAlert.js"></script>


<%=bMain%>

<title><%=cstCompany%> | 编辑用户</title>

   
        
</script>

<script type="text/javascript">
   	function alertSave()
	{	
          alert("Hello world!", "welcome to my world :)", function () {
                //after click the confirm button, will run this callback function
            }, {type: 'success', confirmButtonText: 'OK'});
      }　　
    /*用window.onload调用myfun()*/　
    　
    // 不要括号
    window.onload = alertSave;
</script>




</body>
</html>


