package com.stumesystem.service;

import com.stumesystem.bean.DeptName;
import com.stumesystem.bean.JiBie;
import com.stumesystem.mapper.JiBieMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JiBieService {

    @Autowired
    private JiBieMapper jiBieMapper;

    /**
     * 获取所有年级
     * @return
     */
    public List<JiBie> getJiBies(){
        return jiBieMapper.getJiBie();
    }

    /**
     * 获取年级
     * @param dengji
     * @return
     */
    public JiBie getJiBie(String dengji){
        return jiBieMapper.selectByDengJi(dengji);
    }

    public int insertJiBie(JiBie jiBie){
        return jiBieMapper.insert(jiBie);
    }
}
