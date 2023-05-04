package com.KoreaIT.sdy.demo.util;

public class Ut {

	public static boolean empty(String str) {
		if(str == null || str.trim().length()==0) {
			return true;
		}
		return false;
	}

	public static String f(String format, Object... args) { // 가변인자
		return String.format(format, args);
	}

}
