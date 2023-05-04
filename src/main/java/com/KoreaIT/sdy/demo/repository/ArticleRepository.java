package com.KoreaIT.sdy.demo.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.KoreaIT.sdy.demo.vo.Article;

@Component
public class ArticleRepository {

	int lastArticleId;
	static List<Article> articles;
	
	public ArticleRepository() {
		lastArticleId = 0;
		articles = new ArrayList<>();
	}
	
	public Article writeArticle(String title, String body) {
		int id = lastArticleId + 1;
		
		Article article = new Article(id, title, body);
		articles.add(article);
		lastArticleId++;
		
		return article;
	}

	public List<Article> getArticles() {
		return articles;
	}

	public Article modifyArticle(int id, String title, String body) {
		Article article = getArticleById(id);
		
		article.setTitle(title);
		article.setBody(body);
		
		return article;
	}

	public void deleteArticle(int id) {
		Article foundArticle = getArticleById(id);
		
		articles.remove(foundArticle);
	}
	
	public Article getArticleById(int id) {
		for(Article article : articles) {
			if(article.getId()==id) {
				return article;
			}
		}
		return null;
	}

}
