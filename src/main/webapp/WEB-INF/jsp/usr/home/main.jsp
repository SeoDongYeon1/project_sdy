<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="메인페이지"/>
<%@ include file="../common/head.jspf"%>
<fieldset class="checkbox-group">
	<legend class="checkbox-group-legend">Choose your favorites</legend>
	<div class="checkbox">
		<label class="checkbox-wrapper">
			<input type="checkbox" class="checkbox-input" checked/>
			<span class="checkbox-tile">
				<span class="checkbox-icon">
						<svg xmlns="http://www.w3.org/2000/svg" width="256" height="256" viewBox="0 0 256 256"><path fill="currentColor" d="M128 24a104 104 0 1 0 104 104A104.11 104.11 0 0 0 128 24Zm8 39.38l24.79-17.05a88.41 88.41 0 0 1 36.18 27l-8 26.94c-.2 0-.41.1-.61.17l-22.82 7.41a7.59 7.59 0 0 0-1 .4L136 88.62V63.38ZM95.24 46.33L120 63.38v25.24l-28.56 19.67a7.59 7.59 0 0 0-1-.4l-22.82-7.41c-.2-.07-.41-.12-.61-.17l-8-26.94a88.41 88.41 0 0 1 36.23-27.04Zm-13 129.09H53.9a87.4 87.4 0 0 1-13.79-43.07l22-16.88a5.77 5.77 0 0 0 .58.22l22.83 7.42a7.83 7.83 0 0 0 .93.22l10.79 31.42c-.15.18-.3.36-.44.55l-14.1 19.41a7.8 7.8 0 0 0-.46.71ZM150.69 213a88.16 88.16 0 0 1-45.38 0l-10.06-28.4c.13-.16.27-.31.39-.48l14.11-19.42a7.66 7.66 0 0 0 .46-.7h35.58a7.66 7.66 0 0 0 .46.7l14.11 19.42c.12.17.26.32.39.48Zm23.07-37.61a7.8 7.8 0 0 0-.46-.71l-14.11-19.38c-.14-.19-.29-.37-.44-.55l10.79-31.42a7.83 7.83 0 0 0 .93-.22l22.83-7.42a5.77 5.77 0 0 0 .58-.22l22 16.88a87.4 87.4 0 0 1-13.79 43.07Z"/></svg>
					</svg>
				</span>
				<span class="checkbox-label">축구</span>
			</span>
		</label>
	</div>
</fieldset>
<div class="app-content">
					<div class="app-content-actions">
								<input class="search-bar" placeholder="Search..." type="text">
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
												Items
												<button class="sort-button">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
																		d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
												</button>
										</div>
										<div class="item category">
												Category
												<button class="sort-button">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
																		d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
												</button>
										</div>
										<div class="item status-cell">
												Status
												<button class="sort-button">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
																		d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
												</button>
										</div>
										<div class="item sales">
												Sales
												<button class="sort-button">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
																		d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
												</button>
										</div>
										<div class="item stock">
												Stock
												<button class="sort-button">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
																		d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
												</button>
										</div>
										<div class="item price">
												Price
												<button class="sort-button">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 512 512">
																<path fill="currentColor"
																		d="M496.1 138.3L375.7 17.9c-7.9-7.9-20.6-7.9-28.5 0L226.9 138.3c-7.9 7.9-7.9 20.6 0 28.5 7.9 7.9 20.6 7.9 28.5 0l85.7-85.7v352.8c0 11.3 9.1 20.4 20.4 20.4 11.3 0 20.4-9.1 20.4-20.4V81.1l85.7 85.7c7.9 7.9 20.6 7.9 28.5 0 7.9-7.8 7.9-20.6 0-28.5zM287.1 347.2c-7.9-7.9-20.6-7.9-28.5 0l-85.7 85.7V80.1c0-11.3-9.1-20.4-20.4-20.4-11.3 0-20.4 9.1-20.4 20.4v352.8l-85.7-85.7c-7.9-7.9-20.6-7.9-28.5 0-7.9 7.9-7.9 20.6 0 28.5l120.4 120.4c7.9 7.9 20.6 7.9 28.5 0l120.4-120.4c7.8-7.9 7.8-20.7-.1-28.5z" /></svg>
												</button>
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"
														alt="product"> <span>Ocean</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Furniture
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>11
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>36
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$560
										</div>
								</div>

								<div class="row">
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
														src="https://images.unsplash.com/photo-1484154218962-a197022b5858?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8a2l0Y2hlbnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Lou</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Kitchen
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status disabled">Disabled</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>6
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>46
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$710
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Yellow</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Decoration
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>61
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>56
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$360
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8YmVkcm9vbXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Dreamy</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Bedroom
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status disabled">Disabled</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>41
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>66
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$260
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1554995207-c18c203602cb?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8aW50ZXJpb3J8ZW58MHwwfDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Boheme</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Furniture
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>32
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>40
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$350
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1507652313519-d4e9174996dd?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGludGVyaW9yfGVufDB8MHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Sky</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Bathroom
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status disabled">Disabled</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>22
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>44
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$160
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1516455590571-18256e5bb9ff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzB8fGludGVyaW9yfGVufDB8MHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Midnight</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Furniture
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>23
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>45
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$340
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1554995207-c18c203602cb?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8aW50ZXJpb3J8ZW58MHwwfDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Boheme</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Furniture
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>32
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>40
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$350
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1511389026070-a14ae610a1be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fGludGVyaW9yfGVufDB8MHwwfHw%3D&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Palm</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Decoration
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>24
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>46
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$60
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1600494603989-9650cf6ddd3d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTV8fGludGVyaW9yfGVufDB8MHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Forest</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Living Room
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>41
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>16
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$270
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1560448204-603b3fc33ddc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Njd8fGludGVyaW9yfGVufDB8MHwwfHw%3D&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Sand</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Living Room
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status disabled">Disabled</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>52
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>16
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$230
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1533779283484-8ad4940aa3a8?ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODd8fGludGVyaW9yfGVufDB8MHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Autumn</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Decoration
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>21
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>46
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$252
										</div>
								</div>
								<div class="row">
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
														src="https://images.unsplash.com/photo-1554995207-c18c203602cb?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8aW50ZXJpb3J8ZW58MHwwfDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60"
														alt="product"> <span>Boheme</span>
										</div>
										<div class="item category">
												<span class="cell-label">Category:</span>Furniture
										</div>
										<div class="item status-cell">
												<span class="cell-label">Status:</span> <span class="status active">Active</span>
										</div>
										<div class="item sales">
												<span class="cell-label">Sales:</span>32
										</div>
										<div class="item stock">
												<span class="cell-label">Stock:</span>40
										</div>
										<div class="item price">
												<span class="cell-label">Price:</span>$350
										</div>
								</div>
						</div>	
				</div>
<%@ include file="../common/foot.jspf"%>