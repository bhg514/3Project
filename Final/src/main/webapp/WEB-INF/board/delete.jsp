<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../table_pink.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
/*
 *   selector : 내장객체 , 태그명( $('태그명')=>$('tr')) , 
                ID명 ($('#ID명')) ,
                Class명 ($('.class명'))
             $(document)
 */
$(function(){
	$('#sendBtn').click(function(){
		// ~~
		var pwd=$('#pwd').val();
		if(pwd.trim()=="")
		{
			$('#pwd').focus();
			$('#pwd').val("");
			return;
		}
		
		$('#frm').submit();
	});
});
</script>
</head>
<body>
  <center>
    <h2>삭제하기</h2>
    <p>&nbsp;</p>>
    <form method=post action="board_delete_ok.do" id="frm">
    
          <table id="table_content" class="table_bottom">
           
           <tr>
            <td align="center">
            비밀번호&nbsp;&nbsp;
             <input type="password" size=20 name=pwd id="pwd">
             <input type="hidden" name="no" value="${no }">
             <input type="hidden" name="page" value="${page }">
            </td>
           </tr>
           <tr>
            <td colspan="2" align="center">
             <input type="button" value="삭제" id="sendBtn">
             <input type="button" value="취소"
              onclick="javascript:history.back()">
            </td>
           </tr>
          </table>
        
    </form>
   </center>
</body>
</html>