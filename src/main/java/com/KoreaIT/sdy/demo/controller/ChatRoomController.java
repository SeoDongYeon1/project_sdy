package com.KoreaIT.sdy.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.KoreaIT.sdy.demo.dto.ChatRoom;
import com.KoreaIT.sdy.demo.repository.ChatRepository;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatRoomController {

    @Autowired
    private ChatRepository chatRepository;

    // 채팅 리스트 화면
    @GetMapping("usr/chat/list")
    public String goChatRoom(Model model){

        model.addAttribute("list", chatRepository.findAllRoom());
        log.info("SHOW ALL ChatList {}", chatRepository.findAllRoom());
        return "usr/chat/chatlist";
    }

    // 채팅방 생성
    @PostMapping("usr/chat/createroom")
    public String createRoom(@RequestParam String roomName, RedirectAttributes rttr) {
        ChatRoom room = chatRepository.createChatRoom(roomName);
        log.info("CREATE Chat Room {}", room);
        rttr.addFlashAttribute("roomName", room);
        return "redirect:../chat/list";
    }

    // 채팅방 입장 화면
    // @PathVariable : url 에 넘어오는 변수를 매개변수로 받을 수 있게 하는 어노테이션
    // {roomId} 가 url 변수 -> String 타입 roomId 로 받게됨
    @GetMapping("usr/chat/room")
    public String roomDetail(Model model, String roomId){

        log.info("roomId {}", roomId);
        model.addAttribute("room", chatRepository.findRoomById(roomId));
        return "usr/chat/chatroom";
    }

}