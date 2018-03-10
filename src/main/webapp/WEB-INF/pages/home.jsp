<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%--<%@ include file="../../common/commons.jsp" %>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>成功学院学生会</title>
    <link rel="icon" href="/img/bb.ico">
    <!-- Tell the browser to be responsive to screen width -->
    <%--<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">--%>
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="${staticPath}/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${staticPath}/static/css/caidan.css">
    <link rel="stylesheet" href="${staticPath}/static/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="${staticPath}/static/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${staticPath}/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${staticPath}/static/dist/css/skins/skin-blue.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

    <![endif]-->

</head>
<body class="skin-blue sidebar-collapse sidebar-mini">
<div class="wrapper">

    <!-- Main Header -->
    <header class="main-header">

        <!-- Logo -->
        <a href="#" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><h4>${sessionScope.userinfo.name}--欢迎您！</h4></span>
        </a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>

            <!-- Navbar Right Menu -->
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <!-- Messages: style can be found in dropdown.less-->
                    <li class="dropdown messages-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle advice" data-toggle="dropdown">
                            <i class="fa fa-envelope-o"></i>
                            <span class="label label-success"></span>
                        </a>
                        <ul class="dropdown-menu">

                            <li id="advice_msg">
                                <!-- inner menu: contains the actual data -->
                            </li>

                        </ul>
                    </li>

                    <li class="dropdown messages-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle num" data-toggle="dropdown">
                            <i class="fa fa-bell-o"></i>
                            <span class="label label-success"></span>
                        </a>
                        <ul class="dropdown-menu ">
                            <li id="option_msg">
                                <!-- inner menu: contains the actual data -->

                            </li>
                        </ul>
                    </li>

                    <li class="dropdown messages-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle talk" data-toggle="dropdown">
                            <i class="fa fa-flag-o"></i>
                            <span class="label label-success"></span>
                        </a>
                        <ul class="dropdown-menu">

                            <li id="msg_talk">
                                <!-- inner menu: contains the actual data -->
                            </li>

                        </ul>
                    </li>
                    <!-- /.messages-menu -->
                    <!-- User Account Menu -->
                    <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- The user image in the navbar-->
                            <img src="${sessionScope.userinfo.imgHeah}" class="user-image user_head_img" alt="User Image">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs user_name"></span>
                        </a>

                        <ul class="dropdown-menu">
                            <!-- User image -->
                            <li class="user-header">
                                <img src="${sessionScope.userinfo.imgHeah}" class="img-circle" alt="User Image">

                            </li>
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="${staticPath}/" class="btn btn-default btn-flat">主页</a>
                                </div>
                                <div class="pull-right">
                                    <a href="${staticPath}/user/logout2" class="btn btn-default btn-flat">退出</a>
                                </div>
                            </li>
                        </ul>

                    </li>

                </ul>
            </div>
        </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">

        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">

            <!-- Sidebar user panel (optional) -->
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="${sessionScope.userinfo.imgHeah}" class="img-circle  user_head_img" alt="User Image">
                </div>
                <div class="pull-left info">
                    <p class="user_name">${sessionScope.userinfo.nickname}</p>
                    <!-- Status -->
                    <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                </div>
            </div>



            <!-- Sidebar Menu -->
            <ul class="sidebar-menu">

            </ul>
        </section>
            <!-- /.sidebar-menu -->

        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->

        <!-- Main content -->
        <section class="center" >
            <div class="row J_mainContent" id="content-main">
                <iframe id="J_iframe" width="100%" height="550" src="${staticPath}/user/welcome" frameborder="0"
                        scrolling="auto">
                </iframe>
            </div>
            <!-- Your Page Content Here -->
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <footer class="main-footer text-center">
        <strong>Copyright &copy; 2018 <a href="http://www.chenggong.edu.cn/">成功学院</a>.</strong> All rights reserved.
    </footer>

</div>
<script src="${staticPath}/static/jquery/jquery-2.2.3.min.js"></script>
<script src="${staticPath}/js/click.js"></script>
<script>
    $(function () {
        $.ajax({
            url: "${staticPath}/rights",
            type: "get",
            dataType: "json",
            success: function (result) {
                $.each(result.extend.rights, function (index, item) {
                    if (item.fid == null) {
                        var FIDTd = $("<a href='#'></a>").append($("<i></i>").addClass(item.url))
                            .append($("<span></span>").append(item.right).append($("<span></span>")
                                .addClass("pull-right-container").append($("<i></i>").addClass("fa fa-angle-left pull-right"))));
                    }
                    var UidTd = $("<ul></ul>");
                    $.each(result.extend.rights, function (index, s) {
                        if (s.fid == item.id) {
                            UidTd.addClass("treeview-menu").append($("<li></li>").append($("<a></a>").addClass("J_menuItem").attr("href", "${staticPath}/" + s.url).append(s.right)));
                        }
                    });
                    $("<li></li>").append(FIDTd).append(UidTd).appendTo(".sidebar-menu");
                });
            }
        });
    });

    $(function () {
        msg_point();
        msg_talk();
        msg_advice();
    });

    function msg_advice() {
        $.ajax({
            url: "${staticPath}/user/advice",
            type: "get",
            dataType: "json",
            success: function (result) {
                $(".advice span").text(result.extend.num == 0 ? "" : result.extend.num);
                $("#advice_msg").empty();
                $.each(result.extend.pointMsgs, function (index, p) {
                    var rcount = p.msgCount.substring(p.msgCount.indexOf(",") + 1, p.msgCount.length);
                    var topicid = p.msgCount.substring(0, p.msgCount.indexOf(","));
                    var tishi = $("<li ></li>").append("&nbsp;&nbsp;&nbsp;&nbsp;").append("<i class='fa fa-user text-green'></i>").append("&nbsp;").append(rcount.substring(0, 58)).append(
                        $("<span></span>")
                            .append($("<button topic_id='" + topicid + "' count='" + rcount + "' advice_id='" + p.id + "' ></button>")
                                .addClass("btn btn-default btn-xs btn-success pull-right   look_advice_btn").append("查看")));

                    $("<ul class=\"menu\"></ul>")
                        .append(tishi)
                        .appendTo("#advice_msg");

                });
            }
        });
    };


    function msg_point() {
        $.ajax({
            url: "${staticPath}/user/pointMsg",
            type: "get",
            dataType: "json",
            success: function (result) {
                $(".num span").text(result.extend.num == 0 ? "" : result.extend.num);
                $("#option_msg").empty();
                $.each(result.extend.pointMsgs, function (index, p) {

                    var tishi = $("<li ></li>").append("&nbsp;&nbsp;&nbsp;&nbsp;").append("<i class='fa fa-user text-green'></i>").append("&nbsp;").append(p.msgCount).append(
                        $("<span></span>")
                            .append($("<button uid='" + p.sendUid + "'></button>")
                                .addClass("btn btn-default btn-xs btn-success pull-right   look_btn").append("查看")));

                    $("<ul class=\"menu\"></ul>")
                        .append(tishi)
                        .appendTo("#option_msg");

                });
            }
        });
    };

    function msg_talk() {
        $.ajax({
            url: "${staticPath}/user/msgTalk",
            type: "get",
            dataType: "json",
            success: function (result) {
                $(".talk span").text(result.extend.num == 0 ? "" : result.extend.num);
                $("#msg_talk").empty();
                $.each(result.extend.pointMsgs, function (index, p) {
                    var tishi = $("<li ></li>").append("&nbsp;&nbsp;&nbsp;&nbsp;").append("<i class='fa fa-users text-aqua'></i>").append("&nbsp;").append(p.msgCount).append(
                        $("<span></span>")
                            .append($("<button talk_id='" + p.id + "'></button>")
                                .addClass("btn btn-default btn-xs btn-success pull-right   dle_msg_btn").append("删除")));

                    $("<ul class=\"menu\"></ul>")
                        .append(tishi)
                        .appendTo("#msg_talk");

                });
            }
        });
    };

    $(document).on("click", ".look_btn", function () {
        var send_id = $(this).attr("uid");
        layer.open({
            type: 2,
            title: '添加好友',
            shadeClose: false,
            shade: false,
            // maxmin: true, //开启最大化最小化按钮
            area: ['474px', '437px'],
            content: '${staticPath}/lookFriendMsg?send_id=' + send_id,
            end: function () {
                msg_point();
            }
        });
    });
    //查看通知
    $(document).on("click", ".look_advice_btn", function () {
        var count = $(this).attr("count");
        var advice_id = $(this).attr("advice_id");
        var topic_id = $(this).attr("topic_id");
        if (count === "您有一条消息回复") {
            window.location.href = "${staticPath}/user/lookAdvice?id=" + advice_id;
            window.location.href = "${staticPath}/lookTopic?id=" + topic_id + "&&advice_id=" + advice_id;
            return false;
        }
        layer.open({
            type: 2,
            title: '通知',
            shadeClose: false,
            shade: false,
            // maxmin: true, //开启最大化最小化按钮
            area: ['474px', '437px'],
            content: '${staticPath}/lookFAdviceMsg.jsp?count=' + count + '&&id=' + advice_id,
            end: function () {
                msg_advice();
            }
        });
    });

    $(document).on("click", ".dle_msg_btn", function () {
        var talk_id = $(this).attr("talk_id");
        $.ajax({
            url: "${staticPath}/delMsgTalk?id=" + talk_id,
            type: "get",
            dataType: "json",
            success: function (result) {
                if (result.code = 100) {
                    msg_talk();
                }
            }
        });
    });


</script>

<!-- Bootstrap 3.3.6 -->
<script src="${staticPath}/static/bootstrap/js/bootstrap.min.js"></script>

<script src="${staticPath}/js/plugins/layer/layer.js"></script>
<script src="${staticPath}/js/plugins/layer/laypage/laypage.js"></script>
<!-- AdminLTE App -->
<script src="${staticPath}/static/dist/js/app.min.js"></script>
<script src="${staticPath}/static/dist/js/pages/dashboard.js"></script>
<script src="${staticPath}/static/dist/js/app.js"></script>
<script src="${staticPath}/static/dist/js/demo.js"></script>


</body>
</html>
