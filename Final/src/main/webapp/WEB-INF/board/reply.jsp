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
		var name=$('#name').val();
		if(name.trim()=="")
		{
			$('#name').focus();
			$('#name').val("");
			return;
		}
		var subject=$('#subject').val();
		if(subject.trim()=="")
		{
			$('#subject').focus();
			$('#subject').val("");
			return;
		}
		var content=$('#content').val();
		if(content.trim()=="")
		{
			$('#content').focus();
			$('#content').val("");
			return;
		}
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
    <h2>답변하기</h2>
    <p>&nbsp;</p>
    <form method=post action="board_reply_ok.do" id="frm">
    
          <table id="table_content" class="table_bottom">
           <tr>
            <td width=15% align="right">이름</td>
            <td width=85% align="left">
             <input type="text" name=name size=30 id="name">
             <input type="hidden" name="pno" value="${no }">
             <input type="hidden" name="page" value="${page }">
            </td>
           </tr>
           <tr>
            <td width=15% align="right">제목</td>
            <td width=85% align="left">
             <input type="text" name=subject size=70 id="subject">
            </td>
           </tr>
           <tr>
            <td width=15% align="right">내용</td>
            <td width=85% align="left">
             <textarea rows="10" cols="70" name=content id="content"></textarea>
            </td>
           </tr>
           <tr>
            <td width=15% align="right">비밀번호</td>
            <td width=85% align="left">
             <input type="password" size=30 name=pwd id="pwd">
            </td>
           </tr>
           <tr>
            <td colspan="2" align="center">
             <input type="button" value="답변" id="sendBtn">
             <input type="button" value="취소"
              onclick="javascript:history.back()">
            </td>
           </tr>
          </table>
        
    </form>
   </center>
</body>
</html>