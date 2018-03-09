package com.stumesystem.mapper;

import com.stumesystem.bean.News;

import java.util.List;

public interface NewsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(News record);

    int insertSelective(News record);

    News selectByPrimaryKey(Integer id);

    List<News> selectNewsList();

    List<News> selectNewsListWithUser();

    int updateByPrimaryKeySelective(News record);

    int updateByPrimaryKey(News record);
}