<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/base.jsp" %>
<%@ include file="/common/commons.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 富文本编辑器</title>
    <meta name="keywords" content="">
    <meta name="description" content="">


</head>

<body class="gray-bg" id="addLeaveMsg">
<div class="wrapper wrapper-content">

    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">

                <div class="ibox-content">

                    <div class="form-horizontal">

                        <div class="form-group">

                            <div class="col-sm-10 col-md-7">

                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-1 col-md-2  control-label"></label>
                            <div class="col-sm-10 col-md-7 ">
                                <div class="ibox float-e-margins">

                                    <div class="ibox-content" id="eg">
                                        <div class="click2edit wrapper" id="content">
                                        </div>
                                    </div>
                                    <div id="zishu">
                                        <p>还可以输入100个字</p>
                                    </div>
                                </div>
                                <div>
                                    <button type="button" onclick="submitMyTopic();" class="btn btn-primary"
                                            style="float: right; margin-right: 0px" id="btn">提交
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>


<!-- 自定义js -->
<script src="${staticPath}/js/content.js?v=1.0.0"></script>


<script>
    <%--$.ajaxSetup({--%>
    <%--contentType: "application/x-www-form-urlencoded;charset=utf-8",--%>
    <%--complete: function (XMLHttpRequest, textStatus) {--%>
    <%--var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");--%>
    <%--if (sessionstatus === "timeout") {--%>
    <%--layer.msg("请先登录");--%>
    <%--setTimeout(function () {--%>
    <%--location.replace("${staticPath}/login.html");--%>
    <%--}, 500);--%>
    <%--}--%>
    <%--}--%>
    <%--});--%>

    var MAX_NUM = 200;
    // $(document).on("change",".note-editable",function () {
    //     alert(1);
    // });
    var msg_length = 0;

    var count = $('#content').code();
    var msg_length = count.length;


    $(document).ready(function () {
        $('.summernote').summernote({
            lang: 'zh-CN'
        });
        $.ajax({
            url: '${staticPath}/section/getSection',
            cache: false,
            dataType: "json",
            success: function (data) {

                for (var i = 0; i < data.length; i++) {
                    $('#section').append(' <option value="' + data[i].sid +
                        '">' + data[i].sname +
                        '</option>');
                }
                var sid = getUrlParam("sid");
                if (sid != null) {
                    $("select option[value=" + sid + "]").attr("selected", true);
                } else {
                    $('select option[value="2"]').attr("selected", true);
                }
            }
        })


    });

    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    };
    $(function () {
        $("#eg").addClass("no-padding");
        $('.click2edit').summernote({
            lang: 'zh-CN',
            focus: true
        });
    });
    var save = function () {
        $("#eg").removeClass("no-padding");
        var aHTML = $('.click2edit').code(); //save HTML If you need(aHTML: array).
        $('.click2edit').destroy();
    };


    var submitMyTopic = function () {
        var count = $('#content').code();
        count = count.replace(/[\r\n]/g, "");
        count = count.replace(/\ +/g, "");


        var length = count.length;
        //假设长度限制为10
        if (length > 10) {
            //截取前10个字符
            count = count.substring(0, 200);
        }


        if (count == null || count === '') {
            layer.tips("不能为空", $('#btn'), {anim: 6});
            return false;
        }
        $.ajax({
            type: 'post',
            url: '${staticPath}/addLeaveMsg',
            dataType: "json",
            data: {"count": count},
            success: function (data) {
                if (data.code === 100) {
                    layer.tips("留言成功,等待审核！", $('#btn'), {anim: 6});
                    setTimeout(function () {
                        location.replace("${staticPath}/leaveMsg");
                    }, 1000);
                } else {
                    layer.tips("留言失败", $('#btn'), {anim: 6});
                    setTimeout(function () {
                        location.replace("${staticPath}/leaveMsg");
                    }, 1000);
                }
                // setTimeout(function (args) {
                // layer.confirm('继续留言吗？', {
                //     btn: ['是', '否'] //按钮
                // }, function () {
                //     location.reload();
                // }, function () {
                //
                // });
                // },3000);

            }
        });
    }
</script>


</body>

</html>

