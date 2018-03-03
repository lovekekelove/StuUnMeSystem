
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>纳新</title>
</head>
<body style="width: 90%">
<div class="tab-pane" id="complInfo">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label"></label>
            <div class="col-sm-4">
                <h2 class="text-danger">请认真填写纳新资料</h2>
            </div>
        </div>
        <div class="form-group">

            <label class="col-sm-3 control-label">照片:</label>
            <div class="col-sm-3">
                <img id="myheadimg" readonly="readonly" src="${staticPath}/img/add.png"
                     style="cursor: hand;width: 150px;height: 150px ;" onclick="imgitem();"
                     class="img-circle" alt="User Image">
            </div>
        </div>
        <div class="form-group" id="political">
            <label class="col-sm-3 control-label">学号:</label>
            <div class="col-sm-3">
                <input type="text" name="stuId" class="form-control" id="stuNum" placeholder="请输入您的学号">
                <span class="help-block"></span>
            </div>
            <label class="col-sm-1 control-label">政治面貌:</label>
            <div class="col-sm-3">
                <select class=" form-control" name="political" id="poli">
                    <option value="">请选择：</option>
                    <option value="中共党员">中共党员</option>
                    <option value="中共预备党员">中共预备党员</option>
                    <option value="共青团员">共青团员</option>
                    <option value="群众">群众</option>
                </select>
            </div>

        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">系部:</label>
            <div class="col-sm-3" id="deptName">
                <select class="form-control" name="deptName">
                    <option value="">请选择：</option>
                </select>
            </div>
            <label class="col-sm-1 control-label">年级:</label>
            <div class="col-sm-3" id="jibie">
                <select class="form-control" name="dId">
                    <option value="">请选择：</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">部门:</label>
            <div class="col-sm-3" id="dept">
                <select class="form-control" name="dId">
                    <option value="">请选择：</option>
                </select>
            </div>
            <label class="col-sm-1 control-label">班级:</label>
            <div class="col-sm-3" id="classs">
                <select class="form-control" name="classId">
                    <option value="">请选择：</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">兴趣爱好:</label>
            <div class="col-sm-7">
                <textarea class="form-control" rows="3" id="prec"></textarea>
            </div>
        </div>

    </form>
    <div class="form-group">
        <div class="col-sm-offset-6">
            <button onclick="comInfo()" class="btn btn-success" id="update-btn">确认</button>
        </div>
    </div>
</div>

</body>
<script>
    function imgitem() {
        layer.open({
            type: 2,
            title: '更换头像',
            shadeClose: true,
            shade: 0.8,
            area: ['1000px', '500px'],
            content: '${staticPath}/changeheadimg.jsp' //iframe的url
        });
    }
    function comInfo() {
        var stuNum = $("#stuNum").val();//学号
        var political = $("#political select").val();//面貌
        var deptNameId = $("#deptName select").val();//系部id
        var jiid = $("#jibie select").val();//年级
        var deptid = $("#dept select").val();//部门
        var classs = $("#classs select").val();//班级
        var precCon = $("#prec").val();//兴趣爱好

        var regStuNum = /^([2-9][0-9][1-9][0-9]\d{6})$/;

        var headimg = $('#myheadimg').attr('src');//照片
        if (headimg == "${staticPath}/img/add.png") {
            layer.msg("请添加照片！", {anim: 6, icon: 5});
            return false;
        }

        if (!regStuNum.test(stuNum)) {
            layer.msg("学号格式不正确！", {anim: 6, icon: 5});
            return false;
        }

        if (stuNum == '' || political == '' || classs == '' || deptNameId == '' || jiid == '' || deptid == '') {
            layer.msg("内容不能为空！", {anim: 6, icon: 5});
            return false;
        }

        layer.confirm("确认提交吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/naXingPeoPle",
                type: "post",
                dataType: "json",
                data: {
                    "stuId": stuNum, "political": political, "dId": deptNameId,
                    "jiId": jiid, "deptId": deptid, "classId": classs, "picture": headimg, "speciality": precCon
                },
                success: function (result) {
                    if (result.code == 100) {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("资料提交成功，等待通知", {anim: 2, icon: 6});
                        }, 2000);
                    } else if (result.extend.error == 500) {
                        layer.load(0, {time: 2000});
                        setTimeout(function () {
                            layer.msg("不能重复提交！", {anim: 6, icon: 5});
                        }, 2000);
                    }
                    else {
                        layer.load(0, {time: 2000});
                        setTimeout(function () {
                            layer.msg("资料提交失败，从新提交", {anim: 6, icon: 5});
                        }, 2000);
                    }
                }
            });
        }, function () {

        });

    };
    //显示系部
    $(function () {
        $.ajax({
            url: "${staticPath}/deptNames2",
            type: "GET",
            dataType: "json",
            success: function (result) {
                $.each(result.extend.deptNames, function () {
                    var optionEle = $("<option></option>").append(this.deptname).attr("value", this.id);
                    optionEle.appendTo("#deptName select");
                });
            }
        });
    });
    //显示年级
    $(function () {
        $.ajax({
            url: "${staticPath}/jibies",
            type: "GET",
            dataType: "json",
            success: function (result) {
                $.each(result.extend.jibies, function () {
                    var optionEle = $("<option></option>").append(this.dengji).attr("value", this.jid);
                    optionEle.appendTo("#jibie select");
                });
            }
        });
    });
    //显示部门
    $("#deptName select").change(function () {
        $("#dept select ").empty();
        $("#classs select").empty();
        var deptNameId = $("#deptName select").val();
        var jiid = $("#jibie select").val();
        $.ajax({
            url: "${staticPath}/depts",
            type: "GET",
            data: {"deptNameId": deptNameId},
            dataType: "json",
            success: function (result) {
                $.each(result.extend.list, function () {
                    var optionEle = $("<option></option>").append(this.deptStuName).attr("value", this.id);
                    optionEle.appendTo("#dept select");
                });
            }
        });

        $.ajax({
            url: "${staticPath}/classs",
            type: "GET",
            data: {"deptNameId": deptNameId, "jiid": jiid},
            dataType: "json",
            success: function (result) {
                $.each(result.extend.list, function () {
                    var optionEle = $("<option></option>").append(this.className).attr("value", this.id);
                    optionEle.appendTo("#classs select");
                });
            }
        });

    });

    //显示部门
    $("#jibie select").change(function () {

        $("#classs select").empty();
        var deptNameId = $("#deptName select").val();
        var jiid = $("#jibie select").val();
        $.ajax({
            url: "${staticPath}/classs",
            type: "GET",
            data: {"deptNameId": deptNameId, "jiid": jiid},
            dataType: "json",
            success: function (result) {
                $.each(result.extend.list, function () {
                    var optionEle = $("<option></option>").append(this.className).attr("value", this.id);
                    optionEle.appendTo("#classs select");
                });
            }
        });

    });


</script>
</html>
