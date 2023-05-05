package com.KoreaIT.sdy.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.ArticleRepository;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.ResultData;

@Service
public class ArticleService {
	@Autowired
	ArticleRepository articleRepository;
	
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}
	
	public int writeArticle(String title, String body, int memberId) {
		articleRepository.writeArticle(title, body, memberId);
		
		return articleRepository.getLastInsertId();
	}

	public List<Article> getArticles() {
		
		return articleRepository.getArticles();
	}
	
	public void modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public Article getArticleById(int id) {
		return articleRepository.getArticleById(id);
	}

	public ResultData actorCanModifyRd(Article article, int actorId) {
		
		if(article.getMemberId()!=actorId) {
			return ResultData.from("F-1", "해당 게시글에 권한이 없습니다.");
		}
		
		return ResultData.from("S-1", "수정 가능");
	}

	public ResultData actorCanDeleteRd(Article article, int actorId) {
		
		if(article.getMemberId()!=actorId) {
			return ResultData.from("F-1", "해당 게시글에 권한이 없습니다.");
		}
		
		return ResultData.from("S-1", "삭제 가능");
	}
}

