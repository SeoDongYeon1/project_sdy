package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KoreaIT.sdy.demo.dto.ClubChatRoom;
import com.KoreaIT.sdy.demo.dto.PersonalChatRoom;
import com.KoreaIT.sdy.demo.service.ChatRoomService;
import com.KoreaIT.sdy.demo.service.ChatService;
import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.vo.Rq;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatRoomController {

    @Autowired
    private ChatRoomService chatRoomService;
    
    @Autowired
    private ClubService clubService;
    
    @Autowired
    private ChatService chatService;
    
    @Autowired
    private Rq rq;

    // 채팅 리스트 화면
    @RequestMapping("/usr/chat/list")
    public String ShowChatRoomList(Model model){
    	
    	// 해당 memberId가 속하는 개인 채팅방 가져오기
    	List<PersonalChatRoom> PList = chatRoomService.getPersonalChatRoomsByMemberId(rq.getLoginedMemberId());
    	
    	for(PersonalChatRoom room : PList) {
    		if(room.getMemberId1() == rq.getLoginedMemberId()) {
    			int tmp1 = room.getMemberId1();
    			room.setMemberId1(room.getMemberId2());
    			room.setMemberId2(tmp1);
    			System.out.println(tmp1 + room.getMemberId1() + room.getMemberId2());
    			
    			String tmp2 = room.getMember1_name();
    			room.setMember1_name(room.getMember2_name());
    			room.setMember2_name(tmp2);
    		}
    		
    		String roomType = "Personal";
    		
    		int lastReadId = chatService.getLastReadId(room.getId(), rq.getLoginedMemberId(), roomType);
    		
    		int unreadCount = chatService.getUnreadCount(room.getId(), rq.getLoginedMemberId(), roomType, lastReadId);
    		
    		room.setUnreadCount(unreadCount);
    		
    		System.out.println("================="+room);
    	}
    	
        model.addAttribute("PList", PList);
        
        // 해당 memberId가 속하는 동호회 채팅방 가져오기
        List<ClubChatRoom> CList = chatRoomService.getClubChatRoomsByMemberId(rq.getLoginedMemberId());
        
        model.addAttribute("CList", CList);
        
        log.info("SHOW ALL ChatList {}", chatRoomService.getPersonalChatRoomsByMemberId(rq.getLoginedMemberId()));
        log.info("SHOW ALL ChatList {}", chatRoomService.getClubChatRoomsByMemberId(rq.getLoginedMemberId()));
        
        return "usr/chat/chatlist";
    }

    // 동호회 채팅방 생성
    @RequestMapping("/usr/chat/createClubChatroom")
    public String createClubChatRoom(String roomName, int memberId, int clubId) {
        ClubChatRoom room = chatRoomService.createClubChatRoom(roomName, memberId, clubId);
        
        log.info("CREATE Chat Room {}", room);
        
        return "redirect:/usr/chat/list";
    }
    
    // 회원 채팅방 생성
    @RequestMapping("/usr/chat/createPersonalChatroom")
    public String createPersonalChatRoom(int memberId1) {
    	if(memberId1==rq.getLoginedMemberId()) {
    		return rq.jsHistoryBackOnView("F-1", "해당 기능은 사용할 수 없습니다.");
    	}
    	
    	PersonalChatRoom isExistRoom = chatRoomService.getPersonalChatRoomByMemberId(memberId1, rq.getLoginedMemberId());
    	
    	if(isExistRoom!=null) {
    		return "redirect:/usr/chat/PersonalChatroom?id="+isExistRoom.getId();
    	}
    	
        PersonalChatRoom room = chatRoomService.createPersonalChatRoom(memberId1, rq.getLoginedMemberId());
        
        log.info("CREATE Chat Room {}", room);
        return "redirect:/usr/chat/PersonalChatroom?id="+room.getId();
    }

    // 채팅방 입장 화면
    @RequestMapping("/usr/chat/ClubChatroom")
    public String ClubChatRoomDetail(Model model, int id){
    	
    	Boolean actorCanChat = clubService.actorCanChat(rq.getLoginedMemberId(), id);
    	
    	if(actorCanChat==false) {
    		return rq.jsHistoryBackOnView("F-1", "해당 동호회에 가입 후 이용해주세요.");
    	}
    	
        log.info("id {}", id);
        model.addAttribute("room", chatRoomService.getClubChatRoomById(id));
        model.addAttribute("roomType", "Club");
        return "usr/chat/chatroom";
    }
    
    // 채팅방 입장 화면
    @RequestMapping("/usr/chat/PersonalChatroom")
    public String PersonalChatRoomDetail(Model model, int id){
    	
    	log.info("id {}", id);
    	model.addAttribute("room", chatRoomService.getPersonalChatRoomById(id));
    	model.addAttribute("roomType", "Personal");
    	return "usr/chat/chatroom";
    }
}
