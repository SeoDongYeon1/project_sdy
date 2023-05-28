package com.KoreaIT.sdy.demo.vo;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.KoreaIT.sdy.demo.dto.ClubChatRoom;
import com.KoreaIT.sdy.demo.dto.PersonalChatRoom;
import com.KoreaIT.sdy.demo.service.ChatRoomService;
import com.KoreaIT.sdy.demo.service.ChatService;
import com.KoreaIT.sdy.demo.util.Ut;

import lombok.Getter;
import lombok.Setter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	@Getter
	private boolean isLogined;	
	
	@Getter
	private int loginedMemberId;
	
	@Getter
	private Member loginedMember;	
	
	@Getter
	private String loginedMemberLoginId;
	
	@Getter
	@Setter
	private int PunReadCount;
	
	@Getter
	@Setter
	private int CunReadCount;
	
	@Autowired
	ChatRoomService chatRoomService;
	
	@Autowired
	ChatService chatService;
	
	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;
	
	private Map<String, String> paramMap;

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		
		this.session = req.getSession();
		
		paramMap = Ut.getParamMap(req);

		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;
		String loginedMemberLoginId = null;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = (Member) session.getAttribute("loginedMember");
			loginedMemberLoginId = (String) session.getAttribute("loginedMemberLoginId");
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;
		this.loginedMemberLoginId = loginedMemberLoginId;
		
		this.req.setAttribute("rq", this);
	}

	public void printHitoryBackJs(String msg) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		println("<script>");
		if (!Ut.empty(msg)) {
			println("alert('" + msg + "');");
		}
		println("history.back();");
		println("</script>");
	}

	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void println(String str) {
		print(str + "\n");
	}
	
	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
		session.setAttribute("loginedMember", member);
		session.setAttribute("loginedMemberLoginId", member.getLoginId());
	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
	}
	
	// 삭제 x, rq 객체 자동생성
	public void initOnBeforeActionInterceptor() {
		// 해당 memberId가 속하는 개인 채팅방 가져오기
				List<PersonalChatRoom> PList = chatRoomService.getPersonalChatRoomsByMemberId(getLoginedMemberId());
				
				int PunReadCount = 0;
				// 개인채팅방에서 상대방의 이름과 읽지 않은 채팅 수를 가져오기 위한 반복문
				for (PersonalChatRoom room : PList) {
					if (room.getMemberId1() == getLoginedMemberId()) {
						int tmp1 = room.getMemberId1();
						room.setMemberId1(room.getMemberId2());
						room.setMemberId2(tmp1);

						String tmp2 = room.getMember1_name();
						room.setMember1_name(room.getMember2_name());
						room.setMember2_name(tmp2);
					}

					String roomType = "Personal";

					int lastReadId = chatService.getLastReadId(room.getId(), getLoginedMemberId(), roomType);

					int unreadCount = chatService.getPersonalChatUnreadCount(room.getId(), getLoginedMemberId(), roomType,
							lastReadId);

					room.setUnreadCount(unreadCount);
					
					PunReadCount += unreadCount;
				}
				
				setPunReadCount(PunReadCount);

				// 해당 memberId가 속하는 동호회 채팅방 가져오기
				List<ClubChatRoom> CList = chatRoomService.getClubChatRoomsByMemberId(getLoginedMemberId());
				
				int CunReadCount = 0;
				// 동호회 채팅방에서 읽지 않은 채팅의 수를 가져오는 것
				for (ClubChatRoom room : CList) {
					String roomType = "Club";

					int lastReadId = chatService.getLastReadId(room.getId(), getLoginedMemberId(), roomType);

					int unreadCount = chatService.getClubChatUnreadCount(room.getId(), getLoginedMemberId(), roomType,
							lastReadId);

					room.setUnreadCount(unreadCount);
					
					CunReadCount += unreadCount;
				}
				
				setCunReadCount(CunReadCount);
	}

	public String jsHistoryBackOnView(String resultCode, String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/js";

	}

	public String jsHistoryBack(String resultCode, String msg) {
		return Ut.jsHistoryBack(resultCode, msg);
	}

	public String jsReplace(String msg, String uri) {
		return Ut.jsReplace(msg, uri);
	}
	
	public boolean isNotLogined() {
		return !isLogined;
	}
	
	public String getArticleImgUri(int id) {
		return "/common/genFile/file/article/" + id + "/extra/Img/1";
	}
	
	public String getMemberImgUri(int id) {
		return "/common/genFile/file/member/" + id + "/extra/Img/1";
	}
	
	public String getClubImgUri(int id) {
		return "/common/genFile/file/club/" + id + "/extra/Img/1";
	}

	public String getProfileFallbackImgUri() {
		return "https://via.placeholder.com/150/?text=*^_^*";
	}
	
	public String getMemberProfileFallbackImgUri() {
		return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxOX4mkcW8pH9FbpI9rTBkokiMxSY2GJ3eyw&usqp=CAU";
	}

	public String getProfileFallbackImgOnErrorHtml() {
		return "this.src = '" + getProfileFallbackImgUri() + "'";
	}
	
	public String getMemberProfileFallbackImgOnErrorHtml() {
		return "this.src = '" + getMemberProfileFallbackImgUri() + "'";
	}
		
	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		System.out.println(currentUri);
		System.out.println(queryString);

		if (queryString != null && queryString.length() > 0) {
			currentUri += "?" + queryString;
		}

		System.out.println(currentUri);
		return currentUri;
	}
	
	public void run() {
		System.out.println("===========================run A");
	}
	
	public void jsprintReplace(String msg, String replaceUri) {
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsReplace(msg, replaceUri));

	}
	
	public String getLoginUri() {
		return "../member/login?afterLoginUri=" + getAfterLoginUri();
	}

	private String getAfterLoginUri() {
//		로그인 후 접근 불가 페이지

		String requestUri = req.getRequestURI();

		switch (requestUri) {
		case "/usr/member/login":
		case "/usr/member/join":
			return Ut.getEncodedUri(paramMap.get("afterLoginUri"));

		}

		return getEncodedCurrentUri();
	}

	public String getEncodedCurrentUri() {
		return Ut.getEncodedCurrentUri(getCurrentUri());
	}
	
	public String getLogoutUri() {
		return "../member/doLogout?afterLogoutUri=" + getAfterLogoutUri();
	}

	private String getAfterLogoutUri() {
		//로그아웃 후 접근 불가 페이지 방지
		String requestUri = req.getRequestURI();

		switch (requestUri) {
		case "/usr/member/doLogout":
			return Ut.getEncodedUri(paramMap.get("afterLogoutUri"));

		}

		return getEncodedCurrentUri();
	}
	
	public String getJoinUri() {
		return "../member/join?afterLoginUri=" + getAfterLoginUri();
	}
	
	public String getArticleDetailUriFromArticleList(Article article) {
		return "../article/detail?id=" + article.getId() + "&listUri=" + getEncodedCurrentUri();
	}


}