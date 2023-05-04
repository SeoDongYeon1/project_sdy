package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.service.ArticleService;
import com.KoreaIT.sdy.demo.vo.Article;

@Controller
public class UsrArticleController {
	@Autowired
	ArticleService articleService;
	
	@RequestMapping("usr/article/write")
	@ResponseBody
	public Article write(String title, String body) {
		Article article = articleService.writeArticle(title, body);
		
		return article;
	}
	
	@RequestMapping("usr/article/list")
	@ResponseBody
	public List<Article> showList() {
		
		List<Article> articles = articleService.getArticles();
		
		return articles;
	}
	
	@RequestMapping("usr/article/detail")
	@ResponseBody
	public Object showDetail(int id) {
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return id +"번 게시글은 존재하지 않습니다.";
		}
		
		return foundArticle;
	}
	
	@RequestMapping("usr/article/modify")
	@ResponseBody
	public Object doModify(int id, String title, String body) {
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return id +"번 게시글은 존재하지 않습니다.";
		}
		
		articleService.modifyArticle(id, title, body);
		
		return foundArticle;
	}
	@RequestMapping("usr/article/delete")
	@ResponseBody
	public Object doDelete(int id) {
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return id +"번 게시글은 존재하지 않습니다.";
		}
		
		articleService.deleteArticle(id);
		
		return id + "번 게시글이 삭제되었습니다.";
	}

	
}
