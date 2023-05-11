<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<title>Test</title>

<head>
<meta charset="UTF-8">

<!-- 아이콘 불러오기 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- 제이쿼리 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- materialize 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">

<link rel="stylesheet" href="/resource/test.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
<script src="/resource/test.js" defer="defer"></script>

</head>


<body>

		<ul id="slide-out" class="side-nav fixed z-depth-2">
				<li class="center no-padding">
						<div class="indigo darken-2 white-text" style="height: 180px;">
								<div class="row">
										<img style="margin-top: 5%;" width="100" height="100"
												src="data:image/png;base64,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" />

										<p style="margin-top: -13%;">Tirth Patel</p>
								</div>
						</div>
				</li>

				<li id="dash_dashboard"><a class="waves-effect" href="#!"><b>Dashboard</b></a></li>

				<ul class="collapsible" data-collapsible="accordion">
						<li id="dash_users">
								<div id="dash_users_header" class="collapsible-header waves-effect">
										<b>Users</b>
								</div>
								<div id="dash_users_body" class="collapsible-body">
										<ul>
												<li id="users_seller"><a class="waves-effect" style="text-decoration: none;" href="#!">Seller</a></li>

												<li id="users_customer"><a class="waves-effect" style="text-decoration: none;" href="#!">Customer</a></li>
										</ul>
								</div>
						</li>

						<li id="dash_products">
								<div id="dash_products_header" class="collapsible-header waves-effect">
										<b>Products</b>
								</div>
								<div id="dash_products_body" class="collapsible-body">
										<ul>
												<li id="products_product"><a class="waves-effect" style="text-decoration: none;" href="#!">Products</a>
														<a class="waves-effect" style="text-decoration: none;" href="#!">Orders</a></li>
										</ul>
								</div>
						</li>

						<li id="dash_categories">
								<div id="dash_categories_header" class="collapsible-header waves-effect">
										<b>Categories</b>
								</div>
								<div id="dash_categories_body" class="collapsible-body">
										<ul>
												<li id="categories_category"><a class="waves-effect" style="text-decoration: none;" href="#!">Category</a>
												</li>

												<li id="categories_sub_category"><a class="waves-effect" style="text-decoration: none;" href="#!">Sub
																Category</a></li>
										</ul>
								</div>
						</li>

						<li id="dash_brands">
								<div id="dash_brands_header" class="collapsible-header waves-effect">
										<b>Brands</b>
								</div>
								<div id="dash_brands_body" class="collapsible-body">
										<ul>
												<li id="brands_brand"><a class="waves-effect" style="text-decoration: none;" href="#!">Brand</a></li>

												<li id="brands_sub_brand"><a class="waves-effect" style="text-decoration: none;" href="#!">Sub
																Brand</a></li>
										</ul>
								</div>
						</li>
				</ul>
		</ul>

		<header>
				<ul class="dropdown-content" id="user_dropdown">
						<li><a class="indigo-text" href="#!">Profile</a></li>
						<li><a class="indigo-text" href="#!">Logout</a></li>
				</ul>

				<nav class="indigo" role="navigation">
						<div class="nav-wrapper">
								<a data-activates="slide-out" class="button-collapse show-on-" href="#!"><img
										style="margin-top: 17px; margin-left: 5px;"
										src="https://res.cloudinary.com/dacg0wegv/image/upload/t_media_lib_thumb/v1463989873/smaller-main-logo_3_bm40iv.gif" /></a>

								<ul class="right hide-on-med-and-down">
										<li><a class='right dropdown-button' href='' data-activates='user_dropdown'><i
														class=' material-icons'>account_circle</i></a></li>
								</ul>

								<a href="#" data-activates="slide-out" class="button-collapse"><i class="mdi-navigation-menu"></i></a>
						</div>
				</nav>

				<nav>
						<div class="nav-wrapper indigo darken-2">
								<a style="margin-left: 20px;" class="breadcrumb" href="#!">Admin</a> <a class="breadcrumb" href="#!">Index</a>

								<div style="margin-right: 20px;" id="timestamp" class="right"></div>
						</div>
				</nav>
		</header>

		<main>
				<div class="row">
						<div class="col s6">
								<div style="padding: 35px;" align="center" class="card">
										<div class="row">
												<div class="left card-title">
														<b>User Management</b>
												</div>
										</div>

										<div class="row">
												<a href="#!">
														<div style="padding: 30px;" class="grey lighten-3 col s5 waves-effect">
																<i class="indigo-text text-lighten-1 large material-icons">person</i> <span
																		class="indigo-text text-lighten-1"><h5>Seller</h5></span>
														</div>
												</a>
												<div class="col s1">&nbsp;</div>
												<div class="col s1">&nbsp;</div>

												<a href="#!">
														<div style="padding: 30px;" class="grey lighten-3 col s5 waves-effect">
																<i class="indigo-text text-lighten-1 large material-icons">people</i> <span
																		class="indigo-text text-lighten-1"><h5>Customer</h5></span>
														</div>
												</a>
										</div>
								</div>
						</div>

						<div class="col s6">
								<div style="padding: 35px;" align="center" class="card">
										<div class="row">
												<div class="left card-title">
														<b>Product Management</b>
												</div>
										</div>
										<div class="row">
												<a href="#!">
														<div style="padding: 30px;" class="grey lighten-3 col s5 waves-effect">
																<i class="indigo-text text-lighten-1 large material-icons">store</i> <span
																		class="indigo-text text-lighten-1"><h5>Product</h5></span>
														</div>
												</a>

												<div class="col s1">&nbsp;</div>
												<div class="col s1">&nbsp;</div>

												<a href="#!">
														<div style="padding: 30px;" class="grey lighten-3 col s5 waves-effect">
																<i class="indigo-text text-lighten-1 large material-icons">assignment</i> <span
																		class="indigo-text text-lighten-1"><h5>Orders</h5></span>
														</div>
												</a>
										</div>
								</div>
						</div>
				</div>

				<div class="row">
						<div class="col s6">
								<div style="padding: 35px;" align="center" class="card">
										<div class="row">
												<div class="left card-title">
														<b>Brand Management</b>
												</div>
										</div>

										<div class="row">
												<a href="#!">
														<div style="padding: 30px;" class="grey lighten-3 col s5 waves-effect">
																<i class="indigo-text text-lighten-1 large material-icons">local_offer</i> <span
																		class="indigo-text text-lighten-1"><h5>Brand</h5></span>
														</div>
												</a>

												<div class="col s1">&nbsp;</div>
												<div class="col s1">&nbsp;</div>

												<a href="#!">
														<div style="padding: 30px;" class="grey lighten-3 col s5 waves-effect">
																<i class="indigo-text text-lighten-1 large material-icons">loyalty</i> <span
																		class="indigo-text text-lighten-1"><h5>Sub Brand</h5></span>
														</div>
												</a>
										</div>
								</div>
						</div>

						<div class="col s6">
								<div style="padding: 35px;" align="center" class="card">
										<div class="row">
												<div class="left card-title">
														<b>Category Management</b>
												</div>
										</div>
										<div class="row">
												<a href="#!">
														<div style="padding: 30px;" class="grey lighten-3 col s5 waves-effect">
																<i class="indigo-text text-lighten-1 large material-icons">view_list</i> <span
																		class="indigo-text text-lighten-1"><h5>Category</h5></span>
														</div>
												</a>
												<div class="col s1">&nbsp;</div>
												<div class="col s1">&nbsp;</div>

												<a href="#!">
														<div style="padding: 30px;" class="grey lighten-3 col s5 waves-effect">
																<i class="indigo-text text-lighten-1 large material-icons">view_list</i> <span
																		class="truncate indigo-text text-lighten-1"><h5>Sub Category</h5></span>
														</div>
												</a>
										</div>
								</div>
						</div>
				</div>

				<div class="fixed-action-btn click-to-toggle" style="bottom: 45px; right: 24px;">
						<a class="btn-floating btn-large pink waves-effect waves-light"> <i class="large material-icons">add</i>
						</a>

						<ul>
								<li><a class="btn-floating red"><i class="material-icons">note_add</i></a> <a href=""
										class="btn-floating fab-tip">Add a note</a></li>

								<li><a class="btn-floating yellow darken-1"><i class="material-icons">add_a_photo</i></a> <a href=""
										class="btn-floating fab-tip">Add a photo</a></li>

								<li><a class="btn-floating green"><i class="material-icons">alarm_add</i></a> <a href=""
										class="btn-floating fab-tip">Add an alarm</a></li>

								<li><a class="btn-floating blue"><i class="material-icons">vpn_key</i></a> <a href=""
										class="btn-floating fab-tip">Add a master password</a></li>
						</ul>
				</div>
		</main>

		<footer class="indigo page-footer">
				<div class="container">
						<div class="row">
								<div class="col s12">
										<h5 class="white-text">Icon Credits</h5>
										<ul id='credits'>
												<li>Gif Logo made using <a href="https://formtypemaker.appspot.com/" title="Form Type Maker">Form
																Type Maker</a> from <a href="https://github.com/romannurik/FORMTypeMaker" title="romannurik">romannurik</a>
												</li>
												<li>Icons made by <a href="https://material.io/icons/">Google</a>, available under <a
														href="https://www.apache.org/licenses/LICENSE-2.0" target="_blank">Apache License Version 2.0</a>
												</li>
										</ul>
								</div>
						</div>
				</div>
				<div class="footer-copyright">
						<div class="container">
								<span>Made By <a style='font-weight: bold;' href="https://github.com/piedcipher" target="_blank">Tirth
												Patel</a></span>
						</div>
				</div>
		</footer>
</body>
</html>