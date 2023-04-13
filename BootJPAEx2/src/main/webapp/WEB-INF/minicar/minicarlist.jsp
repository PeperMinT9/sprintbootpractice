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
	<div>
		<h4 class="alert alert-danger">총 ${totalCount}개의 자동차가 등록되었습니다</h4>
		<br>
		<button type="button" class="btn btn-outline-info btn-sm"
			onclick="location.href = 'minicarform'">자동차정보입력</button>
		<button type="button" class="btn btn-outline-info btn-sm"
			onclick="location.href = 'ajaxlist'">Ajax로 목록 출력</button>
		<br>
		<table class="table table-bordered">
			<c:forEach var="dto" items="${list}" varStatus="i">
				<tr>
					<td style="width: 60" align="center">${i.count}</td>
					<td style="width: 200px">
						<a href="detail?num=${dto.num}" style="color: black; text-decoration: none; cursor: pointer;">
							<img src="./save/${dto.carphoto}" width="50" height="50" border="1" hspace="10">
							${dto.carname}
						</a>
					</td>
					<td><fmt:formatDate value="${dto.writeday}"
							pattern="yyyy년 MM월 dd일 등록" />
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>