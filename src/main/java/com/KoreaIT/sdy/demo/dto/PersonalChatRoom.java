package com.KoreaIT.sdy.demo.dto;

import lombok.Data;

@Data
public class PersonalChatRoom {
    private int id; // 채팅방 아이디
    private String regDate; // 채팅방 생성 날짜
    private String updateDate; // 채팅방 수정 날짜
    private int memberId1; // 채팅방 사람1
    private int memberId2; // 채팅방 사람2

}
