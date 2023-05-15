package com.KoreaIT.sdy.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClubRepository {
	
	public int getLastInsertId();

	public void create(int loginedMemberId, String name, String region, String category);


}
