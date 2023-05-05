package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.service.ArticleService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.Member;
import com.KoreaIT.sdy.demo.vo.ResultData;

@Controller
public class UsrArticleController {
	@Autowired
	ArticleService articleService;
	
	@RequestMapping("usr/article/write")
	@ResponseBody
	public ResultData write(HttpSession httpSession, String title, String body) {
		boolean isLogined = false;
		Member member = null;
		
		if(httpSession.getAttribute("loginedMember")!=null) {
			isLogined = true;
			member = (Member) httpSession.getAttribute("loginedMember");
		}
		
		if(isLogined==false) {
			return ResultData.from("F-L", "로그인 후 이용해주세요.");
		}
		
		int id = articleService.writeArticle(title, body, member.getId());
		
		Article article = articleService.getArticleById(id);
		
		return ResultData.from("S-1", Ut.f("%d번 게시글이 생성되었습니다.", id), article);
	}
	
	@RequestMapping("usr/article/list")
	public String showList() {
		
		List<Article> articles = articleService.getArticles();
		
		return "usr/article/list";
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
	public ResultData doModify(HttpSession httpSession, int id, String title, String body) {
		boolean isLogined = false;
		Member member = null;
		
		if(httpSession.getAttribute("loginedMember")!=null) {
			isLogined = true;
			member = (Member) httpSession.getAttribute("loginedMember");
		}
		
		if(isLogined==false) {
			return ResultData.from("F-L", "로그인 후 이용해주세요.");
		}
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return ResultData.from("F-E", "존재하지 않는 게시글입니다.");
		}
		
		ResultData actorCanModifyRd = articleService.actorCanModifyRd(foundArticle, member.getId());
		
		if(actorCanModifyRd.isFail()) {
			return actorCanModifyRd;
		}
		
		articleService.modifyArticle(id, title, body);
		
		return ResultData.from("S-1", Ut.f("%d번 게시글이 수정되었습니다.", id), foundArticle);
	}
	
	@RequestMapping("usr/article/delete")
	@ResponseBody
	public ResultData doDelete(HttpSession httpSession, int id) {
		boolean isLogined = false;
		Member member = null;
		
		if(httpSession.getAttribute("loginedMember")!=null) {
			isLogined = true;
			member = (Member) httpSession.getAttribute("loginedMember");
		}
		
		if(isLogined==false) {
			return ResultData.from("F-L", "로그인 후 이용해주세요.");
		}
		
		Article foundArticle = articleService.getArticleById(id);
		
		if(foundArticle==null) {
			return ResultData.from("F-E", Ut.f("%d번 게시글은 존재하지 않습니다.", id));
		}
		
		ResultData actorCanDeleteRd = articleService.actorCanDeleteRd(foundArticle, member.getId());
		
		if(actorCanDeleteRd.isFail()) {
			return actorCanDeleteRd;
		}
		
		articleService.deleteArticle(id);
		
		return ResultData.from("S-1", Ut.f("%d번 게시글이 삭제되었습니다.", id));
	}

	
}
