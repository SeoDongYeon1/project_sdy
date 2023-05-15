package com.KoreaIT.sdy.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.vo.Club;

@Mapper
public interface ClubRepository {
	
	public int getLastInsertId();

	public void create(int loginedMemberId, String name, String region, int categoryId);

	public Club getClubById(int id);
	
	public List<Club> getClubs();
	
	public List<Club> getForPrintClubs(int categoryId, int limitFrom, int limitTake, String searchKeyword);
	
	public int getClubsCount(int categoryId, String searchKeyword);

}
