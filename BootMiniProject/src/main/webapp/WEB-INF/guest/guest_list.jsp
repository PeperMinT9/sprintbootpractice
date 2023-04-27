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
    <script type="text/javascript">
        $(function () {
            list();

            // 사진부터 업로드
            $("#photoupload").change(function () {
                let cnt = $(this)[0].files.length;
                if(cnt > 3) {
                    alert("3장 까지만 업로드 가능합니다");
                    return false;
                }
                var form = new FormData();
                for(i = 0; i < $(this)[0].files.length; i++) {
                    form.append("upload", $(this)[0].files[i]);
                }
                $.ajax({
                    type:"post",
                    url:"upload",
                    data:form,
                    dataType:"text",
                    processData: false,
                    contentType: false,
                    success:function(res){

                    }
                })
            })

            $("#guestadd").click(function () {
                let content = $("#content").val();
                let nn = $("#nickname").val();
                console.log(content);

                $.ajax({
                    type: "post",
                    url: "./insert",
                    data: {"content":content, "nickname":nn},
                    dataType: "text",
                    success:function(res){
                        // 입력값 초기화
                        $("#nickname").val("");
                        $("#content").val("");
                        $("#photoupload").val("");
                        // 목록 다시 호출
                        list();
                    }
                })
            })
        })
        function list() {};
    </script>
</head>
<body>
    <div style="width: 500px; margin-left: 100px;">
        <textarea style="width: 80%; height: 100px;" class="form-control" id="content"></textarea>
        <input type="file" id="photoupload" multiple="multiple">
        <button type="button" class="btn btn-sm btn-outline-success" id="guestadd">등록</button>
    </div>
</body>
</html>