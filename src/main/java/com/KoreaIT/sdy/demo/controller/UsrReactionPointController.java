package com.KoreaIT.sdy.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.service.ReactionPointService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.ResultData;
import com.KoreaIT.sdy.demo.vo.Rq;

@Controller
public class UsrReactionPointController {
	@Autowired
	private ReactionPointService reactionPointService;

	@Autowired
	private Rq rq;

	@RequestMapping("usr/reactionPoint/doGoodReaction")
	@ResponseBody
	public String doGoodReaction(String relTypeCode, int relId) {
		boolean actorCanMakeReaction = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode,
				relId);
		if (actorCanMakeReaction == false) {
			return rq.jsHistoryBack("F-1", "이미 했음");
		}

		ResultData rd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		if (rd.isFail()) {
			rq.jsHistoryBack(rd.getMsg(), "좋아요 실패");
		}

		return rq.jsReplace("좋아요!", Ut.f("../article/detail?id=%d", relId));
	}

}
