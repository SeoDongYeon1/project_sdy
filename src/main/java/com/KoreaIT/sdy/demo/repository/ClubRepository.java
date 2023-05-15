package com.KoreaIT.sdy.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Club;

@Mapper
public interface ClubRepository {
	
	public int getLastInsertId();

	public void create(int loginedMemberId, String name, String region, String category);

	public Club getClubById(int id);
	
	public List<Club> getClubs();

}
