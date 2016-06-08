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
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	// column
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ["영화명", "선호도(찜)", { role: "style" } ],
        <c:forEach var="vo" items="${list}">
        ['<c:out value="${vo.title}"/>', <c:out value="${vo.like}"/>, '<c:out value="${vo.color}"/>'],
        </c:forEach>
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "영화 선호도 시각화",
        width: 450,
        height: 300,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
    }
    
    // pie
    google.charts.setOnLoadCallback(drawChart1);
    function drawChart1() {

      var data = google.visualization.arrayToDataTable([
        ['영화명', '예매율'],
        <c:forEach var="vo" items="${list}">
        ['<c:out value="${vo.title}"/>', <c:out value="${vo.reserve}"/>],
        </c:forEach>
      ]);

      var options = {
        title: '영화 예매율 시각화'
      };

      var chart = new google.visualization.PieChart(document.getElementById('piechart'));

      chart.draw(data, options);
     }

    
    
    
    //highchart
    $(function () {
        $('#container').highcharts({
            chart: {
                type: 'pie',
                options3d: {
                    enabled: true,
                    alpha: 45,
                    beta: 0
                }
            },
            title: {
                text: '영화별 별점 현황'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    depth: 35,
                    dataLabels: {
                        enabled: true,
                        format: '{point.name}'
                    }
                }
            },
            series: [{
                type: 'pie',
                name: '별점',
                data: <%= request.getAttribute("data")%>
            }]
        });
     }); 
  
  </script>


</head>
<body>
<center>
	<h3>영화 전체 통계 시각화</h3>
	<table id="table_content" style="width:900px;">
		<tr>
			<td align=right>
				<a href="list.do">영화목록</a>
			</td>
		</tr>
	</table>
	<table id="table_content" width="900">
		<tr>
			<td width=50% align=center>
				<div id="columnchart_values" style="width: 450px; height: 300px;"></div>
			</td>
			<td width=50% align=center>
				<div id="piechart" style="width: 450px; height: 300px;"></div>
			</td>
		</tr>
		<tr>
			<td colspan="2" align=center>
				<div id="container" style="width: 450px; height: 300px;"></div>
			</td>
		</tr>
	</table>
</center>
</body>
</html>