<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<style>
	body, body *{

		font-family: 'Jua'

	}
</style>
</head>
<body>
	<div style = "margin: 30px; width: 500px">
		<form action = "addcar" method = "post" enctype = "multipart/form-data">
			<table>
				<tr>
					<th style = "background-color: #ddd; width: 100px;">자동차명</th>
					<td>
						<input type = "text" name = "carname" class = "form-control" style = "width: 200px;">
					</td>
				</tr>
				<tr>
					<th style = "background-color: #ddd; width: 100px;">자동차색상</th>
					<td>
						<input type = "color" name = "carcolor" class = "form-control" style = "width: 100px;" value = "#ffccab">
					</td>
				</tr>
				<tr>
					<th style = "background-color: #ddd; width: 100px;">자동차가격</th>
					<td>
						<input type = "text" name = "carprice" class = "form-control" style = "width: 200px;">
					</td>
				</tr>
				<tr>
					<th style = "background-color: #ddd; width: 100px;">자동차사진</th>
					<td>
						<input type = "file" name = "upload" class = "form-control" style = "width: 300px;">
					</td>
				</tr>
				<tr>
					<td colspan = "2" align = "center">
						<button type = "submit" class = "btn btn-outline-secondary">정보저장</button>
						<button type = "button" class = "btn btn-outline-secondary" onclick = "location.href='/'">자동차목록</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>