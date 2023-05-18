package com.KoreaIT.sdy.demo.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.KoreaIT.sdy.demo.dto.Chat;
import com.KoreaIT.sdy.demo.repository.ChatRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ChatService {

    @Autowired
    private SimpMessageSendingOperations template;

    @Autowired
    private ChatRepository chatRepository;

    public void enterUser(Chat chat, SimpMessageHeaderAccessor headerAccessor) {
        chatRepository.plusUserCnt(chat.getRoomId());
        String userUUID = chatRepository.addUser(chat.getRoomId(), chat.getSender());
        headerAccessor.getSessionAttributes().put("userUUID", userUUID);
        headerAccessor.getSessionAttributes().put("roomId", chat.getRoomId());
        chat.setMessage(chat.getSender() + " 님 입장!!");
        template.convertAndSend("/sub/chat/room/" + chat.getRoomId(), chat);
    }

    public void sendMessage(Chat chat) {
        log.info("CHAT {}", chat);
        chat.setMessage(chat.getMessage());
        template.convertAndSend("/sub/chat/room/" + chat.getRoomId(), chat);
    }

    public void handleDisconnectEvent(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());
        String userUUID = (String) headerAccessor.getSessionAttributes().get("userUUID");
        String roomId = (String) headerAccessor.getSessionAttributes().get("roomId");
        chatRepository.minusUserCnt(roomId);
        String username = chatRepository.getUserName(roomId, userUUID);
        chatRepository.delUser(roomId, userUUID);
        if (username != null) {
            log.info("User Disconnected: " + username);
            Chat chat = Chat.builder()
                    .type(Chat.MessageType.LEAVE)
                    .sender(username)
                    .message(username + " 님 퇴장!!")
                    .build();
            template.convertAndSend("/sub/chat/room/" + roomId, chat);
        }
    }

    public ArrayList<String> getUserList(String roomId) {
        return chatRepository.getUserList(roomId);
    }

    public String isDuplicateName(String roomId, String username) {
        String userName = chatRepository.isDuplicateName(roomId, username);
        log.info("동작확인 {}", userName);
        return userName;
    }
}
