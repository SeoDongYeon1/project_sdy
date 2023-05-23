<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${club.name }" />
<%@ include file="../common/head.jspf"%>

<div class="mt-8 text-xl mx-auto px-3">
		<table class="table-box-type-1 table table-zebra w-full" style="text-align: center;">
				<tr>
						<th>프로필 사진</th>
						<th></th>
				</tr>
				<tr>
						<th>동호회 이름</th>
						<th>${club.name }</th>
				</tr>
				<tr>
						<th>활동 내용</th>
						<th>${club.purpose }</th>
				</tr>
				<tr>
				<tr>
						<th>개설날짜</th>
						<th>${club.regDate }</th>
				</tr>
				<tr>
						<th>사진첩</th>
						<th></th>
				</tr>

				<tr>
						<th>채팅</th>
						<th><a href="../chat/ClubChatroom?id=${club.id }" class="btn btn-outline btn-xs">채팅</a></th>
				</tr>
		</table>
		<br />
		<a href="../club/join?id=${club.id }">
				<button style="width: 100px;" class="app-content-headerButton">동호회 가입</button>
		</a>

		<div class="mt-8 text-xl mx-auto px-3">
				<div>회원 리스트</div>
				<table class="table-box-type-1 table table-zebra " style="text-align: center; width: 200px;">
						<tr>
								<th>이름</th>
						</tr>
						<c:forEach var="member" items="${members }">
								<tr>
										<th><a href="../member/profile?id=${member.id }">${member.name }</a></th>
								</tr>
						</c:forEach>
				</table>
		</div>
</div>



<%@ include file="../common/foot.jspf"%>