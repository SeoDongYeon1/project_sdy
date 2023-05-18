package com.KoreaIT.sdy.demo.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.dto.Chat;
import com.KoreaIT.sdy.demo.dto.Chat.MessageType;
import com.KoreaIT.sdy.demo.dto.ChatRoom;


@Mapper
public interface ChatRepository {

    List<ChatRoom> findAllRoom();

    ChatRoom findRoomById(String roomId);

    void createChatRoom(ChatRoom chatRoom);

    void plusUserCnt(String roomId);

    void minusUserCnt(String roomId);

    String addUser(String roomId, String userName);

    void delUser(String roomId, String userUUID);

    String getUserName(String roomId, String userUUID);

    ArrayList<String> getUserList(String roomId);

	void saveChat(MessageType type, String roomId, String sender, String message, String time);
}