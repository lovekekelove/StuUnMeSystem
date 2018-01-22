$("#niname").change(function () {
    var nickname = $('#niname').val().trim();
    var rniname=/^([a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})$/;
    $.ajax({
        url:"/user/nicheng",
        data:{"nickname":nickname},
        type:"get",
        dataType: "json",
        success:function (result) {
            if(result.code==100){
                //验证昵称
                if (nickname == null || nickname == '') {
                    show_validate_msg("#niname","error","昵称不能为空！");
                    $("#update-btn").attr("ajax_va1","error");
                } else if(!rniname.test(nickname)){
                    show_validate_msg("#niname","error","昵称可以是2-5位中文或者5-16位英文和数字的组合");
                    $("#update-btn").attr("ajax_va1","error");
                } else {
                    show_validate_msg("#niname","success","昵称可以使用！");
                    $("#update-btn").attr("ajax_va1","success");
                }
            }else {
                show_validate_msg("#niname","error","昵称已经被使用！");
                $("#update-btn").attr("ajax_va1","error");
            }
        }
    });
});

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

function check() {
    var age = $('#iage').val().trim();
    var name = $('#iname').val().trim();
    var phone = $('#iphone').val().trim();
    var brith = $('#ibrith').val().trim();
    var docuaddress = $('#iaddress').val().trim();

    var rpassword = /^[\w]{6,12}$/;
    var rname=/^(^[\u2E80-\u9FFF]{2,15})$/;
    var rage=/^([0-9]{2})$/;
    var rbrith=/^((?:19|20)\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
    var rphone=/^1[3|4|5|7|8|9][0-9]\d{8}$/;
    var rpwd=/^([a-zA-Z0-9]{6,16})$/;
    var raddress=/^(([1|2][0-9])|[1-9])-([1-6][0-2][0-9]|[1-6][3][1-5])$/;
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
        return true;
    }

}