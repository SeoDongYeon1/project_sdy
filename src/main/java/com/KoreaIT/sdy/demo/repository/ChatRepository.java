package com.KoreaIT.sdy.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KoreaIT.sdy.demo.dto.Chat;
import com.KoreaIT.sdy.demo.dto.Chat.MessageType;
import com.KoreaIT.sdy.demo.dto.ClubChatRoom;
import com.KoreaIT.sdy.demo.dto.PersonalChatRoom;
import com.KoreaIT.sdy.demo.dto.Chat_User;


@Mapper
public interface ChatRepository {

	public List<ClubChatRoom> getRooms();

    public ClubChatRoom getClubChatRoomById(int id);

    public void createClubChatRoom(String roomName, int memberId, int clubId);

    public void addUser(int roomId, int memberId);

    public void delUser(int roomId, int memberId);

    public String getUserName(int roomId, int memberId);

    public List<String> getUserList(int roomId);

    public void saveChat(MessageType type, int roomId, String sender, int memberId, String message, String time);

	public int getLastInsertId();

	public Chat_User getChat_UserByRoomIdAndMemberId(int roomId, int memberId);

	public List<Chat> getChatHistory(int roomId);

	public void createPersonalChatRoom(int memberId1, int memberId2);

	public PersonalChatRoom getPersonalChatRoomById(int id);

	public PersonalChatRoom getPersonalChatRoomByMemberId(int memberId1, int memberId2);
}