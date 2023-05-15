package com.KoreaIT.sdy.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.repository.ClubRepository;
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

	// 동호회 생성
	public ResultData create(int loginedMemberId, String name, String region, String category) {
		
		clubRepository.create(loginedMemberId, name, region,category);

		int id = clubRepository.getLastInsertId();

		return ResultData.from("S-1", "동호회가 생성되었습니다.", id);
	}

	public Club getClubById(int id) {
		return clubRepository.getClubById(id);
	}

	public List<Club> getClubs() {
		return clubRepository.getClubs();
	}

}
