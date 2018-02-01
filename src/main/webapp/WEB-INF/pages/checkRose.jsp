<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>修改角色</title>
</head>
<body>
<div class="tab-pane" id="complInfo">
    <div class="modal-body">
        <form class="form-horizontal">
            <input type="hidden" name="id" id="StuId" value="${user.id}">
            <div class="form-group" id="rose">
                <div class="col-md-2">
                    <select class="form-control" name="deptName" style="width: 180px">
                        <c:forEach items="${roses}" var="r">
                            <c:if test="${r.rose==user.roseName}">
                                <option value="${r.id}" selected>${r.rose}</option>
                            </c:if>
                            <c:if test="${r.rose!=user.roseName}">
                                <option value="${r.id}">${r.rose}</option>
                            </c:if>
                        </c:forEach>
                    </select>
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
        var stuId = $("#StuId").val();
        var roseId = $("#rose select").val();
        $.ajax({
            url: "${staticPath}/updateRose",
            type: "GET",
            dataType: "json",
            data: {"uid": stuId, "rid": roseId},
            success: function (result) {
                if (result.code == 100) {
                    layer.load(0, {time: 2000});
                    setTimeout(function (args) {
                        layer.msg("修改成功！");
                    }, 2000);
                } else {
                    layer.load(0, {time: 2000});
                    setTimeout(function (args) {
                        layer.msg("修改失败！");
                    }, 2000);
                }
            }
        });
    }


</script>
</html>


