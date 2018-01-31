<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>成功学院学生会</title>
    <link rel="icon" href="/img/bb.ico">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/static/css/caidan.css">
    <link rel="stylesheet" href="/static/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="/static/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-blue.min.css">

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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-envelope-o"></i>
                            <span class="label label-success">4</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">您有4条信息待处理</li>
                            <li class="footer"><a href="#">查看所有信息</a></li>
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
<script src="/static/jquery/jquery-2.2.3.min.js"></script>
<script src="/js/click.js"></script>
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

</script>

<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>


<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/dist/js/pages/dashboard.js"></script>
<script src="/static/dist/js/app.js"></script>
<script src="/static/dist/js/demo.js"></script>


</body>
</html>
