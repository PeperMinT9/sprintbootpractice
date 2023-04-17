<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>

    </style>
    <script>

    </script>
</head>
<c:set var="root" value="<%=request.getContextPath()%>"/>
<body>
    <a href="${root}/">Home1</a>
    &nbsp;&nbsp;

    <a href="${root}/home2">Home2</a>
    &nbsp;&nbsp;

    <a href="${root}/shop/list">Shop</a>
    &nbsp;&nbsp;

    <a href="${root}/board/list">Board</a>
    &nbsp;&nbsp;

    <a href="${root}/guest/list">Guest</a>
    &nbsp;&nbsp;

    <a href="${root}/contact">Contact</a>
</body>
</html>