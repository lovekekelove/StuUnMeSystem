
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>修改密码</title>
</head>
<body style="width: 90%">
<div class="tab-pane" id="updata_id">
    <form class="form-horizontal">
        <div class="form-group">
        </div>
        <div class="form-group">
            <label for="email" class="col-sm-5 control-label">邮箱:</label>
            <div class="col-sm-3">
                <p class="form-control" id="email">${sessionScope.userinfo.email}</p>
                <span  class="help-block"></span>
            </div>
        </div>

        <div class="form-group">
            <label for="pwd1" class="col-sm-5 control-label">新密码:</label>
            <div class="col-sm-3">
                <input type="password"  name="password"    class="form-control" id="pwd1" placeholder="请输入您的新密码">
                <span  class="help-block"></span>
            </div>
        </div>

        <div class="form-group">
            <label for="pwd2" class="col-sm-5 control-label">确认密码:</label>
            <div class="col-sm-3">
                <input type="password"  name="pwd"   class="form-control" id="pwd2" placeholder="请输入确认您的密码">
                <span  class="help-block"></span>
            </div>
        </div>

    </form>
    <div class="form-group">
        <div class="col-sm-offset-6">
            <button onclick="updatePwd()" class="btn btn-success" id="update-btn">确认修改</button>
        </div>
    </div>
</div>

</body>
<script>
    function updatePwd() {
        var pwd1=$("#pwd1").val();
        var pwd2=$("#pwd2").val();
        var regPwd=/^([a-z0-9A-Z]{6,14})$/;
        if(pwd1==''){
            show_validate_msg("#pwd1","error","请输入密码！");
            return false;
        }else if(!regPwd.test(pwd1)){
            show_validate_msg("#pwd1","error","密码格式不对！");
            return false;
        }else{
            show_validate_msg("#pwd1","success","");
        }

        if(pwd2==''){
            show_validate_msg("#pwd2","error","请输入密码！");
            return false;
        }else if(pwd2==pwd1){
            show_validate_msg("#pwd2","success","");
        }else{
            show_validate_msg("#pwd2","error","两次密码不一致！");
            return false;
        }

        $.ajax({
            url:"/user/updatePwd",
            type:"POST",
            dataType: "json",
            data: {"password":pwd1},
            success:function (result) {
                if(result.code == 100) {
                    layer.load(0,{time:2000});
                    setTimeout(function (args) {
                        layer.msg("修改成功！将在下次登录使用！") ;
                    },2000);

                    setTimeout(function () {
                        window.location.href="/user/changePwd";
                    },3000);
                }
            }
        });
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
</script>
</html>
