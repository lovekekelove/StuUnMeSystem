<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/base.jsp" %>

<html>
<head>
    <title>更换头像</title>
    <%@ include file="common/commons.jsp" %>

</head>
<body bgcolor="#ebf6e9" style="height: 500px">
<div class="ibox-content">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-md-1 "></div>
            <div class="col-md-4 col-md-5">
                <div class="image-crop" style="height: 400px">
                    <img src="${sessionScope.userinfo.imgHeah}">
                </div>
            </div>
            <div class="col-md-2 "></div>
            <div class="col-md-5 col-sm-12">
                <h4>图片预览：</h4>
                <div style="height: 30px;width: 200px"></div>
                <div class="img-preview circle-border" style="height: 150px;width: 150px"></div>
                <div style="height: 60px;width: 200px"></div>
                <div class="btn-group">
                    <label title="上传图片" for="inputImage" class="btn btn-primary">
                        <input type="file" accept="image/*" name="file" id="inputImage" class="hidden"> 上传新图片
                    </label>
                    <label title="下载图片" id="download" class="btn btn-primary">下载</label>
                </div>

                <div class="btn-group">
                    <button class="btn btn-white" id="zoomIn" type="button">放大</button>
                    <button class="btn btn-white" id="zoomOut" type="button">缩小</button>
                    <button class="btn btn-white" id="rotateLeft" type="button">左旋转</button>
                    <button class="btn btn-white" id="rotateRight" type="button">右旋转</button>
                    <button class="btn btn-warning" id="upload" type="button">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $(".image-crop > img").attr({'src': $("#myheadimg", parent.document).attr('src')});
        var $image = $(".image-crop > img");
        $($image).cropper({
            aspectRatio: 1,
            preview: ".img-preview",
            done: function (data) {
                console.log("x:" + data.x + " y:" + data.y + " width:" + data.width + " height:" + data.height);
            }
        });

        var $inputImage = $("#inputImage");
        if (window.FileReader) {
            $inputImage.change(function () {
                var fileReader = new FileReader(),
                    files = this.files,
                    file;
                if (!files.length) {
                    return;
                }

                file = files[0];

                if (/^image\/\w+$/.test(file.type)) {
                    fileReader.readAsDataURL(file);
                    fileReader.onload = function () {
                        $inputImage.val("");
                        $image.cropper("reset", true).cropper("replace", this.result);
                    };
                } else {
                    showMessage("请选择图片文件");
                }
            });
        } else {
            $inputImage.addClass("hide");
        }

        $("#download").click(function () {
            window.open($image.cropper("getDataURL"));
        });

        $("#zoomIn").click(function () {
            $image.cropper("zoom", 0.1);
        });

        $("#zoomOut").click(function () {
            $image.cropper("zoom", -0.1);
        });

        $("#rotateLeft").click(function () {
            $image.cropper("rotate", 45);
        });

        $("#rotateRight").click(function () {
            $image.cropper("rotate", -45);
        });

        $('#upload').click(function () {
            var data = $image.cropper("getDataURL");
            var parentimg = $("#myheadimg", parent.document);
            parentimg.attr({"src": data});
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index);
        })
    })
</script>
</body>
</html>
