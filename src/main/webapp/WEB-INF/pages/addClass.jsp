
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>添加班级</title>
</head>
<body style="width: 90%">
<div class="tab-pane" id="updata_id">
    <form class="form-horizontal">
        <div class="form-group">
        </div>
        <div class="form-group">
            <label  class="col-sm-5 control-label">班级:</label>
            <div class="col-sm-3">
                <input type="text"  name="className"    class="form-control" id="className" placeholder="请输入添加的部门名称">
                <span  class="help-block"></span>
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

    </form>
    <div class="form-group">
        <div class="col-sm-offset-6">
            <button onclick="add()" class="btn btn-success" id="add-btn">确认</button>
        </div>
    </div>

</div>
</body>
<script>
    function add() {
        var className=$("#className").val();
        var deptNameId=$("#deptName select").val();
        var jiid=$("#jibie select").val();

        if(className == '' || deptNameId == '' || jiid == ''){
            layer.msg("名称不能为空！",{anim:6}) ;
            return false;
        }

        $.ajax({
            url:"${staticPath}/addClass",
            type:"get",
            dataType: "json",
            data:{"className":className,"deptNameId":deptNameId,"jiid":jiid},
            success:function (result) {
                if(result.code==100){
                    layer.load(0,{time:2000});
                    setTimeout(function (args) {
                        layer.msg("添加成功！");
                    },2000);
                }else {
                    layer.load(0,{time:2000});
                    setTimeout(function (args) {
                        layer.msg("添加失败！年级存在！");
                    },2000);
                }
                setTimeout(function () {
                    window.location.href="/addClassNameJsp";
                },3000);
            }
        });
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
                    var optionEle=$("<option></option>").append(this.dengji).attr("value",this.jid);
                    optionEle.appendTo("#jibie select");
                });
            }
        });
    });
</script>
</html>



