<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ include file="../../common/base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="keywords" content="">
    <meta name="description" content="">

    <%@ include file="../../common/commons.jsp" %>

    <title>留言区</title>
</head>

<body class="gray-bg">
<div class="row">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12 ">
                <div class="wrapper wrapper-content animated fadeInRight">
                    <div class="col-sm-1">

                    </div>
                    <button type="button" class="btn btn-default btn-lg " onclick="sendMsg()">
                        <span class="glyphicon glyphicon-pencil "></span>发表留言
                    </button>

                    <!--版块下的文章列表-->
                    <div class="wrapper wrapper-content  animated fadeInRight blog">
                        <div class="row">

                            <c:if test="${tcvos==null || fn:length(tcvos) ==0}">
                                <div class=" col-lg-6 col-lg-offset-3 ">
                                    <h3>这里还没来人留言，赶紧来<a href="${staticPath}/form_editors.jsp">创建</a>一个吧
                                    </h3>
                                </div>
                            </c:if>
                            <c:if test="${tcvos!=null && fn:length(tcvos) !=0}">
                                <c:forEach items="${tcvos}" var="item" varStatus="status">

                                    <div class="col-lg-4 "></div>


                                    <div class="col-lg-5 ">
                                        <!------------------------------------------------------------------------------------------->

                                        <div class="ibox">
                                            <div class="ibox-content">
                                                    <%--</a>--%>
                                                <div class="small m-b-xs">
                                                    <a href="#"
                                                       class="pull-left">
                                                        <img alt="image" class="img-circle"
                                                             style="width: 38px;height: 38px;"
                                                             src="${staticPath}${item.imgHeah}">
                                                    </a>

                                                    <strong style="margin-left: 5px;margin-bottom: 0px">${item.nickname}</strong> </span>

                                                    <span class="text-muted pull-right "><i
                                                            class="fa fa-clock-o"></i> <fmt:formatDate
                                                            value="${item.creattime}"
                                                            pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></span>
                                                </div>

                                                <br/>
                                                <p>
                                                        ${item.count}
                                                </p>
                                                <div class="row">
                                                    <div class="col-md-5 " onclick="zan(this,${item.id})"
                                                         style="cursor: pointer"><i
                                                            class="fa fa-thumbs-o-up margin-r-5"></i> <span
                                                            style="color: #00a2d4" class="zannum">${item.zanNum}</span>

                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <hr>
                                                </div>
                                                <br>
                                            </div>

                                        </div>

                                        <!------------------------------------------>
                                    </div>


                                </c:forEach>
                                <div class="col-sm-6 col-sm-offset-3" id="page"></div>
                            </c:if>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    function sendMsg() {
        window.location.href = "../../form_editors.jsp";
    };


    function zan(s, a) {
        $.ajax({
            url: "${staticPath}/addzan",
            type: "get",
            dataType: "json",
            data: {"id": a},
            success: function (result) {
                if (result.code == 100) {
                    $(s).find(".zannum").text(result.extend.zanNum);
                } else {
                    layer.tips("赞过啦！", $(s).find(".zannum"), {anim: 6});
                }
            }
        });
    };


    <%--laypage({--%>
    <%--cont: $('#page'),--%>
    <%--pages: ${pages}, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18--%>
    <%--curr: function () { //通过url获取当前页，也可以同上（pages）方式获取--%>
    <%--var page = location.search.match(/page=(\d+)/);--%>
    <%--return page ? page[1] : 1;--%>
    <%--}(),--%>
    <%--jump: function (e, first) { //触发分页后的回调--%>
    <%--if (!first) { //一定要加此判断，否则初始时会无限刷新--%>
    <%--location.href = '${staticPath}/show/topicCatalog?sid=${sid}&&page=' + e.curr;--%>
    <%--}--%>
    <%--}--%>
    <%--});--%>


</script>
</html>

