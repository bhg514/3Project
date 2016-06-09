<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="table.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var activeSystemClass = $('.list-group-item.active');

						//something is entered in search form
						$('#system-search')
								.keyup(
										function() {
											var that = this;
											// affect all table rows on in systems table
											var tableBody = $('.table-list-search tbody');
											var tableRowsClass = $('.table-list-search tbody tr');
											$('.search-sf').remove();
											tableRowsClass
													.each(function(i, val) {

														//Lower text for case insensitive
														var rowText = $(val)
																.text()
																.toLowerCase();
														var inputText = $(that)
																.val()
																.toLowerCase();
														if (inputText != '') {
															$(
																	'.search-query-sf')
																	.remove();
															tableBody
																	.prepend('<tr class="search-query-sf"><td colspan="6"><strong>Searching for: "'
																			+ $(
																					that)
																					.val()
																			+ '"</strong></td></tr>');
														} else {
															$(
																	'.search-query-sf')
																	.remove();
														}

														if (rowText
																.indexOf(inputText) == -1) {
															//hide rows
															tableRowsClass
																	.eq(i)
																	.hide();

														} else {
															$('.search-sf')
																	.remove();
															tableRowsClass
																	.eq(i)
																	.show();
														}
													});
											//all tr elements are hidden
											if (tableRowsClass
													.children(':visible').length == 0) {
												tableBody
														.append('<tr class="search-sf"><td class="text-muted" colspan="6">No entries found.</td></tr>');
											}
										});
					});
</script>


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

	<div class="container">
		<div class="row">
			<br> <br> <br> <br> <br> <br>
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-8">
						<table class="table_content" width="1000px">
							<tr>
								<td>
									<h3>기분에 따른 영화 추천</h3>
								</td>
								<td>
									<form method="post" action="recommand.do" id=frm>
										<select name="feel" id="feel" style="width: 150px;">
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
								<td rowspan="2">
									<div class="col-md-4" style="color: black;">
										<button value="현재 상영작 리스트"
											style="color: black; width: 250px; height: 100px;"></button>
									</div>
								</td>
							</tr>
							</div>
							<tr>
								<div class="col-md-8">
									<td>
										<h3>시간에 따른 영화 추천</h3>
									</td>
									<form method="post" action="time.do" id="timefrm"
										accept-charset="UTF-8">
										<td><select name="showtime" id="showtime"
											style="width: 150px;">
												<option>시간</option>
												<option>오전</option>
												<option>오후</option>
												<option>조조</option>
												<option>심야</option>
												<option>야간</option>
										</select></td>
									</form>
								</div>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<br>
	<hr>

	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h2>현재 상영작 리스트</h2>
			</div>
			<br> <br> <br>
			<div class="col-md-12">
				<form action="#" method="get">
					<div class="input-group">
						<!-- USE TWITTER TYPEAHEAD JSON WITH API TO SEARCH -->

						<input class="form-control" id="system-search" name="q"
							placeholder="장르별로 검색해 보세요 : 액션/모험/판타지/드라마" required> <span
							class="input-group-btn">

							<button type="submit" class="btn btn-default">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</span>
					</div>
				</form>
			</div>
			<br> <br> <br>
			<div class="col-md-12">
				<table class="table table-list-search">
					<thead>
						<tr>
							<th>순위</th>
							<th>제목</th>
							<th>장르</th>
							<th>예매율</th>
							<th>평점</th>
							<th>상영시간</th>
							<th>포스터</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="vo" items="${movielist }">
							<tr>
								<td>${vo.no }</td>
								<td>${vo.title }</td>
								<td>${vo.genre }</td>
								<td>${vo.reserve }%</td>
								<td>${vo.star }점</td>
								<td>${vo.movietime }분</td>
								<td><%-- <img src="${vo.poster }"> --%>포스터보기</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>