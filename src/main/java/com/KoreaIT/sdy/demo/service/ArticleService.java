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
	
	public int writeArticle(String title, String body, int memberId, int boardId) {
		articleRepository.writeArticle(title, body, memberId, boardId);
		
		return articleRepository.getLastInsertId();
	}

	public List<Article> getArticles(int boardId) {
		
		return articleRepository.getArticles(boardId);
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

	public Article getForPrintArticle(int id) {
		return articleRepository.getForPrintArticle(id);
	}

	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return articleRepository.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);
	}

	public List<Article> getForPrintArticles(int boardId, int itemsInAPage, int page, String searchKeywordTypeCode, String searchKeyword) {
		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;
		
		return articleRepository.getForPrintArticles(boardId, limitFrom, limitTake, searchKeywordTypeCode, searchKeyword);
	}

	public ResultData increaseHitCount(int id) {
		int affectedRow = articleRepository.increaseHitCount(id);
		
		if(affectedRow==0) {
			return ResultData.from("F-1", "해당 게시글은 존재하지 않습니다.", affectedRow);
		}
		
		return ResultData.from("S-1", "조회수 증가", affectedRow);
	}

	public int getArticleHitCount(int id) {
		return articleRepository.getArticleHitCount(id);
	}

	public ResultData increaseGoodReactionPoint(int id) {
		int affectedRow = articleRepository.increaseGoodReactionPoint(id);
		
		if(affectedRow==0) {
			return ResultData.from("F-1", "해당 게시글은 존재하지 않습니다.", affectedRow);
		}
		return ResultData.from("S-1", "좋아요 증가", affectedRow);
	}

	public ResultData decreaseGoodReactionPoint(int id) {
		int affectedRow = articleRepository.decreaseGoodReactionPoint(id);
		
		if(affectedRow==0) {
			return ResultData.from("F-1", "해당 게시글은 존재하지 않습니다.", affectedRow);
		}
		return ResultData.from("S-1", "좋아요 감소", affectedRow);
		
	}
}

