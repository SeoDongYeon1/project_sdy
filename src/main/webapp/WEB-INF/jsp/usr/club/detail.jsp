<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${club.name }" />
<%@ include file="../common/head.jspf"%>

<div class=" text-xl mx-auto px-3" style="width: 100%;">
		<%@ include file="../common/clubhead.jspf"%>
		<form action="../club/profileUpload" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${param.id}" />
				<div style="margin-left: 30%;">
						<table class="table-box-type-1 table table-zebra" style="text-align: center;">
								<tr>
										<th>프로필 사진</th>
										<th>
												<img style="width: 500px;" class="rounded-xl" src="${rq.getClubImgUri(club.id)}"
														onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
												<c:forEach var="member" items="${members }">
														<c:if test="${member.memberId==rq.loginedMemberId && member.authLevel==7 || member.authLevel==6 }">
																<div>
																		<input name="file__club__0__extra__Img__1" placeholder="이미지를 선택해주세요" type="file" />
																</div>
																<button class="btn btn-outline" type="submit" value="업로드">업로드</button>
														</c:if>
												</c:forEach>
										</th>
								</tr>
								<tr>
										<th>동호회 이름</th>
										<th>${club.name }</th>
								</tr>
								<tr>
										<th>활동 내용</th>
										<th>${club.purpose }</th>
								</tr>
								<tr>
								<tr>
										<th>개설날짜</th>
										<th>${club.regDate }</th>
								</tr>
						</table>
				</div>
		</form>
		<br />
</div>


<%@ include file="../common/foot.jspf"%>