<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/head.jspf"%>

<div style="margin: 5px auto;">
		<br />
		<div class="container flex">
				<div style="padding: 0 20px;">
						<div>
								<span style="width: 200px; padding: 10px 100px; font-size: 20px; border: 1px solid black;">개인 채팅방</span>
								<br />
								<br />
								<c:forEach var="proom" items="${PList}">
										<div style="border: 1px solid black; height: 33px;">
												<div class="ms-2 me-auto">
														<div class="fw-bold" style="text-align: center;">
																<span class="hidden" id="${proom.memberId1}"></span>
																<a href="../chat/PersonalChatroom?id=${proom.id}">${proom.member1_name}
																		<span class="badge badge-sm ml-auto">+${proom.unreadCount}</span>
																</a>
														</div>
												</div>
										</div>
										<br />
								</c:forEach>
						</div>

				</div>
				<div style="padding: 0 20px;">
						<div>
								<span style="width: 200px; padding: 10px 100px; font-size: 20px; border: 1px solid black;">동호회 채팅방</span>
								<br />
								<br />
								<c:forEach var="croom" items="${CList}">
										<div style="border: 1px solid black; height: 33px;">
												<div class="ms-2 me-auto">
														<div class="fw-bold" style="text-align: center;">
																<span class="hidden" id="${croom.roomName}"></span>
																<a  href="../chat/ClubChatroom?id=${croom.id}">
																		${croom.roomName}
																		<span class="badge badge-sm ml-auto">+${croom.unreadCount}</span>
																</a>
														</div>
												</div>
										</div>
										<br />
								</c:forEach>

						</div>
				</div>
		</div>
</div>







<%@ include file="../common/foot.jspf"%>