<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="../assets/table.css">
<link rel="stylesheet" type="text/css" href="../table_detail.css">
  <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css'>
    <link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/nvd3/1.7.0/nv.d3.min.css'>
        <link rel="stylesheet" href="../assets/css/feel.css">
        <link rel="stylesheet" href="../assets/css/who.css">
            <link rel="stylesheet" href="../assets/css/good.css">
		    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/gsap/1.11.8/TweenMax.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/nvd3/1.7.0/nv.d3.min.js'></script>


<!-- graph -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/pie.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>

<script type="text/javascript">
 var chart = AmCharts.makeChart( "chartdiv", {
	  "type": "pie",
	  "theme": "light",
	  "dataProvider": [ 
	<c:forEach var="vo" items="${movielist}">
	{
	    "country":"<c:out value="${vo.title}"/>",
	    "value": <c:out value="${vo.count}"/>
	  },</c:forEach> 
	  ],
	  "valueField": "value",
	  "titleField": "country",
	  "outlineAlpha": 0.4,
	  "depth3D": 15,
	  "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
	  "angle": 30,
	  "export": {
	    "enabled": true
	  }
	} );
	jQuery( '.chart-input' ).off().on( 'input change', function() {
	  var property = jQuery( this ).data( 'property' );
	  var target = chart;
	  var value = Number( this.value );
	  chart.startDuration = 0;

	  if ( property == 'innerRadius' ) {
	    value += "%";
	  }

	  target[ property ] = value;
	  chart.validateNow();
	} );
	

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
		
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<!-- 영화목록 -->
			<div class="col-md-12">
			<div class="col-md-7">
			<table id="table_content" width=900 border=1 style="color: black;">
				<c:forEach var="vo" items="${movielist }" begin="0" end="2">
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
			</div>
			
		<!-- 그래프  -->
		<div class="col-md-5">
		<div id="chartdiv"></div>
		</div>																		
		</div>
</body>
</html>