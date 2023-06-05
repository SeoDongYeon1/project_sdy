<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="동호회 가입"/>
<%@ include file="../common/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js" referrerpolicy="no-referrer"></script>
<script>
	let submitJoinFormDone = false;
	let validPurpose = "";

	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.purpose.value == 0) {
			alert('가입 목적을 입력해주세요');
			form.purpose.focus();
			return;
		}

		submitJoinFormDone = true;
		form.submit();
	}
</script>
<form method="POST" action="../club/doJoin" onsubmit="submitJoinForm(this); return false;">
		<input type="hidden" name="clubId" value="${param.id}" />
		<div class="form-menu">
				<h1>동호회 가입</h1>
				<br />
				<div style="display: inline-block;">
						<div class="form-purpose">가입 목적</div>
						<div>
								<textarea autocomplete="off" name="purpose" class="textarea textarea-bordered w-full" placeholder="가입목적을 입력해주세요"></textarea>
						</div>
				</div>
				
				<br /> 
				<br />
				
				<div class="btn-box">
						<button class="btn-outline btn" type="button" onclick="history.back();">뒤로가기</button>
						<button class="btn btn-outline" type="submit" value="가입하기">가입하기</button>
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

.btn-box {
	text-align: center;
}

input {
	width: 500px;
}

.form-name {
	text-align: left;
	width: 500px;
}

.form-box {
	border: solid 1px black;
	border-radius: 8px;
}

h1 {
	font-size: 25px;
}
</style>

<%@ include file="../common/foot.jspf"%>