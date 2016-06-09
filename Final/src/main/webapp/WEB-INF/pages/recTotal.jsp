<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table id="table_content" width=900 border=1 style="color: black;">
			<c:forEach var="vo" items="${movielist }">
				<tr>
					<td rowspan=6><img src="${vo.poster }" width=100%></td>
				</tr>
				<tr>
					<td>${vo.title }</td>
				</tr>
				<tr>
					<td>${vo.genre }</td>
				</tr>
				<tr>
					<td>${vo.reserve }%</td>
				</tr>
				<tr>
					<td>${vo.star }점</td>
				</tr>
				<tr>
					<td>상영시간 : ${vo.movietime }</td>
				</tr>
			</c:forEach>

		</table>
</body>
</html>