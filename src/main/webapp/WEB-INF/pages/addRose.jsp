<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>增加角色</title>
</head>
<body>
<div class="tab-pane" id="complInfo">
    <div class="modal-body">
        <form class="form-horizontal">
            <div class="form-group">
                <div class="col-md-2">
                    <input type="text" name="rose" class="form-control" id="addRose"
                           placeholder="请输入添加的角色名称">
                </div>
            </div>
        </form>
    </div>
    <div class="modal-footer">
        <button onclick="comInfo()" class="btn btn-success" id="update-btn">确认</button>
    </div>
</div>

</body>
<script>
    function comInfo() {
        var rose = $("#addRose").val();
        if (rose == '') {
            layer.msg("不能为空！", {anim: 6, icon: 5});
            return false;
        }
        $.ajax({
            url: "${staticPath}/addRose",
            type: "GET",
            dataType: "json",
            data: {"rose": rose},
            success: function (result) {
                if (result.code == 100) {
                    layer.load(0, {time: 2000});
                    setTimeout(function (args) {
                        layer.msg("添加成功！");
                    }, 2000);
                } else {
                    layer.load(0, {time: 2000});
                    setTimeout(function (args) {
                        layer.msg("添加失败！已经存在！");
                    }, 2000);
                }
            }
        });
    }


</script>
</html>
