<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>成功学院学生会</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->

    <script src="/js/home.js"></script>
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
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <!-- Main Header -->
    <header class="main-header">

        <!-- Logo -->
        <a href="/user/home" class="logo">
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
                <!-- Optionally, you can add icons to the links -->
                <c:forEach items="${requestScope.rights}" var="r">
                <li class="treeview">
                    <c:if test="${empty r.fid}">
                     <a href="#"><i class="${r.url}"></i>
                        <span>${r.rRight}</span>
                         <span class="pull-right-container">
                             <i class="fa fa-angle-left pull-right"></i>
                         </span>
                    </a>
                    </c:if>
                    <c:forEach items="${requestScope.rights}" var="s">
                        <c:if test="${s.fid==r.id}">
                    <ul class="treeview-menu">
                        <li><a class="J_menuItem" href="${staticPath}${s.url}">${s.rRight}</a></li>
                    </ul>
                        </c:if>
                    </c:forEach>
                </li>
                </c:forEach>
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
                <iframe id="J_iframe"  width="100%" height="550" src="${staticPath}/welcome.jsp" frameborder="0" scrolling="auto" >
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
<!-- ./wrapper -->
<%--<script>--%>
<%--function changeFrameHeight(){--%>
<%--var ifm= document.getElementById("J_iframe");--%>
<%--ifm.height=document.documentElement.clientHeight-56;--%>
<%--}--%>
<%--$(function(){changeFrameHeight();});--%>
<%--</script>--%>
<!-- REQUIRED JS SCRIPTS -->
<!-- jQuery 2.2.3 -->
<script src="/static/jquery/jquery-2.2.3.min.js"></script>
<script>
    $(function(){
        alert(1);
        $.ajax({
            type: 'get',
            url: '/user/personCon2',
            dataType: "json",
            success:function (result) {
                    $.each(result,function (index,rs) {
                        if(rs.fid==null){
                            var empTd=$("<span></span>").append(rs.rRight);
                        }
                        $.each(result.extend.rights,function (index,s) {


                        });
                    });
                }
        });
    });
</script>

<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>

<script src="/js/click.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/js/user.js"></script>
<script src="/static/dist/js/pages/dashboard.js"></script>
<script src="/static/dist/js/app.js"></script>
<script src="/static/dist/js/demo.js"></script>

</body>
</html>
