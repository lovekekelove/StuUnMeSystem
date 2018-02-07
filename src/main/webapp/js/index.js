
<!--退出系统-->
$("#logout").click(function () {
    $.ajax({
        type: "POST",
        url: "/user/logout",
        dataType: "json",
        success: function (result) {
            if(result.code == 100){
                // console.log(result)
                window.location.href = "/";
            }
        }
    });
});

//注册用户

$("#user_save_btn").click(function () {



    if(!check()){
        return false;
    }

    if($(this).attr("ajax_va1")=="error" ||
        $(this).attr("ajax_va")=="error" ||
        $(this).attr("ajax_va2")=="error"){
      return  false;
    }


   var arr=$("#stuAdd form").serialize();
    $.ajax({
        url: "/user/reg",
        type:"POST",
        dataType: "json",
        data: arr,//序列化保存的数据
        success:function (result) {
            //员工保存成功
            if(result.code == 100) {
                alert("注册成功！");
                //1.关闭模态框
                $('#stuAdd').modal('hide')
            }else{
                if(result.code == 200){

                    if(result.extend.errors == 'email'){
                        show_validate_msg("#iemail","error","邮箱已存在！");
                    }
                    if(result.extend.errors == 'niname'){
                        show_validate_msg("#niname","error","昵称已存在！");
                    }
                    if(result.extend.errors == 'error'){
                        show_validate_msg("#iyzm","error","验证码输入错误！");
                    }
                    else {
                        show_validate_msg("#iemail", "error", result.extend.errorFileds.email);
                    }
                }
            }
        }
    });
});

//清除表单数据和样式
function reset_form(ele) {
    $(ele)[0].reset();
    //清除表单样式
    $(ele).find("*").removeClass("has-success has-error");
    $(ele).find(".help-block").text("");
}

<!--忘记密码，修改密码-->
$("#wangjimima").click(function () {
    //1.关闭模态框
    $("#stulogin").modal('hide');
    setTimeout(function(){
        reset_form("#changePwd form");
        $("#changePwd").modal({
            backdrop:"static"
        });
    },600);
    //2打开修改密码的模态框
});

function checkyzm() {
    var email=$("#sEmail").val();
    var pwd=$("#stupassword1").val();
    var pwd2=$("#stupassword2").val();
    var regPwd=/^([a-z0-9A-Z]{6,14})$/;
    if(email==''){
        show_validate_msg("#sEmail","error","请输入邮箱！");
        return false;
    }
    if(pwd==''){
        show_validate_msg("#stupassword1","error","请输入密码！");
        return false;

    }else if(!regPwd.test(pwd)){
        show_validate_msg("#stupassword1","error","密码格式不对！");
        return false;
    }else{
        show_validate_msg("#stupassword1","success","");
        return true;
    }

    if(pwd2==''){
        show_validate_msg("#stupassword2","error","请输入密码！");
        return false;
    }else if(pwd==pwd2){
        show_validate_msg("#stupassword2","success","");
        return true;
    }else{
        show_validate_msg("#stupassword2","error","两次密码不一致！");
        return false;
    }

    var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if(!regEmail.test(email)){
        //alert("邮箱格式不正确")
        return  false;
    }
}
<!--获取验证码-->
function getyzm(obj) {
    var email=$("#sEmail").val();
    if(!checkyzm()){
        return false;
    }

    changetime(obj,'#mimayzm');//倒计时60s
    $.ajax({
        type: 'get',
        url: '/user/sendyzm',
        dataType: "json",
        data: {"email":email},
        success: function (result) {
            if(result.code==100){
                show_validate_msg("#sEmail","success","");
                $("#stu_change_btn").attr("ajax_va","success");
                window.setTimeout(show,65000);
                function show()
                {
                    $.ajax ({
                        type: 'get',
                        data: {"email":email},
                        url: '/user/checkoutyzm',
                        dataType: "json",
                        success: function (result) {
                            if(result.code==100){
                                yzmre('#mimayzm');
                                $(obj).removeAttr('disabled');
                            }
                        }
                    });
                }
            }else{
                show_validate_msg("#sEmail","error",result.extend.va_msg);
                $("#stu_change_btn").attr("ajax_va","error");
                yzmre('#mimayzm');
                $(obj).removeAttr('disabled');
            }
        }
    });
}

var countdown=60;

function  changetime(obj,ele) {
    if (countdown == 0) {
        yzmre(ele);
        $(obj).removeAttr('disabled');
        $(obj).text("获取验证码");
        countdown = 60;
        return false;
    } else {
        yzmzt(ele);
        $(obj).attr({'disabled': 'disabled'});
        $(obj).text("重新发送(" + countdown + ")");
        countdown--;
    }
    setTimeout(function() {
        changetime(obj);
    },1000);
}

function yzmzt(ele) {
    $(ele).removeAttr('readonly');
}

function yzmre(ele) {
    $(ele).attr({'readonly': 'readonly'});
}

//修改密码验证邮箱
$("#sEmail").change(function () {
    var email=$("#sEmail").val();
    if(email==''){
        show_validate_msg("#sEmail","error","邮箱不能为空！");
        $("#emp_save_btn").attr("ajax_va","success");
    }

    var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if(!regEmail.test(email)){
        //alert("邮箱格式不正确")
        show_validate_msg("#sEmail","error","邮箱格式不正确");

    }else{
        show_validate_msg("#sEmail","success"," ");
    }
});

<!--确认修改密码-->
$("#stu_change_btn").click(function () {
    var email=$("#sEmail").val();
    var pwd2=$("#stupassword2").val();
    var mimayzm=$("#mimayzm").val();
    var regY=/^([0-9]{6})$/;
    if(!regY.test(mimayzm)){
        show_validate_msg("#mimayzm","error","格式错误，请重新输入！");
        return false;
    }else if(mimayzm ==''){
        show_validate_msg("#mimayzm","error","请在60s内输入验证码！");
        return false;
    }else {
        show_validate_msg("#mimayzm","success","");
    }

    if($(this).attr("ajax_va")=="error"){
        return false;
    }

    $.ajax({
        url: "/user/intoalterpassword",
        type:"POST",
        dataType: "json",
        cache: false,
        data: {"email":email,"password":pwd2,"yzm":mimayzm},
        success:function (result) {
            if(result.code==100){
                alert("密码修改成功！");
                $("#changePwd").modal('hide');
            }else {
                 $("#changePwd").modal('hide');
            }
        }
    });
});

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
function validate_add_form(eles) {

    //校验email
    var empEmail= $(eles).val();
    var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if(!regEmail.test(empEmail)){
        //alert("邮箱格式不正确")
        show_validate_msg(eles,"error","邮箱格式不正确");
        return false;
    }else{
        show_validate_msg(eles,"success","");
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
    validate_add_form("#stuEmail");
});

$("#stu_login_btn").click(function () {

    if(!validate_add_form("#stuEmail")){
        return false;
    }
    var email=$("#stuEmail").val();
    var pwd=$("#stupassword").val();
    //2.发送ajax请求保存员工
    $.ajax({
        url: "/user/login",
        type:"POST",
        dataType: "json",
        data: {"email":email,"password":pwd},
        success:function (result) {
            // console.log(result.code);
            if(result.code == 100) {
                //1.关闭模态框
                $("#stulogin").modal('hide');
                window.location.href = "/";
            }else{
                if(result.code == 404){
                    show_validate_msg("#stuEmail","error",result.extend.errors);
                }
                if(result.code == 200){
                    show_validate_msg("#stupassword","error",result.extend.errors);
                }
            }
        }
    });
});



// function Datetime() {
$('#ibrith').datetimepicker({
    language: 'zh-CN',//显示中文
    format: 'yyyy-mm-dd',//显示格式
    minView: "month",//设置只显示到月份
    initialDate: new Date(),
    autoclose: true,//选中自动关闭
    todayBtn: true,//显示今日按钮
    locale: moment.locale('zh-cn')
});
//默认获取当前日期
var today = new Date();
var nowdate = (today.getFullYear()) + "-" + (today.getMonth() + 1) + "-" + today.getDate();
//对日期格式进行处理
var date = new Date(nowdate);
var mon = date.getMonth() + 1;
var day = date.getDate();
var mydate = date.getFullYear() + "-" + (mon < 10 ? "0" + mon : mon) + "-" + (day < 10 ? "0" + day : day);
document.getElementById("ibrith").value = mydate;

$("#niname").change(function () {
    var nickname = $('#niname').val().trim();
    var rniname=/^([a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})$/;
        $.ajax({
            url: "/user/nicheng",
            data:{"nickname":nickname},
            type:"get",
            dataType: "json",
            success:function (result) {
                if(result.code==100){
                    //验证昵称
                    if (nickname == null || nickname == '') {
                        show_validate_msg("#niname","error","昵称不能为空！");
                        $("#user_save_btn").attr("ajax_va1","error");
                    } else if(!rniname.test(nickname)){
                        show_validate_msg("#niname","error","昵称可以是2-5位中文或者5-16位英文和数字的组合");
                        $("#user_save_btn").attr("ajax_va1","error");
                    } else {
                        show_validate_msg("#niname","success","昵称可以使用！");
                        $("#user_save_btn").attr("ajax_va1","success");
                    }
                }else {
                    show_validate_msg("#niname","error","昵称已经被使用！");
                     $("#user_save_btn").attr("ajax_va1","error");
                    validate_yz_button();
                }
            }
        });
    });
function validate_yz_button(ele) {
    if(ele=='error') {
        $("#make_yz_btn").attr({'disabled': 'disabled'});
    }else if(ele='success'){
        $("#make_yz_btn").removeAttr('disabled');
    }
}

$("#iemail").change(function () {
    var email = $('#iemail').val().trim();
    var remail = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
    $.ajax({
        url: "/user/yEmail",
        data:{"email":email},
        type:"get",
        dataType: "json",
        success:function (result) {
            if(result.code==100){
                //验证昵称
                if (email == null || email == '') {
                    show_validate_msg("#iemail","error","邮箱不能为空！");
                    $("#user_save_btn").attr("ajax_va","error");
                    validate_yz_button('error');
                } else if(!remail.test(email)){
                    show_validate_msg("#iemail","error","邮箱格式不对！");
                    $("#user_save_btn").attr("ajax_va","error");
                    validate_yz_button('error');
                } else {
                    show_validate_msg("#iemail","success","邮箱可以注册使用！");
                    $("#user_save_btn").attr("ajax_va","success");
                    validate_yz_button('success');
                }
            }else {
                show_validate_msg("#iemail","error","邮箱已经被使用！");
                $("#user_save_btn").attr("ajax_va","error");
                validate_yz_button('error');
            }
        }
    });
});

function check() {
    var password = $('#ipwd').val().trim();
    var age = $('#iage').val().trim();
    var name = $('#iname').val().trim();
    var phone = $('#iphone').val().trim();
    var brith = $('#ibrith').val().trim();
    var docuaddress = $('#iaddress').val().trim();
    var yzm = $('#iyzm').val().trim();

    var rpassword = /^[\w]{6,12}$/;
    var rname=/^(^[\u2E80-\u9FFF]{2,15})$/;
    var rage=/^([0-9]{2})$/;
    var rbrith=/^((?:19|20)\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
    var rphone=/^1[3|4|5|7|8|9][0-9]\d{8}$/;
    var rpwd=/^([a-zA-Z0-9]{6,16})$/;
    var raddress = /^(([1|2][0-9])|[1-9])-([1-6][0-2][0-9]|[1-6][3][1-5])$/;
    var ryzm=/^[0-9]{6}$/;
    //验证姓名
    if(name == null || name == ''){
        show_validate_msg("#iname","error","姓名不能为空！");
        return false;
    }else if (!rname.test(name)) {
        show_validate_msg("#iname","error","姓名可以是2-15位中文！");
        return false;
    } else {
        show_validate_msg("#iname","success","");
    }
   //验证年龄
    if(age == null || age == ''){
        show_validate_msg("#iage","error","年龄不能为空！");
        return false;
    }else if (!rage.test(age)) {
        show_validate_msg("#iage","error","年龄只能为两位数字！");
        return false;
    } else {
        show_validate_msg("#iage","success","");
    }

    //验证出生年月
    if(brith == null || brith == ''){
        show_validate_msg("#ibrith","error","出生年月不能为空！");
        return false;
    }else {
        show_validate_msg("#ibrith","success","");
    }
    //验证手机号
    if(phone == null || phone == ''){
        show_validate_msg("#iphone","error","手机不能为空！");
        return false;
    }else if (!rphone.test(phone)) {
        show_validate_msg("#iphone","error","手机格式不正确！");
        return false;
    } else {
        show_validate_msg("#iphone","success","");
    }

    //验证住址
    if (docuaddress == null || docuaddress == '') {
        show_validate_msg("#iaddress","error","住址不能为空！");
        return false;
    } else if (!raddress.test(docuaddress)) {
        show_validate_msg("#iaddress","error","请输入正确的寝室住址！");
        return false;
    } else {
        show_validate_msg("#iaddress","success","");
    }
    //验证密码
    if (password == null || password == '') {
        show_validate_msg("#ipwd","error","密码不能为空！");
        return false;
    } else if (!rpwd.test(password)) {
        show_validate_msg("#ipwd","error","密码格式不正确！");
        return false;
    } else {
        show_validate_msg("#ipwd","success","");
        return true;
    }

    if (yzm == null || yzm == '') {
        show_validate_msg("#iyzm","error","验证码不能为空！");
        return false;
    } else if (!ryzm.test(yzm)) {
        show_validate_msg("#iyzm","error","验证码格式不正确！");
        return false;
    } else {
        show_validate_msg("#iyzm","success","");
        return true;
    }
}

<!--获取注册验证码-->
function getyzm2(obj) {
    var email = $('#iemail').val().trim();
    var remail = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
    if (email == null || email == '') {
        show_validate_msg("#iemail","error","邮箱不能为空！");
        return false;
    } else if(!remail.test(email)){
        show_validate_msg("#iemail","error","邮箱格式不对！");
        return false;
    } else{
        show_validate_msg("#iemail","success","");
    }


    if(!check()){
        return false;
    }

    changetime(obj,'#iyzm');//倒计时60s

    $.ajax({
        type: 'get',
        url: '/user/sendyzm2',
        dataType: "json",
        data: {"email":email},
        success: function (result) {
            if(result.code==100){
                show_validate_msg("#iemail","success","");
                $("#user_save_btn").attr("ajax_va2","success");
                window.setTimeout(show,60000);
                function show()
                {
                    $.ajax ({
                        type: 'get',
                        data: {"email":email},
                        url: '/user/checkoutyzm',
                        dataType: "json",
                        success: function (result) {
                            if(result.code==100){
                                yzmre('#iyzm');
                                $(obj).removeAttr('disabled');
                            }
                        }
                    });
                }
            }else{
                show_validate_msg("#iemail","error",result.extend.va_msg);
                $("#user_save_btn").attr("ajax_va2","error");
                yzmre('#iyzm');
                $(obj).removeAttr('disabled');
            }
        }
    });
}

$("#peocenter").click(function () {
    window.location.href = "/user/personCon";
});

////////////////////////////评论区////////////////////////////


$("#leaveMSG").click(function () {
    var id = $("#peocenter").attr("mark");
    if (id == undefined) {
        return false;
    }
    var msg = layer.open({
        type: 2,
        title: '留言板',
        shadeClose: false,
        shade: 0.6,
        // maxmin: true, //开启最大化最小化按钮
        //area: ['864px', '600px'],
        content: '/leaveMsg'
    });
    layer.full(msg);
});

$("#news_msg").click(function () {
    var id = $("#peocenter").attr("mark");

    if (id == undefined) {
        return false;
    }
    var msg = layer.open({
        type: 2,
        title: '学生会动态',
        shadeClose: false,
        shade: 0.6,
        // maxmin: true, //开启最大化最小化按钮
        //area: ['864px', '600px'],
        content: '/newsMsg'
    });
    layer.full(msg);
});


