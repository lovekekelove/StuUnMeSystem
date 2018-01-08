package com.stumesystem.service;

import com.stumesystem.bean.StuUser;
import com.stumesystem.mapper.StuUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private StuUserMapper stuUserMapper;

    /**
     * 验证用户是否存在
     * @param email
     * @return
     */
    public StuUser getUser(String email){
       return stuUserMapper.selectByEmail(email);
    }

    public Boolean updatePwd(StuUser stu){
        return stuUserMapper.updateByEmailSelective(stu)>0;
    }
    public Boolean regUser(StuUser stu){
        return stuUserMapper.insertSelective(stu)>0;
    }

    public StuUser getUserYZniC(String nickname){
        return stuUserMapper.selectBynickname(nickname);
    }
}
