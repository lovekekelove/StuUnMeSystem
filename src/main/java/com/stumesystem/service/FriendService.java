package com.stumesystem.service;

import com.stumesystem.mapper.FriendMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FriendService {

    @Autowired
    private FriendMapper friendMapper;
}
