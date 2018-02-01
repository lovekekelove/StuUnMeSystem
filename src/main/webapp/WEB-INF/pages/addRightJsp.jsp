<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>添加系部</title>
</head>
<body style="width: 90%">
<div class="tab-pane">
    <form class="form-horizontal">
        <div class="form-group"></div>
        <div class="form-group">
            <label class="col-md-1 control-label">权限名称:</label>
            <div class="col-md-3">
                <input type="text" name="className" class="form-control" id="right"
                       placeholder="请输入添加的权限名称">
            </div>
        </div>

        <div class="form-group" id="fid">
            <label class="col-sm-1 control-label">所属菜单:</label>
            <div class="col-sm-3">
                <select class="form-control" name="deptName">
                    <option value="">请选择：</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-1 control-label">URL:</label>
            <div class="col-sm-3">
                <input type="text" name="className" class="form-control" id="url"
                       placeholder="请输入URL">
            </div>
        </div>

    </form>
    <div class="modal-footer">
        <div class="col-sm-offset-6">
            <button onclick="comInfo()" class="btn btn-success" id="update-btn">确认添加</button>
        </div>
    </div>
</div>

</body>
<script>
    function comInfo() {
        var right = $("#right").val();
        var fid = $("#fid select").val();
        var url = $("#url").val();
        if (right == '') {
            layer.tips("权限名称不能为空！", ("#update-btn"), {anim: 6});
            return false;
        }

        $.ajax({
            url: "${staticPath}/addStuRight",
            type: "GET",
            dataType: "json",
            data: {"right": right, "fid": fid, "url": url},
            success: function (result) {
                if (result.code == 100) {
                    layer.load(0, {time: 600});
                    setTimeout(function (args) {
                        layer.msg("添加成功！");
                    }, 1000);
                } else if (result.extend.error = 300) {
                    layer.load(0, {time: 600});
                    setTimeout(function () {
                        layer.msg("添加失败！存在此权限！");
                    }, 1000);
                } else {
                    layer.load(0, {time: 600});
                    setTimeout(function () {
                        layer.msg("添加失败！");
                    }, 1000);
                }
            }
        });
    }

    //显示部门
    $(function () {
        $.ajax({
            url: "${staticPath}/fid",
            type: "GET",
            dataType: "json",
            success: function (result) {
                $.each(result.extend.fidRight, function () {
                    var optionEle = $("<option></option>").append(this.right).attr("value", this.id);
                    optionEle.appendTo("#fid select");
                });
            }
        });
    });

</script>
</html>


