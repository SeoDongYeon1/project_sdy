<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/head.jspf"%>

<div>
		<div class="container">
				<div>
					<h1>개인 채팅방</h1>
						<c:forEach var="proom" items="${PList }">
								<ul>
										<li class="list-group-item d-flex justify-content-between align-items-start">
												<div class="ms-2 me-auto">
														<div class="fw-bold">
																<span class="hidden" id="${proom.memberId1}"></span> <a href="../chat/PersonalChatroom?id=${proom.id }">[[${proom.member1_name}]]</a>
														</div>
												</div> 
										</li>
								</ul>
						</c:forEach>
				</div>
		</div>
		<hr />
		
</div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<div>
	<div class="container">
				<div>
					<h1>동호회 채팅방</h1>
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
</div>
<%@ include file="../common/foot.jspf"%>