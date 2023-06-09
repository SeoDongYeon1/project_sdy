package com.KoreaIT.sdy.demo.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.dto.member_club;
import com.KoreaIT.sdy.demo.vo.AreaRequestDTO;
import com.KoreaIT.sdy.demo.vo.Article;
import com.KoreaIT.sdy.demo.vo.Club;

@Mapper
public interface ClubRepository {
	
	public int getLastInsertId();

	public void create(int loginedMemberId, String name, String areacode, int categoryId, String purpose);

	public Club getClubById(int id);
	
	public List<Club> getClubs();
	
	public List<Club> getForPrintClubs(int categoryId, int limitFrom, int limitTake, String searchKeyword, String step1, String step2, String step3);
	
	public int getClubsCount(int categoryId, String searchKeyword, String step1, String step2, String step3);

	public List<Club> getavgAge();

	public List<Club> getmembersCount();

	public List<AreaRequestDTO> selectArea(Map<String, String> params);

	public int actorCanChat(int actorId, int id);

	public List<Club> getMyClubs(int memberId);

	public void doJoin(int clubId, int memberId, String purpose, int authLevel);

	public member_club getClubByMemberId(int memberId, int clubId);
	
	public List<member_club> getMembersByClubId(int clubId);

	public List<Article> getArticleByClubId(int id);

	public int getmembersCountByclubId(int id);

}
