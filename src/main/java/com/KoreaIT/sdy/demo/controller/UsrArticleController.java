package com.KoreaIT.sdy.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.KoreaIT.sdy.demo.service.ArticleService;
import com.KoreaIT.sdy.demo.service.BoardService;
import com.KoreaIT.sdy.demo.service.GenFileService;
import com.KoreaIT.sdy.demo.service.ReactionPointService;
import com.KoreaIT.sdy.demo.service.ReplyService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.Board;
import com.KoreaIT.sdy.demo.vo.Reply;
import com.KoreaIT.sdy.demo.vo.ResultData;
import com.KoreaIT.sdy.demo.vo.Rq;

@Controller
public class UsrArticleController {
	@Autowired
	private ArticleService articleService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReplyService replyService;

	@Autowired
	private ReactionPointService reactionPointService;

	@Autowired
	private Rq rq;
	
	@Autowired
	private GenFileService genFileService;
	
	@RequestMapping("usr/article/write")
	public String write(@RequestParam(defaultValue = "0") int clubId) {
		if(clubId != 0) {
			return "usr/article/write2";
		}
		return "usr/article/write";
	}

	@RequestMapping("usr/article/doWrite")
	@ResponseBody
	public String doWrite(String title, String body, @RequestParam(defaultValue = "0") int boardId, String replaceUri, MultipartRequest multipartRequest, @RequestParam(defaultValue = "0") int clubId) {
		
		if (Ut.empty(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력하세요.");
		}
		if (Ut.empty(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력하세요.");
		}

		ResultData writeArticleRd = articleService.writeArticle(title, body, rq.getLoginedMemberId(), boardId, clubId);
		
		int id = (int)writeArticleRd.getData1();
		
		if (boardId == 0 && Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../club/gallery?id=%d", clubId);
		}
		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../article/detail?id=%d", id);
		}
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, id);
			}
		}

		return Ut.jsReplace(writeArticleRd.getMsg(), replaceUri);
	}

	@RequestMapping("usr/article/list")
	public String showList(Model model, @RequestParam(defaultValue = "0") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		Board board = boardService.getBoardById(boardId);

		if (boardId != 0 && board == null) {
			return rq.jsHistoryBackOnView("F-E", "존재하지 않는 게시판입니다.");
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

	@RequestMapping("usr/article/detail")
	public String showDetail(int id, Model model) {
		Article foundArticle = articleService.getForPrintArticle(id);
		
		if(foundArticle==null) {
			return rq.jsHistoryBackOnView("F-E", "존재하지 않는 페이지입니다.");
		}

		ResultData actorCanMakeReactionRd = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(),
				"article", id);

		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "article", id);

		if (actorCanMakeReactionRd.isSuccess()) {
			model.addAttribute("actorCanMakeReaction", actorCanMakeReactionRd.isSuccess());

		}

		model.addAttribute("replies", replies);
		model.addAttribute("article", foundArticle);
		model.addAttribute("isAlreadyAddGoodRp", reactionPointService.isAlreadyAddGoodRp(id, "article"));
		model.addAttribute("isAlreadyAddBadRp", reactionPointService.isAlreadyAddBadRp(id, "article"));

		return "usr/article/detail";
	}

	@RequestMapping("usr/article/doIncreaseHitCount")
	@ResponseBody
	public ResultData doIncreaseHitCount(int id) {
		ResultData increaseHitCountRd = articleService.increaseHitCount(id);

		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData rd = ResultData.newData(increaseHitCountRd, articleService.getArticleHitCount(id));

		return rd;
	}

	@RequestMapping("usr/article/modify")
	public String modify(Model model, int id, String title, String body) {
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
	public String doModify(int id, String title, String body, MultipartRequest multipartRequest) {
		Article foundArticle = articleService.getForPrintArticle(id);

		if (foundArticle == null) {
			return Ut.jsHistoryBack("F-E", "존재하지 않는 게시글입니다.");
		}

		ResultData actorCanModifyRd = articleService.actorCanModifyRd(foundArticle, rq.getLoginedMemberId());

		if (actorCanModifyRd.isFail()) {
			return Ut.jsHistoryBack(actorCanModifyRd.getResultCode(), actorCanModifyRd.getMsg());
		}

		articleService.modifyArticle(id, title, body);
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, id);
			}
		}
		
		return Ut.jsReplace("S-1", Ut.f("%d번 게시글이 수정되었습니다.", id), Ut.f("../article/detail?id=%d", id));
	}

	@RequestMapping("usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		Article foundArticle = articleService.getArticleById(id);

		if (foundArticle == null) {
			return Ut.jsHistoryBack("F-E", "존재하지 않는 게시글입니다.");
		}

		ResultData actorCanDeleteRd = articleService.actorCanDeleteRd(foundArticle, rq.getLoginedMemberId());

		if (actorCanDeleteRd.isFail()) {
			return Ut.jsHistoryBack(actorCanDeleteRd.getResultCode(), actorCanDeleteRd.getMsg());
		}

		articleService.deleteArticle(id);

		return Ut.jsReplace("S-1", Ut.f("%d번 게시글이 삭제되었습니다.", id), "../article/list");
	}

}
