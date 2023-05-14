<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
int totalPage = (int) request.getAttribute("totalPage");
int cur_Page = (int) request.getAttribute("page");

int displayPage = 10;
int startPage = ((cur_Page - 1) / displayPage) * displayPage + 1;
int endPage = startPage + displayPage - 1;
%>
<style type="text/css">
.title:hover {
	text-decoration: underline;
}

.reply:hover {
	text-decoration: underline;
}

form {
	text-align: center;
}

.select_box, .search_box, .btn_box {
	display: inline-block;
	margin-top: 20px;
}

.btn_box {
	border-radius: 8px;
}

.articlesCount{
	font-size: 20px;
}

</style>

<c:set var="pageTitle" value="전체 게시글 보기" />
<c:if test="${board!=null }">
	<c:set var="pageTitle" value="${board.name }" />
</c:if>

<%@ include file="../common/head.jspf"%>

<div class="app-content">
						<div>
							<div class="pageTitle">
								${pageTitle }
							</div>
						</div>
						<br />
						<br />
						
						
						<div class="products-area-wrapper tableView">
						<div>
							<div class="common-color articlesCount">
								게시물 갯수: ${articlesCount }
							</div>
						</div>
								<div class="list-header article">
										<c:if test="${board!=null }">
											<div class="item">
												번호
											</div>
										</c:if>
										<c:if test="${board==null }">
											<div class="item">
												게시판
											</div>
										</c:if>
										<div class="item">
												제목
										</div>
										<div class="item">
												작성자
										</div>
										<div class="item">
												작성일
										</div>
										<div class="item">
												조회수
										</div>
										<div class="item">
												좋아요
										</div>
								</div>
								<c:forEach var="article" items="${articles }">
									<div class="row article">
											<c:if test="${board!=null }">
												<div class="item category">
														<div style="width: 50px;"class="badge badge-outline">${article.id }</div>
												</div>
											</c:if>
		
											<c:if test="${board==null }">
												<div class="item category">
														<div>${article.board_name }</div>
												</div>
											</c:if>
											
											<div class="item status-cell">
													<a class="title" href="../article/detail?id=${article.id }">${article.title }</a>
													<c:if test="${article.repliesCount!=0}">
														<a class="reply" href="detail?id=${article.id }" style="color: red;">&nbsp;[${article.repliesCount }]</a>
													</c:if>
											</div>
											<div class="item sales">
													<span class="">${article.extra__writer }</span>
											</div>
											<div class="item stock">
													<span class="">${article.regDate.substring(0,10) }</span>
											</div>
											<div class="item price">
													<span class="">${article.hitCount }</span>
											</div>
											<div class="item price">
													<span class="">${article.goodReactionPoint }</span>
											</div>
									</div>
								</c:forEach>
						</div>	
<div class="pagenation" style="text-align: center; margin-top: 20px;">
		<c:set var="baseUri" value="?boardId=${board.id }" />
		<c:set var="baseUri" value="${baseUri }&searchKeywordTypeCode=${searchKeywordTypeCode }" />
		<c:set var="baseUri" value="${baseUri }&searchKeyword=${searchKeyword }" />
		<%
		if (cur_Page > 10) {
		%>
		<a class="btn btn-outline btn-xs first_page" href="${baseUri }&page=1">◀◀</a>
		<%
		}
		if (endPage > totalPage) {
		endPage = totalPage;
		}

		if (startPage > displayPage) {
		%>
		<a class="btn btn-outline btn-xs" href="${baseUri }&page=<%=startPage - 10%>">이전</a>
		<%
		}

		for (int i = startPage; i <= endPage; i++) {
		%>
		<a class="btn btn-outline btn-xs <%=cur_Page == i ? "btn-active" : "" %>"
				href="${baseUri }&page=<%=i%>"><%=i%></a>
		<%
		}

		if (endPage < totalPage) {
		%>
		<a class="btn btn-outline btn-xs" href="${baseUri }&page=<%=startPage + 10 %>">다음</a>
		<%
		}
		if (cur_Page < totalPage) {
		%>
		<a class="last_page btn btn-outline btn-xs" href="${baseUri }&page=<%=totalPage%>">▶▶</a>
		<%
		}
		%>
</div>

<form action="">
		<input type="hidden" name="boardId" value="${param.boardId }" />
		<div class="select_box">
				<select data-value="${param.searchKeywordTypeCode } " name="searchKeywordTypeCode" class="select select-ghost">
						<option disabled selected>검색 설정</option>
						<option value="title">제목</option>
						<option value="body">내용</option>
						<option value="title,body">제목+내용</option>
				</select>
		</div>
		<div class="search_box">
				<input type="text" value="${param.searchKeyword }" max-length="20" name="searchKeyword" class="input input-bordered"
						placeholder="검색어를 입력해주세요" />
		</div>
		<div class="btn_box">
				<button class="btn btn-outline" onclick="Search() return false;" type="submit">검색</button>
		</div>
</form>
</div>




<%@ include file="../common/foot.jspf"%>