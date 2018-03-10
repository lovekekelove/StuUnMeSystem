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
                        <span class="glyphicon glyphicon-pencil "></span>发表动态
                    </button>

                    <!--版块下的文章列表-->
                    <div class="wrapper wrapper-content  animated fadeInRight blog">
                        <div class="row">

                            <c:if test="${tcvos==null || fn:length(tcvos) ==0}">
                                <div class=" col-lg-6 col-lg-offset-3 ">
                                    <h3>这里还没来人留言，赶紧来<a href="${staticPath}/reportdynamic.jsp">创建</a>一个吧
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
                                                    <a href="${staticPath}/lookTopic?id=${item.id}&&advice_id=0"
                                                       style="text-decoration: none"><h3
                                                            style="font-style: normal; color: #337ab7">${item.title}</h3>
                                                    </a>
                                                    <a href="#"
                                                       class="pull-left">
                                                        <img alt="image" class="img-circle"
                                                             style="width: 38px;height: 38px;"
                                                             src="${staticPath}${item.imgHeah}">
                                                    </a>

                                                    <strong style="margin-left: 5px;margin-bottom: 0px">${item.nickname}</strong> </span>

                                                    <span class="text-muted pull-right "><i
                                                            class="fa fa-clock-o"></i> <fmt:formatDate
                                                            value="${item.ttime}"
                                                            pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></span>
                                                </div>

                                                <br/>
                                                <p style="color:#aa1111">
                                                        ${item.tcontent}
                                                </p>
                                                <div class="row">
                                                    <div class="col-md-2 " onclick="zan(this,${item.id})"
                                                    >
                                                        <i style="cursor: pointer"
                                                           class="fa fa-thumbs-o-up margin-r-5"></i>
                                                        <span style="color: #00a2d4;cursor: pointer"
                                                              class="zannum">${item.tzan}赞</span>
                                                    </div>
                                                    <div class="col-md-3 ">
                                                        <span style="color: #00a2d4">点击量：${item.tclickcount}次</span>
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
        window.location.href = "../../reportdynamic.jsp";
    };


    function zan(s, a) {
        $.ajax({
            url: "${staticPath}/addzanDy",
            type: "get",
            dataType: "json",
            data: {"id": a},
            success: function (result) {
                if (result.code == 100) {
                    $(s).find(".zannum").text(result.extend.zanNum + "赞");
                } else {
                    layer.tips("赞过啦！", $(s).find(".zannum"), {anim: 6});
                }
            }
        });
    };




</script>
</html>

