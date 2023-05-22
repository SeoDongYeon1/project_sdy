<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="Member Profile" />
<%@ include file="../common/head.jspf"%>


<div class="profile_box mt-8 text-xl">
		<table style="width: 700px;" class="table-box-type-1 table table-zebra">
				<tr>
						<th>이메일</th>
						<th>${member.email }</th>
				</tr>

				<tr>
						<th>이름</th>
						<th>${member.name }</th>
				</tr>

				<tr>
						<th>닉네임</th>
						<th>${member.nickname }</th>
				</tr>
				<c:if test="${rq.loginedMemberId == member.id }">
						<tr>
								<th>이메일</th>
								<th>${member.email }</th>
						</tr>

						<tr>
								<th>전화번호</th>
								<th>${member.cellphoneNum }</th>
						</tr>

						<tr>
								<th>가입날짜</th>
								<th>${member.regDate }</th>
						</tr>
				</c:if>

		</table>
		<br />
		<div class="btn_box">
				<button class="btn btn-outline" type="button" onclick="history.back()">뒤로가기</button>
				<c:if test="${rq.loginedMemberId != member.id }">
					<a class="btn btn-outline" href="../chat/createPersonalChatroom?memberId1=${member.id }">채팅</a>
				</c:if>
				<c:if test="${rq.loginedMemberId == member.id }">
						<a class="btn btn-outline" href="../member/checkPw">회원정보 수정</a>
				</c:if>
		</div>
</div>

<style type="text/css">
.profile_box {
	margin-left: auto;
	margin-right: auto;
	width: 600px;
}

.btn_box {
	text-align: center;
}

tr, th {
	border: 1px solid black;
}
</style>

<%@ include file="../common/foot.jspf"%>