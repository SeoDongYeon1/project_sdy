<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${club.name }" />
<%@ include file="../common/head.jspf"%>

<div class="mt-8 text-xl mx-auto px-3">
		<table class="table-box-type-1 table table-zebra w-full" style="text-align: center;">
				<tr>
						<th>번호</th>
						<th>${article.id }</th>
				</tr>
				<tr>
						<th>작성자</th>
						<th>${article.extra__writer }</th>
				</tr>
				<tr>
						<th>제목</th>
						<th>${article.title }</th>
				</tr>
				<tr>
						<th>내용</th>
						<th>${article.body }</th>
				</tr>
				<tr>
						<th>작성날짜</th>
						<th>${article.regDate }</th>
				</tr>
				<tr>
						<th>수정날짜</th>
						<th>${article.updateDate }</th>
				</tr>
				<tr>
						<th>조회수</th>
						<th><span class="article-detail__hit-count">${article.hitCount }</span></th>
				</tr>
				<tr>
						<th>좋아요</th>
						<th>${article.goodReactionPoint }</th>
				</tr>
		</table>
</div>

<div>${club.purpose }</div>

	<div>
			<a href="../chat/room?id=${club.id }" class="btn btn-outline btn-xs">채팅</a>
	</div>

<%@ include file="../common/foot.jspf"%>