<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>成功学院学生会</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">



</head>
<body style="width: 90%">
<div class="tab-pane" id="updata_id">
    <form class="form-horizontal">
        <div class="form-group">
            <div class="col-sm-5"></div>
            <div class="col-sm-4">
                <img id="myheadimg" readonly="readonly" src="${sessionScope.userinfo.imgHeah}"
                     style="cursor: hand;width: 200px;height: 200px" onclick="imgitem();" class="img-circle"
                     alt="User Image">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">学号:</label>
            <div class="col-sm-2">
                <h4>${requestScope.deptInfo.stuId}</h4>
                <span class="help-block"></span>
            </div>

            <label class="col-sm-2 control-label">姓名:</label>
            <div class="col-sm-2">
                <h4>${sessionScope.userinfo.name}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">性别:</label>
            <div class="col-sm-3">
                <c:if test="${sessionScope.userinfo.sex=='W'}">
                    <h4>女</h4>
                </c:if>
                <c:if test="${sessionScope.userinfo.sex=='M'}">
                    <h4>男</h4>
                </c:if>
            </div>
        </div>


        <div class="form-group">


            <label class="col-sm-2 control-label">出生年月:</label>
            <div class="col-sm-2">
                <h4><fmt:formatDate value="${sessionScope.userinfo.brith}" type="date"/></h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-2 control-label">年龄:</label>
            <div class="col-sm-2">
                <h4>${sessionScope.userinfo.age}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">寝室住址:</label>
            <div class="col-sm-3">
                <h4>${sessionScope.userinfo.docuAddress}</h4>
                <span class="help-block"></span>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">联系方式:</label>
            <div class="col-sm-2">
                <h4>${sessionScope.userinfo.phone}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-2 control-label">昵称:</label>
            <div class="col-sm-2">
                <h4>${sessionScope.userinfo.nickname}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">班级:</label>
            <div class="col-sm-3">
                <h4>${requestScope.deptInfo.className}</h4>
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">系部:</label>
            <div class="col-sm-2">
                <h4>${requestScope.deptInfo.deptname}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-2 control-label">部门:</label>
            <div class="col-sm-2">
                <h4>${requestScope.deptInfo.deptStuName}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">年级:</label>
            <div class="col-sm-3">
                <h4>${requestScope.deptInfo.dengji}</h4>
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">政治面貌:</label>
            <div class="col-sm-2">
                <h4>${requestScope.deptInfo.political}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-2 control-label">邮箱:</label>
            <div class="col-sm-2">
                <h4>${sessionScope.userinfo.email}</h4>
                <span class="help-block"></span>
            </div>
        </div>
    </form>
</div>

</body>

</html>

