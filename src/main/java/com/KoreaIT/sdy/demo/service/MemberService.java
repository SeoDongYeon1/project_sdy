package com.KoreaIT.sdy.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.MemberRepository;
import com.KoreaIT.sdy.demo.vo.Member;

@Service
public class MemberService {
	@Autowired
	MemberRepository memberRepository;
	
	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	
	public int doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		// 로그인 아이디 중복 체크
		Member member = memberRepository.getMemberByLoginId(loginId);
		
		if(member!=null) {
			return -1;
		}
		
		// 이름과 이메일 중복 체크
		member = memberRepository.getMemberByNameAndEmail(name, email);
		
		if(member!=null) {
			return -2;
		}
		
		memberRepository.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		int id = memberRepository.getLastInsertId();
		
		return id;
	}

	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}
}

