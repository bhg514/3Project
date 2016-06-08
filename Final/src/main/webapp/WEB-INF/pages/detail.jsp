<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="table.css">


</head>
<body>
<center>
<h3>${vo.title } 상세보기</h3>
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
			<img src="${vo.image }" width=320 height=400>
		</td>
		<th colspan="2">${vo.title }</th>
	</tr>
	<tr>
		<td width=20% align=right>개봉일</td>
		<td width=40% align=left>${vo.regdate }</td>
	</tr>
	<tr>
		<td width=20% align=right>예매율</td>
		<td width=40% align=left>${vo.reserve }%</td>
	</tr>
	<tr>
		<td width=20% align=right>선호도</td>
		<td width=40% align=left>♥ ${vo.like }</td>
	</tr>
	<tr>
		<td width=20% align=right>별점</td>
		<td width=40% align=left>${vo.star }</td>
	</tr>
	<tr>
		<td width=20% align=right>등급</td>
		<td width=40% align=left>${vo.grade }</td>
	</tr>
</table>
<table id="table_content" style="width:900px">
	<tr>
		<td><img src="../text/feel.png"></td>
	</tr>
</table>
</center>
</body>
</html>