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
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);
	function drawChart() {

		var data = google.visualization.arrayToDataTable([
				[ '영화명', '감성' ],
				<c:forEach var="vo" items="${mflist}">[
						'<c:out value="${vo.title}"/>',
						<c:out value="${vo.count}"/>], </c:forEach> ]);

		var options = {
			title : '영화 추천'
		};

		var chart = new google.visualization.PieChart(document
				.getElementById('piechart'));

		chart.draw(data, options);
	}

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
					<form method="post" action="recommand.do" id=frm>
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
							<option>야간</option>
						</select>
					</form>
				</div>

				<div class="col-md-4" style="color: black;">
					<button value="현재 상영작 리스트"></button>
					<h2>현재 상영작 리스트</h2>
				</div>
			</div>
		</div>






		<h2 style="color: black;">현재 상영작 리스트</h2>

		<%-- <table id="table_content" style="width: 600px;">
			<tr>
				<c:forEach var="vo" items="${list }">
					<td class="tdcenter"><a href="detail.do?no=${vo.no }"> <img
							src="${vo.poster }" border=0></a></td>
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
		
		
		
		<table id="table_content" width=600>
			<tr>
				<td align=center>
					<div id="piechart" style="width: 600px; height: 500px;"></div>
				</td>
			</tr>
		</table> --%>
		
		<table class="table table-hover">
		<thead>
			<tr>
				<td rowspan="6">포스터</td>
				<td>No.</td>
				<td>제목</td>
				<td>장르</td>
				<td>예약순위</td>
				<td>평점</td>
				<td>상영시간</td>
			</tr>
			<tr>
				<td colspan="6">data1</td>
				<td>data2</td>
				<td>data3</td>
				<td>data4</td>
				<td>data5</td>
				<td>data6</td>
			</tr>
		</thead>
		</table>
	


		<div class="container">
			<h2>현재 상영작 정보</h2>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>포스터</th>
						<th>No.</th>
						<th>제목</th>
						<th>장르</th>
						<th>예약순위</th>
						<th>평점</th>
						<th>상영시간</th>
					</tr>
				</thead>
				<c:forEach var="vo" items="${movielist }">
					<tbody>
						<tr>
							<td rowspan=6><img src="${vo.poster }" width=100%></td>
							<td>${vo.no }</td>
							<td>${vo.title }</td>
							<td>${vo.genre }</td>
							<td>${vo.reserve }%</td>
							<td>${vo.star }점</td>
							<td>상영시간 : ${vo.movietime }</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</div>


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