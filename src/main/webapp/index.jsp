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
    <title>成功学院学生会</title>
    <%@ include file="common/commons.jsp" %>
    <!-- Bootstrap core CSS -->
    <script src="${staticPath}/js/jquery-1.12.4.min.js"></script>
    <script src="${staticPath}/js/bootstrap.min.js"></script>
    <link href="${staticPath}/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${staticPath}/css/font-awesome.min.css">
    <!-- Custom styles for this template -->
    <link href="${staticPath}/css/style.css" rel="stylesheet">
</head>
<body id="page-top">
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
                        <label for="empName_add" class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="stuEmail" placeholder="123@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">密码:</label>
                        <div class="col-sm-9">
                            <input type="text" name="password" class="form-control" id="stupassword" placeholder="yourpassword">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <%--<div class="form-group">--%>
                        <%--<div class="col-md-2"></div>--%>
                        <%--<div class="col-sm-7">--%>
                            <%--<input id="yzm2" type="text" readonly class="form-control" placeholder="验证码"/>--%>
                        <%--</div>--%>
                        <%--<div class="col-sm-2">--%>
                            <%--<button type="button" class="btn btn-danger" onclick="getyzm(this);">获取验证码</button>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="stu_login_btn">Save</button>
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
                        <label for="empName_add" class="col-sm-2 control-label">姓名:</label>
                        <div class="col-sm-9">
                            <input type="text" name="empName" class="form-control" id="empName_add" placeholder="请输入您的姓名">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别:</label>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update" value="M" checked> MAN
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update" value="w"> WOMAN
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">年龄:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="请输入您的年龄">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">昵称:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="请输入您的昵称">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">出生年月:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="请输入您的出生年月">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">联系方式:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="请输入您的联系方式">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">寝室住址:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="请输入您的寝室住址">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add" class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-9">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="请输入您的邮箱">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2"></div>
                        <div class="col-sm-7">
                            <input id="yzm" type="text" readonly class="form-control" placeholder="验证码"/>
                        </div>
                        <div class="col-sm-2">
                            <button type="button" class="btn btn-danger" onclick="getyzm(this);">获取验证码</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
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
                    <img src="images/aa.png"  width="70" height="70"><a>郑州成功财经学院学生会</a>
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
                <li>
                    <a class="page-scroll" id="peocenter" style="cursor: pointer">个人中心</a>
                </li>

                <li>
                    <a class="page-scroll" id="resert" style="cursor: pointer">注册</a>
                </li>
                <li>
                    <a class="page-scroll"  id="login" style="cursor: pointer">登录</a>
                </li>
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
                        <img src="images/demo/portfolio-1.jpg" alt="img02" class="img-responsive" />
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
                        <img src="images/demo/portfolio-2.jpg" alt="img02" class="img-responsive" />
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
                        <img src="images/demo/portfolio-3.jpg" alt="img02" class="img-responsive" />
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
                        <img src="images/demo/portfolio-4.jpg" alt="img02" class="img-responsive" />
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
                        <img src="images/demo/portfolio-5.jpg" alt="img02" class="img-responsive" />
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
                        <img src="images/demo/portfolio-6.jpg" alt="img02" class="img-responsive" />
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
        <div class="row row-0-gutter">
            <!-- about module -->
            <div class="col-md-3 col-0-gutter mz-about-default text-center">
                <div class="mz-module-about">
                    <i class="fa fa-briefcase ot-circle"></i>
                    <h3>Web Development</h3>
                </div>
            </div>
            <!-- end about module -->
            <!-- about module -->
            <div class="col-md-3 col-0-gutter mz-about-dark text-center">
                <div class="mz-module-about">
                    <i class="fa fa-photo ot-circle"></i>
                    <h3>Visualisation</h3>
                </div>
            </div>
            <!-- end about module -->
            <!-- about module -->
            <div class="col-md-3 col-0-gutter mz-about-default text-center">
                <div class="mz-module-about">
                    <i class="fa fa-camera-retro ot-circle"></i>
                    <h3>Photography</h3>
                </div>
            </div>
            <!-- end about module -->
            <!-- about module -->
            <div class="col-md-3 col-0-gutter mz-about-dark text-center">
                <div class="mz-module-about">
                    <i class="fa fa-cube ot-circle"></i>
                    <h3>UI/UX Design</h3>
                </div>
            </div>
            <!-- end about module -->
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
                        <img src="images/demo/author-2.jpg" class="img-responsive" alt="author">
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
                        <img src="images/demo/author-6.jpg" class="img-responsive" alt="author">
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
                        <img src="images/demo/author-4.jpg" class="img-responsive" alt="author">
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

<section id="contact">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <h2>Contact Us</h2>
                    <p>If you have some Questions or need Help! Please Contact Us!<br>We make Cool and Clean Design for your Business</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 text-center">
                <form name="sentMessage" id="contactForm" novalidate="">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Your Name *" id="name" required="" data-validation-required-message="Please enter your name.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="email" class="form-control" placeholder="Your Email *" id="email" required="" data-validation-required-message="Please enter your email address.">
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <textarea class="form-control" placeholder="Your Message *" id="message" required="" data-validation-required-message="Please enter a message."></textarea>
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <div id="success"></div>
                            <button type="submit" class="btn">Send Message</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<p id="back-top">
    <a href="#top"><i class="fa fa-angle-up"></i></a>
</p>
<footer>
    <div class="container text-center">
        <p>Designed by MOOZThemes - More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>
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
                <img src="images/demo/portfolio-1.jpg" alt="img01" class="img-responsive" />
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
                <img src="images/demo/portfolio-2.jpg" alt="img01" class="img-responsive" />
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
                <img src="images/demo/portfolio-3.jpg" alt="img01" class="img-responsive" />
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
                <img src="images/demo/portfolio-4.jpg" alt="img01" class="img-responsive" />
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
                <img src="images/demo/portfolio-5.jpg" alt="img01" class="img-responsive" />
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

<script src="${staticPath}/js/bootstrap.min.js"></script>
<script src="${staticPath}/js/SmoothScroll.js"></script>
<script src="${staticPath}/js/theme-scripts.js"></script>
<script>
    //弹出模态框
    $("#login").click(function(){
        // //清除表单数据和样式
       reset_form("#stulogin form");
        //弹出模态框
        $("#stulogin").modal({
            backdrop:"static"
        });
    });

    $("#resert").click(function(){
        // //清除表单数据和样式
        reset_form("#stuAdd form");
        //弹出模态框
        $("#stuAdd").modal({
            backdrop:"static"
        });
    });

    //清除表单数据和样式
    function reset_form(ele) {
        $(ele)[0].reset();
        //清除表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    //校验表单数据
    function validate_add_form() {

        //校验email
        var empEmail=$("#stuEmail").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(empEmail)){
            //alert("邮箱格式不正确")
            show_validate_msg("#stuEmail","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#stuEmail","success","");
        }
        return true;
    }

    function show_validate_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text(" ");
        if("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#stuEmail").change(function () {
        validate_add_form();
    });

    $("#stu_login_btn").click(function () {

        if(!validate_add_form()){
            return false;
        }

        var email=$("#stuEmail").val();
        var pwd=$("#stupassword").val();
       //2.发送ajax请求保存员工
        $.ajax({
            url:"/user/check",
            type:"POST",
            data: {"email":email,"password":pwd},//序列化保存的数据
            success:function (result) {
                //员工保存成功
                if(result.code == 100) {
                    //1.关闭模态框
                    $("#stulogin").modal('hide');
                    window.location.href="/user/home";
                }else{
//                    console.log(result);
                    if(undefined != result.extend.errorFileds.email){
                        //显示邮箱的错误信息
                        show_validate_msg("#email_add","error",result.extend.errorFileds.email);
                    }

                    if(undefined != result.extend.errorFileds.empName){
                        //显示员工的错误信息
                        show_validate_msg("#empName_add","error",result.extend.errorFileds.empNamel);
                    }
                }
            }
        });
    });


        function getyzm(obj) {
            var email = $('#stuEmail').val().trim();
            var remail = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
            if (email != null && email != '') {
                if (!remail.test(email)) {
                    layer.tips("邮箱格式错误", $('#email'));
                } else {
                    $('#yzm').removeAttr('readonly');
                    $(obj).attr({'disabled': 'disabled'});
                    $.ajax({
                        type: 'get',
                        url: '/user/sendyzm3',
                        data: {email: email},
                        success: function (data) {
                            if (data == 'has_email') {
                                layer.msg("账号已注册！请确认！3秒后跳转到登录页面！");
                                setTimeout(function () {
                                    location.href = '/login.html';
                                }, 3000);
                            }
                        }
                    });
                    setTimeout(function () {
                        $(obj).removeAttr('disabled');
                    }, 45000);
                }
            } else {
                layer.tips("请输入邮箱", $('#email'));
            }
        }

    function check() {
        var email = $('#email').val().trim();
        var nickname = $('#nickname').val().trim();
        var password = $('#password').val().trim();
        var again = $('#again').val().trim();
        var yzm = $('#yzm').val().trim();
        var rpassword = /^[\w]{6,12}$/;
        var remail = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        if (email == null || email == '') {
            layer.tips("不能为空", $('#email'));
            return false;
        } else if (nickname == null || nickname == '') {
            layer.tips("不能为空", $('#nickname'));
            return false;
        } else if (password == null || password == '') {
            layer.tips("不能为空", $('#password'));
            return false;
        } else if (again == null || again == '') {
            layer.tips("不能为空", $('#again'));
            return false;
        } else if (!remail.test(email)) {
            layer.tips("邮箱格式错误", $('#email'));
            return false;
        } else if (!rpassword.test(password)) {
            layer.tips("6-12位字母、数字、下划线", $('#password'));
            return false;
        } else if (password != again) {
            layer.tips("两次密码输入不同", $('#again'));
            return false;
        } else if (yzm == null || yzm == '') {
            layer.tips("请输入验证码", $('#yzm'));
            return false;
        } else {
            return true;
        }
    }

    function submitf2() {
        var email = $('#email').val().trim();
        var nickname = $('#nickname').val().trim();
        var password = $('#password').val().trim();
        var yzm = $('#yzm').val().trim();
        //alert(email + ":" + nickname + ":" + password);
        if (check()) {
            //alert(email);
            $.ajax({
                type: 'post',
                url: "/user/checkRegister",
                dataType: "text",
                data: {uemail: email, unickname: nickname, upassword: password, yzm: yzm},
                success: function (data) {
                    if (data == "success") {
                        layer.msg("注册成功");
                        setTimeout(function () {
                            location.href = "/login.html";
                        }, 1000);
                    } else if (data == "busy") {
                        layer.msg("服务器繁忙");
                    } else if (data == "has") {
                        layer.tips("此邮箱已被注册！", $("#email"));
                    } else if (data == 'error_yzm') {
                        layer.tips("验证码错误！", $("#yzm"));
                    } else if (data == 'unknowerr') {
                        layer.msg("未知错误！");
                    } else {
                        layer.msg("请不要修改客户端！");
                    }

                }
            });
        }
    }

</script>
</body>
</html>
