<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${club.name }" />
<%@ include file="../common/head.jspf"%>

<div class="img_container">
<%@ include file="../common/clubhead.jspf"%>
		<h1 class="heading">
				Image Gallery with CSS Grid
				<span>& Flexbox Fallback</span>
		</h1>

		<div class="gallery">
				<div class="gallery-item" style="border: 1px solid gray; border-radius: 8px; padding: 8px;">
						<div >
								<img class="gallery-image"
										src="https://images.unsplash.com/photo-1488190211105-8b0e65b80b4e?w=500&h=500&fit=crop"
										alt="person writing in a notebook beside by an iPad, laptop, printed photos, spectacles, and a cup of coffee on a saucer">

						</div>
						<br />
						<span class="img_name">ㅇㄴㄴㄴ</span>
				</div>
				<div class="gallery-item" style="border: 1px solid gray; border-radius: 8px; padding: 8px;">
						<div >
								<img class="gallery-image" src="https://images.unsplash.com/photo-1515260268569-9271009adfdb?w=500&h=500&fit=crop"
								alt="sunset behind San Francisco city skyline">

						</div>
						<br />
						<span class="img_name">ㅇㄴㄴㄴ</span>
				</div>
				<div class="gallery-item" style="border: 1px solid gray; border-radius: 8px; padding: 8px;">
						<div >
								<img class="gallery-image" src="https://images.unsplash.com/photo-1506045412240-22980140a405?w=500&h=500&fit=crop"
								alt="people holding umbrellas on a busy street at night lit by street lights and illuminated signs in Tokyo, Japan">

						</div>
						<br />
						<span class="img_name">ㅇㄴㄴㄴ</span>
				</div>
				<div class="gallery-item" style="border: 1px solid gray; border-radius: 8px; padding: 8px;">
						<div >
								<img class="gallery-image" src="https://images.unsplash.com/photo-1514041181368-bca62cceffcd?w=500&h=500&fit=crop"
								alt="car interior from central back seat position showing driver and blurred view through windscreen of a busy road at night">

						</div>
						<br />
						<span class="img_name">ㅇㄴㄴㄴ</span>
				</div>
				<div class="gallery-item" style="border: 1px solid gray; border-radius: 8px; padding: 8px;">
						<div >
								<img class="gallery-image" src="https://images.unsplash.com/photo-1445810694374-0a94739e4a03?w=500&h=500&fit=crop"
								alt="back view of woman wearing a backpack and beanie waiting to cross the road on a busy street at night in New York City, USA">

						</div>
						<br />
						<span class="img_name">ㅇㄴㄴㄴ</span>
				</div>
				<div class="gallery-item" style="border: 1px solid gray; border-radius: 8px; padding: 8px;">
						<div >
								<img class="gallery-image" src="https://images.unsplash.com/photo-1486334803289-1623f249dd1e?w=500&h=500&fit=crop"
								alt="man wearing a black jacket, white shirt, blue jeans, and brown boots, playing a white electric guitar while sitting on an amp">

						</div>
						<br />
						<span class="img_name">ㅇㄴㄴㄴ</span>
				</div>
		</div>

</div>

<style>
:root {
	/* Base font size */
	font-size: 10px;
}

*, *::before, *::after {
	box-sizing: border-box;
}

body {
	min-height: 100vh;
	background-color: #fafafa;
}

.img_container {
	max-width: 100%;
	margin: 0 auto;
	padding: 0 2rem 2rem;
}

.heading {
	font-family: "Montserrat", Arial, sans-serif;
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