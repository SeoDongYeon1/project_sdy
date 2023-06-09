<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.KoreaIT.sdy.demo.vo.Article"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="동호회 글작성" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUIEditorLib.jspf"%>

<!-- Article write 관련 -->
<script type="text/javascript">
	
	let ArticleWrite__submitDone = false;

	function ArticleWrite__submit(form) {
		var title = form.title.value.trim();
		var body = form.body.value.trim();
		

		if (title.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return false;
		}

		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();

		if (markdown.length == 0) {
			alert('내용을 입력해주세요.');
			editor.focus();
			return false;
		}
		form.body.value = markdown;

		ArticleWrite__submitDone = true;
		form.submit();
	}
</script>


<form style="margin-left: 10%;" method="post" action="doWrite" onsubmit="return ArticleWrite__submit(this); return false;" enctype="multipart/form-data">
		<br /> 
		<input type="hidden" name="body">
		<input type="hidden" value="${param.clubId} " name="clubId">
		<div class="form-menu">
				<div style="width: 90%; font-weight: bold; font-size: 25px; text-align: center;">게시글 작성</div>
				<hr style="width: 90%;"/>

				<br />
				<br />
				<div style="text-align: left;">
						<div style="font-size: 17px; font-weight: bold; width: 90%;">
								제목 <br /> <input class="title input input-bordered"
										style="border-radius: 8px; width: 500px;" type="text"
										name="title" />
								
						</div>
						
						<div>
							<div>첨부 이미지</div>
							<div>
								<input name="file__article__0__extra__Img__1" placeholder="이미지를 선택해주세요" type="file" />
							</div>
						</div>
						
						<br />
						<div style="font-size: 17px; font-weight: bold;">
								내용 
								<h1 style="display: inline-block; text-align: right; width: 87%">작성자: ${rq.loginedMember.nickname }</h1>
								<br />
								<div style="width: 90%" class="toast-ui-editor">
										<script type="text/x-template"></script>
								</div>
						</div>
						<br />
				</div>
				<br /> <br />
				<div style="text-align: center; width: 90%; ">
						<button class="btn btn-outline" style="padding: 0 40px;" type="submit">작성</button>
				</div>
		</div>
</form>

<style>
form {
	width: 100%;
}

.form-menu {
	height: 800px; /* 원하는 높이 값을 지정하세요 */
	overflow-y: auto; /* 세로 스크롤을 생성합니다 */
	display: inline-block;
	padding: 50px;
	width: 100%;
	text-align: center;
}
</style>
<%@ include file="../common/foot.jspf"%>