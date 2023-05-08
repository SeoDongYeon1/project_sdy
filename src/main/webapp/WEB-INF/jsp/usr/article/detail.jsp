<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${article.title }" />
<%@ include file="../common/head.jspf"%>

<!-- 변수 생성 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}');
</script>

<!-- 조회수 관련 -->
<script>
	function ArticleDetail__increaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);
		$.get('../article/doIncreaseHitCount', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	$(function() {
		ArticleDetail__increaseHitCount();
	})
</script>

<!-- 좋아요, 싫어요 관련 -->
<script>
	function doGoodReaction(articleId) {
		$.ajax({
            url: '/usr/reactionPoint/doGoodReaction',
            type: 'POST',
            data: {relTypeCode: 'article', relId: articleId},
            dataType: 'json',
            success: function(data) {
                if (data.resultCode.startsWith('S-')) {
                    var likeButton = $('#likeButton');
                    var likeCount = $('#likeCount');

                    if (data.resultCode == 'S-1') {
                        likeButton.removeClass('btn-danger').addClass('btn-outline');
                        likeCount.text(parseInt(likeCount.text()) - 1);
                    } else {
                        likeButton.removeClass('btn-outline').addClass('btn-danger');
                        likeCount.text(parseInt(likeCount.text()) + 1);
                    }
                } 
                else {
                    alert(data.msg);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('오류가 발생했습니다: ' + textStatus);
            }
        });
	}
	
	function doBadReaction(articleId) {
		$.ajax({
            url: '/usr/reactionPoint/doBadReaction',
            type: 'POST',
            data: {relTypeCode: 'article', relId: articleId},
            dataType: 'json',
            success: function(data) {
                if (data.resultCode.startsWith('S-')) {
                    var DislikeButton = $('#DislikeButton');
                    var DislikeCount = $('#DislikeCount');

                    if (data.resultCode == 'S-1') {
                    	DislikeButton.removeClass('btn-danger').addClass('btn-outline');
                    	DislikeCount.text(parseInt(DislikeCount.text()) - 1);
                    } else {
                    	DislikeButton.removeClass('btn-outline').addClass('btn-danger');
                        DislikeCount.text(parseInt(DislikeCount.text()) + 1);
                    }
                } 
                else {
                    alert(data.msg);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('오류가 발생했습니다: ' + textStatus);
            }
        });
	}
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
				<tr>
						<th>좋아요</th>
						<th>${article.goodReactionPoint }</th>
				</tr>
		</table>

		<br />
		<div class="btn_box">
				<button id="likeButton" class="btn btn-outline" type="button" onclick="doGoodReaction(${param.id})">
				  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
				    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
				  </svg>
				  <span id="likeCount">${article.goodReactionPoint}</span>
				</button>
				
				<button id="DislikeButton" class="btn btn-outline" type="button" onclick="doBadReaction(${param.id})">
					<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
				    	<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18,4h3v10h-3V4z M5.23,14h4.23l-1.52,4.94C7.62,19.97,8.46,21,9.62,21c0.58,0,1.14-0.24,1.52-0.65L17,14V4H6.57 C5.5,4,4.59,4.67,4.38,5.61l-1.34,6C2.77,12.85,3.82,14,5.23,14z" />
					</svg>
					<span id="DislikeCount">${article.badReactionPoint}</span>
				</button>
			
				<c:if test="${rq.getLoginedMemberId()==article.memberId }">
						<a class="btn btn-outline" href="../article/modify?id=${article.id }">수정</a>
						<a class="btn btn-outline" onclick="if(confirm('정말 삭제하시겠습니까?')==false) return false;"
								href="doDelete?id=${article.id }">삭제</a>
				</c:if>
				<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
		</div>
</div>

<%@ include file="../common/foot.jspf"%>