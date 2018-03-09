<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 帖子</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="${staticPath}/img/favicon.ico">
    <link href="${staticPath}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${staticPath}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${staticPath}/css/animate.css" rel="stylesheet">
    <link href="${staticPath}/css/style.css?v=4.1.0" rel="stylesheet">
    <style type="text/css">
        .loadnav {
            color: #5fd3d4;
            font-size: 18px;
            font-family: 华文彩云;
        }

        .loadnav:hover {
            color: #00a2d4;
        }

        .topichead {
            font-size: 14px;
            color: #898986;
            font-weight: 300;
        }
    </style>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-8 col-md-8 col-md-offset-1 " style="padding-left: 0px">

            <%--标题结束--%>
            <%--帖子内容开始--%>
            <div class="social-feed-separated">
                <div class="social-feed-box">
                    <br>

                    <div class="social-avatar">
                        <img alt="image" style="width: 70px;height: 70px;"
                             src="${staticPath}${requestScope.topic.imgHeah}">
                        <a href="#" style="font-size: 18px">
                            ${requestScope.topic.nickname}
                        </a>&nbsp;&nbsp;
                        <small class="text-muted "><i class="fa fa-clock-o"></i><fmt:formatDate type="both"
                                                                                                value="${requestScope.topic.ttime}"></fmt:formatDate>
                        </small>
                    </div>
                    <div class="social-body">
                        <p>
                            ${requestScope.topic.tcontent}
                        </p>

                        <div class="btn-group">
                            <button class="btn btn-white btn-xs" onclick="zan(this,${topic.id});"><i
                                    class="fa fa-thumbs-up "></i> <span class="zannum">${requestScope.topic.tzan}</span>赞
                            </button>
                            <button class="btn btn-white btn-xs"><i class="fa fa-comments"></i><span
                                    id="com_zan"></span>
                            </button>
                            <button class="btn btn-white btn-xs"> 浏览量：<span>${requestScope.topic.tclickcount}次</span>
                            </button>
                        </div>
                    </div>
                    <br>
                    <!--评论-->
                    <c:if test="${requestScope.comment==null || fn:length(requestScope.comment)==0}">
                        <div class="social-footer">
                            <div class="media-body" style="text-align: center">
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <h3 style="color: #291f40"> 啊偶，没有评论噢</h3>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                            </div>
                            <div class="social-comment">
                                <div class="media-body">
                                    <textarea class="form-control rootcontent saytext" placeholder="填写评论..."></textarea>
                                    <button type="button" class="btn btn-primary "
                                            style="float: right;margin-top: 5px" onclick="submitroot()">发表评论
                                    </button>
                                </div>
                            </div>
                        </div>

                    </c:if>
                    <c:if test="${requestScope.comment!=null && fn:length(requestScope.comment)!=0}">
                    <div class="social-footer">
                        <c:forEach items="${requestScope.comment}" var="single">
                            <!--根评论开始-->
                            <div class="social-comment" rootcid="${single.comments.comId}">
                                <a href="#" class="pull-left">
                                    <img alt="image" style="width: 27px;height:27px;"
                                         src="${staticPath}${single.comments.imgHeah}">
                                </a>
                                <div class="media-body" id="${single.comments.comId}">
                                    <a href="#">
                                            ${single.comments.nickname} :
                                    </a>
                                        ${single.comments.comCount}
                                    <br/>
                                    &nbsp;
                                    <a class="small" onclick="adddirecTextArea(this);"><i
                                            class="fa fa-comments"></i></a>&nbsp;
                                    <small class="text-muted"><fmt:formatDate type="both"
                                                                              value="${single.comments.comTime}"></fmt:formatDate></small>
                                    <br>
                                </div>

                                <c:if test="${single.root_directcomment !=null && fn:length(single.root_directcomment)!=0}">
                                    <c:forEach items="${single.root_directcomment }" var="ndire">
                                        <div class="social-comment" style="margin-left: 30px">
                                            <a href="#"
                                               class="pull-left">
                                                <img alt="image" style="width: 27px;height:27px;"
                                                     src="${staticPath}${ndire.imgHeah}">
                                            </a>
                                            <div class="media-body" directuid="${ndire.comId}"
                                                 id="${ndire.comId}">
                                                <a href="#">
                                                        ${ndire.nickname}
                                                </a>
                                                &nbsp;<font color="#8b5de4">回复</font>
                                                <a href="#">${single.comments.nickname}</a>

                                                    ${ndire.comCount}
                                                <br/>
                                                &nbsp;
                                                <a class="small"
                                                   onclick="addNdirectTextArea(this,${ndire.comId});"><i
                                                        class="fa fa-comments"></i></a>&nbsp;
                                                <small class="text-muted"><fmt:formatDate type="both"
                                                                                          value="${ndire.comTime}"></fmt:formatDate></small>
                                            </div>
                                        </div>

                                        <c:if test="${single.root_Ndirectcomment  !=null && fn:length(single.root_Ndirectcomment )!=0}">
                                            <c:forEach items="${single.root_Ndirectcomment  }" var="ndireto">
                                                <c:if test="${ ndireto.comFid eq ndire.comId }">
                                                    <div class="social-comment" style="margin-left: 30px">
                                                        <a href="#"
                                                           class="pull-left">
                                                            <img alt="image" style="width: 27px;height:27px;"
                                                                 src="${staticPath}${ndireto.imgHeah}">
                                                        </a>
                                                        <div class="media-body" directuid="${ndireto.comId}"
                                                             id="${ndireto.comId}">
                                                            <a href="#">
                                                                    ${ndireto.nickname}
                                                            </a>
                                                            &nbsp;<font color="#8b5de4">回复</font>
                                                            <a href="#">${ndire.nickname}</a>

                                                                ${ndireto.comCount}
                                                            <br/>
                                                            &nbsp;
                                                            <a class="small"
                                                               onclick="addNdirectTextArea(this,${ndireto.comId});"></a>&nbsp;
                                                            <small class="text-muted"><fmt:formatDate type="both"
                                                                                                      value="${ndireto.comTime}"></fmt:formatDate></small>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>
                                </c:if>

                            </div>
                        </c:forEach>
                        <div class="social-comment">
                            <div class="media-body">
                                <textarea class="form-control rootcontent saytext" placeholder="填写评论..."></textarea>
                                    <%--<p><span class="emotion">表情</span>--%>
                                <button type="button" class="btn btn-primary "
                                        style="float: right;margin-top: 5px" onclick="submitroot()">发表评论
                                </button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>


                </c:if>
            </div>

        </div>


    </div>
</div>
<!-- 全局js -->
<script src="${staticPath}/js/jquery.min.js?v=2.1.4"></script>
<script src="${staticPath}/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${staticPath}/js/plugins/layer/layer.min.js"></script>
<!-- 自定义js -->
<script src="${staticPath}/js/content.js?v=1.0.0"></script>

<script type="text/javascript">

    function zan(s, a) {
        $.ajax({
            url: "${staticPath}/addzanDy",
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

    $(function () {
        $.ajax({
            url: "${staticPath}/lookCommentNum",
            type: "get",
            dataType: "json",
            data: {"topicid": ${requestScope.topic.id}},
            success: function (result) {
                if (result.code == 100) {
                    $("#com_zan").text(result.extend.Com_num + "评论");
                }
            }
        });
    });

    function submitroot() {
        var count = $(".saytext").val();

        if (count == null || count === '') {
            layer.msg("内容不能为空！");
            return false;
        }

        $.ajax({
            url: "${staticPath}/insertComment",
            type: "get",
            dataType: "json",
            data: {"topicId":  ${requestScope.topic.id}, "comCount": count},
            success: function (result) {
                if (result.code == 100) {
                    layer.msg("评论成功！");
                    location.reload();
                } else {
                    layer.msg("评论失败！");
                    location.reload();
                }
            }
        });
    }


    /*根评论的非直接评论*/
    function addNdirectTextArea(obj, direcid) {
        if ($('#ndirect').length > 0) {
            $('#ndirect').remove();
        }
        if ($('#direct').length > 0) {
            $('#direct').remove();
        }
        var parentName = $(obj).parent().children().first('a').text().trim();
        var html = '<div class="social-comment" id="ndirect"> <a  class="pull-left"> <img alt="image" style="width: 27px;height:27px;" src="${staticPath}${sessionScope.userinfo.imgHeah}"/> </a> <div class="media-body"> <textarea class="form-control Ndirectcontent"  placeholder="@' + parentName + '"></textarea> <button type="button" class="btn btn-primary "  style="float: right;margin-top: 1px" onclick="submitNdirect(this,' + direcid +
            ')">发表评论</button> ' +
            '<button type="button" class="btn btn-primary " onclick="cancle(this)" style="float: right;margin-top: 1px;margin-right:2px">取消</button></div> </div>';
        $(obj).parent().after(html);
    }

    function submitNdirect(obj, direcid) {
        var parentuid = $(obj).parent().parent().prev().attr('directuid');
        var content = $(".Ndirectcontent").val().trim();
        if (content == null || content == '') {
            layer.tips("不允许为空", $('.Ndirectcontent'));
            return false;
        }
        $.ajax({
            url: '${staticPath}/insertComment',
            type: 'post',
            dataType: "json",
            data: {comCount: content, topicId:${requestScope.topic.id}, comFid: parentuid},
            success: function (result) {
                if (result.code == 100) {
                    layer.msg("评论成功！");
                    location.reload();
                } else {
                    layer.msg("评论失败！");
                    location.reload();
                }
            }
        });

    }

    function submitdirect(obj, rootcid) {

        var content = $('.directcontent').val().trim();
        if (content == null || content == '') {
            layer.tips("不允许为空", $('.directcontent'));
            return false;
        }
        $.ajax({
            url: '${staticPath}/insertComment',
            type: 'post',
            dataType: "json",
            data: {comCount: content, topicId:${requestScope.topic.id}, comFid: rootcid},
            success: function (result) {
                if (result.code == 100) {
                    layer.msg("评论成功！");
                    location.reload();
                } else {
                    layer.msg("评论失败！");
                    location.reload();
                }
            }
        });
    }

    /*根评论的直接评论*/
    function adddirecTextArea(obj) {
        if ($('#ndirect').length > 0) {
            $('#ndirect').remove();
        }
        if ($('#direct').length > 0) {
            $('#direct').remove();
        }
        var rootid = $(obj).parent().parent().attr('rootcid');
        var rootname = $(obj).parent().children().first('a').text().trim();

        var html = '<div class="social-comment" id="direct"> <a  class="pull-left"> <img alt="image" style="width: 27px;height:27px;" src="${staticPath}${sessionScope.userinfo.imgHeah}"/> </a> <div class="media-body"> <textarea class="form-control directcontent"  placeholder="@' + rootname + '"></textarea> <button type="button" class="btn btn-primary "  style="float: right;margin-top: 1px" onclick="submitdirect(this,' + rootid + ')">发表评论</button>' +
            '<button type="button" class="btn btn-primary " onclick="cancle(this)" style="float: right;margin-top: 1px;margin-right:2px">取消</button> </div> </div>';
        $(obj).parent().after(html);
    }


    /*取消*/
    function cancle(obj) {
        $(obj).parent().parent().remove();
    }

    /**获取#后面的cid并用颜色展示**/
    function lookTheComment() {
        var href = window.location.href;
        var a = href.split("#");
        if (a[1] != null) {
            $('#' + a[1]).css({background: '#E0E0E0'});
        }
    }

    lookTheComment();
</script>


</body>

</html>

