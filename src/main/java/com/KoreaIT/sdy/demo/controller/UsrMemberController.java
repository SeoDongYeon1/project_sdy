package com.KoreaIT.sdy.demo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.KoreaIT.sdy.demo.service.GenFileService;
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
	
	@Autowired
	private GenFileService genFileService;

	// 회원가입 페이지로
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}

	// 회원가입
	@RequestMapping("usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, Integer age, String nickname, String cellphoneNum, String email, @RequestParam(defaultValue = "/") String afterLoginUri) {
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
		if (age==0 || age == null) {
			System.out.println(age);
			return Ut.jsHistoryBack("F-7", "나이를 입력해주세요");
		}
		
		ResultData joinRd = memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email, age);
		
		if(joinRd.isFail()) {
			return rq.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}
		
		String afterJoinUri = "../member/login?afterLoginUri=" + Ut.getEncodedUri(afterLoginUri);

		return Ut.jsReplace("S-1", "회원가입이 완료되었습니다", afterJoinUri);
	}

	// 로그인 페이지로
	@RequestMapping("usr/member/login")
	public String login(String loginId, String loginPw) {
		
		return "usr/member/login";
	}

	// 로그인
	@RequestMapping("usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, @RequestParam(defaultValue = "/") String afterLoginUri) {
		
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

		return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getName()), afterLoginUri);
	}

	// 로그아웃
	@RequestMapping("usr/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue = "/") String afterLogoutUri) {
		rq.logout();

		return Ut.jsReplace("S-1", "로그아웃 되었습니다", afterLogoutUri);
	}
	
	// 아이디 중복 체크
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
	
	// 이메일 중복 체크
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
	
	// 닉네임 중복 체크
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
	
	// 프로필 페이지로
	@RequestMapping("/usr/member/profile")
	public String showProfile(Model model, int id) {
		Member member = memberService.getMemberById(id);

		model.addAttribute("member", member);
		
		return "usr/member/profile";
	}
	
	// 비밀번호 확인하기
	@RequestMapping("/usr/member/checkPw")
	public String showCheckPw(Model model) {
		Member member = rq.getLoginedMember();
		
		model.addAttribute("member", member);

		return "usr/member/checkPw";
	}
	
	// 회원 정보 수정 페이지로
	@RequestMapping("/usr/member/modify")
	public String modify(Model model) {

		Member member = rq.getLoginedMember();

		model.addAttribute("member", member);

		return "usr/member/modify";
	}

	// 회원 정보 수정
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(int id, String loginPw, String name, String nickname, String cellphoneNum) {
		
		if(rq.getLoginedMemberId()!= id) {
			return rq.jsHistoryBack("F-0", "권한이 없습니다.");
		}
		
		Member member = memberService.getMemberById(id);

		if (member == null) {
			return rq.jsHistoryBack("F-E", "존재하지 않는 회원입니다.");
		}

		if (Ut.empty(loginPw)) {
			loginPw = null;
		}

		if (Ut.empty(name)) {
			return rq.jsHistoryBack("F-1", "이름을 입력해주세요.");
		}
		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("F-2", "닉네임을 입력해주세요.");
		}
		if (Ut.empty(cellphoneNum)) {
			return rq.jsHistoryBack("F-3", "전화번호를 입력해주세요.");
		}

		ResultData modifyRd = memberService.modifyMember(id, loginPw, name, nickname, cellphoneNum);

		return rq.jsReplace(modifyRd.getMsg(), "../member/profile");
	}
	
	@RequestMapping("usr/member/profileUpload")
	@ResponseBody
	public String upload(int id, Model model, String replaceUri, MultipartRequest multipartRequest) {
		
		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../club/detail?id=%d", id);
		}
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, id);
			}
		}
		
		return Ut.jsReplace("업로드 되었습니다.", replaceUri);
	}
	
	@RequestMapping("/usr/member/findLoginId")
	public String showLoginId() {

		return "usr/member/findLoginId";
	}

	@RequestMapping("/usr/member/doFindLoginId")
	@ResponseBody
	public String doFindLoginId(@RequestParam(defaultValue = "/") String afterFindLoginIdUri, String name, String email) {
		Member member = memberService.getMemberByNameAndEmail(name, email);

		if(member==null) {
			return Ut.jsHistoryBack("F-1", "입력된 정보로 가입된 아이디가 없습니다.");
		}

		return Ut.jsReplace("S-1", Ut.f("아이디 : %s", member.getLoginId()), afterFindLoginIdUri);
	}
}
