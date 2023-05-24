package com.KoreaIT.sdy.demo.vo;

import java.util.Map;

import com.KoreaIT.sdy.demo.util.Ut;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ResultData {
	private String resultCode;
	
	private String msg;
	
	private Object data1;
	
	private Map<String, Object> body;
	
	public ResultData(String resultCode, String msg, Object... args) {
		this.resultCode = resultCode;
		this.msg = msg;
		this.body = Ut.mapOf(args);
	}
	
	public static ResultData from(String resultCode, String msg) {
		return from(resultCode, msg, null);
	}
	
	public static ResultData from(String resultCode, String msg, Object data1) {
		ResultData rd = new ResultData();
		
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1 = data1;
		
		return rd;
	}
	
	public static ResultData newData(ResultData Rd, Object newData) {
		return from(Rd.getResultCode(), Rd.getMsg(), newData);
	}
	
	public boolean isSuccess() { // 출력형태 -> "success": true || false
		return resultCode.startsWith("S-");
	}

	public boolean isFail() { // 출력형태 -> "fail": true || false
		return isSuccess()==false;
	}

}
