<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/head.jspf"%>

<div>
		<div class="container">
				<div>
						<c:forEach var="proom" items="${PList }">
								<ul>
										<li class="list-group-item d-flex justify-content-between align-items-start">
												<div class="ms-2 me-auto">
														<div class="fw-bold">
																<span class="hidden" id="${proom.memberId1}"></span> <a href="../chat/PersonalChatroom?id=${proom.id }">[[${proom.memberId1}]]</a>
														</div>
												</div> 
										</li>
								</ul>
						</c:forEach>
				</div>
		</div>
		
		<div class="container">
				<div>
						<c:forEach var="croom" items="${CList }">
								<ul>
										<li class="list-group-item d-flex justify-content-between align-items-start">
												<div class="ms-2 me-auto">
														<div class="fw-bold">
																<span class="hidden" id="${croom.roomName}"></span> <a href="../chat/ClubChatroom?id=${croom.id }">[[${croom.roomName}]]</a>
														</div>
												</div> 
										</li>
								</ul>
						</c:forEach>
				</div>
		</div>
		<form action="/usr/chat/createroom" method="post" onsubmit="createRoom(this); return false;">
				<input type="hidden" name="memberId" value=${rq.loginedMemberId }>
				<input style="display: inline-block;" type="text" name="roomName" class="form-control input input-bordered" id="roomName">
				<button class="btn btn-secondary" id="create">개설하기</button>
		</form>
</div>
<%@ include file="../common/foot.jspf"%>