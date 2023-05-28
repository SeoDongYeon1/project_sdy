<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정</title>
</head>
<body>
<!-- Reply modify 관련 -->
<script type="text/javascript">
	let ReplyModify__submitFormDone = false;
	function ReplyModify__submit(form) {
		if (ReplyModify__submitFormDone) {
			return;
		}
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요');
			form.body.focus();
			return;
		}
		ReplyModify__submitFormDone = true;
		form.submit();
	}
</script>
	<div class="text-box mt-2 text-xl mx-auto px-3">
		<form onsubmit="ReplyModify__submit(this) return false;" method= "post" action="../reply/doModify">
			<input value= "${reply.id }" type="hidden" name="id"/>
			<input type="hidden" name="replaceUri" value="${param.replaceUri }" />
			<textarea class="textarea textarea-bordered w-full body" name="body">${reply.body }</textarea>
				
			<div style="border-radius: 8px; display: inline-block; width: 200px;">
				<button class="btn btn-outline" type="submit" >수정하기</button>
			</div>
		</form>
	</div>
		
</body>

<style>
	.text-box {
		position: absolute;
		top:0;
		left: 0;
	}
	
	.body {
		width: 1000px;
		font-size: 18px;
	}
</style>
</html>