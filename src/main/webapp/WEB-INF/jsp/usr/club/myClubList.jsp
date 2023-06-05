<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="내 동호회" />
<%@ include file="../common/head.jspf"%>

<div class="products-area-wrapper3 gridView">
				<div class="list-header club">
						<div class="item image">
								동호회명
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
				</div>
				<c:forEach var="club" items="${clubs }">
						<a href="../club/detail?id=${club.id }" class="row club-row">
								<button class="cell-more-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-more-vertical">
														<circle cx="12" cy="12" r="1" />
														<circle cx="12" cy="5" r="1" />
														<circle cx="12" cy="19" r="1" /></svg>
								</button> <span class="item image"> <img
										src="${rq.getClubImgUri(club.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}"
										alt=""> <span>${club.name }</span>
						</span>
						</a>
				</c:forEach>
		</div>

<%@ include file="../common/foot.jspf"%>