package com.KoreaIT.sdy.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
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
		boolean isMemberIdUnique = isMemberIdUnique(chat.getRoomId(), chat.getMemberId(), chat.getRoomType());

		if (!isMemberIdUnique) {
			return;
		}
		
		System.out.println("ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ");

		chatRepository.addUser(chat.getRoomId(), chat.getMemberId(), chat.getRoomType());
		


		int memberId = chat.getMemberId();

		headerAccessor.getSessionAttributes().put("memberId", memberId);
		headerAccessor.getSessionAttributes().put("roomId", chat.getRoomId());
		headerAccessor.getSessionAttributes().put("roomType", chat.getRoomType());

		chat.setMessage(chat.getSender() + " 님 입장!!");
		
		chatRepository.saveChat(chat.getType(), chat.getRoomId(), chat.getSender(), chat.getMemberId(),
				chat.getMessage(), chat.getTime(), chat.getRoomType());
		template.convertAndSend("/sub/chat/room/" + chat.getRoomId(), chat);
	}

	public void sendMessage(Chat chat) {
		log.info("CHAT {}", chat);
		chat.setMessage(chat.getMessage());
		template.convertAndSend("/sub/chat/room/" + chat.getRoomId(), chat);

		// if(chat.getReceiver == 0)
		// ChatRepository를 통해 메시지 정보를 DB에 저장
		chatRepository.saveChat(chat.getType(), chat.getRoomId(), chat.getSender(), chat.getMemberId(),
				chat.getMessage(), chat.getTime(), chat.getRoomType());

	}

	@EventListener
	public void handleDisconnectEvent(SessionDisconnectEvent event) {
		log.info("SessionDisconnectEvent occurred.");
		log.info("DisConnEvent {}", event);

		StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

		int memberId = (int) headerAccessor.getSessionAttributes().get("memberId");
		int roomId = (int) headerAccessor.getSessionAttributes().get("roomId");
		String roomType = (String) headerAccessor.getSessionAttributes().get("roomType");

		log.info("headAccessor {}", headerAccessor);

		String username = chatRepository.getUserName(roomId, memberId, roomType);

		chatRepository.delUser(roomId, memberId, roomType);

		System.out.println("ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ");
		
		if (username != null) {
			log.info("User Disconnected: " + username);
			Chat chat = Chat.builder().type(Chat.MessageType.LEAVE).sender(username).message(username + " 님 퇴장!!")
					.roomId(roomId).memberId(memberId).roomType(roomType).build();

			chatRepository.saveChat(chat.getType(), chat.getRoomId(), chat.getSender(), chat.getMemberId(),
					chat.getMessage(), chat.getTime(), chat.getRoomType());

			template.convertAndSend("/sub/chat/room/" + roomId, chat);
		}
	}

	public List<String> getUserList(int roomId, String roomType) {
		return chatRepository.getUserList(roomId, roomType);
	}

	public boolean isMemberIdUnique(int roomId, int memberId, String roomType) {
		// 해당 방(roomId)에서 memberId가 중복되는지 확인하는 로직을 구현합니다.
		// 예를 들어, userRepository를 활용하여 데이터베이스에서 중복 여부를 확인할 수 있습니다.
		boolean isUnique = chatRepository.getChat_UserByRoomIdAndMemberId(roomId, memberId, roomType) == null;

		return isUnique;
	}

	public List<Chat> getChatHistory(int roomId, String roomType) {

		return chatRepository.getChatHistory(roomId, roomType);
	}

}
