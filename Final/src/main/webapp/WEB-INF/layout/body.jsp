<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
			<br><br>
				<div class="row">
					<div class="col-md-12">
						<div class="col-md-5 col-sm-5">
							<div class="main1">
							asdfjsadfjsadlkfjasldf
							</div>
						</div>
						<div class="col-md-5 col-sm-5">
							<div class="main2">
							asdkjasldjsakldjlkasd
							</div>
						</div>
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
	<script src="../assets/js/grayscale.js"></script>

</body>
</html>