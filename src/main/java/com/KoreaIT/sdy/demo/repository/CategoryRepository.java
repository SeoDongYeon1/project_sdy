package com.KoreaIT.sdy.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Category;

@Mapper
public interface CategoryRepository {

	public Category getCategoryById(int id);

}
