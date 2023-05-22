package com.KoreaIT.sdy.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.CategoryRepository;
import com.KoreaIT.sdy.demo.vo.Category;

@Service
public class CategoryService {
	@Autowired
	private CategoryRepository categoryRepository;
	
	public CategoryService(CategoryRepository categoryRepository) {
		this.categoryRepository = categoryRepository;
	}

	// id에 해당되는 카테고리 가져오기
	public Category getCategoryById(int id) {
		return categoryRepository.getCategoryById(id);
	}
}
