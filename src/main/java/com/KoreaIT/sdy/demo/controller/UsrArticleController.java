package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.service.ArticleService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.ResultData;

@Controller
public class UsrArticleController {
	@Autowired
	ArticleService articleService;
	
	@RequestMapping("usr/article/write")
	@ResponseBody
	public ResultData write(String title, String body) {
		int id = articleService.writeArticle(title, body);
		
		Article article = articleService.getArticleById(id);
		
		return ResultData.from("S-1", Ut.f("%d번 게시글이 생성되었습니다.", id), article);
	}
	
	@RequestMapping("usr/article/list")
	@ResponseBody
	public ResultData showList() {
		
		List<Article> articles = articleService.getArticles();
		
		return ResultData.from("S-1", "게시글 리스트입니다.", articles);
	}
	
	@RequestMapping("usr/article/detail")
	@ResponseBody
	public ResultData showDetail(int id) {
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return ResultData.from("F-E", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
		}
		
		return ResultData.from("S-1", Ut.f("%d번 게시글 입니다.", id), foundArticle);
	}
	
	@RequestMapping("usr/article/modify")
	@ResponseBody
	public ResultData doModify(int id, String title, String body) {
		
		articleService.modifyArticle(id, title, body);
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return ResultData.from("F-E", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
		}
		
		return ResultData.from("S-1", Ut.f("%d번 게시글이 수정되었습니다.", id), foundArticle);
	}
	@RequestMapping("usr/article/delete")
	@ResponseBody
	public ResultData doDelete(int id) {
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return ResultData.from("F-E", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
		}
		
		articleService.deleteArticle(id);
		
		return ResultData.from("S-1", Ut.f("%d번 게시글이 삭제되었습니다.", id));
	}

	
}
