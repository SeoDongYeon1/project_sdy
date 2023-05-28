<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../common/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js" referrerpolicy="no-referrer"></script>

<script>
	let MemberFindLoginId__submitDone = false;

	function MemberFindLoginId__submit(form) {
		if (MemberFindLoginId__submitDone) {
			alert('처리중입니다');
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}

		MemberFindLoginId__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-8 text-xl form-box">
		<div class="container mx-auto px-3">
				<form class="table-box-type-1" method="POST" action="../member/doFindLoginId"
						onsubmit="MemberFindLoginId__submit(this); return false;">
						<input type="hidden" name="afterFindLoginIdUri" value="${param.afterFindLoginIdUri }" />
						<br />
						<div style="font-size: 30px; font-weight: bold;">아이디 찾기</div>
						<br />
						<div style="display: inline-block; text-align: left;">
								<div style="font-size: 15px; font-weight: bold;">
										이름
										<br />
										<input name="name" class="w-full input input-bordered  max-w-xs" placeholder="이름을 입력해주세요" />
								</div>
								<br />
								<div style="font-size: 15px; font-weight: bold;">
										이메일
										<br />
										<input name="email" class="w-full input input-bordered  max-w-xs" placeholder="가입시 입력하신 이메일을 입력해주세요" />
								</div>
								<br />
						</div>
						<div class="container mx-auto btns">
								<button class="btn-text-link btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn btn-outline" type="submit" value="아이디 찾기">찾기</button>
						</div>
				</form>
		</div>


</section>
<style>
.form-box {
	text-align: center;
}

form {
	width: 450px;
	height: 370px;
	border: 2px solid black;
	display: inline-block;
	border-radius: 8px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	text-align: center;
}

.input {
	width: 400px;
}
</style>

<%@ include file="../common/foot.jspf"%>