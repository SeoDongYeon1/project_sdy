package com.KoreaIT.sdy.demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Builder
@Entity
@Table(name = "chat")
public class Chat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "room_id")
    private ChatRoom room;

    @Column(nullable = false)
    private String sender;

    @Column(nullable = false)
    private String message;

    public enum MessageType {
        CHAT,
        JOIN,
        LEAVE
    }
}
