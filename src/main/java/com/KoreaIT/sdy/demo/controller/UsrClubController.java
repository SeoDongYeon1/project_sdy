package com.KoreaIT.sdy.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.dto.member_club;
import com.KoreaIT.sdy.demo.service.ChatRoomService;
import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.service.MemberService;
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
	private MemberService memberService;
	
	@Autowired
	private Rq rq;
	
	

//	@RequestMapping("/usr/club/list")
//	public String showClubList(Model model, String category) {
//		List<Club> clubs = clubService.getClubs();
//		
//		model.addAttribute("clubs", clubs);
//		return "usr/club/list";
//	}
	
	// 동호회별 페이지
	@RequestMapping("usr/club/detail")
	public String showDetail(int id, Model model) {
		Club club = clubService.getClubById(id);
		
		if(club==null) {
			return rq.jsHistoryBackOnView("F-E", "존재하지 않는 페이지입니다.");
		}
		
		List<Member> members = memberService.getMembersByClubId(id);
		
		model.addAttribute("club", club);
		model.addAttribute("members", members);

		return "usr/club/detail";
	}
	
	
	// 지역 csv 가져오기
	@RequestMapping("/usr/club/getArea")
    @ResponseBody
    public List<AreaRequestDTO> getAreaStep(@RequestParam Map<String, String> params)
    {
        return clubService.getArea(params);
    }
	
	// 동호회 생성 페이지로 보내기
	@RequestMapping("/usr/club/create")
	public String create() {
		
		return "usr/club/create";
	}
	
	// 동호회 생성
	@RequestMapping("/usr/club/doCreate")
	@ResponseBody
	public String doCreate(String name, String areacode, int categoryId, String purpose) {
		
		if(rq.getLoginedMemberId()==0) {
			return rq.jsHistoryBackOnView("F-L", "로그인 후 이용해주세요.");
		}
		
		ResultData createRd = clubService.create(rq.getLoginedMemberId(), name, areacode ,categoryId, purpose);
		
		int id = (int)createRd.getData1();
		
		chatRoomService.createClubChatRoom(name, rq.getLoginedMemberId(), id);
		
		return Ut.jsReplace(createRd.getMsg(), Ut.f("../club/detail?id=%d", id));
	}
	
	// 내가 가입한 동호회 리스트
	@RequestMapping("usr/club/showMyClubList")
	public String showMyClubList(Model model) {
		
		if(rq.getLoginedMemberId()==0) {
			return rq.jsHistoryBackOnView("F-L", "로그인 후 이용해주세요.");
		}
		
		List<Club> clubs = clubService.getMyClubs(rq.getLoginedMemberId());
		
		model.addAttribute("clubs", clubs);

		return "usr/club/myClubList";
	}
	
	
	// 동호회 가입 페이지로 보내기
	@RequestMapping("/usr/club/join")
	public String showJoin(@RequestParam("id") int clubId, Model model) {
		if(rq.getLoginedMemberId()==0) {
			return rq.jsHistoryBackOnView("F-L", "로그인 후 이용해주세요.");
		}
		
		member_club mc = clubService.getClubByMemberId(rq.getLoginedMemberId());
		
		if(mc.getClubId()==clubId) {
			return rq.jsHistoryBackOnView("F-1", "이미 가입한 동호회입니다.");
		}
		
		model.addAttribute("clubId", clubId);
		return "usr/club/join";
	}

	// 동호회 가입
	@RequestMapping("usr/club/doJoin")
	@ResponseBody
	public String doJoin(String purpose, int clubId) {
		if(rq.getLoginedMemberId()==0) {
			return rq.jsHistoryBackOnView("F-L", "로그인 후 이용해주세요.");
		}
		
		if (Ut.empty(purpose)) {
			return Ut.jsHistoryBack("F-1", "가입 목적을 입력해주세요");
		}
		
		// 해당 동호회에 가입했는지 판단
		member_club mc = clubService.getClubByMemberId(rq.getLoginedMemberId());
		
		if(mc.getClubId()==clubId) {
			return rq.jsHistoryBackOnView("F-2", "이미 가입한 동호회입니다.");
		}
		
		clubService.doJoin(clubId, purpose, rq.getLoginedMemberId());
		
		return  Ut.jsReplace("동호회에 가입되었습니다.", "../club/detail?id="+clubId);
	}

}
