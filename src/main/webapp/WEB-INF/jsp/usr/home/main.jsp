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

<script type="text/javascript">
	$(document).ready(function() {
		$('#categoryId').on('change', function() {
			$('input[name="categoryId"]').val($(this).val());
		});
		
		$('#step1').on('change', function() {
			$('input[name="step1"]').val($(this).val());
		});
		
		$('#step2').on('change', function() {
			$('input[name="step2"]').val($(this).val());
		});
		
		$('#step3').on('change', function() {
			$('input[name="step3"]').val($(this).val());
		});
	});

	window.onload = function() {
		// 추가된 코드
		loadArea('city');

		// 지역 DB AJAX로 가져오기
		$('#step1').on("change", function() {
			loadArea('county', $(this));
		});

		$('#step2').on("change", function() {
			loadArea('town', $(this));
		});

		function loadArea(type, element) {
			var value = $(element).find('option:selected').text();
			var data = {
				type : type,
				keyword : value
			};

			console.log(data);
			$.ajax({
				url : "../club/getArea",
				data : data,
				dataType : "JSON",
				method : "POST",
				success : function(res) {
					if (type == 'city') {
						res.forEach(function(city) {
							$('#step1').append(
									'<option value="'+city.step1+'">'
											+ city.step1 + '</option>')
						});
					} else if (type == 'county') {
						$('#county').siblings().remove();
						$('#town').siblings().remove();
						res.forEach(function(county) {
							$('#step2').append(
									'<option value="'+county.step2+'">'
											+ county.step2 + '</option>')
						});
					} else {
						$('#town').siblings().remove();
						res.forEach(function(town) {
							$('#step3').append(
									'<option value="'+town.step3+'">'
											+ town.step3 + '</option>')
						});
					}
				},
				error : function(xhr) {
					alert(xhr.responseText);
				}
			});
		}
	};
</script>


<div class="app-content">
		<div class="app-content-actions">
				<form action="" style="width: 90%;">
				
						<input class="step1" type="hidden" name="step1" />
						<input class="step2" type="hidden" name="step2" />
						<input class="step3" type="hidden" name="step3" />
						
						<input class="categoryId" type="hidden" name="categoryId" />
						<div class="form-group " style="display: inline-block;">
								<select class="select select-ghost select-sm" id="step1" title="시/도">
										<option id="city" value="${param.step1 }">시/도</option>
								</select>

								<select id="step2" class="select select-ghost select-sm">
										<option id="county" value="${param.step2 }">시/군/구</option>
								</select>

								<select id="step3" class="select select-ghost select-sm">
										<option id="town" value="${param.step3 }">읍/면/동</option>
								</select>
						</div>

						<div class="select_box" style="display: inline-block;">
								<select id="categoryId" class="select select-ghost select-sm">
										<option disabled selected>카테고리 선택</option>
										<option value="${param.categoryId }">운동/스포츠</option>
										<option value="${param.categoryId }">아웃도어/여행</option>
										<option value="${param.categoryId }">문화/공연/축제</option>
										<option value="${param.categoryId }">음악/악기</option>
										<option value="${param.categoryId }">공예/만들기</option>
										<option value="${param.categoryId }">댄스/무용</option>
										<option value="${param.categoryId }">봉사활동</option>
										<option value="${param.categoryId }">차/오토바이</option>
										<option value="${param.categoryId }">사진/영상</option>
										<option value="${param.categoryId }">게임/오락</option>
										<option value="${param.categoryId }">요리/제조</option>
										<option value="${param.categoryId }">반려동물</option>
										<option value="${param.categoryId }">자유주제</option>
								</select>
						</div>

						<div class="search_box" style="display: inline-block;">
								<input type="text" value="${param.searchKeyword }" max-length="20" name="searchKeyword" class="search-bar"
										placeholder="검색어를 입력해주세요" />
						</div>
						<div class="btn_box" style="display: inline-block;">
								<button class="btn btn-outline btn-sm" onclick="Search() return false;" type="submit">검색</button>
						</div>
				</form>
				<a href="../club/create">
						<button style="width: 100px;" class="app-content-headerButton">동호회 개설</button>
				</a>
				<div></div>
				<div class="app-content-actions-wrapper">
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
		<div>&nbsp; 총 갯수: ${clubsCount }개</div>
		<div class="products-area-wrapper tableView">
				<div class="list-header club">
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
								내용
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
						<div class="item stock">
								회원수
								<button class="sort-button">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
														d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
								</button>
						</div>
						<div class="item price">
								평균나이
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
								</button>
								<span class="item image block">
										<img src="${rq.getClubImgUri(club.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="">
										<span class="cell-label" style="font-size: 13px;">동호회명:</span>
										<span>${club.name }</span>
								</span>
								<span class="item block">
										<span class="cell-label">지역:</span>${club.region_name }
								</span>
								<span class="item block">
										<span class="cell-label">카테고리:</span>
										${club.category_name }
								</span>
								<span class="item block">
										<span class="cell-label">내용:</span>
										${club.purpose }
								</span>
								<span class="item block">
										<span class="cell-label">회원수:</span>${club.membersCount }
								</span>
								<span class="item block">
										<span class="cell-label">평균나이:</span>${club.avgAge }
								</span>

						</a>
				</c:forEach>
		</div>
		<div class="pagenation" style="text-align: center; margin-top: 20px; width: 90%;">
				<c:set var="baseUri" value="?searchKeyword=${searchKeyword }" />
				<%
				if (cur_Page > 10) {
				%>
				<a class="btn btn-outline btn-sm first_page" href="${baseUri }&page=1">◀◀</a>
				<%
				}
				if (endPage > totalPage) {
				endPage = totalPage;
				}

				if (startPage > displayPage) {
				%>
				<a class="btn btn-outline btn-sm" href="${baseUri }&page=<%=startPage - 10%>">이전</a>
				<%
				}

				for (int i = startPage; i <= endPage; i++) {
				%>
				<a class="btn btn-outline btn-sm <%=cur_Page == i ? "btn-active" : "" %>" href="${baseUri }&page=<%=i%>"><%=i%></a>
				<%
				}

				if (endPage < totalPage) {
				%>
				<a class="btn btn-outline btn-sm" href="${baseUri }&page=<%=startPage + 10 %>">다음</a>
				<%
				}
				if (cur_Page < totalPage) {
				%>
				<a class="last_page btn btn-outline btn-sm" href="${baseUri }&page=<%=totalPage%>">▶▶</a>
				<%
				}
				%>
		</div>
</div>


<%@ include file="../common/foot.jspf"%>