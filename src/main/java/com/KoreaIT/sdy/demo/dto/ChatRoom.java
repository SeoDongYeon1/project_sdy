package com.KoreaIT.sdy.demo.dto;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "chat_room")
public class ChatRoom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String roomId;

    @OneToMany(mappedBy = "room", cascade = CascadeType.ALL)
    private List<Chat> chats = new ArrayList<>();

    public void addChat(Chat chat) {
        chats.add(chat);
        chat.setRoom(this);
    }
}
