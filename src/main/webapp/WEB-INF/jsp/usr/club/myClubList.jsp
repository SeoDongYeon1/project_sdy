<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="내 동호회" />
<%@ include file="../common/head.jspf"%>
<div class=" text-xl mx-auto px-3" style="width: 100%;">
		<div style="margin: 20px 30px; font-size: 25px;">내 동호회</div>
		<div class="container">
				<br />
				<br />
				<c:forEach var="club" items="${clubs}">
						<div class="card">
						<a href="../club/detail?id=${club.id}">
								<div class="card-header">
										<img src="${rq.getClubImgUri(club.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="">
								</div>
								<div class="card-body">
										<div class="title">
												<div class="title-text">
														<a href="../club/detail?id=${club.id}">${club.name}</a>
												</div>
										</div>
								</div>
						</a>
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
	width: 250px;
}

.card-header img {
	width: 100%;
	height: 150px;
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

</style>

<%@ include file="../common/foot.jspf"%>