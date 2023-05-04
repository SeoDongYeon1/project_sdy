package com.KoreaIT.sdy.demo.util;

public class Ut {

	public static boolean empty(String str) {
		if(str == null || str.trim().length()==0) {
			return true;
		}
		return false;
	}

}
