package com.KoreaIT.sdy.demo.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.KoreaIT.sdy.demo.dto.Chat;
import com.KoreaIT.sdy.demo.repository.ChatRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class ChatController {

    private final SimpMessageSendingOperations template;
    private final ChatRepository chatRepository;

    @MessageMapping("/chat/enterUser")
    public void enterUser(@Payload Chat chat, SimpMessageHeaderAccessor headerAccessor) {
        chatRepository.plusUserCnt(chat.getRoomId());
        String userUUID = chatRepository.addUser(chat.getRoomId(), chat.getSender());
        headerAccessor.getSessionAttributes().put("userUUID", userUUID);
        headerAccessor.getSessionAttributes().put("roomId", chat.getRoomId());

        chat.setMessage(chat.getSender() + " 님 입장!!");
        template.convertAndSend("/sub/chat/room/" + chat.getRoomId(), chat);
    }

    @MessageMapping("/chat/sendMessage")
    public void sendMessage(@Payload Chat chat) {
        log.info("CHAT {}", chat);
        chat.setMessage(chat.getMessage());
        template.convertAndSend("/sub/chat/room/" + chat.getRoomId(), chat);
    }

    @GetMapping("/chat/userlist")
    @ResponseBody
    public ArrayList<String> userList(@RequestParam("roomId") String roomId) {
        return chatRepository.getUserList(roomId);
    }

    @GetMapping("/chat/duplicateName")
    @ResponseBody
    public String isDuplicateName(@RequestParam("roomId") String roomId, @RequestParam("username") String username) {
        String userName = chatRepository.isDuplicateName(roomId, username);
        return userName;
    }

    @EventListener
    public void webSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String userUUID = (String) headerAccessor.getSessionAttributes().get("userUUID");
        String roomId = (String) headerAccessor.getSessionAttributes().get("roomId");

        if (userUUID != null && roomId != null) {
            String username = chatRepository.getUserName(roomId, userUUID);
            if (username != null) {
                chatRepository.minusUserCnt(roomId);
                chatRepository.delUser(roomId, userUUID);
                Chat chat = Chat.builder()
                        .type(Chat.MessageType.LEAVE)
                        .sender(username)
                        .message(username + " 님 퇴장!!")
                        .build();
                template.convertAndSend("/sub/chat/room/" + roomId, chat);
                log.info("User Disconnected: " + username);
            }
        }
    }
}
