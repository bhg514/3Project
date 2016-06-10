<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../assets/table.css">

  <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css'>
    <link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/nvd3/1.7.0/nv.d3.min.css'>
        <link rel="stylesheet" href="../assets/css/feel.css">
        <link rel="stylesheet" href="../assets/css/who.css">
                <link rel="stylesheet" href="../assets/css/good.css">
		    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://cdnjs.cloudflare.com/ajax/libs/gsap/1.11.8/TweenMax.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/nvd3/1.7.0/nv.d3.min.js'></script>

<link rel="stylesheet" type="text/css" href="../table_detail.css">




<script>
</script>
</head>
<body>
<center>
<h2 style="margin-top:130px;"><b>'${vo.title }'</b> 상세보기</h2>
<p>&nbsp;</p>
<br><br>
<table id="table_content_top" class="table_bottom"
		style="width:1000px;">
	<tr height="50px">
		<td align=right>
			<a href="recommand.do">추천</a>
		</td>
	</tr>
</table>
<table id="table_content" class="table_bottom" style="width:1000px">
	<tr>
		<td width=40% class="tdcenter" rowspan="6">
			<img src="${vo.poster }" width=420 height=500>
		</td>
		<th colspan="2" style="text-align: center;font-size:25px;">${vo.title }</th>
	</tr>
	<tr>
		<td width=30% align=right style="padding-right:80px;"><b>장르</b></td>
		<td width=30% align=left>${vo.genre }</td>
	</tr>
	<tr>
		<td width=30% align=right style="padding-right:80px;"><b>예매율</b></td>
		<td width=30% align=left>${vo.reserve }%</td>
	</tr>
	<tr>
		<td width=30% align=right style="padding-right:80px;"><b>상영시간</b></td>
		<td width=30% align=left>♥ ${vo.movietime }</td>
	</tr>
	<tr>
		<td width=30% align=right style="padding-right:80px;"><b>별점</b></td>
		<td width=30% align=left>${vo.star }</td>
	</tr>
</table>
<p>&nbsp;</p>
<table width="1000px">
	<tr style="background:#9C9DA4;border-radius:50px;margin-bottom:70px;">
		<td colspan="2" >
			<h3 align=center style="">
				영화  <b>'${vo.title }'</b>  통계 자료 
			</h3>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3 align=center style="margin-top:60px;margin-bottom:30px;">
				긍정, 부정 그래프
			</h3>
		</td>
	</tr>
	<tr>
		<td style="background:#fff;">
			       	<!-- ---------------------------------호불호 그래프------------------------------------------------------------- -->
    <div class="graph" style="	position:absolute;
									top: 930px;"></div>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js'></script>

        <script>
        function donutGraph(selector, percentage){
            'use strict';
            var height, width, radius, data, color, svg, g, bgArc, visArc, pie, path, vis;
            height = 75;
            width = 75;
            radius = Math.min(width, height) / 2;
            svg = d3.select(selector)
                .append('svg')
                .attr('viewBox', '0 0 ' + width + ' ' + height)
                .attr('preserveAspectRatio', 'none');
            g = svg.append('g')
                .attr('transform', 'translate(' + (width / 2) + ',' + (height / 2) + ')');
          
            g.append('text')
                .text(percentage + '%')
                .attr('alignment-baseline', 'middle')
                .attr('text-anchor', 'middle');
          
            bgArc = d3.svg.arc()
                .innerRadius(radius / 1.25)
                .outerRadius(radius)
                .startAngle(0) //converting from degs to radians
                .endAngle(degTOrad(perTOdeg(100))); //just radians
            visArc = d3.svg.arc()
                .innerRadius(radius / 1.18)
                .outerRadius(radius)
                .cornerRadius(20)
                .startAngle(0) //converting from degs to radians
                .endAngle(degTOrad(perTOdeg(percentage))); //just radians
            g.append("path")
                .attr("d", bgArc)
                .attr('class', 'background');
            g.append("path")
                .attr("d", visArc)
                .attr('class', 'visual');
            function perTOdeg(per) {
                'use strict';
                return 360 * per / 100;
            }
            function degTOrad(deg) {
                'use strict';
                return deg * (Math.PI / 180);
            }
        }
        donutGraph('.graph', '${bestValue}');
        
        </script>
		</td>
	</tr>
	<tr>
		<td width="50%">
			<h3 align=center style="padding-top:230px;margin-bottom:30px;">
				<b>'${vo.title }'</b>  감정 분석
			</h3>
		</td>
		<td>
			<h3 align=center style="padding-top:230px;margin-bottom:30px;">
				시간대별 <b>'${vo.title }'</b> 관람 수
			</h3>
		</td>
		<tr>
	</tr>
	</tr>
	<tr>
			<!-- ---------------------------------  감정 그래프 ------------------------------------------------------------- -->
		
		<td><canvas id='graph'></canvas></td>
		
        <script>
     // CUSTOMISABLE
        var sides  = 6;
        var canvasSize = 500;
        var padding = 50;
        var data = 
					<%=request.getAttribute("fc")%>
        var feilds = <%=request.getAttribute("mf")%>
        // CUSTOMISABLE
        // Variable
        var canvas = $('#graph')[0];
        var ctx = canvas.getContext('2d');
        var centerX = canvasSize/2;
        var centerY = canvasSize/2;
        var shapesArray = [];
        var dataArray = [];
        var radius = canvasSize/2-padding;
        canvas.width = canvasSize;
        canvas.height = canvasSize;
        // Prototypes
        Shape = function() {}
        Shape.pt = Shape.prototype;
        Point = function() {};
        Point.pt = Point.prototype;
        // Functions
        function loop() {
          ctx.clearRect(0,0,canvasSize,canvasSize);
          
          for (var j = 0; j < shapesArray.length; j++) {
            var shape = shapesArray[j];
            ctx.beginPath();
            ctx.lineTo(shape.points[0].x, shape.points[0].y);
            
            for(var i = 0; i < shape.points.length; i++) {
              ctx.lineTo(shape.points[i].x, shape.points[i].y);
            }
            
            ctx.fillStyle   = shape.fill;
            ctx.strokeStyle = shape.stroke;
            ctx.lineWidth   = shape.linewidth;
            
            ctx.closePath();
            ctx.fill();
            ctx.stroke();
          }
          
          for(var i = 0; i < shapesArray[0].points.length; i++) {
            ctx.strokeStyle = '#208963';
            ctx.lineWidth   = 1;
            ctx.moveTo(centerX, centerY);
            ctx.lineTo(shapesArray[0].points[i].x, shapesArray[0].points[i].y);
            ctx.stroke();
          }
          for (var j = 0; j < dataArray.length; j++) {
            var shape = dataArray[j];
            ctx.beginPath();
            ctx.lineTo(shape.points[0].x, shape.points[0].y);
            
            for(var i = 0; i < shape.points.length; i++) {
              ctx.lineTo(shape.points[i].x, shape.points[i].y);
            }
            
            ctx.fillStyle   = shape.fill;
            ctx.strokeStyle = shape.stroke;
            ctx.lineWidth   = shape.linewidth;
            
            ctx.closePath();
            ctx.fill();
            ctx.stroke();
            
            var shape = dataArray[j];
            ctx.textBaseline = 'middle';
            for(var i = 0; i < shape.feilds.length; i++) {
              var _x = Math.round(shape.feilds[i].x);
              if(_x < centerX) {
                ctx.textAlign = 'right';
              } else if(_x > centerX) {
                ctx.textAlign = 'left';
              } else if(_x == centerX) {
                ctx.textAlign = 'center';
              }
              ctx.fillText(feilds[i],shape.feilds[i].x,shape.feilds[i].y);
            }
            
          }
          
          
        }
        var timer = setInterval(loop, 1000/60);
        function setupShape(_sides, _radius, _fill, _stroke, _linewidth) {
          
          var shape = new Shape();
          shape.sides = _sides;
          shape.radius = _radius;
          shape.fill = _fill;
          shape.stroke = _stroke;
          shape.linewidth = _linewidth;
          shape.points = [];
          
          for(var i = 0; i < _sides; i++){
            p    = new Point();
            ang  = Math.PI/(_sides/2)*i;
            sang = Math.sin(ang);
            cang = Math.cos(ang);
            p.x  = centerX + sang*_radius;
            p.y  = centerY + cang*_radius;
            shape.points.push(p);
          }
          
          shapesArray.push(shape);
          
        }
        function setupData(_data, _fill, _stroke, _linewidth) {
          var shape = new Shape();
          length = data.length;
          shape.sides = length;
          shape.fill = _fill;
          shape.stroke = _stroke;
          shape.linewidth = _linewidth;
          shape.points = [];
          shape.feilds = [];
          
          for(var i = 0; i < length; i++){
            p    = new Point();
            ang  = Math.PI/(length/2)*i;
            sang = Math.sin(ang);
            cang = Math.cos(ang);
            p.x  = centerX + sang*(data[i]/100*radius);
            p.y  = centerY + cang*(data[i]/100*radius);
            shape.points.push(p);
            
            p    = new Point();
            ang  = Math.PI/(length/2)*i;
            sang = Math.sin(ang);
            cang = Math.cos(ang);
            p.x  = centerX + sang*(radius+20);
            p.y  = centerY + cang*(radius+20);
            shape.feilds.push(p);
          }
          dataArray.push(shape);
          for(var i = 0; i < shape.points.length; i++) {
            TweenMax.from(shape.points[i], Math.random()*0.75+0.25, {x:canvasSize/2, y:canvasSize/2, delay:1.2});
          }
        }
        function play() {
          setupShape(sides, radius, '#175f45', '#3ad59c', 3);
          setupShape(sides, radius*3/4, '#2e6f58', '#208963', 1);
          setupShape(sides, radius/2, '#437e69', '#208963', 1);
          setupShape(sides, radius*1/4, '#1f8862', '#208963', 1);
          for (var j = 0; j < shapesArray.length; j++) {
            var shape = shapesArray[j];
            for(var i = 0; i < shape.points.length; i++) {
              TweenMax.from(shape.points[i], Math.random()*0.75+1, {x:canvasSize/2, y:canvasSize/2, ease:Elastic.easeOut});
            }
          }
          setupData(data, 'rgba(99, 223, 178, 0.5)', '#3ad59c', 2);
          
        }
        play();
        </script>
		<td>
		<div style="width:500;border:0.5px dotted #ccc;border-radius:20px;overflow:hidden;">
				<!-- ---------------------------------언제 그래프------------------------------------------------------------- -->
		<?xml version="1.0" encoding="utf-8"?>
<svg viewBox="0 0 800 460" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:bx="https://www.boxy-svg.com/bx">

  <defs>
    <radialGradient id="gradient-1" gradientUnits="userSpaceOnUse" cx="545" cy="213" r="500" gradientTransform="matrix(0.7, 0, 0, 0.4642, 0, 130)">
      <stop style="stop-color: rgb(99, 84, 84);" offset="0"/>
      <stop style="stop-color: rgb(19, 19, 19);" offset="1"/>
    </radialGradient>
    <pattern id="pattern-2" viewBox="-10 13 181 180" patternUnits="userSpaceOnUse" width="100" height="100">
      <rect x="86.5" y="71.3" width="6.9" height="180.6" style="fill: rgb(216, 216, 216);" transform="matrix(1, 0, 0, 1, -9.2, -57.9)"/>
      <rect x="86.5" y="71.3" width="6.9" height="180.6" style="fill: rgb(216, 216, 216); stroke-width: 1;" transform="matrix(0, 1, -1, 0, 242, 13)"/>
    </pattern>
    <style id="bx-google-fonts">@import url(https://fonts.googleapis.com/css?family=Roboto:100,100italic,300,300italic,400,400italic,500,500italic,700,700italic,900,900italic);</style>
    <pattern id="pattern-3" patternTransform="matrix(0.22454, 0, 0, 0.22513, 180.02606, 317.30121)" xlink:href="#pattern-2"/>
  </defs>

  <rect width="800" height="460" style="fill: url(#gradient-1);"/>
  <rect x="79.6" y="59.6" width="690" height="360" style="fill: url(#pattern-3); fill-opacity: 0.2; stroke: rgb(105, 105, 104);"/>
   
  <path d="M
  <%=request.getAttribute("time")%>
  " style="stroke: rgb(33, 125, 245); fill: none; stroke-width: 3;" bx:origin="0.5 0.5"/>



  <g class="y-axis">
    <text y="420" x="40" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 20px;">0%</text>
   <text y="348" x="40" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 20px;">20%</text>
    <text y="276" x="40" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 20px;">40%</text>
    <text y="204" x="40" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 20px;">60%</text>
    <text y="132" x="40" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 20px;">80%</text>
   <text y="70" x="40" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 20px;">100%</text>

  </g>
  <g class="x-axis" transform="matrix(1, 0, 0, 1, 32, 12)">
    <text y="430" x="50" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 25px;">조조</text>
    <text y="430" x="185" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 25px;">오전</text>
    <text y="430" x="371" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 25px;">오후</text>
    <text y="430" x="556" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 25px;">야간</text>
    <text y="430" x="735" style="text-anchor: middle; fill: rgb(103, 102, 102); font-size: 25px;">심야</text>

  </g>
</svg>
	</div>
</td>
	<tr>
		<td colspan="2">
			<h3 align=center style="padding-top:100px;margin-bottom:30px;">
				<b>'${vo.title }'</b> 워드 클라우드  
			</h3>
		</td>
	</tr>
	<tr>
		<td colspan="2">
				<!-- ---------------------------------wordcloud --------------------------------------------------------------->
				
				 <div id="cloud" style="width:500;border:0.5px dotted #ccc;border-radius:20px;overflow:hidden;margin-bottom:130px;">
    <canvas width="800" height="400" id="myCanvas" align="center">
        <p>Anything in here will be replaced on browsers that support the canvas element</p>
        <ul class="weighted" style="font-size: 50%" id="weightTags">
          <%=request.getAttribute("wordCloud")%>
      
        </ul>
    </canvas>
</div>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://file1.hpage.com/001492/58/html/tagcloud.js'></script>
<script src='../assets/js/aoxypj.js'></script>

        <script src="../assets/js/wordCloud.js"></script>
  <%--   <div class="content">
  <h1></h1>
  
  <div id="donut-chart">
    <svg></svg>
  </div>
</div>
        <script>
     // Create the donut pie chart and insert it onto the page
        nv.addGraph(function() {
          var donutChart = nv.models.pieChart()
          		.x(function(d) {
                return d.label
              })
          		.y(function(d) {
                return d.value
              })
          		.showLabels(true)
          		.showLegend(false)
          		.labelThreshold(.05)
          		.labelType("key")
          		.color(["#965251", "#00b3ca", "#7dd0b6", "#e38690", "#ead98b"])
          		.tooltipContent(
                function(key, y, e, graph) { return 'Custom tooltip string' }
              ) // This is for when I turn on tooltips
          		.tooltips(false)
          		.donut(true)
          		.donutRatio(0.35);
          
          	// Insert text into the center of the donut
          	function centerText() {
        			return function() {
                var svg = d3.select("svg");
            		var donut = svg.selectAll("g.nv-slice").filter(
                  function (d, i) {
                    return i == 0;
                  }
                );
                
                // Insert first line of text into middle of donut pie chart
                donut.insert("text", "g")
                    .text("Line One")
                    .attr("class", "middle")
                    .attr("text-anchor", "middle")
                		.attr("dy", "-.55em")
                		.style("fill", "#000");
                // Insert second line of text into middle of donut pie chart
                donut.insert("text", "g")
                    .text("Line Two")
                    .attr("class", "middle")
                    .attr("text-anchor", "middle")
                		.attr("dy", ".85em")
                		.style("fill", "#000");
              }
            }
          
          // Put the donut pie chart together
          d3.select("#donut-chart svg")
            .datum(seedData())
            .transition().duration(300)
            .call(donutChart)
            .call(centerText())
            .call(pieSlice());
            
          return donutChart;
        });
        // Seed data to populate donut pie chart
        function seedData() {
          return [
					<%=request.getAttribute("whoText")%>
          ];
        }
        </script> --%>
    
    
    
     
     
		</td>
	</tr>
</table>
</center>
</body>
</html>