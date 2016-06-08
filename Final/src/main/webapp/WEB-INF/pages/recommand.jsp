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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart);
  function drawChart() {

    var data = google.visualization.arrayToDataTable([
      ['영화명', '감성'],
      <c:forEach var="vo" items="${mflist}">
      	['<c:out value="${vo.title}"/>',<c:out value="${vo.count}"/>],
      </c:forEach>
    ]);

    var options = {
      title: '영화 추천'
    };

    var chart = new google.visualization.PieChart(document.getElementById('piechart'));

    chart.draw(data, options);
  }

$(function(){
	$('#feel').change(function(){
		$('#frm').submit();
	});
});
</script>
</head>
<body>
<center>
	<h2>추천영화</h2>
	<table id="table_content" style="width:600px;">
		<tr>
			<td>
				<form method="post" action="recommand.do" id=frm>
				검색:<select name="feel" id="feel">
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
			</td>
			<td>
				시간
				:<select>
				<option>--시간--</option>
				<option>오전</option>
				<option>오후</option>
				<option>조조</option>
				<option>심야</option>
				</select>
			</td>
		</tr>
	</table>
	<table id="table_content" style="width:600px;">
		<tr>
		<c:forEach var="vo" items="${list }">
			<td class="tdcenter">
				<a href="detail.do?no=${vo.no }">
				<img src="${vo.image }" border=0></a>
			</td>
		</c:forEach>
		</tr>
		<tr>
		<c:forEach var="vo" items="${list }">
			<td class="tdcenter">
				<h3>${vo.title }</h3>
			</td>
		</c:forEach>
		</tr>
	</table>
	<table id="table_content" style="width:600px;">
		<tr>
			<td align=right>
				<a href="list.do">목록</a>
			</td>
		</tr>
	</table>
	<table id="table_content" width=600>
		<tr>
			<td align=center>
				<div id="piechart" style="width: 600px; height: 500px;"></div>
			</td>
		</tr>
	</table>
	<%-- <table id="table_content" width=900 border=1>
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
		
	</table> --%>
</center>
</body>
</html>