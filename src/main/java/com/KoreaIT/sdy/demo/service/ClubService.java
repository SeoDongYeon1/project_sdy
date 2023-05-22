package com.KoreaIT.sdy.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.dto.member_club;
import com.KoreaIT.sdy.demo.repository.ClubRepository;
import com.KoreaIT.sdy.demo.repository.MemberRepository;
import com.KoreaIT.sdy.demo.vo.AreaRequestDTO;
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
	
	public List<AreaRequestDTO> getArea(Map<String, String> params) {
		return clubRepository.selectArea(params);
	}

	// 동호회 생성
	public ResultData create(int loginedMemberId, String name, String areacode, int categoryId, String purpose) {
		
		clubRepository.create(loginedMemberId, name, areacode,categoryId, purpose);

		int clubId = clubRepository.getLastInsertId();
		
		// 클럽 만든 사람 자동으로 클럽에 가입되도록
		clubRepository.doJoin(clubId, loginedMemberId, purpose);

		return ResultData.from("S-1", "동호회가 생성되었습니다.", clubId);
	}

	public Club getClubById(int id) {
		return clubRepository.getClubById(id);
	}

	public List<Club> getClubs() {
		return clubRepository.getClubs();
	}
	
	public int getClubsCount(int categoryId, String searchKeyword) {
		return clubRepository.getClubsCount(categoryId, searchKeyword);
	}

	public List<Club> getForPrintClubs(int categoryId, int itemsInAPage, int page, String searchKeyword) {
		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return clubRepository.getForPrintClubs(categoryId, limitFrom, limitTake, searchKeyword);
	}

	public List<Club> getavgAge() {
		return clubRepository.getavgAge();
	}

	public List<Club> getmembersCount() {
		return clubRepository.getmembersCount();
	}

	public Boolean actorCanChat(int actorId, int id) {
		int count = clubRepository.actorCanChat(actorId, id);
		
		if(count!=1) {
			return false;
		}
		
		return true;
	}

	public List<Club> getMyClubs(int memberId) {
		
		return clubRepository.getMyClubs(memberId);
	}

	public void doJoin(int clubId, String purpose, int memberId) {
		clubRepository.doJoin(clubId, memberId, purpose);
	}

	public member_club getClubByMemberId(int memberId) {
		
		return clubRepository.getClubByMemberId(memberId);
	}

}
