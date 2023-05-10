<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/head.jspf"%>
		<script>
			let createRoom__submitFormDone = false;
			
			function createRoom(form) {
				if (createRoom__submitFormDone) {
					return;
				}

				form.name.value = form.name.value.trim();

				if (form.name.value == "") {
					alert('채팅방 이름을 입력해주세요.');
					return;
				}
				alert(form.name.value + "방이 개설되었습니다.");

				createRoom__submitFormDone = true;
				form.submit();
			}
		</script>

			<div>
				<div class="container">
						<div>
								<c:forEach var="room" items="${list }">
								<ul>
									<li><a href="../chat/room?roomId=${room.roomId }">[[${room.roomName}]]</a></li>
								</ul>
								</c:forEach>
						</div>
				</div>
				<form action="/usr/chat/createroom" method="post" onsubmit="createRoom(this); return false;">
						<input style="display: inline-block;" type="text" name="name" class="form-control input input-bordered" id="roomName">
						<button class="btn btn-secondary" id="create">개설하기</button>
				</form>
			</div>
<%@ include file="../common/foot.jspf"%>