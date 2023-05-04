package com.KoreaIT.sdy.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.ArticleRepository;
import com.KoreaIT.sdy.demo.vo.Article;

@Service
public class ArticleService {
	@Autowired
	ArticleRepository articleRepository;
	
	public Article writeArticle(String title, String body) {

		return articleRepository.writeArticle(title, body);
	}

	public List<Article> getArticles() {
		
		return articleRepository.getArticles();
	}
	
	public Article modifyArticle(int id, String title, String body) {
		
		return articleRepository.modifyArticle(id, title, body);
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public Article getArticleById(int id) {
		return articleRepository.getArticleById(id);
	}
}

