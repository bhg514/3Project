<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://s.codepen.io/assets/libs/modernizr.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../assets/css/table.css">
<link rel='stylesheet prefetch'
	href='http://maxcdn.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css'>
<link rel="stylesheet" href="../assets/css/feel.css">
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/gsap/1.11.8/TweenMax.min.js'></script>


<script>

</script>
</head>
<body>
<center>
<h3>${vo.title } 상세정보</h3>
<table id="table_content" style="width:800px">
   <tr>
      <td align=right>
         <a href="list.do">목록</a>&nbsp;
         <a href="recommand.do">추천</a>
      </td>
   </tr>
</table>
<table id="table_content" style="width:800px">
   <tr>
      <td width=40% class="tdcenter" rowspan="6">
         <img src="${vo.poster }" width=320 height=400>
      </td>
      <th colspan="2">${vo.title }</th>
   </tr>
   <tr>
      <td width=20% align=right>장르</td>
      <td width=40% align=left>${vo.genre }</td>
   </tr>
   <tr>
      <td width=20% align=right>예매율</td>
      <td width=40% align=left>${vo.reserve }%</td>
   </tr>
   <tr>
      <td width=20% align=right>상영시간</td>
      <td width=40% align=left>${vo.movietime }분</td>
   </tr>
   <tr>
      <td width=20% align=right>별점</td>
      <td width=40% align=left>${vo.star }</td>
   </tr>
</table>
<table>
   <tr>
      <td><canvas id='graph'></canvas></td>

			<div class="col-md-1 col-sm-1"></div>
			<div class="col-md-10">
				<h3>${vo.title }상세정보</h3>
			</div>
			<div class="col-md-1 col-sm-1"></div>


			<div class="col-md-1 col-sm-1"></div>
			<div class="col-md-5">
				<img src="${vo.image }" width=320 height=400>
			</div>

			<div class="col-md-5">
				<table class="table">
					<tbody>
						<tr>
							<td>제목</td>
							<td>${vo.title }</td>
						</tr>

						<tr>
							<td>개봉일</td>
							<td>${vo.regdate }</td>
						</tr>

						<tr>
							<td>예매율</td>
							<td>${vo.reserve }%</td>
						</tr>

						<tr>
							<td>선호도</td>
							<td>${vo.like }</td>
						</tr>

						<tr>
							<td>별점</td>
							<td>${vo.star }</td>
						</tr>

						<tr>
							<td>등급</td>
							<td>${vo.grade }</td>
						</tr>
					</tbody>
				</table>

			</div>
			<div class="col-md-1 col-sm-1"></div>
		</div>
		<br>
		<br>

		<div class="col-md-1 col-sm-1"></div>
		<div class="col-md-10">
			<canvas id='graph'></canvas>
		</div>
		<br>
		<br>
		<div class="col-md-1 col-sm-1"></div>
		<div class="col-md-5">누구랑</div>
		<div class="col-md-5">언제</div>
		<div class="col-md-1 col-sm-1"></div>


		<script>
     // CUSTOMISABLE
        var sides  = 6;
        var canvasSize = 500;
        var padding = 50;
        var data = [
               <c:forEach var="count" items="${feelCount}" end="5" begin="0">
               '${count*1.5}',            
                  </c:forEach>
                     ];
        var feilds = [
                      <c:forEach var="feel" items="${movieFeel}"  end="5"  begin="0">                   
                     '${feel}',                   
                            
                     </c:forEach>
                     ];
        // CUSTOMISABLE
 /* <c:out value="${feel}" escapeXml="true"/>, */
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
	</center>
</body>
</html>