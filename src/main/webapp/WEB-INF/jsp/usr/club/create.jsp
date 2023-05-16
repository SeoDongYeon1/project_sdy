<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="동호회 개설" />
<%@ include file="../common/head.jspf"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js" referrerpolicy="no-referrer"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#category').on('change', function() {
			$('input[name="categoryId"]').val($(this).val());
		});

		$('#region').on('change', function() {
			$('input[name="region"]').val($(this).val());
		});
	});

	function ClubCreate__submit(form) {
		var region = $('input[name="region"]').val().trim();
		var categoryId = $('input[name="categoryId"]').val().trim();
		var name = form.name.value.trim();

		if (region.length == 0) {
			alert('지역을 선택해주세요.');
			return false;
		}

		if (categoryId.length == 0) {
			alert('카테고리를 선택해주세요.');
			return false;
		}

		if (name.length == 0) {
			alert('동호회 이름을 입력해주세요.');
			form.name.focus();
			return false;
		}

		if (purpose.length == 0) {
			alert('동호회 이름을 입력해주세요.');
			form.name.focus();
			return false;
		}

		form.submit();
	}

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
									'<option value="'+city.areacode+'">'
											+ city.step1 + '</option>')
						});
					} else if (type == 'county') {
						$('#county').siblings().remove();
						$('#town').siblings().remove();
						res.forEach(function(county) {
							$('#step2').append(
									'<option value="'+county.areacode+'">'
											+ county.step2 + '</option>')
						});
					} else {
						$('#town').siblings().remove();
						res.forEach(function(town) {
							$('#step3').append(
									'<option value="'+town.areacode+'">'
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
<form method="POST" action="../club/doCreate" onsubmit="ClubCreate__submit(this); return false;">
		<div class="form-menu">
				<h1>동호회 개설</h1>
				<br />
				<div style="display: inline-block;">
						<div style="text-align: center; width: 90%;">
								<select style="border-color: black; width: 200px;" id="region" class="select select-ghost">
										<option disabled selected>지역 선택</option>
										<option value="서울특별시">서울특별시</option>
										<option value="부산광역시">부산광역시</option>
										<option value="대구광역시">대구광역시</option>
										<option value="인천광역시">인천광역시</option>
										<option value="광주광역시">광주광역시</option>
										<option value="대전광역시">대전광역시</option>
										<option value="울산광역시">울산광역시</option>
										<option value="세종특별자치시">세종특별자치시</option>
										<option value="경기도">경기도</option>
										<option value="강원도">강원도</option>
										<option value="충청북도">충청북도</option>
										<option value="충청남도">충청남도</option>
										<option value="전라북도">전라북도</option>
										<option value="전라남도">전라남도</option>
										<option value="경상북도">경상북도</option>
										<option value="경상남도">경상남도</option>
										<option value="제주특별자치도">제주특별자치도</option>
								</select>
						</div>
				</div>
				<div style="display: inline-block; width: 50px;"></div>
				<div style="display: inline-block;">
						<div style="text-align: center; width: 90%;">
								<select style="border-color: black; width: 200px;" id="categoryId" class="select select-ghost">
										<option disabled selected>카테고리 선택</option>
										<option value="1">운동/스포츠</option>
										<option value="2">아웃도어/여행</option>
										<option value="3">문화/공연/축제</option>
										<option value="4">음악/악기</option>
										<option value="5">공예/만들기</option>
										<option value="6">댄스/무용</option>
										<option value="7">봉사활동</option>
										<option value="8">차/오토바이</option>
										<option value="9">사진/영상</option>
										<option value="10">게임/오락</option>
										<option value="11">요리/제조</option>
										<option value="12">반려동물</option>
										<option value="13">자유주제</option>
								</select>
						</div>
				</div>
				<div class="form-group">
						<select class="select" id="step1" title="시/도">
								<option id="city" value="">시/도</option>
						</select> 
						
						<select id="step2" class="select">
								<option id="county" value="">시/군/구</option>
						</select> 
						
						<select id="step3" class="select">
								<option id="town" value="">읍/면/동</option>
						</select>
				</div>


				<br /> <br /> <br />
				<div style="display: inline-block;">
						<input class="region" type="hidden" name="region" /> <input class="category" type="hidden" name="categoryId" />
						<div class="form-name">동호회 이름</div>
						<div>
								<input autocomplete="off" name="name" class="input input-bordered" placeholder="동호회 이름을 입력해주세요." />
								<div class="checkName-msg"></div>
						</div>
						<br />
						<div class="form-name">동호회 목표</div>

						<textarea style="width: 500px; height: 300px;" autocomplete="off" name="purpose" class="input input-bordered" placeholder="동호회 목표를 입력해주세요."></textarea>

				</div>

				<br /> <br />
				<div class="btn-box">
						<button class="btn-outline btn" type="button" onclick="history.back();">뒤로가기</button>
						<button class="btn btn-outline" type="submit" value="생성">생성</button>
				</div>
		</div>

</form>



<style>
form {
	width: 100%;
}

.form-menu {
	height: 800px; /* 원하는 높이 값을 지정하세요 */
	overflow-y: auto; /* 세로 스크롤을 생성합니다 */
	display: inline-block;
	padding: 50px;
	width: 100%;
	text-align: center;
}

.btn-box {
	text-align: center;
}

input {
	width: 500px;
}

.form-name {
	text-align: left;
	width: 500px;
}

.form-box {
	border: solid 1px black;
	border-radius: 8px;
}

h1 {
	font-size: 25px;
}
</style>

<%@ include file="../common/foot.jspf"%>