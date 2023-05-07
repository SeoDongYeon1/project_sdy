<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${article.title }" />
<%@ include file="../common/head.jspf"%>

<!-- 변수 생성 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<!-- 조회수 관련 -->
<script>
	function ArticleDetail__increaseHitCount() {
		$.get('../article/doIncreaseHitCount', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	$(function(){
		ArticleDetail__increaseHitCount();
	})
</script>

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
		</table>

		<br />
		<div class="btn_box">
				<c:if test="${rq.getLoginedMemberId()==article.memberId }">
						<a class="btn btn-outline" href="../article/modify?id=${article.id }">수정</a>
						<a class="btn btn-outline" onclick="if(confirm('정말 삭제하시겠습니까?')==false) return false;"
								href="doDelete?id=${article.id }">삭제</a>
				</c:if>
				<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
		</div>
</div>

<%@ include file="../common/foot.jspf"%>