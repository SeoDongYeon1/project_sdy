package com.KoreaIT.sdy.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Article;

@Mapper
public interface ArticleRepository {
	
	public void writeArticle(String title, String body, int memberId);

	public List<Article> getArticles();

	public void modifyArticle(int id, String title, String body);

	public void deleteArticle(int id);
	
	public Article getArticleById(int id);

	public int getLastInsertId();

	public Article getForPrintArticle(int id);

}
