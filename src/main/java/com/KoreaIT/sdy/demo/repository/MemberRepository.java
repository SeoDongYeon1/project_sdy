package com.KoreaIT.sdy.demo.repository;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Member;

@Mapper
public interface MemberRepository {

	public void doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email, int age);

	public Member getMemberByLoginId(String loginId);

	public Member getMemberById(int id);

	public Member getMemberByNameAndEmail(String name, String email);

	public Member getMemberByEmail(String email);

	public Member getMemberByNickname(String nickname);

}
