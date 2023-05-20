<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${club.name }" />
<%@ include file="../common/head.jspf"%>

<div>${club.purpose }</div>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<hr />
	<div>
			<a href="../chat/room?id=${club.id }" class="btn btn-outline btn-xs">채팅</a>
	</div>

<%@ include file="../common/foot.jspf"%>