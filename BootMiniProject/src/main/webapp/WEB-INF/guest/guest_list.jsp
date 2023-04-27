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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .small_photo {
            border: 5px solid pink;
            border-radius: 30px;
            margin-right: 10px;
        }
        .today {
            float: right;
            color: #CCC;
            font-size: 14px;
            margin-right: 10px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            list();

            //사진부터 업로드
            // $("#photoupload").change(function () {
            //     console.dir(this);
            //     //file input type 은 한개일지라도 기본이 배열타입으로 넘어온다
            //     //그래서 배열의 0번으로 표시함
            //     let cnt = $(this)[0].files.length;
            //     if (cnt > 3) {
            //         alert("3장까지만 업로드가능합니다");
            //         return false;
            //     }
            //     var form = new FormData();
            //     for (i = 0; i < $(this)[0].files.length; i++) {
            //         form.append("upload", $(this)[0].files[i]);//선택한 사진 모두 추가
            //     }
            //
            //     $.ajax({
            //         type: "post",
            //         dataType: "text",
            //         url: "upload",
            //         processData: false,
            //         contentType: false,
            //         data: form,
            //         success: function (res) {
            //
            //         }
            //     });
            // });
            //
            // $("#guestadd").click(function () {
            //     let content = $("#content").val();
            //     let nn = $("#nickname").val();
            //     console.log(content);
            //     $.ajax({
            //         type: "post",
            //         dataType: "text",
            //         url: "./insert",
            //         data: {"content": content, "nickname": nn},
            //         success: function (res) {
            //             //입력값 초기화
            //             $("#nickname").val("");
            //             $("#content").val("");
            //             $("#photoupload").val("");
            //             //목록 다시 호출
            //             list();
            //         }
            //     });
            // });


            //업로드한 사진들과 데이타를 같이 묶어서 서버에 전송하기
            $("#guestadd").click(function () {

                let cnt = $("#photoupload")[0].files.length;
                let content = $("#content").val();
                let nn = $("#nickname").val();

                if (content.length == 0) {
                    alert("내용을 입력해주세요");
                    return false;
                }
                if (nn.length == 0) {
                    alert("닉네임을 입력해주세요");
                    return false;
                }

                var form = new FormData();
                for (i = 0; i < $("#photoupload")[0].files.length; i++) {
                    form.append("upload", $("#photoupload")[0].files[i]);//선택한 사진 모두 추가
                }

                form.append("content", content);
                form.append("nickname", nn);

                $.ajax({
                    type: "post",
                    dataType: "text",
                    url: "./insert",
                    processData: false,
                    contentType: false,
                    data: form,
                    success: function (res) {
                        //입력값 초기화
                        $("#nickname").val("");
                        $("#content").val("");
                        $("#photoupload").val("");
                        //목록 다시 호출
                        list();
                    }
                });
            });
        });

        function large_photo(photoname, content) {
            let src = `https://${imageUrl}/guest/\${photoname}`;
            $("#largephoto").attr("src", src);
            $("#MB_content").text(content);
        }

        function list() {
            $.ajax({
                type: "get",
                url: "./alist",
                dataType: "json",
                success: function (res) {
                    let s = "";
                    $.each(res, function (idx, element) {
                        s += 
                            `
                            <div class = 'guest_box'>
                                <div>
                                    <b>\${element.nickname}</b><br>
                                    <b>\${element.content}</b>
                                    <span class = 'today'>\${element.writeday}</span>
                                </div>
                            </div>
                            `;
                        s += "<div class='photo_box'>";
                        $.each(element.photoList, function (pidx, pelement) {
                            s += 
                                `
                                <img src="http://${imageUrl_small}/guest/\${pelement.photoname}?type=f&w=80&h=80&faceopt=true&ttype=jpg"
                                 class = "small_photo" onclick="large_photo('\${pelement.photoname}', '\${element.content}')"
                                 data-bs-toggle="modal" data-bs-target="#myPhotoModal">
                                `;
                        })
                        s+="</div>";
                    })
                    $("div.alist").html(s);
                }
            })
        };
    </script>
</head>
<body>
    <!-- The Modal -->
    <div class="modal" id="myPhotoModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">원본사진</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <img src="" id="largephoto" style="max-width: 100%;"><br>
                    <b id="MB_content"></b>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div style="width: 500px; margin-left: 100px;">
        <input type="text" id="nickname" class="form-control" placeholder="닉네임" style="width: 200px;">
        <textarea style="width: 80%; height: 100px;" class="form-control" id="content"></textarea>
        <input type="file" id="photoupload" multiple="multiple">
        <button type="button" class="btn btn-sm btn-outline-success" id="guestadd">등록</button>
    </div>
    <hr>
    <div class="alist"></div>
</body>
</html>