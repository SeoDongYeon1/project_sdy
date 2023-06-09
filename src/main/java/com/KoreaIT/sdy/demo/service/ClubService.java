package com.KoreaIT.sdy.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.dto.member_club;
import com.KoreaIT.sdy.demo.repository.ClubRepository;
import com.KoreaIT.sdy.demo.repository.MemberRepository;
import com.KoreaIT.sdy.demo.vo.AreaRequestDTO;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.Club;
import com.KoreaIT.sdy.demo.vo.ResultData;

@Service
public class ClubService {
	@Autowired
	ClubRepository clubRepository;
	
	@Autowired
	MemberRepository memberRepository;
	

	// 생성자
	public ClubService(ClubRepository clubRepository) {
		this.clubRepository = clubRepository;
	}
	
	// 지역정보 가져오기
	public List<AreaRequestDTO> getArea(Map<String, String> params) {
		return clubRepository.selectArea(params);
	}

	// 동호회 생성
	public ResultData create(int loginedMemberId, String name, String areacode, int categoryId, String purpose) {
		
		clubRepository.create(loginedMemberId, name, areacode,categoryId, purpose);

		int clubId = clubRepository.getLastInsertId();
		
		// 클럽 만든 사람 자동으로 클럽에 가입되도록
		clubRepository.doJoin(clubId, loginedMemberId, purpose, 7);

		return ResultData.from("S-1", "동호회가 생성되었습니다.", clubId);
	}

	// id에 해당하는 동호회 가져오기
	public Club getClubById(int id) {
		return clubRepository.getClubById(id);
	}

	// 전체 동호회 리스트로 가져오기
	public List<Club> getClubs() {
		return clubRepository.getClubs();
	}
	
	// 조건으로 카테고리와 검색어에 해당되는 동호회 가져오기
	public int getClubsCount(int categoryId, String searchKeyword, String step1, String step2, String step3) {
		return clubRepository.getClubsCount(categoryId, searchKeyword, step1, step2, step3);
	}

	// 검색어에 해당되는 동호회들을 한페이지 limitFrom과 limitTake의 조건에 맞게 보여주기 
	public List<Club> getForPrintClubs(int categoryId, int itemsInAPage, int page, String searchKeyword, String step1, String step2, String step3) {
		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return clubRepository.getForPrintClubs(categoryId, limitFrom, limitTake, searchKeyword, step1, step2, step3);
	}

	// 전체 동호회별 평균 나이 가져오기
	public List<Club> getavgAge() {
		return clubRepository.getavgAge();
	}

	// 전체 동호회별 회원 수 가져오기
	public List<Club> getmembersCount() {
		return clubRepository.getmembersCount();
	}

	// 해당 동호회에 가입했는지 확인(채팅을 사용 가능한지)
	public Boolean actorCanChat(int actorId, int id) {
		int count = clubRepository.actorCanChat(actorId, id);
		
		if(count!=1) {
			return false;
		}
		
		return true;
	}

	// 내가 가입한 동호회들 리스트로 가져오기
	public List<Club> getMyClubs(int memberId) {
		
		return clubRepository.getMyClubs(memberId);
	}

	// 동호회 가입
	public void doJoin(int clubId, String purpose, int memberId, int authLevel) {
		clubRepository.doJoin(clubId, memberId, purpose, authLevel);
	}

	// 해당 회원이 가입한 동호회 가져오기
	public member_club getClubByMemberId(int memberId, int clubId) {
		
		return clubRepository.getClubByMemberId(memberId, clubId);
	}
	
	public List<member_club> getMembersByClubId(int clubId) {
		return clubRepository.getMembersByClubId(clubId);
	}

	public List<Article> getArticleByClubId(int id) {
		return clubRepository.getArticleByClubId(id);
	}

	public int getmembersCountByclubId(int id) {
		return clubRepository.getmembersCountByclubId(id);
	}
}
