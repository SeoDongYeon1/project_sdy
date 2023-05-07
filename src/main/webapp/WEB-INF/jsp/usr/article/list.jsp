<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
int totalPage = (int) request.getAttribute("totalPage");
int cur_Page = (int) request.getAttribute("page");

int displayPage = 10;
int startPage = ((cur_Page-1)/displayPage)*displayPage+1;
int endPage = startPage+displayPage-1;
%>
<c:set var="pageTitle" value="전체 게시글 보기"/>

<c:if test="${board!=null }">
	<c:set var="pageTitle" value="${board.name }"/>
</c:if>
<%@ include file="../common/head.jspf" %>

<div class="mt-8 text-xl mx-auto px-3">
		<div>게시글 갯수 : ${articlesCount }</div>
		<table class="table-box-type-1 table w-full" style="text-align:center;">
		
			<tr>
				<c:if test="${board!=null }">
					<th>번호</th>
				</c:if>
				<c:if test="${board==null }">
					<th>게시판</th>
				</c:if>
				<th>제목</th>
				<th>작성자</th>
				<th>작성날짜</th>
			</tr>
		<c:forEach var="article" items="${articles }">
			<tr>
				<c:if test="${board!=null }">
					<th>
						<div class="badge badge-outline">${article.id }</div>
					</th>
				</c:if>
				
				<c:if test="${board==null }">
					<th>
						<div>${article.board_name }</div>
					</th>
				</c:if>
				
				<th>
					<a class="title" href="detail?id=${article.id }">${article.title }</a>
				</th>
				<th>${article.extra__writer }</th>
				<th>${article.regDate.substring(0,10) }</th>
			</tr>

		</c:forEach>
		</table>
	</div>
	
	<div class="pagenation" style="text-align: center; margin-top:20px;">
		<c:set var="baseUri" value="?boardId=${board.id }" />
		<%
		if(cur_Page > 10) {
			%>
			<a class = "btn btn-outline btn-xs first_page" href="${baseUri }&page=1">◀◀</a>	
			<%
		}
		if(endPage > totalPage)	{
			endPage = totalPage;
		}
							
	    if(startPage > displayPage) { 
		%>
			<a class="btn btn-outline btn-xs" href="${baseUri }&page=<%=startPage - 10%>">이전</a>
		<%
		}
	    
		for(int i=startPage; i <= endPage; i++){%>
				<a class= "btn btn-outline btn-xs <%=cur_Page == i ? "btn-active" : "" %>" href="${baseUri }&page=<%=i%>"><%=i %></a>
		<%}
		
		if(endPage < totalPage)	{
		%>
			<a class="btn btn-outline btn-xs" href="${baseUri }&page=<%=startPage + 10 %>">다음</a>
		<%
		}
		if(cur_Page < totalPage) {
			%>
			<a class = "last_page btn btn-outline btn-xs" href="${baseUri }&page=<%=totalPage%>">▶▶</a>	
			<%
		}
		%>
	</div>
	
	<style type="text/css">	

	</style>

<%@ include file="../common/foot.jspf" %>