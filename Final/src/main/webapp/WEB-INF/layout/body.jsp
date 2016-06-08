<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link href="../assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">

</head>
<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

	<!-- Navigation -->
	<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-main-collapse">
					<i class="fa fa-bars"></i>
				</button>
				<a class="navbar-brand page-scroll" href="#page-top"> <i
					class="fa fa-play-circle"></i> <span class="light">Start</span>
					Movie Finder
				</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div
				class="collapse navbar-collapse navbar-right navbar-main-collapse">
				<ul class="nav navbar-nav">
					<!-- Hidden li included to remove active class from about link when scrolled up past about section -->
					<li class="hidden"><a href="#page-top"></a></li>
					<li><a class="page-scroll" href="recommand.do">추천</a></li>
					<li><a class="page-scroll" href="community.do">커뮤니티</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<!-- Intro Header -->
	<header class="intro">
		
		<div class="intro-body">
		<div class="col-md-12">
			<div class="row">
				<div class="col-sm-6">
					<div id="carousel">
						<c:forEach var="vo" items="${nList }" varStatus="1">
							<figure>
								<a href="detail.do?no=${vo.no}" class="aImg" value="${vo.no }">
									<img src="${vo.poster }" width=100 height=150 border=0 id="m${vo.no }">
									<br><br>
									<h2 style="color:white">${vo.no }위</h2>
									<br><br>
									<h2 style="color: white"> ${vo.title } </h2>
								</a>
							</figure>
						</c:forEach>
					</div>
					</div>
					<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="col-md-6 col-sm-6">1</div>
					<div class="col-md-6 col-sm-6">2</div>
				</div>
			</div>
		</div>
		</div>
	</header>
	
	<!-- Footer -->
	<footer>
		<div class="container text-center">
			<p>Copyright &copy; Your Website 2014</p>
		</div>
	</footer>

	<!-- jQuery -->
	<script src="assets/js/jquery.js"></script>
	<!-- Bootstrap Core JavaScript -->
	<script src="assets/js/bootstrap.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="assets/js/jquery.easing.min.js"></script>

	<!-- Google Maps API Key - Use your own API key to enable the map feature. More information on the Google Maps API can be found at https://developers.google.com/maps/ -->
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRngKslUGJTlibkQ3FkfTxj3Xss1UlZDA&sensor=false"></script>

	<!-- Custom Theme JavaScript -->
	<script src="assets/js/grayscale.js"></script>

</body>
</html>