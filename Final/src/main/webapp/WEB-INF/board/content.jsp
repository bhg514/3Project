<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../table.css">
</head>
<body>
  <center>
    <h3>내용보기</h3>
    <table id="table_content">
      <tr height=27>
        <th width=20%>번호</th>
        <td width=30% align=center>${dto.no }</td>
        <th width=20%>작성일</th>
        <td width=30% align=center>${dto.regdate }</td>
      </tr>
      <tr height=27>
        <th width=20%>이름</th>
        <td width=30% align=center>${dto.name }</td>
        <th width=20%>조회수</th>
        <td width=30% align=center>${dto.hit }</td>
      </tr>
      <tr height=27>
        <th width=20%>제목</th>
        <td width=30% align=left colspan="3">${dto.subject }</td>
      </tr>
      <tr>
        <td colspan="4" align="left" valign="top" height=200>
          <pre>${dto.content }</pre>
        </td>
      </tr>
    </table>
    <table border=0 width=600>
      <tr>
       <td align=right>
         <a href="board_reply.do?no=${dto.no }&page=${page}">
         <%--
                     request
            reply.do ======> DispatcherServlet(Controller)
                             Controller = request
                                              request
                             =====> ReplyModel(처리) =====> 
                             DispatcherServlet(Controller)
                              ==> jsp
                                                                                        
                                                                                     
                                 
                            
         --%>
         <img src="../image/btn_reply.gif"></a>
         <a href="board_update.do?no=${dto.no }&page=${page}">
         <img src="../image/btn_modify.gif"></a>
         <a href="board_delete.do?no=${dto.no }&page=${page}">
         <img src="../image/btn_delete.gif"></a>
         <a href="board_list.do?page=${page }">
         <img src="../image/btn_list.gif" border=0></a>
       </td>
      </tr>
    </table>
  </center>
</body>
</html>





