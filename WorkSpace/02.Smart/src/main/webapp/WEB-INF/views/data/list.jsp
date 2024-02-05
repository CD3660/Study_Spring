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
			aria-current="page" href="">약국 조회</a></li>
		<li class="nav-item"><a class="nav-link" href="">유기동물 조회</a></li>
		<li class="nav-item"><a class="nav-link" href="">기타등등1</a></li>
		<li class="nav-item"><a class="nav-link" href="">기타등등2</a></li>
	</ul>
	<div class="row mb-2 justify-content-between">
		<div class="col-auto animal-top">
			
		</div>
		<div class="col-auto">
			<select id="dataPerPage" class="form-select">
				<c:forEach var="i" begin="1" end="5">
					<option value="${10*i }">${10*i }개씩</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div id="data-list"></div>

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
			pharmacy_list($(this).data("page"));
		})
		$("#dataPerPage").change(function() {
			page.dataPerPage = $(this).val();
			pharmacy_list(1);
		})
		function pharmacy_list(nowPage) {
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
				console.log(resp);
				table = ""
				$(resp.items.item).each(function() {
					table += `
						<tr>
							<td>\${this.yadmNm}</td>
							<td>\${this.telno ? this.telno : "-" }</td>
							<td>\${this.addr}</td>
						</tr>
					`
				})
				$("#data-list .pharmacy tbody").html(table);
				paging(resp.totalCount,nowPage)
			})
		}
		function animal_list(pageNo) {
			console.log("유기동물 레츠고");
		}
		var page = { dataPerPage: 10, pagePerBlock: 10 };
	</script>
</body>
</html>