package com.KoreaIT.sdy.demo.dto;

import lombok.Data;

@Data
public class ChatRoom {
    private int id; // 채팅방 아이디
    private String roomName; // 채팅방 이름
    private long userCount; // 채팅방 인원수

}
