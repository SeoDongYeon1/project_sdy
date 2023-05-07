package com.KoreaIT.sdy.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReactionPointRepository {

	int getSumReactionPointByMemberId(int actorId, String relTypeCode, int relId);

	int addGoodReactionPoint(int actorId, String relTypeCode, int relId);
	
}
