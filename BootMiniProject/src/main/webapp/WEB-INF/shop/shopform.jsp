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
<body>
    <img id="showimg" style="position: absolute; left: 500px; top: 10px; max-width: 300px">
    <div style="width: 450px">
        <form action="insert" method="post" enctype="multipart/form-data">
            <table class="table table-bordered">
                <tr>
                    <th style="width: 100px; background-color: #ddd;">상품명</th>
                    <td>
                        <input type="text" class="form-control" name="sangpum" required="required">
                    </td>
                </tr>
                <tr>
                    <th style="width: 100px; background-color: #ddd;">상품사진</th>
                    <td>
                        <input type="file" class="form-control" name="upload" id="myfile" required="required">
                    </td>
                </tr>
                <tr>
                    <th style="width: 100px; background-color: #ddd;">상품색상</th>
                    <td>
                        <input type="color" class="form-control" name="color" value="#a35296">
                    </td>
                </tr>
                <tr>
                    <th style="width: 100px; background-color: #ddd;">가격</th>
                    <td>
                        <input type="number" class="form-control" name="price" value="1000"
                        min="1000" max="9999999" step="5000">
                    </td>
                </tr>
                <tr>
                    <th style="width: 100px; background-color: #ddd;">갯수</th>
                    <td>
                        <input type="number" class="form-control" name="price" value="1"
                               min="1" max="9" step="1">
                    </td>
                </tr>
                <tr>
                   <td colspan="2" align="center">
                       <button type="submit" class="btn btn-outline-success">상품등록</button>
                       <button type="button" class="btn btn-outline-success"
                        onclick="location.href='list'">상품등록</button>
                   </td>
                </tr>
            </table>
        </form>
    </div>
    <script type="text/javascript">
        $("#myfile").change(function(){
            console.log("1:"+$(this)[0].files.length);
            console.log("2:"+$(this)[0].files[0]);
            //정규표현식
            var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
            var f=$(this)[0].files[0];//현재 선택한 파일
            if(!f.type.match(reg)){
                alert("확장자가 이미지파일이 아닙니다");
                return;
            }
            if($(this)[0].files[0]){
                var reader=new FileReader();
                reader.onload=function(e){
                    $("#showimg").attr("src",e.target.result);
                }
                reader.readAsDataURL($(this)[0].files[0]);
            }
        });
    </script>
</body>
</html>