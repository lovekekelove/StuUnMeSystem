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
                <input type="text" name="className" value="${requestScope.stuRight.right}" class="form-control"
                       id="right"
                       placeholder="请输入添加的权限名称">
            </div>
        </div>
        <input type="hidden" value="${requestScope.stuRight.id}" id="rgId">
        <div class="form-group" id="fid">
            <label class="col-sm-1 control-label">所属菜单:</label>
            <div class="col-sm-3">
                <select class="form-control">
                    <option value="null">请选择</option>
                    <c:forEach items="${requestScope.fidRight}" var="r">
                        <c:if test="${r.id==requestScope.stuRight.fid}">
                            <option value="${r.id}" selected>${r.right}</option>
                        </c:if>
                        <c:if test="${r.id!=requestScope.stuRight.fid}">
                            <option value="${r.id}">${r.right}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-1 control-label">URL:</label>
            <div class="col-sm-3">
                <input type="text" name="className" value="${requestScope.stuRight.url}" class="form-control" id="url"
                       placeholder="请输入URL">
            </div>
        </div>

    </form>
    <div class="modal-footer">
        <div class="col-sm-offset-6">
            <button onclick="comInfo()" class="btn btn-success" id="update-btn">确认修改</button>
        </div>
    </div>
</div>

</body>
<script>
    function comInfo() {
        var right = $("#right").val();
        var fid = $("#fid select").val();
        var url = $("#url").val();
        var rgId = $("#rgId").val();
        if (right == '') {
            layer.tips("权限名称不能为空！", ("#update-btn"), {anim: 6});
            return false;
        }

        $.ajax({
            url: "${staticPath}/updateStuRight",
            type: "GET",
            dataType: "json",
            data: {"right": right, "fid": fid, "url": url, "id": rgId},
            success: function (result) {
                if (result.code == 100) {
                    layer.load(0, {time: 600});
                    setTimeout(function (args) {
                        layer.msg("更新成功！");
                    }, 1000);
                } else {
                    layer.load(0, {time: 600});
                    setTimeout(function () {
                        layer.msg("更新失败！");
                    }, 1000);
                }
            }
        });
    }


</script>
</html>



