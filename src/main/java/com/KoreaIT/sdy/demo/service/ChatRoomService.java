package com.KoreaIT.sdy.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.dto.ClubChatRoom;
import com.KoreaIT.sdy.demo.dto.PersonalChatRoom;
import com.KoreaIT.sdy.demo.repository.ChatRepository;

@Service
public class ChatRoomService {

    private ChatRepository chatRepository;

    public ChatRoomService(ChatRepository chatRepository) {
        this.chatRepository = chatRepository;
    }

    public List<ClubChatRoom> getRooms() {
        return chatRepository.getRooms();
    }

    public ClubChatRoom createClubChatRoom(String roomName, int memberId, int clubId) {
    	chatRepository.createClubChatRoom(roomName, memberId, clubId);
    	
    	int id = chatRepository.getLastInsertId();
    	
    	ClubChatRoom room = chatRepository.getClubChatRoomById(id);
    	
    	return room;
    }

    public ClubChatRoom getClubChatRoomById(int id) {
        return chatRepository.getClubChatRoomById(id);
    }
    
    public PersonalChatRoom getPersonalChatRoomById(int id) {
    	return chatRepository.getPersonalChatRoomById(id);
    }

	public PersonalChatRoom createPersonalChatRoom(int memberId1, int memberId2) {
		chatRepository.createPersonalChatRoom(memberId1, memberId2);
    	
    	int id = chatRepository.getLastInsertId();
    	
    	PersonalChatRoom room = chatRepository.getPersonalChatRoomById(id);
    	
    	return room;
	}

	public PersonalChatRoom getPersonalChatRoomByMemberId(int memberId1, int memberId2) {
		return chatRepository.getPersonalChatRoomByMemberId(memberId1, memberId2);
	}
}