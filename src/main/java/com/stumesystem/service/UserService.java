package com.stumesystem.service;

import com.stumesystem.bean.StuUser;
import com.stumesystem.mapper.StuUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private StuUserMapper stuUserMapper;

    public StuUser getUser(String email){
       return stuUserMapper.selectByEmail(email);
    }
}
