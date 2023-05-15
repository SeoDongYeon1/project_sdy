package com.KoreaIT.sdy.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Club {
	private int id; 
	private String regDate; 
	private String updateDate; 
	private int leaderId;
	private String name; 
	private String category;
	private boolean delStatus;
	private String delDate;
	
}
