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
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <style>

    </style>
    <script>

    </script>
</head>
<body>
    <div style="text-align: center;">
        <h2>${dto.sangpum}</h2><br>
<%--        <img src="https://kr.object.ncloudstorage.com/bit701-bucket-29/shop/${dto.photo}" border="1" hsapce="10"><br>--%>
        <img src="https://${imageUrl}/shop/${dto.photo}" border="1" hsapce="10"><br>
        <h4 style="background-color: ${dto.color};">색상: ${dto.color}</h4><br>
        <h4>가격: ${dto.price}</h4><br>
        <h4>수량: ${dto.cnt}</h4><br>
        <c:if test="${selector % 3 == 1}">
            <button type="button" onclick="location.href='list'" class="btn btn-info btn-lg">목록으로</button>
        </c:if>
        <c:if test="${selector % 3 == 2}">
            <button type="button" onclick="location.href='list2'" class="btn btn-info btn-lg">목록으로</button>
        </c:if>
        <button id="delshop" type="button" class="btn btn-info btn-lg">삭제</button>
        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myPhotoModal">사진 수정</button>
        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myShopModal">상품정보 수정</button>
    </div>
    <script type="text/javascript">
        $("#delshop").click(function() {
            let a = confirm("삭제하려면 확인을 눌러주세요")
            if(a) {
                location.href="./delete?num=" + ${dto.num}
            };
        });
    </script>

    <!-- 사진변경 Modal -->
    <div class="modal fade" id="myPhotoModal" role="dialog">
        <div class="modal-dialog modal-sm">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"></button>
                    <h4 class="modal-title">사진수정</h4>
                </div>

                <div class="modal-body">
<%--                    <img src="http://tuifirjpufst16981859.cdn.ntruss.com/shop/${dto.photo}?type=f&w=160&h=160&faceopt=true&ttype=jpg" border="2"--%>
<%--                     style="margin-left: 30px; border-radius: 50px;" id="modalphoto">--%>
                    <img src="http://${imageUrl_small}/shop/${dto.photo}?type=f&w=160&h=160&faceopt=true&ttype=jpg" border="2"
                         style="margin-left: 30px; border-radius: 50px;" id="modalphoto">
                    <i class="bi bi-camera-fill update-photo" style="position: absolute; left: 180px; top: 140px; font-size: 26px; cursor: pointer;"></i>
                    <input type="file" id="photoupload" style="display: none">
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.reload()">Close</button>
                </div>
            </div>

        </div>
    </div>
    <script type="text/javascript">
        $(".update-photo").click(function() {
            $("#photoupload").trigger("click") // 클릭이벤트 강제 발생
        })

        $("#photoupload").change(function() {
            let form = new FormData();
            form.append("upload", $("#photoupload")[0].files[0]) // 선택한 1개의 파일만 업로드
            form.append("num", ${dto.num})
            $.ajax({
                type:"post",
                dataType:"text",
                url:"./photochange",
                data:form,
                processData:false,
                contentType:false,
                success:function(res) {
                    alert(res)
                    // let src = `http://tuifirjpufst16981859.cdn.ntruss.com/shop/\${res}?type=f&w=160&h=160&faceopt=true&ttype=jpg`;
                    let src = `http://${imageUrl_small}/shop/\${res}?type=f&w=160&h=160&faceopt=true&ttype=jpg`;
                    $("#modalphoto").attr("src", src);
                }
            })
        })
    </script>

    <!-- 내용변경 Modal -->
    <div class="modal fade" id="myShopModal" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"></button>
                    <h4 class="modal-title">상품정보 수정</h4>
                </div>

                <div class="modal-body">
<%--                    <img src="http://tuifirjpufst16981859.cdn.ntruss.com/shop/${dto.photo}?type=f&w=160&h=160&faceopt=true&ttype=jpg" border="2"--%>
<%--                         style="margin-left: 30px; border-radius: 50px;">--%>
                    <img src="http://${imageUrl_small}/shop/${dto.photo}?type=f&w=160&h=160&faceopt=true&ttype=jpg" border="2"
                         style="margin-left: 30px; border-radius: 50px;">
                    <br><br>
                    <form id="updateform">
                        <input type="hidden" name="num" value="${dto.num}">
                        <table class="table table-bordered">
                            <tr>
                                <th style="width: 100px; background-color: #ddd;">상품명</th>
                                <td>
                                    <input type="text" class="form-control" name="sangpum" required="required" value="${dto.sangpum}">
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 100px; background-color: #ddd;">상품색상</th>
                                <td>
                                    <input type="color" class="form-control" name="color" value="${dto.color}">
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 100px; background-color: #ddd;">가격</th>
                                <td>
                                    <input type="number" class="form-control" name="price" value="${dto.price}"
                                           min="1000" max="9999999" step="5000">
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 100px; background-color: #ddd;">갯수</th>
                                <td>
                                    <input type="number" class="form-control" name="cnt" value="${dto.cnt}"
                                           min="1" max="9" step="1">
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="btn_update">Apply</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $("#btn_update").click(function () {
            let data = $("#updateform").serialize();
            // alert(data);
            $.ajax({
                type: "get",
                dataType: "text",
                url: "./update",
                data: data,
                success: function (res) {
                    location.reload();
                }
            })
        })
    </script>

</body>
</html>