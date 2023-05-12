package com.KoreaIT.sdy.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id; 
	private String title; 
	private String body; 
	private String regDate; 
	private String updateDate; 
	private int memberId;
	private int boardId;
	private int hitCount;
	private int repliesCount;
	private int goodReactionPoint;
	private int badReactionPoint;
	
	private String extra__writer;
	private String board_name;
}
