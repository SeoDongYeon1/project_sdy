package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.Board;
import com.KoreaIT.sdy.demo.vo.Club;

@Controller
public class UsrHomeController {
	@Autowired
	ClubService clubService;
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model, String category) {
		List<Club> clubs = clubService.getClubs();
		
		int clubsCount = clubService.getClubsCount(category);
		
		model.addAttribute("clubsCount", clubsCount);
		model.addAttribute("clubs", clubs);
		
		return "usr/home/main";
	}
	
	@RequestMapping("usr/article/list")
	public String showList(Model model, String category,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		Board board = boardService.getBoardById(boardId);

		if (boardId != 0 && board == null) {
			return rq.jsHistoryBackOnView("존재하지 않는 게시판입니다.");
		}

		int articlesCount = articleService.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);

		// 페이지 네이션
		int itemsInAPage = 10;
		int totalPage = (int) Math.ceil(articlesCount / (double) itemsInAPage);

		List<Article> articles = articleService.getForPrintArticles(boardId, itemsInAPage, page, searchKeywordTypeCode,
				searchKeyword);

		List<Article> article_replies = articleService.getRepliesCount();

		for (Article article : articles) {
			for (Article article1 : article_replies) {
				if (article.getId() == article1.getId()) {
					article.setRepliesCount(article1.getRepliesCount());
				}
			}
		}

		model.addAttribute("articles", articles);
		model.addAttribute("board", board);
		model.addAttribute("page", page);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("article_replies", article_replies);

		return "usr/article/list";
	}
	
	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
}
