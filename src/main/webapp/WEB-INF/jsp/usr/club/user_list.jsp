<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/head.jspf"%>

<div>
		<div class="container">
				<%@ include file="../common/clubhead.jspf"%>
				<br/>
				<br/>
				<c:forEach var="member" items="${members}">
						<div class="card">



								<div class="card-header">
										<img class="w-full rounded-xl" src="${rq.getMemberImgUri(member.memberId)}"
												onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
								</div>


								<div class="card-body">
										<c:choose>
												<c:when test="${member.authLevel == 7 }">
														<span class="tag tag-teal">회장</span>
												</c:when>
												<c:when test="${member.authLevel == 6 }">
														<span class="tag tag-purple">매니저</span>
												</c:when>
												<c:otherwise>
														<span class="tag">일반 회원</span>
												</c:otherwise>
										</c:choose>


										<div class="title">
												<div class="title-text">
														<a href="../member/profile?id=${member.memberId}">이름 : ${member.name}</a>
												</div>
										</div>

										<div class="user"></div>

								</div>
						</div>
				</c:forEach>
		</div>
</div>
<style>
* {
	box-sizing: border-box;
}

.container {
	max-width: 100%;
	margin: 0 auto;
	padding: 0 12px;
	flex-wrap: wrap;
	display: flex;
}

.card {
	margin: 10px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 2px 20px rgba(0, 0, 0, 0.2);
	overflow: hidden;
	width: 200px;
}

.card-header img {
	width: 100%;
	height: 100px;
	object-fit: cover;
}

.card-body {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: flex-start;
	padding: 20px;
	min-height: 100px;
}

.tag {
	background: #cccccc;
	border-radius: 50px;
	font-size: 12px;
	margin: 0;
	color: #fff;
	padding: 2px 10px;
	text-transform: uppercase;
	cursor: pointer;
}

.tag-teal {
	background-color: #47bcd4;
}

.tag-purple {
	background-color: #5e76bf;
}

.tag-pink {
	background-color: #cd5b9f;
}

.card-body p {
	font-size: 13px;
	margin: 0 0 40px;
}

.user {
	display: flex;
	margin-top: auto;
}

.user img {
	border-radius: 50%;
	width: 40px;
	height: 40px;
	margin-right: 10px;
}

.user-info h5 {
	margin: 0;
}

.user-info small {
	color: #545d7a;
}
</style>

<%@ include file="../common/foot.jspf"%>