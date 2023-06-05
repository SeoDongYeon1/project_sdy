package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.KoreaIT.sdy.demo.dto.ClubChatRoom;
import com.KoreaIT.sdy.demo.dto.PersonalChatRoom;
import com.KoreaIT.sdy.demo.service.CategoryService;
import com.KoreaIT.sdy.demo.service.ChatRoomService;
import com.KoreaIT.sdy.demo.service.ChatService;
import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.vo.Category;
import com.KoreaIT.sdy.demo.vo.Club;
import com.KoreaIT.sdy.demo.vo.Rq;

@Controller
public class UsrHomeController {
	@Autowired
	ClubService clubService;

	@Autowired
	ChatRoomService chatRoomService;

	@Autowired
	ChatService chatService;

	@Autowired
	CategoryService categoryService;

	private Rq rq;

	public UsrHomeController(Rq rq) {
		this.rq = rq;
	}

	@RequestMapping("/usr/home/main")
	public String showList(Model model, @RequestParam(defaultValue = "0") int categoryId,
			@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "") String step1, @RequestParam(defaultValue = "") String step2,
			@RequestParam(defaultValue = "") String step3) {

		rq.run();

		Category category = categoryService.getCategoryById(categoryId);

		if (categoryId != 0 && category == null) {
			return rq.jsHistoryBackOnView("F-E", "존재하지 않는 카테고리입니다.");
		}

		// 조건식에 맞는 동호회 갯수 가져오기
		int clubsCount = clubService.getClubsCount(categoryId, searchKeyword, step1, step2, step3);

		// 페이지 네이션
		int itemsInAPage = 12;
		int totalPage = (int) Math.ceil(clubsCount / (double) itemsInAPage);

		List<Club> clubs = clubService.getForPrintClubs(categoryId, itemsInAPage, page, searchKeyword, step1, step2, step3);

		List<Club> avgAge = clubService.getavgAge();

		List<Club> membersCount = clubService.getmembersCount();

		// 평균 나이 결합
		for (Club club : clubs) {
			for (Club clubAge : avgAge) {
				if (club.getId() == clubAge.getId()) {
					club.setAvgAge(clubAge.getAvgAge());
				}
			}
		}

		// 회원수 결합
		for (Club club : clubs) {
			for (Club clubMembers : membersCount) {
				if (club.getId() == clubMembers.getId()) {
					club.setMembersCount(clubMembers.getMembersCount());
				}
			}
		}

		// 해당 memberId가 속하는 개인 채팅방 가져오기
		List<PersonalChatRoom> PList = chatRoomService.getPersonalChatRoomsByMemberId(rq.getLoginedMemberId());

		// 개인채팅방에서 상대방의 이름과 읽지 않은 채팅 수를 가져오기 위한 반복문
		for (PersonalChatRoom room : PList) {
			if (room.getMemberId1() == rq.getLoginedMemberId()) {
				int tmp1 = room.getMemberId1();
				room.setMemberId1(room.getMemberId2());
				room.setMemberId2(tmp1);

				String tmp2 = room.getMember1_name();
				room.setMember1_name(room.getMember2_name());
				room.setMember2_name(tmp2);
			}

			String roomType = "Personal";

			int lastReadId = chatService.getLastReadId(room.getId(), rq.getLoginedMemberId(), roomType);

			int unreadCount = chatService.getPersonalChatUnreadCount(room.getId(), rq.getLoginedMemberId(), roomType,
					lastReadId);

			room.setUnreadCount(unreadCount);

		}

		model.addAttribute("PList", PList);

		// 해당 memberId가 속하는 동호회 채팅방 가져오기
		List<ClubChatRoom> CList = chatRoomService.getClubChatRoomsByMemberId(rq.getLoginedMemberId());

		// 동호회 채팅방에서 읽지 않은 채팅의 수를 가져오는 것
		for (ClubChatRoom room : CList) {
			String roomType = "Club";

			int lastReadId = chatService.getLastReadId(room.getId(), rq.getLoginedMemberId(), roomType);

			int unreadCount = chatService.getClubChatUnreadCount(room.getId(), rq.getLoginedMemberId(), roomType,
					lastReadId);

			room.setUnreadCount(unreadCount);
		}

		model.addAttribute("CList", CList);

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
