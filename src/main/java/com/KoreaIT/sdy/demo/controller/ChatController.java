package com.KoreaIT.sdy.demo.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KoreaIT.sdy.demo.dto.ChatDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/chat")
@RequiredArgsConstructor
public class ChatController {

    private final SimpMessageSendingOperations template;

    // MessageMapping 을 통해 webSocket 로 들어오는 메시지를 발신 처리한다.
    // 이때 클라이언트에서는 /pub/chat/message 로 요청하게 되고 이것을 controller 가 받아서 처리한다.
    // 처리가 완료되면 /sub/chat/room/roomId 로 메시지가 전송된다.
    // 이후 /sub/chat/room/roomId 를 구독하고 있는 구독자(클라이언트)들이 /sub/chat/room/roomId 로 날아온 메시지를
    // 구독(subscribe, 수신)하고 view 에서 볼 수 있게 된다.
    @MessageMapping("/chat/message")
    public void message(ChatDTO chat){
        if (ChatDTO.MessageType.ENTER.equals(chat.getType())) {
            chat.setMessage(chat.getSender()+" 님 두둥 등장!!");
            template.convertAndSend("/sub/chat/room"+ chat.getRoomId(), chat);
        }
    }

}