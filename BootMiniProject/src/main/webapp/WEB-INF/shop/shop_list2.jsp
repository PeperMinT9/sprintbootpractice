<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp"%>

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
<body>
    <button type="button" class="btn btn-sm btn-outline-success" onclick="location.href='shopform'" style="margin-bottom: 10px">상품등록</button>

    <h5 class="alert alert-danger">총 ${totalCount}개의 상품이 등록되었습니다
        <span style="float: right">
            <button type="button" class="btn btn-sm btn-outline-danger" onclick="location.href='list'" style="margin-bottom: 10px">자세히 확인</button>
        </span>
    </h5>
    <div >
        <c:forEach var="dto" items="${list}" varStatus="i">
            <div style="float: left; margin-right: 10px;" align="center">
<%--                <img src="http://tuifirjpufst16981859.cdn.ntruss.com/shop/${dto.photo}?type=f&w=160&h=160&faceopt=true&ttype=jpg" border="1" hsapce="10"--%>
<%--                 onclick="location.href='detail?num=${dto.num}&selector=${selector}'" style="cursor: pointer"><br>--%>
                <img src="http://${imageUrl_small}/shop/${dto.photo}?type=f&w=160&h=160&faceopt=true&ttype=jpg" border="1" hsapce="10"
                     onclick="location.href='detail?num=${dto.num}&selector=${selector}'" style="cursor: pointer">
                <b>${dto.sangpum}</b>
            </div>
            <c:if test="${i.count % 4 == 0}">
                <br>
            </c:if>
        </c:forEach>
    </div>
</body>
</html>