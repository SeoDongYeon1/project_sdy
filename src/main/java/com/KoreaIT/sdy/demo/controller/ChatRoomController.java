package com.KoreaIT.sdy.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.KoreaIT.sdy.demo.dto.ChatRoom;
import com.KoreaIT.sdy.demo.service.ChatRoomService;
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
    private Rq rq;

    // 채팅 리스트 화면
    @GetMapping("/usr/chat/list")
    public String goChatRoom(Model model){
        model.addAttribute("list", chatRoomService.getRooms());
        log.info("SHOW ALL ChatList {}", chatRoomService.getRooms());
        return "usr/chat/chatlist";
    }

    // 채팅방 생성
    @PostMapping("/usr/chat/createroom")
    public String createRoom(@RequestParam String roomName, @RequestParam int memberId, @RequestParam int clubId, RedirectAttributes rttr) {
        ChatRoom room = chatRoomService.createChatRoom(roomName, memberId, clubId);
        
        log.info("CREATE Chat Room {}", room);
        rttr.addFlashAttribute("roomName", room);
        return "redirect:/usr/chat/list";
    }

    // 채팅방 입장 화면
    @GetMapping("/usr/chat/room")
    public String roomDetail(Model model, @RequestParam int id){
    	
    	Boolean actorCanChat = clubService.actorCanChat(rq.getLoginedMemberId(), id);
    	
    	if(actorCanChat==false) {
    		return rq.jsHistoryBackOnView("F-1", "해당 동호회에 가입 후 이용해주세요.");
    	}
    	
        log.info("id {}", id);
        model.addAttribute("room", chatRoomService.getRoomById(id));
        return "usr/chat/chatroom";
    }
}
