package com.stumesystem.service;

import com.stumesystem.mapper.TopicMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author:张腾飞
 * @Date:2018/2/7 17:09
 */
@Service
public class TopicService {

    @Autowired
    private TopicMapper topicMapper;

}
