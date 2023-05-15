package com.KoreaIT.sdy.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.ResultData;
import com.KoreaIT.sdy.demo.vo.Rq;

@Controller
public class UsrClubController {
	@Autowired
	private ClubService clubService;
	
	@Autowired
	private Rq rq;
	
	
	@RequestMapping("/usr/club/list")
	public String showClubList() {
		
		return "usr/club/list";
	}
	
	@RequestMapping("/usr/club/create")
	public String create() {
		
		return "usr/club/create";
	}
	
	@RequestMapping("/usr/club/doCreate")
	@ResponseBody
	public String doCreate(String name, String category) {
		
		if(rq.getLoginedMemberId()==0) {
			return Ut.jsHistoryBack("F-L", "로그인 후 이용해주세요.");
		}
		
		ResultData createRd = clubService.create(rq.getLoginedMemberId(), name, category);
		
		int id = (int)createRd.getData1();
		
		return Ut.jsReplace(createRd.getMsg(), Ut.f("../club/detail?id=%d", id));
	}

}
