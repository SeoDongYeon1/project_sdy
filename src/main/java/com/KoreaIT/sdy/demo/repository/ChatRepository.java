package com.KoreaIT.sdy.demo.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.dto.ChatRoom;


@Mapper
public interface ChatRepository {

    List<ChatRoom> findAllRoom();

    ChatRoom findRoomById(String roomId);

    ChatRoom createChatRoom(String roomName);

    void plusUserCnt(String roomId);

    void minusUserCnt(String roomId);

    String addUser(String roomId, String userName);

    String isDuplicateName(String roomId, String username);

    void delUser(String roomId, String userUUID);

    String getUserName(String roomId, String userUUID);

    ArrayList<String> getUserList(String roomId);
}