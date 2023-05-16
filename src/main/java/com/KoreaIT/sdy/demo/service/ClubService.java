package com.KoreaIT.sdy.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.ClubRepository;
import com.KoreaIT.sdy.demo.vo.AreaRequestDTO;
import com.KoreaIT.sdy.demo.vo.Club;
import com.KoreaIT.sdy.demo.vo.ResultData;

@Service
public class ClubService {
	@Autowired
	ClubRepository clubRepository;
	

	// 생성자
	public ClubService(ClubRepository clubRepository) {
		this.clubRepository = clubRepository;
	}
	
	public List<AreaRequestDTO> getArea(Map<String, String> params) {
		return clubRepository.selectArea(params);
	}

	// 동호회 생성
	public ResultData create(int loginedMemberId, String name, String region, int categoryId) {
		
		clubRepository.create(loginedMemberId, name, region,categoryId);

		int id = clubRepository.getLastInsertId();

		return ResultData.from("S-1", "동호회가 생성되었습니다.", id);
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

}
