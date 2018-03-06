<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>新闻</title>
</head>
<body style="margin: 0 auto; padding: 0 auto">
<div style="width: 100%;height: 100%;">
    <div style="width: 70%;margin:0 auto">
        <div style="text-align: center;">
            <h1>${requestScope.news.title}</h1>
            <p style="height: 30px; line-height: 30px;background-color: #e8f5dc">
                发布时间:<fmt:formatDate value="${requestScope.news.sendTime}"></fmt:formatDate>&nbsp;&nbsp;
                来源:${requestScope.news.deptName}&nbsp;&nbsp;
                作者:${requestScope.news.name}&nbsp;&nbsp;
                点击量:${requestScope.news.lookNum}次
            </p>
        </div>
        <div style="width: 60%;margin:0 auto;background-color: #e8f5dc;text-align: left; ">
            <p>${requestScope.news.newsCount}</p>
        </div>
    </div>
</div>
</body>
</html>
