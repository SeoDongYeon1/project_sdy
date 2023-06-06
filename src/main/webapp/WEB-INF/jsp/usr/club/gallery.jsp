<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${club.name } 사진첩" />
<%@ include file="../common/head.jspf"%>

<div class=" text-xl mx-auto px-3 img_container" style="width: 100%;">
		<%@ include file="../common/clubhead.jspf"%>
		<nav style="margin: 0 65px;">
				<div class="gallery">
						<c:forEach var="article" items="${articles }">
								<div class="gallery-item" style="border: 1px solid gray; border-radius: 8px; padding: 8px;">
										<a href="../article/detail?id=${article.id }">
												<div>
														<img class="gallery-image" src="${rq.getArticleImgUri(article.id)}"
																onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />

												</div>
												<br />
												<span class="img_name">${article.title }</span>
										</a>
								</div>
						</c:forEach>
				</div>
		</nav>
</div>

<style>


*, *::before, *::after {
	box-sizing: border-box;
}

body {
	min-height: 100vh;
}

.img_container {
	max-width: 100%;
	margin: 0 auto;
	padding: 0 12px;
}

.heading {
	font-size: 4rem;
	font-weight: 500;
	line-height: 1.5;
	text-align: center;
	padding: 3.5rem 0;
	color: #1a1a1a;
}

.heading span {
	display: block;
}

.gallery {
	display: flex;
	flex-wrap: wrap;
	/* Compensate for excess margin on outer gallery flex items */
	margin: -1rem -1rem;
}

.gallery-item {
	/* Minimum width of 24rem and grow to fit available space */
	flex: 0 0 24rem;
	/* Margin value should be half of grid-gap value as margins on flex items don't collapse */
	margin: 1rem;
	box-shadow: 0.3rem 0.4rem 0.4rem rgba(0, 0, 0, 0.4);
	overflow: hidden;
}

.gallery-image {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 400ms ease-out;
}

.gallery-image:hover {
	transform: scale(1.15);
}

@
supports (display: grid) { .gallery { display:grid;
	grid-template-columns: repeat(auto-fit, minmax(24rem, 1fr));
	grid-gap: 2rem;
}

.gallery, .gallery-item {
	margin: 0;
}

}
.img_name {
	font-size: 20px;
}
</style>


<%@ include file="../common/foot.jspf"%>