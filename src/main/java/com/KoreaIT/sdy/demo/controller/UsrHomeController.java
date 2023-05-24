package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.KoreaIT.sdy.demo.service.CategoryService;
import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.vo.Category;
import com.KoreaIT.sdy.demo.vo.Club;
import com.KoreaIT.sdy.demo.vo.Rq;

@Controller
public class UsrHomeController {
	@Autowired
	ClubService clubService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	Rq rq;
	
	@RequestMapping("/usr/home/main")
	public String showList(Model model, @RequestParam(defaultValue = "0") int categoryId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "") String searchKeyword) {
		
		Category category = categoryService.getCategoryById(categoryId);

		if (categoryId != 0 && category == null) {
			return rq.jsHistoryBackOnView("F-E", "존재하지 않는 카테고리입니다.");
		}

		// 조건식에 맞는 동호회 갯수 가져오기
		int clubsCount = clubService.getClubsCount(categoryId, searchKeyword);

		// 페이지 네이션
		int itemsInAPage = 12;
		int totalPage = (int) Math.ceil(clubsCount / (double) itemsInAPage);

		List<Club> clubs = clubService.getForPrintClubs(categoryId, itemsInAPage, page, searchKeyword);
		
		List<Club> avgAge = clubService.getavgAge();

		List<Club> membersCount = clubService.getmembersCount();
		
		// 평균 나이 결합
		for(Club club: clubs) {
			for(Club clubAge: avgAge) {
				if(club.getId()==clubAge.getId()) {
					club.setAvgAge(clubAge.getAvgAge());
				}
			}
		}
		
		// 회원수 결합
		for(Club club: clubs) {
			for(Club clubMembers: membersCount) {
				if(club.getId()==clubMembers.getId()) {
					club.setMembersCount(clubMembers.getMembersCount());
				}
			}
		}
		
		model.addAttribute("page", page);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("clubsCount", clubsCount);
		model.addAttribute("clubs", clubs);

		return "usr/home/main";
	}
	
	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
	
	@RequestMapping("/usr/home/main2")
	public String showmain2() {
		return "/usr/home/main2";
	}
}
