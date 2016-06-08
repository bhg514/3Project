<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../table.css">
<!-- Bootstrap Core CSS -->
<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="../assets/css/grayscale.css" rel="stylesheet">
<link href="../assets/css/slide.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="../assets/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic"
	rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">

</head>
<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">


	<!-- Intro Header -->
	<header class="intro">
		<div class="intro-body">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="carousel">
							<h2>인기 영화 Top 7</h2>
							<div class="holder">
								<c:forEach var="vo" items="${list }">
									<%-- <h2 style="color: white">${vo.no }위</h2>
									<br> --%>
									<a href="detail.do?no=${vo.no}" class="aImg" value="${vo.no }">
										<img src="${vo.image }" width=250 height=300 border=0
										id="m${vo.no }">
									</a>
									<%-- <br>
									<h2 style="color: white">${vo.title }</h2> --%>

								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<br>
				<br>
				<div class="row">
					<div class="col-md-12">
						<div class="col-md-5 col-sm-5">
							<div class="main1">asdfjsadfjsadlkfjasldf</div>
						</div>
						<div class="col-md-5 col-sm-5">
							<div class="main2">asdkjasldjsakldjlkasd</div>
						</div>
					</div>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="col-md-6 col-sm-6">
							<center>
								<h3>실시간 예매 순위</h3>
								<table id="table_content" width="320px">
									<c:forEach var="vo" items="${reList }" varStatus="status">
										<tr height="30px">
											<td style="text-align: left; width: 15%">${status.count}위</td>
											<td style="text-align: left; width: 85%">&nbsp;${vo }
											<td>
										</tr>
									</c:forEach>
								</table>
							</center>
						</div>
						<div class="col-md-6 col-sm-6">
							<h3>실시간 영화 소식</h3>
							<table id="table_content" width="400px">
								<tr>
									<form method="post" action="main.do" accept-charset="UTF-8">
										<th
											style="height: 40px; text-align: center; vertical-align: middle;">
											<input type="text"
											style="width: 40%; color: #000; display: inline;"
											name="title" value="${search }"> <input type="submit"
											value="검색" style="background: #fff; color: #ccc; width: 8%">
										</th>
									</form>
								</tr>
								<c:forEach var="vo" begin="0" end="10" items="${newslist }">
									<tr style="text-align: left;">
										<td height="30px">
											<div
												style="width: 100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; cursor: pointer;"
												class="newsClass">
												<a href="#" style="color: #fff;">${vo.title }</a><br>
											</div>
											<div style="color: gray; display: none;">
												&nbsp;&nbsp;&nbsp; <a href="${vo.link }"
													style="color: gray;"> ${vo.description } </a>
											</div>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
	</header>



	<!-- jQuery -->
	<script src="../assets/js/jquery.js"></script>
	<!-- Bootstrap Core JavaScript -->
	<script src="../assets/js/bootstrap.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="../assets/js/jquery.easing.min.js"></script>
	<script src="../assets/js/slide.js"></script>
	<!-- Google Maps API Key - Use your own API key to enable the map feature. More information on the Google Maps API can be found at https://developers.google.com/maps/ -->
	<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRngKslUGJTlibkQ3FkfTxj3Xss1UlZDA&sensor=false"></script>

	<!-- Custom Theme JavaScript -->

	<script src="assets/js/grayscale.js"></script>
	<script type="text/javascript">
		$(function() {
			var shownum = 0;
			$('.newsClass').click(function() {
				if (shownum == 0) {
					$(this).nextAll().show();
					shownum = 1;
				} else {
					$(this).nextAll().hide();
					shownum = 0;
				}
			});
		});
	</script>
</body>
</html>