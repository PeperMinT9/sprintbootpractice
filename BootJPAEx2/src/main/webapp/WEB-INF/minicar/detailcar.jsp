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
	
	div.car {
		width: 400px;
		height: 500px;
		font-size: 20px;
		padding-left: 10px;
		padding-top: 10px;
		margin-top: 30px;
		margin-left: 30px;
		border: 10px solid pink;
		border-radius: 30px;
		background-color: #afeeee;
		font-weight: bold;
	}
</style>
</head>
<body>
	<div class = "car">
		<img src="./save/${dto.carphoto}" style = "width: 96%">
		<br><br>
		자동차명: ${dto.carname}<br>
		가격: <fmt:formatNumber type="currency" currencySymbol="w" value="${dto.carprice}" minFractionDigits="0"/>
		<br>
		색상: <span style = "background-color: ${dto.carcolor};">${dto.carcolor}</span>
		<br>
		등록일: <fmt:formatDate value = "${dto.writeday}" pattern = "yyyy년MM월dd일"/>
		<br>
		<i class = "bi bi-pencil-square" style = "font-size: 30px; cursor: pointer; margin-left: 100px"
		 onclick="location.href='updatecar?num=${dto.num}'"></i>
		<i class = "bi bi-folder-minus" style = "font-size: 30px; cursor: pointer; margin-left: 20px"
		 onclick="location.href='deletecar?num=${dto.num}'"></i>
		<i class = "bi bi-card-list" style = "font-size: 30px; cursor: pointer; margin-left: 20px"
		 onclick="location.href='./'"></i>
		 
	</div>
</body>
</html>