package com.stumesystem.controller;

import com.stumesystem.bean.Msg;
import com.stumesystem.bean.StuRight;
import com.stumesystem.service.StuRightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class StuRightController {

    @Autowired
    private StuRightService stuRightService;

    /**
     * 删除角色的权限
     *
     * @return
     */
    public Msg deleteRightWithRose(@RequestParam("rgId") Integer rgId, @RequestParam("rid") Integer rid,@RequestParam("fid") Integer fid) {
        List<StuRight> fidRight=stuRightService.getStuRightByFid(fid);
        List<StuRight> ridRight=stuRightService.getRightByRoseId(rid);
        boolean flag=false;
        if (stuRightService.deleteRightWithRose(rgId, rid) > 0) {
            for (StuRight fidRId:fidRight){
                for (StuRight ridId:ridRight){
                    if(fidRId.getId()==ridId.getId()){
                        flag=false;
                    }else {
                        flag=true;
                    }
                }
            }
            if(flag){
                if(stuRightService.deleteRightWithRoseByFid(fid,rid)>0){
                    return Msg.success();
                }
            }
            return Msg.success();
        }
        return Msg.fail();
    }


}
