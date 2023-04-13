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
<script>
	$(function() {
		list(1)
		$("b.list").click(function() {
			list($(this).attr("idx"))
		})
	})
	
	function list(idx) {
		$.ajax({
			type: "get",
			url: "list",
			data: {"idx" : idx},
			dataType: "json",
			success: function(res) {
				let s = ""
				$.each(res, function(idx, element) {
					s += 
						`
						<div>
							<img src = "./save/\${element.carphoto}">
						</div>
						`
				})
				$("div.carlist").html(s)
			}
		})
	}
</script>
</head>
<body>
	<div class = "menu">
		<b class = "list" idx = "1">고가순</b>&nbsp;
		<b class = "list" idx = "2">저가순</b>&nbsp;
		<b class = "list" idx = "3">등록순</b>
	</div>
	<div class = "carlist">
		{
	</div>
</body>
</html>