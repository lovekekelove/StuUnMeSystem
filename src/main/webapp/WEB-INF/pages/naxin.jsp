<%--
  Created by IntelliJ IDEA.
  User: 13719
  Date: 2018/3/3
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>纳新</title>
</head>
<body style="width: 90%">
<div class="tab-pane" id="complInfo">
    <form class="form-horizontal">
        <div class="form-group">
        </div>
        <div class="form-group">
            <label class="col-sm-5 control-label">学号:</label>
            <div class="col-sm-3">
                <input type="text" name="stuId" class="form-control" id="stuNum" placeholder="请输入您的学号">
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group" id="political">
            <label class="col-sm-5 control-label">政治面貌:</label>
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
        <div class="form-group" id="deptName">
            <label class="col-sm-5 control-label">系部:</label>
            <div class="col-sm-3">
                <select class="form-control" name="deptName">
                    <option value="">请选择：</option>
                </select>
            </div>
        </div>

        <div class="form-group" id="jibie">
            <label class="col-sm-5 control-label">年级:</label>
            <div class="col-sm-3">
                <select class="form-control" name="dId">
                    <option value="">请选择：</option>
                </select>
            </div>
        </div>

        <div class="form-group" id="dept">
            <label class="col-sm-5 control-label">部门:</label>
            <div class="col-sm-3">
                <select class="form-control" name="dId">
                    <option value="">请选择：</option>
                </select>
            </div>
        </div>

        <div class="form-group" id="classs">
            <label class="col-sm-5 control-label">班级:</label>
            <div class="col-sm-3">
                <select class="form-control" name="dId">
                    <option value="">请选择：</option>
                </select>
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
    function comInfo() {
        var stuNum = $("#stuNum").val();//学号
        var political = $("#political select").val();//面貌
        var deptNameId = $("#deptName select").val();//系部id
        var jiid = $("#jibie select").val();//年级
        var deptid = $("#dept select").val();//部门
        var classs = $("#classs select").val();//班级

        var regStuNum = /^([2-9][0-9][1-9][0-9]\d{6})$/;

        if (!regStuNum.test(stuNum)) {
            layer.msg("学号格式不正确！", {anim: 6, icon: 5});
            return false;
        }

        if (stuNum == '' || political == '' || classs == '' || deptNameId == '' || jiid == '' || deptid == '') {
            layer.msg("内容不能为空！", {anim: 6, icon: 5});
            return false;
        }
        $.ajax({
            url: "${staticPath}/compl",
            type: "post",
            dataType: "json",
            data: {
                "stuId": stuNum, "political": political, "dId": deptNameId,
                "jiid": jiid, "deptId": deptid, "classId": classs
            },
            success: function (result) {
                if (result.code == 100) {
                    layer.load(0, {time: 2000});
                    setTimeout(function (args) {
                        layer.msg("资料完善成功！", {anim: 2, icon: 6});
                    }, 2000);
                } else {
                    layer.load(0, {time: 2000});
                    setTimeout(function () {
                        layer.msg("资料完善失败！", {anim: 6, icon: 5});
                    }, 2000);
                }
                setTimeout(function () {
                    window.location.href = "/user/complInfo";
                }, 3000);
            }
        });
    }

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

    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text(" ");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
</script>
</html>
