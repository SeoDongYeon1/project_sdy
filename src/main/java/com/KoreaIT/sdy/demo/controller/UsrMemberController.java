package com.KoreaIT.sdy.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.sdy.demo.service.MemberService;
import com.KoreaIT.sdy.demo.util.Ut;
import com.KoreaIT.sdy.demo.vo.Member;
import com.KoreaIT.sdy.demo.vo.ResultData;
import com.KoreaIT.sdy.demo.vo.Rq;

@Controller
public class UsrMemberController {
	@Autowired
	MemberService memberService;
	
	@RequestMapping("usr/member/join")
	@ResponseBody
	public ResultData doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,	String email) {
		
		if (Ut.empty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요");
		}
		if (Ut.empty(loginPw)) {
			return ResultData.from("F-2", "비밀번호를 입력해주세요");
		}
		if (Ut.empty(name)) {
			return ResultData.from("F-3", "이름을 입력해주세요");
		}
		if (Ut.empty(nickname)) {
			return ResultData.from("F-4", "닉네임을 입력해주세요");
		}
		if (Ut.empty(cellphoneNum)) {
			return ResultData.from("F-5", "전화번호를 입력해주세요");
		}
		if (Ut.empty(email)) {
			return ResultData.from("F-6", "이메일을 입력해주세요");
		}
		
		int id = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		if(id==-1) {
			return ResultData.from("F-E1", "이미 사용중인 아이디입니다.");
		}
		
		if(id==-2) {
			return ResultData.from("F-E2", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다.", name, email));
		}
		
		Member member = memberService.getMemberById(id);

		return ResultData.from("S-1", "회원가입 되었습니다.", member);
	}

	
	@RequestMapping("usr/member/login")
	public String login(String loginId, String loginPw) {
		
		return "usr/member/login";
	}
	
	@RequestMapping("usr/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw) {
		Rq rq = (Rq)req.getAttribute("rq");
		
		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 상태입니다.");
		}
		
		if(Ut.empty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요.");
		}
		
		if(Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요.");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member==null) {
			return Ut.jsHistoryBack("F-3", "아이디 또는 비밀번호를 확인해주세요.");
		}
		
		if(member.getLoginPw().equals(loginPw)==false) {
			return Ut.jsHistoryBack("F-4", "아이디 또는 비밀번호를 확인해주세요.");
		}
		
		rq.login(member);
		
		return Ut.jsReplace("S-1", Ut.f("%s님 로그인 되었습니다.", member.getNickname()), "/");
	}
	
	@RequestMapping("usr/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {
		Rq rq = (Rq)req.getAttribute("rq");
		
		if (rq.isLogined()==false) {
			return Ut.jsHistoryBack("F-A", "로그인 상태가 아닙니다.");
		}
		
		rq.logout();
		
		return Ut.jsReplace("S-1", "로그아웃 되었습니다.","/");
	}
	
}
