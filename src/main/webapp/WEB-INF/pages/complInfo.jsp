
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>完善资料</title>
</head>
<body style="width: 90%">
<div class="tab-pane" id="updata_id">
    <form class="form-horizontal">
        <div class="form-group">
        </div>
        <div class="form-group">
            <label  class="col-sm-5 control-label">学号:</label>
            <div class="col-sm-3">
                <input type="password"  name="stuId"    class="form-control" id="pwd1" placeholder="请输入您的学号">
                <span  class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-5 control-label">政治面貌:</label>
            <div class="col-sm-3">
            <select class=" form-control"  name="political" id="poli">
                <option value="">请选择：</option>
                <option value="">中共党员</option>
                <option value="">中共预备党员</option>
                <option value="">共青团员</option>
                <option value="">群众</option>
            </select>
            </div>
        </div>
        <div class="form-group" id="deptName">
            <label  class="col-sm-5 control-label">系部:</label>
            <div class="col-sm-3">
                <select class="form-control" name="deptName" >
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

        <div class="form-group">
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

    }
//显示系部
    $(function () {
        $.ajax({
            url:"${staticPath}/deptNames2",
            type:"GET",
            dataType: "json",
            success:function (result) {
                $.each(result.extend.deptNames,function(){
                    var optionEle=$("<option></option>").append(this.deptname).attr("value",this.id);
                    optionEle.appendTo("#deptName select");
                });
            }
        });
    });
//显示年级
    $(function () {
        $.ajax({
            url:"${staticPath}/jibies",
            type:"GET",
            dataType: "json",
            success:function (result) {
                $.each(result.extend.jibies,function(){
                    var optionEle=$("<option></option>").append(this.dengji).attr("value",this.id);
                    optionEle.appendTo("#jibie select");
                });
            }
        });
    });
 //显示部门
    $("#deptName select").change(function () {
        $("#dept select").empty();
        var deptNameId=$("#deptName select").val();
        $.ajax({
            url:"${staticPath}/depts",
            type:"GET",
            data: {"deptNameId":deptNameId},
            dataType: "json",
            success:function (result) {
                $.each(result.extend.list,function(){
                    var optionEle=$("<option></option>").append(this.deptStuName).attr("value",this.id);
                    optionEle.appendTo("#dept select");
                });
            }
        });

        $.ajax({
            url:"${staticPath}/depts",
            type:"GET",
            data: {"deptNameId":deptNameId},
            dataType: "json",
            success:function (result) {
                $.each(result.extend.list,function(){
                    var optionEle=$("<option></option>").append(this.deptStuName).attr("value",this.id);
                    optionEle.appendTo("#dept select");
                });
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
</script>
</html>

