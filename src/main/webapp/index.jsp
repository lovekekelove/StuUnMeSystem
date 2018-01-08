<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/base.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="img/bb.ico">
    <title>成功学院学生会</title>
    <!-- Bootstrap core CSS -->

    <script src="js/jquery-1.12.4.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/SmoothScroll.js"></script>
    <script src="js/theme-scripts.js"></script>

    <link href="js/datatime/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="js/datatime/moment-with-locales.js"></script>
    <script src="js/datatime/bootstrap-datetimepicker.min.js"></script>
    <script src="js/datatime/bootstrap-datetimepicker.zh-CN.js"></script>

    <script src="${staticPath}/js/plugins/layer/layer.min.js"></script>
    <script src="${staticPath}/js/plugins/layer/laypage/laypage.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body id="page-top">
<!--修改密码-->
<div class="modal fade" id="changePwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <br>
                    <div class="form-group">
                        <label for="stuEmail" class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="sEmail" placeholder="123@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="stupassword" class="col-sm-2 control-label">新密码:</label>
                        <div class="col-sm-9">
                            <input type="password" name="password" class="form-control" id="stupassword1" placeholder="yourpassword">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stupassword2" class="col-sm-2 control-label">确认密码:</label>
                        <div class="col-sm-9">
                            <input type="password" name="password" class="form-control" id="stupassword2" placeholder="yourpassword">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2"></div>
                        <div class="col-sm-6">
                            <input id="mimayzm" type="text" readonly class="form-control" placeholder="验证码"/>
                            <span  class="help-block"></span>
                        </div>
                        <div class="col-sm-3">
                            <button type="button" class="btn btn-danger" onclick="getyzm(this);">获取验证码</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="stu_change_btn">确定</button>
            </div>
        </div>
    </div>
</div>
<!--login-->
<div class="modal fade" id="stulogin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户登录</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <br>
                    <div class="form-group">
                        <label for="stuEmail" class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="stuEmail" placeholder="123@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="stupassword" class="col-sm-2 control-label">密码:</label>
                        <div class="col-sm-9">
                            <input type="password" name="password" class="form-control" id="stupassword" placeholder="yourpassword">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <span id="wangjimima" class="col-sm-3 " style="cursor: pointer;color: red">忘记密码？</span>
                <span class="col-sm-4 "></span>
                <button type="button" class="btn btn-default col-sm-2" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary col-sm-2" id="stu_login_btn">Save</button>
            </div>
        </div>
    </div>
</div>
<!--注册-->
<div class="modal fade" id="stuAdd" tstuabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">用户注册</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <br>
                    <div class="form-group">
                        <label for="iname" class="col-sm-2 control-label">姓名:</label>
                        <div class="col-sm-9">
                            <input type="text" name="name" class="form-control" id="iname" placeholder="请输入您的姓名">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别:</label>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="isex1" value="M" checked> MAN
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="isex2" value="w"> WOMAN
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="iage" class="col-sm-2 control-label">年龄:</label>
                        <div class="col-sm-9">
                            <input type="text" name="age" class="form-control" id="iage" placeholder="请输入您的年龄">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="niname" class="col-sm-2 control-label">昵称:</label>
                        <div class="col-sm-9">
                            <input type="text" name="nickname" class="form-control" id="niname" placeholder="请输入您的昵称">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ibrith" class="col-sm-2 control-label">出生年月:</label>
                        <div class="col-sm-9">
                                <input type='text' name="brith" class="form-control" id='ibrith' placeholder="请选择您的出生日期" />
                                <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="iphone" class="col-sm-2 control-label">联系方式:</label>
                        <div class="col-sm-9">
                            <input type="text" name="phone" class="form-control" id="iphone" placeholder="请输入您的联系方式">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="iaddress" class="col-sm-2 control-label">寝室住址:</label>
                        <div class="col-sm-9">
                            <input type="text" name="docuAddress" class="form-control" id="iaddress" placeholder="请输入您的寝室住址（几号楼/几号房间）">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="iemail" class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="iemail" placeholder="请输入您的邮箱">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ipwd" class="col-sm-2 control-label">密码:</label>
                        <div class="col-sm-9">
                            <input type="text" name="password" class="form-control" id="ipwd" placeholder="请输入您的密码">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2"></div>
                        <div class="col-sm-6">
                            <input id="iyzm" type="text" name="yzm" readonly class="form-control" placeholder="验证码"/>
                            <span  class="help-block"></span>
                        </div>
                        <div class="col-sm-3">
                            <button type="button" class="btn btn-danger" onclick="getyzm2(this);">获取验证码</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="user_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- Navigation -->
<nav class="navbar navbar-default">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <span class="navbar-brand page-scroll">
                <div>
                    <img src="img/aa.png"  width="70" height="70"><a>郑州成功财经学院学生会</a>
                </div>
               </span>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="hidden">
                    <a href="#page-top"></a>
                </li>
                <li>
                    <a class="page-scroll" href="#about">关于学院</a>
                </li>
                <c:if test="${not empty sessionScope.userinfo}">
                <li>
                    <a class="page-scroll" id="peocenter" style="cursor: pointer">个人中心</a>
                </li>
                <li>
                    <a class="page-scroll"  id="logout" style="cursor: pointer">退出</a>
                </li>
                </c:if>
                <c:if test="${ empty sessionScope.userinfo}">
                <li>
                    <a class="page-scroll" id="resert" style="cursor: pointer">注册</a>
                </li>
                <li>
                   <a class="page-scroll"  id="login" style="cursor: pointer">登录</a>
                </li>
                </c:if>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>


<section id="portfolio">
    <div class="container">
        <%--<div class="row">--%>
            <%--<div class="col-lg-12 text-center">--%>
                <%--<div class="section-title">--%>
                    <%--<h2>Our Works</h2>--%>
                    <%--<p>Our portfolio is the best way to show our work, you can see here a big range of our work. Check them all and you will find what you are looking for.</p>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="row row-0-gutter">
            <!-- start portfolio item -->
            <div class="col-md-6 col-0-gutter">
                <div class="ot-portfolio-item">
                    <figure class="effect-bubba">
                        <img src="img/demo/portfolio-1.jpg" alt="img02" class="img-responsive" />
                        <figcaption>
                            <h2>Dean & Letter</h2>
                            <p>Branding, Design</p>
                            <a href="#" data-toggle="modal" data-target="#Modal-1">View more</a>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <!-- end portfolio item -->
            <!-- start portfolio item -->
            <div class="col-md-6 col-0-gutter">
                <div class="ot-portfolio-item">
                    <figure class="effect-bubba">
                        <img src="img/demo/portfolio-2.jpg" alt="img02" class="img-responsive" />
                        <figcaption>
                            <h2>Startup Framework</h2>
                            <p>Branding, Web Design</p>
                            <a href="#" data-toggle="modal" data-target="#Modal-2">View more</a>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <!-- end portfolio item -->
        </div>
        <div class="row row-0-gutter">
            <!-- start portfolio item -->
            <div class="col-md-6 col-0-gutter">
                <div class="ot-portfolio-item">
                    <figure class="effect-bubba">
                        <img src="img/demo/portfolio-3.jpg" alt="img02" class="img-responsive" />
                        <figcaption>
                            <h2>Lamp & Velvet</h2>
                            <p>Branding, Web Design</p>
                            <a href="#" data-toggle="modal" data-target="#Modal-3">View more</a>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <!-- end portfolio item -->
            <!-- start portfolio item -->
            <div class="col-md-6 col-0-gutter">
                <div class="ot-portfolio-item">
                    <figure class="effect-bubba">
                        <img src="img/demo/portfolio-4.jpg" alt="img02" class="img-responsive" />
                        <figcaption>
                            <h2>Smart Name</h2>
                            <p>Branding, Design</p>
                            <a href="#" data-toggle="modal" data-target="#Modal-4">View more</a>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <!-- end portfolio item -->
        </div>
        <div class="row row-0-gutter">
            <!-- start portfolio item -->
            <div class="col-md-6 col-0-gutter">
                <div class="ot-portfolio-item">
                    <figure class="effect-bubba">
                        <img src="img/demo/portfolio-5.jpg" alt="img02" class="img-responsive" />
                        <figcaption>
                            <h2>Fast People</h2>
                            <p>Branding, Web Design</p>
                            <a href="#" data-toggle="modal" data-target="#Modal-5">View more</a>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <!-- end portfolio item -->
            <!-- start portfolio item -->
            <div class="col-md-6 col-0-gutter">
                <div class="ot-portfolio-item">
                    <figure class="effect-bubba">
                        <img src="img/demo/portfolio-6.jpg" alt="img02" class="img-responsive" />
                        <figcaption>
                            <h2>Kites & Stars</h2>
                            <p>Branding, Web Design</p>
                            <a href="#" data-toggle="modal" data-target="#Modal-2">View more</a>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <!-- end portfolio item -->
        </div>
    </div><!-- container -->
</section>

<section id="about" class="mz-module">
    <div class="container light-bg">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <h2>郑州成功财经学院</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 text-center">
                <div class="mz-about-container">
                    <p>郑州成功财经学院(Zhengzhou Chenggong University Of Finance And Economics,ZCGU)简称“成功学院”，是一所位于河南省巩义市的私立应用型大学，建于2004年，前身为河南财经政法大学成功学院，2012年3月更为现名。[1]
                        学校现有三个校区，分别是东校区、西校区、北校区，建筑总面积50余万平方米以上，设有9个教学院系和3个教学部，截止到目前在校生为20000余人[2]  </p>
                </div>
            </div>
            <div class="col-md-6">
                <!-- skill bar item -->
                <div class="skillbar-item">
                    <div class="skillbar" data-percent="90%">
                        <h3>Web design</h3>
                        <div class="skillbar-bar">
                            <div class="skillbar-percent" style="width: 90%;">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- skill bar item -->
                <div class="skillbar-item">
                    <div class="skillbar" data-percent="80%">
                        <h3>Development</h3>
                        <div class="skillbar-bar">
                            <div class="skillbar-percent" style="width: 80%;">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- skill bar item -->
                <div class="skillbar-item">
                    <div class="skillbar" data-percent="85%">
                        <h3>Photography</h3>
                        <div class="skillbar-bar">
                            <div class="skillbar-percent" style="width: 85%;">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- skill bar item -->
                <div class="skillbar-item">
                    <div class="skillbar" data-percent="70%">
                        <h3>Marketing</h3>
                        <div class="skillbar-bar">
                            <div class="skillbar-percent" style="width: 70%;">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container -->
</section>

<section id="team">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <h2>Our Team</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- team member item -->
            <div class="col-md-4">
                <div class="team-item">
                    <div class="team-image">
                        <img src="img/1.jpg" class="img-responsive" alt="author">
                    </div>
                    <div class="team-text">
                        <h3>TOM BEKERS</h3>
                        <div class="team-position">CEO & Web Design</div>
                        <p>Mida sit una namet, cons uectetur adipiscing adon elit. Aliquam vitae barasa droma.</p>
                    </div>
                </div>
            </div>
            <!-- end team member item -->
            <!-- team member item -->
            <div class="col-md-4">
                <div class="team-item">
                    <div class="team-image">
                        <img src="img/1.jpg" class="img-responsive" alt="author">
                    </div>
                    <div class="team-text">
                        <h3>LINA GOSATA</h3>
                        <div class="team-position">Photography</div>
                        <p>Worsa dona namet, cons uectetur dipiscing adon elit. Aliquam vitae fringilla unda mir.</p>
                    </div>
                </div>
            </div>
            <!-- end team member item -->
            <!-- team member item -->
            <div class="col-md-4">
                <div class="team-item">
                    <div class="team-image">
                        <img src="img/1.jpg" class="img-responsive" alt="author">
                    </div>
                    <div class="team-text">
                        <h3>John BEKERS</h3>
                        <div class="team-position">Marketing</div>
                        <p>Dolor sit don namet, cons uectetur beriscing adon elit. Aliquam vitae fringilla unda.</p>
                    </div>
                </div>
            </div>
            <!-- end team member item -->
        </div>
    </div>
</section>


<p id="back-top">
    <a href="#top"><i class="fa fa-angle-up"></i></a>
</p>
<footer>
    <div class="container text-center">
        <p>Designed by 张腾飞 - More Templates  - Collect from <a href="http://www.chenggong.edu.cn/" title="成功学院" target="_blank">成功学院</a></p>
    </div>
</footer>

<!-- Modal for portfolio item 1 -->
<div class="modal fade" id="Modal-1" tabindex="-1" role="dialog" aria-labelledby="Modal-label-1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="Modal-label-1">Dean & Letter</h4>
            </div>
            <div class="modal-body">
                <img src="img/demo/portfolio-1.jpg" alt="img01" class="img-responsive" />
                <div class="modal-works"><span>Branding</span><span>Web Design</span></div>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for portfolio item 2 -->
<div class="modal fade" id="Modal-2" tabindex="-1" role="dialog" aria-labelledby="Modal-label-2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="Modal-label-2">Startup Framework</h4>
            </div>
            <div class="modal-body">
                <img src="img/demo/portfolio-2.jpg" alt="img01" class="img-responsive" />
                <div class="modal-works"><span>Branding</span><span>Web Design</span></div>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for portfolio item 3 -->
<div class="modal fade" id="Modal-3" tabindex="-1" role="dialog" aria-labelledby="Modal-label-3">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="Modal-label-3">Lamp & Velvet</h4>
            </div>
            <div class="modal-body">
                <img src="img/demo/portfolio-3.jpg" alt="img01" class="img-responsive" />
                <div class="modal-works"><span>Branding</span><span>Web Design</span></div>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for portfolio item 4 -->
<div class="modal fade" id="Modal-4" tabindex="-1" role="dialog" aria-labelledby="Modal-label-4">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="Modal-label-4">Smart Name</h4>
            </div>
            <div class="modal-body">
                <img src="img/demo/portfolio-4.jpg" alt="img01" class="img-responsive" />
                <div class="modal-works"><span>Branding</span><span>Web Design</span></div>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for portfolio item 5 -->
<div class="modal fade" id="Modal-5" tabindex="-1" role="dialog" aria-labelledby="Modal-label-5">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="Modal-label-5">Fast People</h4>
            </div>
            <div class="modal-body">
                <img src="img/demo/portfolio-5.jpg" alt="img01" class="img-responsive" />
                <div class="modal-works"><span>Branding</span><span>Web Design</span></div>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<!--引入jqury-->
<script src="js/index.js"></script>
</body>
</html>
