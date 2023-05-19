package com.KoreaIT.sdy.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.dto.Chat.MessageType;
import com.KoreaIT.sdy.demo.dto.ChatRoom;
import com.KoreaIT.sdy.demo.dto.Chat_User;


@Mapper
public interface ChatRepository {

	public List<ChatRoom> getRooms();

    public ChatRoom getRoomById(int id);

    public void createChatRoom(String roomName, int memberId);

    public void addUser(int roomId, int memberId);

    public void delUser(int roomId, int memberId);

    public String getUserName(int roomId, int memberId);

    public List<String> getUserList(int roomId);

    public void saveChat(MessageType type, int roomId, String sender, int memberId, String message, String time);

	public int getLastInsertId();

	public Chat_User getChat_UserByRoomIdAndMemberId(int roomId, int memberId);
}