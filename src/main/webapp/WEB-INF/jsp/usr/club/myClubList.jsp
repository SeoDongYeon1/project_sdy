<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../common/head.jspf"%>

<div>
		<div style= "background-color: #afafaf; ">내 동호회 리스트</div>
		<div class="mt-8">
			<c:forEach var="club" items="${clubs }">
					<div>- <a href="../club/detail?id=${club.id }">${club.name }</a></div>
		
			</c:forEach>
		</div>
</div>
<%@ include file="../common/foot.jspf"%>