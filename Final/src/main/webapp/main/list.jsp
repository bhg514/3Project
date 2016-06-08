<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="table.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
<!-- if else 는 funtion2개-->
$(function(){
	var i = 0;
	$('.aImg').hover(function(){
		i = $(this).attr("value");
		$('#m'+i).css({"opacity":0.2});
	},function(){
		$('#m'+i).css({"opacity":1});
	});
});
</script>
</head>
<body>
<center>
	<h3>영화 목록</h3>
	<table id="table_content" style="width:900px;">
		<tr>
			<td align=right>
				<a href="../board/board_list.do">커뮤니티</a>
			</td>
			<td align=right>
				<a href="total.do">영화시각화</a>
			</td>
		</tr>
	</table>
	<table id="table_content" style="width:900px;">
		<tr>
		<c:forEach var="vo" items="${list }">
				<td class="tdcenter">
					<a href="detail.do?no=${vo.no}" class="aImg" value="${vo.no }">
					<img src="${vo.image }" width=100 height=150 border=0 id="m${vo.no }"></a>
				</td>
		</c:forEach>
		</tr>
		<tr>
		<c:forEach var="vo" items="${list }">
				<td class="tdcenter">
					${vo.title }
				</td>
		</c:forEach>
		</tr>
		<tr>
		<c:forEach var="vo" items="${list }">
				<td class="tdcenter">
					${vo.regdate }
				</td>
		</c:forEach>
		</tr>
		<tr>
		<c:forEach var="vo" items="${list }">
				<td class="tdcenter">
					예매율:${vo.reserve }%
				</td>
		</c:forEach>
		</tr>
		<tr>
		<c:forEach var="vo" items="${list }">
				<td class="tdcenter">
					별점:${vo.star }
				</td>
		</c:forEach>
		</tr>
		<tr>
		<c:forEach var="vo" items="${list }">
				<td class="tdcenter">
					♥&nbsp;${vo.like }
				</td>
		</c:forEach>
		</tr>
	</table>
	<table border=0 style="width:900px;">
		<tr>
			<td>
				<table id="table_content" width=280>
					<tr>
						<th>영화 Rank</th>
					</tr>
					<c:forEach var="s" items="${raList }" varStatus="status">
					<tr><td>${status.index+1}&nbsp;${s }</td></tr>
					</c:forEach>
				</table>
			</td>
			<td>
				<table id="table_content" width=280>
					<tr>
						<th>영화 Reserve</th>
					</tr>
					<c:forEach var="s" items="${reList }" varStatus="status">
					<tr><td>${status.index+1}&nbsp;${s }</td></tr>
					</c:forEach>
				</table>
			</td>
			<td>
				<table id="table_content" width=280>
					<tr>
						<th>영화 BoxOffice</th>
					</tr>
					<c:forEach var="s" items="${bList }" varStatus="status">
					<tr><td>${status.index+1}&nbsp;${s }</td></tr>
					</c:forEach>
				</table>
			</td>
		</tr>
	</table>
</center>
</body>
</html>