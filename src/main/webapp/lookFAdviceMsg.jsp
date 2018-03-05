<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/base.jsp" %>
<%@ include file="/common/commons.jsp" %>
<html>
<head>
    <title>查看通知</title>
</head>
<body>
<div style="width: 437px">
    <p>${param.count}</p>
    <input type="hidden" value="${param.id}" id="advice_id">
</div>
</body>
<script>
    $(function () {
        var id = $("#advice_id").val();
        $.ajax({
            url: "${staticPath}/user/lookAdvice?id=" + id,
            type: "get"
        });
    })
</script>
</html>
