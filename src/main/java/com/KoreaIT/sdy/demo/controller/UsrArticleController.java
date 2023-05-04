package com.KoreaIT.sdy.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.vo.Article;

@Controller
public class UsrArticleController {
	int lastArticleId;
	static List<Article> articles;
	
	public UsrArticleController() {
		lastArticleId = 0;
		articles = new ArrayList<>();
	}
	
	@RequestMapping("usr/article/write")
	@ResponseBody
	public Article write(String title, String body) {
		int id = lastArticleId + 1;
		
		Article article = new Article(id, title, body);
		articles.add(article);
		lastArticleId++;
		
		return article;
	}
	
	@RequestMapping("usr/article/list")
	@ResponseBody
	public List<Article> showList() {
		
		return articles;
	}
	
	@RequestMapping("usr/article/detail")
	@ResponseBody
	public Object showDetail(int id) {
		
		Article foundArticle = getArticleById(id);
		
		if(foundArticle==null) {
			return id +"번 게시글은 존재하지 않습니다.";
		}
		
		return foundArticle;
	}
	
	@RequestMapping("usr/article/modify")
	@ResponseBody
	public Object doModify(int id, String title, String body) {
		
		Article foundArticle = getArticleById(id);
		
		if(foundArticle==null) {
			return id +"번 게시글은 존재하지 않습니다.";
		}
		
		foundArticle.setTitle(title);
		foundArticle.setBody(body);
		
		return foundArticle;
	}
	@RequestMapping("usr/article/delete")
	@ResponseBody
	public Object doDelete(int id) {
		
		Article foundArticle = getArticleById(id);
		
		if(foundArticle==null) {
			return id +"번 게시글은 존재하지 않습니다.";
		}
		
		articles.remove(foundArticle);
		return id + "번 게시글이 삭제되었습니다.";
	}

	private Article getArticleById(int id) {
		for(Article article : articles) {
			if(article.getId()==id) {
				return article;
			}
		}
		return null;
	}
}
