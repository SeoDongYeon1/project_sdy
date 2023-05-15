<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="메인페이지" />
<%@ include file="../common/head.jspf"%>
<%
int totalPage = (int) request.getAttribute("totalPage");
int cur_Page = (int) request.getAttribute("page");

int displayPage = 10;
int startPage = ((cur_Page - 1) / displayPage) * displayPage + 1;
int endPage = startPage + displayPage - 1;
%>


<div class="app-content">
		<div class="app-content-actions">
				<input class="search-bar" placeholder="Search..." type="text">
				<div>🚗</div>
				<div>⚽</div>
				<div>⚾</div>
				<div>🏀</div>
				<div>🎳</div>
				<div>${clubsCount }개</div>
				<div class="app-content-actions-wrapper">
						<div class="filter-button-wrapper">
								<button class="action-button filter jsFilter">
										<span>Filter</span>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-filter">
																<polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3" /></svg>
								</button>
								<div class="filter-menu">
										<label>Category</label> <select>
												<option>All Categories</option>
												<option>Furniture</option>
												<option>Decoration</option>
												<option>Kitchen</option>
												<option>Bathroom</option>
										</select> <label>Status</label> <select>
												<option>All Status</option>
												<option>Active</option>
												<option>Disabled</option>
										</select>
										<div class="filter-menu-buttons">
												<button class="filter-button reset">Reset</button>
												<button class="filter-button apply">Apply</button>
										</div>
								</div>
						</div>
						<button class="action-button list" title="List View">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
										class="feather feather-list">
														<line x1="8" y1="6" x2="21" y2="6" />
														<line x1="8" y1="12" x2="21" y2="12" />
														<line x1="8" y1="18" x2="21" y2="18" />
														<line x1="3" y1="6" x2="3.01" y2="6" />
														<line x1="3" y1="12" x2="3.01" y2="12" />
														<line x1="3" y1="18" x2="3.01" y2="18" /></svg>
						</button>
						<button class="action-button grid" title="Grid View">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
										class="feather feather-grid">
														<rect x="3" y="3" width="7" height="7" />
														<rect x="14" y="3" width="7" height="7" />
														<rect x="14" y="14" width="7" height="7" />
														<rect x="3" y="14" width="7" height="7" /></svg>
						</button>
				</div>
		</div>
		
		<div class="products-area-wrapper tableView">
				<div class="list-header">
						<div class="item image">
								동호회명
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
						<div class="item category">
								지역
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
						<div class="item status-cell">
								카테고리
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
						<div class="item sales">
								회원수
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
						<div class="item stock">
								평균나이
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
						<div class="item price">
								회비
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
				</div>
				<c:forEach var="club" items="${clubs }">
						<a href="../club/detail?id=${club.id }" class="row">
								<button class="cell-more-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
												class="feather feather-more-vertical">
														<circle cx="12" cy="12" r="1" />
														<circle cx="12" cy="5" r="1" />
														<circle cx="12" cy="19" r="1" /></svg>
								</button>

								<div class="item image">
										<img
												src="data:image/jpeg;base64,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"
												alt=""> <span>${club.name }</span>
								</div>
								<div class="item category">
										<span class="cell-label">지역:</span>${club.region }
								</div>
								<div class="item status-cell">
										<span class="cell-label">카테고리:</span> ${club.category }
								</div>
								<div class="item sales">
										<span class="cell-label">회원수:</span>11
								</div>
								<div class="item stock">
										<span class="cell-label">평균 나이:</span>20
								</div>
								<div class="item price">
										<span class="cell-label">회비:</span> 10,000
								</div>
						</a>
				</c:forEach>
		</div>
</div>
<%@ include file="../common/foot.jspf"%>