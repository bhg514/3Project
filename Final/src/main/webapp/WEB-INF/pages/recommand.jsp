<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="table.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	
	$(function() {
		$('#feel').change(function() {
			$('#frm').submit();
		});
	});

	$(function() {
		$('#showtime').change(function() {
			$('#timefrm').submit();
		});
	});
</script> 


</head>
<body>

	<center>
		<br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br>
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-8" style="color: black;">
					<h3>기분에 따른 영화 추천</h3>
					
					<form method="post" action="recommandEmotion.do" id="frm" accept-charset="UTF-8">
						<select name="feel" id="feel">
							<c:forEach var="str" items="${flist }">
								<c:if test="${str==feel }">
									<option selected="selected">${str }</option>
								</c:if>

								<c:if test="${str!=feel }">
									<option>${str }</option>
								</c:if>
							</c:forEach>
						</select>
					</form>
				</div>

				<div class="col-md-8" style="color: black;">
					<h3>시간에 따른 영화 추천</h3>

					<form method="post" action="time.do" id="timefrm"
						accept-charset="UTF-8">
						<select name="showtime" id="showtime">
							<option>--시간--</option>
							<option>오전</option>
							<option>오후</option>
							<option>조조</option>
							<option>심야</option>
						</select>
					</form>
				</div>
			</div>
		</div>
		
		
					<!-- 영화목록+그래프 뿌려줄 곳 -->
		
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
		
		 		
		

		
	</center>
</body>
</html>