package com.KoreaIT.sdy.demo.controller;

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
	private MemberService memberService;

	@Autowired
	private Rq rq;

	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}

	@RequestMapping("usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,	String email) {
		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요");
		}
		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요");
		}
		if (Ut.empty(name)) {
			return Ut.jsHistoryBack("F-3", "이름을 입력해주세요");
		}
		if (Ut.empty(nickname)) {
			return Ut.jsHistoryBack("F-4", "닉네임을 입력해주세요");
		}
		if (Ut.empty(cellphoneNum)) {
			return Ut.jsHistoryBack("F-5", "전화번호를 입력해주세요");
		}
		if (Ut.empty(email)) {
			return Ut.jsHistoryBack("F-6", "이메일을 입력해주세요");
		}
		
		ResultData joinRd = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		if(joinRd.isFail()) {
			return rq.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}
		
		return  Ut.jsReplace(joinRd.getResultCode(), joinRd.getMsg(), "../member/login");
	}

	@RequestMapping("usr/member/login")
	public String login(String loginId, String loginPw) {
		
		return "usr/member/login";
	}

	@RequestMapping("usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		
		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요.");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("F-3", "존재하지 않는 아이디입니다.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("F-4", "비밀번호가 일치하지 않습니다.");
		}

		rq.login(member);

		return Ut.jsReplace("S-1", Ut.f("%s님 로그인 되었습니다.", member.getNickname()), "/");
	}

	@RequestMapping("usr/member/doLogout")
	@ResponseBody
	public String doLogout() {
		rq.logout();

		return Ut.jsReplace("S-1", "로그아웃 되었습니다.", "../home/main");
	}
	
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(String loginId) {
		
		if(Ut.empty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요.");
		}
		
		Member existsMember = memberService.getMemberByLoginId(loginId);
		
		if(existsMember != null) {
			return ResultData.from("F-2", "해당 아이디는 이미 사용중인 아이디입니다.", loginId);
		}

		return ResultData.from("S-1", "사용 가능한 아이디입니다.", loginId);
	}
	
	@RequestMapping("/usr/member/getEmailDup")
	@ResponseBody
	public ResultData getEmailDup(String email) {
		
		if(Ut.empty(email)) {
			return ResultData.from("F-1", "이메일을 입력해주세요.");
		}
		
		Member existsMember = memberService.getMemberByEmail(email);
		
		if(existsMember != null) {
			return ResultData.from("F-2", "해당 이메일은 이미 사용중인 이메일입니다.", email);
		}
		
		return ResultData.from("S-1", "사용 가능한 이메일입니다.", email);
	}
	
	@RequestMapping("/usr/member/getNicknameDup")
	@ResponseBody
	public ResultData getNicknameDup(String nickname) {
		
		if(Ut.empty(nickname)) {
			return ResultData.from("F-1", "닉네임을 입력해주세요.");
		}
		
		Member existsMember = memberService.getMemberByNickname(nickname);
		
		if(existsMember != null) {
			return ResultData.from("F-2", "해당 닉네임은 이미 사용중인 닉네임입니다.", nickname);
		}
		
		return ResultData.from("S-1", "사용 가능한 닉네임입니다.", nickname);
	}
}
