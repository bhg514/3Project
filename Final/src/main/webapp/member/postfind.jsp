<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="table.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="../../ajax.js"></script>
<script type="text/javascript">
$(function(){
	$('#postBtn').click(function(){
		var dong=$('#dong').val();
		if(dong.trim()=="")
		{
			$('#dong').focus();
			return;
		}
		var param="dong="+encodeURIComponent(dong);
		sendMessage("POST", "../../postfind_ok.do", param, postfind)
	});
});
function postfind()
{
	if(httpRequest.readyState==4)
	{
		if(httpRequest.status==200)
		{
			alert(httpRequest.responseText);
			$('#postPrint').html(httpRequest.responseText);
		}
	}
}
function post(zip,addr)
{
	parent.join_frm.post1.value=zip.substring(0,3);
	parent.join_frm.post2.value=zip.substring(4,7);
	parent.join_frm.addr1.value=addr;
	parent.Shadowbox.close();
}
</script>
</head>
<body>
  <center>
    <table id="table_content" style="margin-top: 20px;width:450px">
      <tr>
        <td>입력:<input type=text name=dong id="dong" size=15>
            <input type=button value=찾기 id="postBtn">
        </td>
      </tr>
      <tr>
        <td id="postPrint"></td>
      </tr>
    </table>
  </center>
</body>
</html>





