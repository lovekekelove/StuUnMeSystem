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

    <%@ include file="../../common/commons.jsp" %>
    <script src="${staticPath}/js/jquery-3.2.1.js"></script>

    <link href="${staticPath}/js/datatime/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="${staticPath}/js/datatime/moment-with-locales.js"></script>
    <script src="${staticPath}/js/datatime/bootstrap-datetimepicker.min.js"></script>
    <script src="${staticPath}/js/datatime/bootstrap-datetimepicker.zh-CN.js"></script>

    <link rel="stylesheet" href="${staticPath}/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${staticPath}/static/css/caidan.css">
    <link rel="stylesheet" href="${staticPath}/static/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="${staticPath}/static/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${staticPath}/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="${staticPath}/static/dist/css/skins/skin-blue.min.css">

    <![endif]-->

</head>
<body>
<div class="tab-pane" id="updata_id">
    <form class="form-horizontal">
        <div class="form-group">
            <div class="col-sm-5"></div>
            <div class="col-sm-4">
                <img id="myheadimg" readonly="readonly" src="${sessionScope.userinfo.imgHeah}" style="cursor: hand;width: 200px;height: 200px" onclick="imgitem();" class="img-circle" alt="User Image" >
            </div>
        </div>

        <div class="form-group">
            <label for="iname" class="col-sm-2 control-label">姓名:</label>
            <div class="col-sm-3">
                <input type="text"  name="name" class="form-control" readonly="readonly" value="${sessionScope.userinfo.name}" id="iname" placeholder="请输入您的姓名">
                <span  class="help-block"></span>
            </div>

            <label for="ibrith" class="col-sm-2 control-label">出生年月:</label>
            <div class="col-sm-3">
                <input type='text' name="brith"  disabled="disabled" class="form-control" value='<fmt:formatDate value="${sessionScope.userinfo.brith}" type="date"/>' id='ibrith' placeholder="请选择您的出生日期" />
                <span  class="help-block"></span>
            </div>
        </div>


        <div class="form-group">

            <label  class="col-sm-2 control-label">性别:</label>
            <div class="col-sm-3">

                <label class="radio-inline">
                    <input type="radio"  disabled="disabled"  name="sex" ${sessionScope.userinfo.sex=='M'?'checked':''}  id="isex1" value="M"> 男
                </label>
                <label class="radio-inline">
                    <input type="radio" disabled="disabled" name="sex" ${sessionScope.userinfo.sex=='W'?'checked':''} id="isex2" value="W"> 女
                </label>
            </div>
            <label for="niname" class="col-sm-2 control-label">昵称:</label>
            <div class="col-sm-3">
                <input type="text" readonly="readonly" name="nickname"  value="${sessionScope.userinfo.nickname}"  class="form-control" id="niname" placeholder="请输入您的昵称">
                <span  class="help-block"></span>
            </div>
        </div>

        <div class="form-group">
            <label for="iage" class="col-sm-2 control-label">年龄:</label>
            <div class="col-sm-3">
                <input type="text" readonly="readonly" name="age" value="${sessionScope.userinfo.age}"  class="form-control" id="iage" placeholder="请输入您的年龄">
                <span  class="help-block"></span>
            </div>
            <label for="iaddress" class="col-sm-2 control-label">寝室住址:</label>
            <div class="col-sm-3">
                <input type="text" readonly="readonly" name="docuAddress" value="${sessionScope.userinfo.docuAddress}" class="form-control" id="iaddress" placeholder="请输入您的寝室住址（几号楼-几号房间）">
                <span  class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="iphone" class="col-sm-2 control-label">联系方式:</label>
            <div class="col-sm-3">
                <input type="text" readonly="readonly" name="phone" value="${sessionScope.userinfo.phone}" class="form-control" id="iphone" placeholder="请输入您的联系方式">
                <span  class="help-block"></span>
            </div>
        </div>
    </form>
    <div class="form-group">
        <div class="col-sm-offset-5 col-sm-10 ">
            <button id="change" class="btn btn-danger">编辑</button>
            <button  onclick="save();" class="btn btn-success" id="update-btn">更新</button>
        </div>
    </div>
</div>

</body>


<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/dist/js/app.js"></script>
<script src="/static/dist/js/demo.js"></script>
<script src="${staticPath}/js/change.js"></script>


<script>
    function imgitem() {

    if($("#myheadimg").attr('readonly')=="readonly"){
        return false;
    }
        layer.open({
            type: 2,
            title: '更换头像',
            shadeClose: true,
            shade: 0.8,
            area: ['1000px', '500px'],
            content: '${staticPath}/changeheadimg.jsp' //iframe的url
        });
    }

    $('#ibrith').datetimepicker({
        language: 'zh-CN',//显示中文
        format: 'yyyy-mm-dd',//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),
        autoclose: true,//选中自动关闭
        todayBtn: true,//显示今日按钮
        locale: moment.locale('zh-cn')
    });


    function save() {

        // var arr=$("#updata_id form").serialize();
        var age = $('#iage').val().trim();
        var name = $('#iname').val().trim();
        var phone = $('#iphone').val().trim();
        var brith = $('#ibrith').val().trim();
        var docuaddress = $('#iaddress').val().trim();
        var sex = $(':radio:checked').val();
        var nickname = $('#niname').val().trim();

        if(!check()){
            return false;
        }

        if($(this).attr("ajax_va1")=="error" ){
            return  false;
        }

        if($(":input").attr("readonly")=="readonly"){
            return false;
        }
            var flag = 0;
            var headimg = $('#myheadimg').attr('src');
            if (headimg != "${staticPath}${sessionScope.userinfo.imgHeah}") {
                flag = 1;
            } else {
                flag = 0;
            }
            $.ajax({
                url: '/user/alterInfo',
                type: 'post',
                dataType: "json",
                data: {
                    name: name,
                    nickname: nickname,
                    sex: sex,
                    brith: brith,
                    imgHeah: headimg,
                    phone: phone,
                    docuAddress: docuaddress,
                    age: age,
                    flag: flag
                },
                success: function (data) {
                 if(data.code==100){
                     layer.load(0,{time:2000});
                     setTimeout(function (args) {
                         layer.msg("修改成功！") ;
                     },2000);
                     setTimeout(function () {
                         window.location.href="/user/changeinfo";
                     },3000);
                    }
                }
            });
    }

   $("#change").click(function () {
       $(":input").removeAttr('readonly','readonly');
       $("#myheadimg").removeAttr('readonly');
       $(":input").removeAttr('disabled');
   });


</script>
</body>

</html>

