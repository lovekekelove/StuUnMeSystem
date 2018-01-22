
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


        <div class="form-group" id="deptName">
            <label  class="col-sm-5 control-label">系部:</label>
            <div class="col-sm-3">
                <select class="form-control" name="deptName" >
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

    </form>
    <div class="form-group">
        <div class="col-sm-offset-6">
            <button onclick="comInfo()" class="btn btn-success" id="update-btn">确认分配</button>
        </div>
    </div>
</div>

</body>
<script>
    function comInfo() {
        var deptNameId=$("#deptName select").val();
        var deptStuId=$("#dept select").val();
        if(deptNameId == '' || deptStuId ==''){
            layer.msg("名称不能为空！",{anim:6}) ;
            return false;
        }

        $.ajax({
            url:"${staticPath}/giveDeptStu",
            type:"GET",
            dataType: "json",
            data:{"deptNameId":deptNameId,"deptStuId":deptStuId},
            success:function (result) {
                if(result.code==100){
                    layer.load(0,{time:2000});
                    setTimeout(function (args) {
                        layer.msg("分配成功！");
                    },2000);
                }else {
                    layer.load(0,{time:2000});
                    setTimeout(function () {
                        layer.msg("分配失败！该系存在此部门！");
                    },2000);
                }
                setTimeout(function () {
                    window.location.href="/giveDeptStuJsp";
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

    //显示部门
    $(function () {
        $.ajax({
            url:"${staticPath}/deptStus2",
            type:"GET",
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

