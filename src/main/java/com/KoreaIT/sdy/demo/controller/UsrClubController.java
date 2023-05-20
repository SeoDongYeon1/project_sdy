package com.KoreaIT.sdy.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.service.ChatRoomService;
import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.AreaRequestDTO;
import com.KoreaIT.sdy.demo.vo.Club;
import com.KoreaIT.sdy.demo.vo.Member;
import com.KoreaIT.sdy.demo.vo.ResultData;
import com.KoreaIT.sdy.demo.vo.Rq;

@Controller
public class UsrClubController {
	@Autowired
	private ClubService clubService;
	
	@Autowired
	private ChatRoomService chatRoomService;
	
	@Autowired
	private Rq rq;
	
	
	@RequestMapping("/usr/club/list")
	public String showClubList(Model model, String category) {
		List<Club> clubs = clubService.getClubs();
		
		model.addAttribute("clubs", clubs);
		return "usr/club/list";
	}
	
	@RequestMapping("usr/club/detail")
	public String showDetail(int id, Model model) {
		Club club = clubService.getClubById(id);
		
		if(club==null) {
			return rq.jsHistoryBackOnView("존재하지 않는 페이지입니다.");
		}
		
		Boolean actorCanChat = clubService.actorCanChat(rq.getLoginedMemberId(), id);
		
		model.addAttribute("club", club);
		model.addAttribute("actorCanChat", actorCanChat);

		return "usr/club/detail";
	}
	
	
	@PostMapping(value = "/usr/club/getArea")
    @ResponseBody
    public List<AreaRequestDTO> getAreaStep(@RequestParam Map<String, String> params)
    {
        return clubService.getArea(params);
    }
	
	@RequestMapping("/usr/club/create")
	public String create() {
		
		return "usr/club/create";
	}
	
	@RequestMapping("/usr/club/doCreate")
	@ResponseBody
	public String doCreate(String name, String areacode, int categoryId, String purpose) {
		
		if(rq.getLoginedMemberId()==0) {
			return Ut.jsHistoryBack("F-L", "로그인 후 이용해주세요.");
		}
		
		ResultData createRd = clubService.create(rq.getLoginedMemberId(), name, areacode ,categoryId, purpose);
		
		int id = (int)createRd.getData1();
		
		chatRoomService.createChatRoom(name, rq.getLoginedMemberId(), id);
		
		return Ut.jsReplace(createRd.getMsg(), Ut.f("../club/detail?id=%d", id));
	}

}
