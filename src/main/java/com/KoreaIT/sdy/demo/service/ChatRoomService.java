package com.KoreaIT.sdy.demo.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.KoreaIT.sdy.demo.dto.ChatRoom;

@Service
public class ChatRoomService {

    private Map<String, ChatRoom> chatRooms = new HashMap<>();

    public List<ChatRoom> getAllChatRooms() {
        return new ArrayList<>(chatRooms.values());
    }

    public ChatRoom createChatRoom(String roomName) {
        ChatRoom chatRoom = new ChatRoom();
        chatRoom.setRoomId(UUID.randomUUID().toString());
        chatRoom.setRoomName(roomName);
        chatRoom.setUserCount(0);
        chatRoom.setUserlist(new HashMap<>());
        chatRooms.put(chatRoom.getRoomId(), chatRoom);
        return chatRoom;
    }

    public ChatRoom getChatRoomById(String roomId) {
        return chatRooms.get(roomId);
    }
}