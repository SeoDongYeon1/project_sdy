package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.service.ArticleService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.ResultData;
import com.KoreaIT.sdy.demo.vo.Rq;

@Controller
public class UsrArticleController {
	@Autowired
	ArticleService articleService;
	
	@RequestMapping("usr/article/write")
	public String write(String title, String body, Integer boardId) {
		
		return "usr/article/write";
	}
	
	@RequestMapping("usr/article/doWrite")
	@ResponseBody
	public String doWrite(String title, String body, int boardId, HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		
		if(Ut.empty(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력하세요.");
		}
		if(Ut.empty(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력하세요.");
		}
		
		int id = articleService.writeArticle(title, body, rq.getLoginedMemberId(), boardId);
		
		return Ut.jsReplace("S-1", Ut.f("%d번 게시글이 생성되었습니다.", id), Ut.f("../article/detail?id=%d",id));
	}
	
	@RequestMapping("usr/article/list")
	public String showList(Model model) {
		
		List<Article> articles = articleService.getArticles();
		
		model.addAttribute("articles", articles);
		
		return "usr/article/list";
	}
	
	@RequestMapping("usr/article/detail")
	public String showDetail(HttpServletRequest req, int id, Model model) {
		Rq rq = (Rq)req.getAttribute("rq");
		
		Article foundArticle = articleService.getForPrintArticle(id);
		
		model.addAttribute("article", foundArticle);
		model.addAttribute("rq", rq);
		
		return "usr/article/detail";
	}
	
	@RequestMapping("usr/article/modify")
	public String modify(HttpServletRequest req, Model model, int id, String title, String body) {
		Rq rq = (Rq)req.getAttribute("rq");
		Article article = articleService.getForPrintArticle(id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModifyRd(article, rq.getLoginedMemberId());

		if (actorCanModifyRd.isFail()) {
			return Ut.jsHistoryBack(actorCanModifyRd.getResultCode(), actorCanModifyRd.getMsg());
		}

		model.addAttribute("article", article);
		
		return "usr/article/modify";
	}
	
	@RequestMapping("usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String title, String body) {
		Rq rq = (Rq)req.getAttribute("rq");
		
		Article foundArticle = articleService.getForPrintArticle(id);
		
		if(foundArticle==null) {
			return Ut.jsHistoryBack("F-E", "존재하지 않는 게시글입니다.");
		}
		
		ResultData actorCanModifyRd = articleService.actorCanModifyRd(foundArticle, rq.getLoginedMemberId());
		
		if(actorCanModifyRd.isFail()) {
			return Ut.jsHistoryBack(actorCanModifyRd.getResultCode(), actorCanModifyRd.getMsg());
		}
		
		articleService.modifyArticle(id, title, body);
		
		return Ut.jsReplace("S-1", Ut.f("%d번 게시글이 수정되었습니다.", id), Ut.f("../article/detail?id=%d",id));
	}
	
	@RequestMapping("usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {
		Rq rq = (Rq)req.getAttribute("rq");
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return Ut.jsHistoryBack("F-E", "존재하지 않는 게시글입니다.");
		}
		
		ResultData actorCanDeleteRd = articleService.actorCanDeleteRd(foundArticle, rq.getLoginedMemberId());
		
		if(actorCanDeleteRd.isFail()) {
			return Ut.jsHistoryBack(actorCanDeleteRd.getResultCode(), actorCanDeleteRd.getMsg());
		}
		
		articleService.deleteArticle(id);
		
		return Ut.jsReplace("S-1", Ut.f("%d번 게시글이 삭제되었습니다.", id), "../article/list");
	}

	
}
