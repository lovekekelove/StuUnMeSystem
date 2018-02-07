<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>添加好友</title>
</head>
<body>
<div>
    <div>
        <div class="form-group">
            <div class="col-sm-2"></div>
            <input type="hidden" value="${requestScope.user.id}" id="uid">
        </div>
        <div class="form-group">
            <div class="col-sm-3"></div>
            <div class="col-sm-6 text-center">
                <img src="${requestScope.user.imgHeah}"
                     style="width: 200px;height: 200px" class="img-circle"
                     alt="User Image">
            </div>
            <div class="col-sm-3 text-center">
                <h2>${requestScope.user.name}</h2>
                <h4>请求添加您为好友！</h4>
            </div>
        </div>


        <div class="modal-footer">
            <button type="button" class="btn btn-default col-sm-2 pull-left" id="re_btn">拒绝</button>
            <button type="button" class="btn btn-primary col-sm-2 pull-right " id="accept_btn">同意</button>
        </div>
    </div>
</div>
</body>
<script>

    $(document).on("click", "#accept_btn", function () {
        //1.弹出是否删除确认框
        var id = $("#uid").val();//请求方的id
        layer.confirm("确认同意${requestScope.user.name}吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/updateFriend?uid=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.msg("添加成功！");
                    } else {
                        layer.msg("添加失败！");
                    }
                }
            });
        }, function () {

        });
    });

    $(document).on("click", "#re_btn", function () {
        //1.弹出是否删除确认框
        var id = $("#uid").val();//请求方的id
        layer.confirm("确认拒绝${requestScope.user.name}吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/refuseFriend?uid=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.msg("拒绝成功！");
                    } else {
                        layer.msg("拒绝失败！");
                    }
                }
            });
        }, function () {

        });
    });

</script>
</html>
