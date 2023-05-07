<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:set var="pageTitle" value="전체 게시글 보기"/>

<c:if test="${board!=null }">
	<c:set var="pageTitle" value="${board.name }"/>
</c:if>
<%@ include file="../common/head.jspf" %>

<div class="mt-8 text-xl mx-auto px-3">
		<div>게시글 갯수 : ${articlesCount }</div>
		<table class="table-box-type-1 table w-full" style="text-align:center;">
		
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성날짜</th>
			</tr>
		<c:forEach var="article" items="${articles }">
			<tr>
				<th><div class="badge badge-outline">${article.id }</div></th>
				<th>
					<a class="title" href="detail?id=${article.id }">${article.title }</a>
				</th>
				<th>${article.extra__writer }</th>
				<th>${article.regDate.substring(0,10) }</th>
			</tr>

		</c:forEach>
		</table>
	</div>

<%@ include file="../common/foot.jspf" %>