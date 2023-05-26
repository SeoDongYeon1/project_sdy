<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${club.name }" />
<%@ include file="../common/head.jspf"%>

<div class="mt-8 text-xl mx-auto px-3">
		<form action="../club/profileUpload" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${param.id}" />
				<table class="table-box-type-1 table table-zebra w-full" style="text-align: center;">
						<tr>
								<th>프로필 사진</th>
								<th>
										<img class="w-full rounded-xl" src="${rq.getClubImgUri(club.id)}"
												onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
										<c:forEach var="member" items="${members }">
												<c:if test="${member.memberId==rq.loginedMemberId && member.authLevel==7 || member.authLevel==6 }">
														<div>
																<input name="file__club__0__extra__Img__1" placeholder="이미지를 선택해주세요" type="file" />
														</div>
														<button class="btn btn-outline" type="submit" value="업로드">업로드</button>
												</c:if>
										</c:forEach>
								</th>
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
								<th>일정</th>
								<th>
									<a href="../calendar/do?id=${club.id }" class="btn btn-outline btn-xs">일정</a>
								</th>
						</tr>

						<tr>
								<th>채팅</th>
								<th>
										<a href="../chat/ClubChatroom?id=${club.id }" class="btn btn-outline btn-xs">채팅</a>
								</th>
						</tr>
				</table>

		</form>
		<br />
		<a href="../club/join?id=${club.id }">
				<button style="width: 100px;" class="app-content-headerButton">동호회 가입</button>
		</a>

		<div class="mt-8 text-xl mx-auto px-3">
				<div>회원 리스트</div>
				<table class="table-box-type-1 table table-zebra" style="text-align: center; width: 200px;">
						<tr>
								<th>이름</th>
						</tr>
						<c:forEach var="member" items="${members}">
								<tr>
										<th>
												<c:choose>
														<c:when test="${member.authLevel == 7 || member.authLevel == 6}">
																<a href="../member/profile?id=${member.id}" style="color: blue;">${member.name}</a>
														</c:when>
														<c:otherwise>
																<a href="../member/profile?id=${member.id}" style="color: black;">${member.name}</a>
														</c:otherwise>
												</c:choose>
										</th>
								</tr>
						</c:forEach>
				</table>
		</div>
</div>



<%@ include file="../common/foot.jspf"%>