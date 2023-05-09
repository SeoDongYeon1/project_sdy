<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/head.jspf"%>

<c:set var="pageTitle" value="채팅" />
<link rel="stylesheet" href="/css/main.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">

<c:if test="${rq.isLogined() }">
<div id="username-page">
    <div class="username-page-container">
        <form id="usernameForm" name="usernameForm">
            <div class="form-group">
                <input type="hidden" value="${rq.loginedMemberLoginId }" id="name" name="loginId"/>
            </div>
            <div class="form-group">
                <button type="submit" class="accent username-submit">참여하기</button>
            </div>
        </form>
    </div>
</div>
</c:if>

<c:if test="${!rq.isLogined() }">
<div id="username-page">
	<div class="username-page-container">
	<form id="usernameForm" method="post" action="../member/doLogin">
		<br /> 
		<input type="hidden" name="afterLoginUri" value=${param.afterLoginUri } />
		<div style="display: inline-block; text-align: left;">
			<div class="form-group" style="font-size: 15px; font-weight: bold;">
				아이디 <br /> 
				<input class="form-control" type="text" placeholder="아이디" name="loginId" autocomplete="off" required />
			</div>
			<br />
			<div class="form-group" style="font-size: 15px; font-weight: bold;">
				비밀번호 <br /> 
				<input class="form-control" type="password" placeholder="비밀번호" name="loginPw" autocomplete="off" required />
			</div>
			<br />
			<div class="form-group">
				<button type="submit" class="accent username-submit" style="padding: 0 40px;">로그인</button>
			</div>
		</div>
	</form>
	</div>
</div>
</c:if>

<div id="chat-page" class="hidden">
    <div class="chat-container">
        <div class="chat-header">
            <h2>채팅방</h2>
        </div>
        <div class="connecting">
            연결중..
        </div>
        <ul id="messageArea">

        </ul>
        <form id="messageForm" name="messageForm">
            <div class="form-group">
                <div class="input-group clearfix">
                    <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                    <button type="submit" class="primary">전송</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/js/main.js"></script>
<%@ include file="../common/foot.jspf"%>