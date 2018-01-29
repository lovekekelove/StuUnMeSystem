package com.stumesystem.service;

import com.stumesystem.bean.StuRight;
import com.stumesystem.bean.StuUser;
import com.stumesystem.mapper.StuRightMapper;
import com.stumesystem.mapper.StuUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private StuUserMapper stuUserMapper;

    @Autowired
    private StuRightMapper stuRightMapper;

    /**
     * 验证用户是否存在
     * @param email
     * @return
     */
    public StuUser getUser(String email){
       return stuUserMapper.selectByEmail(email);
    }

    /**
     * 更新用户
     * @param stu
     * @return
     */
    public Boolean updatePwd(StuUser stu){
        return stuUserMapper.updateByEmailSelective(stu)>0;
    }

    /**
     * 注册并且赋予角色
     * @param stu
     * @return
     */
    public Boolean regUser(StuUser stu){
        if(stuUserMapper.insertSelective(stu)>0){
             if(stuUserMapper.insert_Rose(stu.getId(),5)>0){
                  return true;
             }else{
                 return false;
             }
        }
        return false;
    }

    /**
     * 判断昵称是否存在
     * @param nickname
     * @return
     */
    public StuUser getUserYZniC(String nickname){
        return stuUserMapper.selectBynickname(nickname);
    }

    /**
     * 获取菜单列表
     * @param id
     * @return
     */
    public List<StuRight> getRoseAndRightByUid(Integer id){
        return stuRightMapper.selectByUserId(id);
    }

    /**
     * 通过用户名搜索所有用户
     *
     * @param name
     * @return
     */
    public List<StuUser> getStuUserByName(String name) {
        return stuUserMapper.selectStuByName(name);
    }
}
