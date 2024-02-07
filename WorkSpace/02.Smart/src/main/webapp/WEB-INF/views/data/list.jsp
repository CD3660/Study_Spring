<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>공공데이터</h1>
	<ul class="nav nav-pills justify-content-center mb-3">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page">약국 조회</a></li>
		<li class="nav-item"><a class="nav-link">유기동물 조회</a></li>
		<li class="nav-item"><a class="nav-link">기타등등1</a></li>
		<li class="nav-item"><a class="nav-link">기타등등2</a></li>
	</ul>
	<div class="row mb-2 justify-content-between">
		<div class="d-flex gap-2 col-auto animal-top"></div>
		<div class="col-auto">
			<select id="dataPerPage" class="form-select">
				<c:forEach var="i" begin="1" end="5">
					<option value="${10*i }">${10*i }개씩</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div id="data-list"></div>
	<jsp:include page="../include/modal.jsp"></jsp:include>
	<jsp:include page="../include/loading.jsp"></jsp:include>
	<script src='<c:url value="/js/animal.js"/>'></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=앱키"></script>
	<script type="text/javascript">
		$(".nav-pills li").click(function() {
			$(".nav-pills li a").removeClass("active");
			$(this).find("a").addClass("active");
			var idx = $(this).index();
			if (idx == 0) {
				pharmacy_list(1);
			} else if (idx == 1) {
				animal_list(1);
			}
		})
		$(function() {
			$(".nav-pills li").eq(0).trigger("click");
		})
		
		$(document).on("click",".pagination li a",function(){
			if($(".nav-pills li .active").closest(".nav-item").index() == 0)	pharmacy_list($(this).data("page"));
			if($(".nav-pills li .active").closest(".nav-item").index() == 1)	animal_list($(this).data("page"));
			
		}).on("click",".map",function(){
			//xpos, ypos가 undefined가 아닌 경우만 지도 표시 가능
			if($(this).data("x") != "undefined" && $(this).data("y") != "undefined"){
				showKakaoMap($(this));
			} else {
				alert("위치 정보가 없습니다.");
			}
		})
		function showKakaoMap( tag ) {
			$("#map").remove();
			$("#modal-map").after(`<div id="map" style="width: 668px; height: 700px;"></div>`);
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var xy  = new kakao.maps.LatLng(tag.data("y"), tag.data("x")); 
			var options = { //지도를 생성할 때 필요한 기본 옵션
				center: xy, //지도의 중심좌표.
				level: 4 //지도의 레벨(확대, 축소 정도)
			};
			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴


			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: xy
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			//var iwContent = '<div style="padding:5px;">Hello World! <br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

			var storeName = tag.text();
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
		  	 	position : xy, 
			    content : `<div style="padding:5px;" class="text-danger fw-bold">\${storeName}</div>` 
			});

			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
			
			$("#modal-map .modal-body").html($("#map"));
			new bootstrap.Modal($("#modal-map")).show();
		}
		
		
		$("#dataPerPage").change(function() {
			page.dataPerPage = $(this).val();
			if($(".nav-pills li .active").closest(".nav-item").index() == 0)	pharmacy_list(1);
			if($(".nav-pills li .active").closest(".nav-item").index() == 1)	animal_list(1);
		})
		function pharmacy_list(nowPage) {
			$(".animal-top").empty();
			
			var table
			=
			`
			<table class="table tb-list pharmacy">
				<colgroup>
					<col width="300px">
					<col width="160px">
					<col>
				</colgroup>
				<thead>
					<tr>
						<th>약국명</th>
						<th>전화번호</th>
						<th>주소</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			`
			$("#data-list").html(table);
			
			$.ajax({
				url: "pharmacy",
				data:{pageNo:nowPage,numOfRows:page.dataPerPage}
			}).done(function( resp ) {
				resp = resp.response.body;
				table = ""
				$(resp.items.item).each(function() {
					table += `
						<tr>
							<td><a class="map text-link" data-x="\${this.XPos}" data-y="\${this.YPos}">\${this.yadmNm}</a></td>
							<td>\${this.telno ? this.telno : "-" }</td>
							<td>\${this.addr}</td>
						</tr>
					`
				})
				$("#data-list .pharmacy tbody").html(table);
				paging(resp.totalCount,nowPage)
			})
		}
		function animal_list(nowPage) {
			$(".loading").removeClass("d-none");
			
			if($("#sido").length == 0) animal_sido();
			
			var animal = {
				pageNo:nowPage,
				numOfRows:page.dataPerPage,
				sido: $("#sido").length==1 ? $("#sido").val() : "",
				sigungu: $("#sigungu").length==1 ? $("#sigungu").val() : "",
				shelter: $("#shelter").length==1 ? $("#shelter").val() : "",
				upkind: $("#upkind").length==1 ? $("#upkind").val() : "",
				kind: $("#kind").length==1 ? $("#kind").val() : ""
			}
			$.ajax({
				url: "animal/list",
				data: JSON.stringify(animal),
				type:'post',
				contentType:'application/json'
			}).done(function( resp ) {
				$("#data-list").html(resp);
				setTimeout(function() {
					$(".loading").addClass("d-none");
				}, 1000);
			});
		}
		function animal_sido() {
			$.ajax({
				url: "animal/sido"
			}).done(function( resp ) {
				$(".animal-top").prepend(resp);
				animal_type();
			});
		}
		var page = { dataPerPage: 10, pagePerBlock: 10 };
	</script>
</body>
</html>