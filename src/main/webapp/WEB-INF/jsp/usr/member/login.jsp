<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="로그인" />
<%@ include file="../common/head.jspf"%>

<div class="form-box">
		<form method="post" action="doLogin">
				<br />
				<input type="hidden" name="afterLoginUri" value=${param.afterLoginUri } />
				<div style="font-size: 30px; font-weight: bold;">로그인</div>
				<br />
				<div style="display: inline-block; text-align: left;">
						<div style="font-size: 15px; font-weight: bold;">
								아이디
								<br />
								<input class="input input-bordered w-full max-w-xs" type="text" placeholder="아이디" name="loginId"
										autocomplete="on" required />
						</div>
						<br />
						<div style="font-size: 15px; font-weight: bold;">
								비밀번호
								<br />
								<input class="input input-bordered w-full max-w-xs" type="password" placeholder="비밀번호" name="loginPw"
										autocomplete="off" required />
						</div>
						<br />
				</div>
				<br />
				<div class="btn-box">
						<button class="btn btn-outline" style="margin-left: -15px; width: 230px;" type="submit">로그인</button>
				</div>
				<br />
				<br />
				<div style="border-radius: 8px; display: inline-block; margin: 20px 10px; text-decoration: underline;">
						<a href="${rq.findLoginIdUri }">아이디 찾기</a>
				</div>
				<div style="border-radius: 8px; display: inline-block; margin: 20px 10px; text-decoration: underline;">
						<a href="${rq.findLoginPwUri }">비밀번호 찾기</a>
				</div>
				<div style="border-radius: 8px; display: inline-block; margin: 20px 10px; text-decoration: underline;">
						<a href="../member/join">회원가입</a>
				</div>
		</form>
</div>

<style type="text/css">
.form-box {
}

form {
	width: 350px;
	height: 400px;
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
	height: 30px;
	border-radius: 8px;
	width: 230px;
	border: 2px solid black;
}

.btn-box {
	border-radius: 8px;
	display: inline-block;
	width: 200px;
	text-align: center;
}
</style>

<%@ include file="../common/foot.jspf"%>