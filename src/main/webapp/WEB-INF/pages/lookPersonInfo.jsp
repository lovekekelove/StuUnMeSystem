<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>查看个人资料</title>
</head>
<body style="width: 90%">
<div class="tab-pane" id="updata_id">
    <form class="form-horizontal">
        <div class="form-group">
            <div class="col-sm-5"></div>
            <div class="col-sm-4">
                <img id="myheadimg" readonly="readonly" src="${requestScope.userInfo.imgHeah}"
                     style="cursor: hand;width: 200px;height: 200px" class="img-circle"
                     alt="User Image">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">学号:</label>
            <div class="col-sm-2">
                <h4>
                    <c:if test="${not empty requestScope.deptInfo.stuId }">
                        ${requestScope.deptInfo.stuId }
                    </c:if>
                    <c:if test="${empty requestScope.deptInfo.stuId }">
                        待完善
                    </c:if>
                </h4>
                <span class="help-block"></span>
            </div>

            <label class="col-sm-2 control-label">姓名:</label>
            <div class="col-sm-2">
                <h4>${requestScope.userInfo.name}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">性别:</label>
            <div class="col-sm-3">
                <c:if test="${requestScope.userInfo.sex=='W'}">
                    <h4>女</h4>
                </c:if>
                <c:if test="${requestScope.userInfo.sex=='M'}">
                    <h4>男</h4>
                </c:if>
            </div>
        </div>


        <div class="form-group">


            <label class="col-sm-2 control-label">出生年月:</label>
            <div class="col-sm-2">
                <h4><fmt:formatDate value="${requestScope.userInfo.brith}" type="date"/></h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-2 control-label">年龄:</label>
            <div class="col-sm-2">
                <h4>${requestScope.userInfo.age}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">寝室住址:</label>
            <div class="col-sm-3">
                <h4>${requestScope.userInfo.docuAddress}</h4>
                <span class="help-block"></span>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">联系方式:</label>
            <div class="col-sm-2">
                <h4>${requestScope.userInfo.phone}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-2 control-label">昵称:</label>
            <div class="col-sm-2">
                <h4>${requestScope.userInfo.nickname}</h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">班级:</label>
            <div class="col-sm-3">
                <h4>
                    <c:if test="${not empty requestScope.deptInfo.className }">
                        ${requestScope.deptInfo.className }
                    </c:if>
                    <c:if test="${empty requestScope.deptInfo.className }">
                        待完善
                    </c:if>
                </h4>
                <span class="help-block"></span>
            </div>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">系部:</label>
            <div class="col-sm-2">
                <h4>
                    <c:if test="${not empty requestScope.deptInfo.deptname }">
                        ${requestScope.deptInfo.deptname}
                    </c:if>
                    <c:if test="${empty requestScope.deptInfo.deptname }">
                        待完善
                    </c:if>
                </h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-2 control-label">部门:</label>
            <div class="col-sm-2">
                <h4>
                    <c:if test="${not empty requestScope.deptInfo.deptStuName }">
                        ${requestScope.deptInfo.deptStuName}
                    </c:if>
                    <c:if test="${empty requestScope.deptInfo.deptStuName }">
                        待完善
                    </c:if>
                </h4>
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">年级:</label>
            <div class="col-sm-3">
                <h4>
                    <c:if test="${not empty requestScope.deptInfo.dengji }">
                        ${requestScope.deptInfo.dengji}
                    </c:if>
                    <c:if test="${empty requestScope.deptInfo.dengji }">
                        待完善
                    </c:if>
                </h4>
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">政治面貌:</label>
            <div class="col-sm-2">
                <h4>
                    <c:if test="${not empty requestScope.deptInfo.political}">
                        ${requestScope.deptInfo.political}
                    </c:if>
                    <c:if test="${empty requestScope.deptInfo.political }">
                        待完善
                    </c:if>
                </h4>
                <span class="help-block"></span>
            </div>
        </div>
    </form>
</div>
</body>
</html>
