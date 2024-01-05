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
	<h3 class="mb-4">회원가입</h3>
	<div class="mb-2 text-danger">*은 필수입력항목입니다.</div>
	<form method="post" action="join" enctype="multipart/form-data">
		<table class="table tb-row">
			<colgroup>
				<col width="180px">
				<col>
			</colgroup>
			<tr>
				<th><span>*</span>성명</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" type="text" name="name" autofocus>
						</div>
					</div></td>
			</tr>
			<tr>
				<th><span>*</span>아이디</th>
				<td><div class="row align-items-center input-check">
						<div class="col-auto">
							<input class="form-control check-item" type="text" name="user_id"
								title="아이디">
						</div>
						<div class="col-auto">
							<input type="button" class="btn btn-primary" value="중복확인"
								id="idCheck" />
						</div>
						<div class="col-auto">아이디는 영문 소문자나 숫자 8~16자</div>
						<div class="desc"></div>
					</div></td>
			</tr>
			<tr>
				<th><span>*</span>비밀번호</th>
				<td><div class="row align-items-center input-check">
						<div class="col-auto">
							<input class="form-control check-item" type="password"
								name="user_pw" title="비밀번호">
						</div>
						<div class="col-auto">비밀번호는 영문 대/소문자, 숫자 조합 8~16자</div>
						<div class="desc"></div>
					</div></td>
			</tr>
			<tr>
				<th><span>*</span>비밀번호 확인</th>
				<td><div class="row align-items-center input-check">
						<div class="col-auto">
							<input class="form-control check-item" type="password"
								name="checkPw" title="비밀번호 확인">
						</div>
						<div class="desc"></div>
					</div></td>
			</tr>
			<tr>
				<th><span>*</span>이메일</th>
				<td><div class="row align-items-center input-check">
						<div class="col-auto">
							<input class="form-control check-item" type="text" name="email"
								title="이메일">
						</div>
						<div class="desc"></div>
					</div></td>
			</tr>
			<tr>
				<th><span>*</span>성별</th>
				<td><div class="form-check form-check-inline">
						<label class="form-check-label"> 남 <input
							class="form-check-input" type="radio" name="gender" value="남"
							checked>
						</label>
					</div>
					<div class="form-check form-check-inline">
						<label class="form-check-label"> 여 <input
							class="form-check-input" type="radio" name="gender" value="여">
						</label>
					</div></td>
			</tr>
			<tr>
				<th>프로필이미지</th>
				<td><div class="row">
						<div class="col-auto d-flex file-info align-items-center">
							<label> <input class="form-control img-only"
								id="file-single" accept="image/*" type="file" name="imgFile">
								<i role="button" class="fa-regular fa-address-card fs-8 me-4"></i>
							</label>
							<div class="col-auto d-flex align-items-center">
								<span class="file-preview me-3"></span> <i role="button"
									class="d-none fa-solid fa-trash-can fs-8 text-danger remover"></i>
							</div>
						</div>
					</div></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><div class="row">
						<div class="col-auto d-flex align-items-center">
							<input class="form-control date" type="text" name="birth">
							<i role="button"
								class="fa-solid fa-trash-can fs-6 text-danger date-remover"></i>
						</div>
					</div></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" type="text" name="phone">
						</div>
					</div></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><div class="row mt-2">
						<div class="col-auto">
							<input class="btn btn-primary" type="button" id="btn-post"
								value="주소찾기">
						</div>
						<div class="col-auto">
							<input class="form-control w-px80" type="text" name="post">
						</div>

					</div>
					<div class="row mt-2 mb-2">
						<div class="col-8">
							<input class="form-control" type="text" name="address">
						</div>
						<div class="col">
							<input class="form-control" type="text" name="address-plus">
						</div>
					</div></td>
			</tr>
		</table>
	</form>
	<div class="btn-toolbar justify-content-center gap-2">
		<button class="btn btn-primary" id="btn-join">회원가입</button>
		<button class="btn btn-outline-primary">취소</button>
	</div>

	<script src="<c:url value='/js/member.js'/>"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		$("#btn-join").click(
				function() {
					if ($("[name=name]").val() == "") {
						alert("이름을 입력하세요");
						$("[name=name]").focus();
						return;
					}
					var desc = $("[name=user_id]").closest(".input-check")
							.find(".desc").text();
					if (desc.indexOf("사용가능") == -1) {
						alert("회원가입 불가!\n" + desc);
						return;
					}
					if (invalidStatus($("[name=checkPw]")))
						return;
					if (invalidStatus($("[name=user_pw]")))
						return;
					if (invalidStatus($("[name=email]")))
						return;

					$("form").submit();
				});

		function invalidStatus(tag) {
			var status = member.tagStatus(tag);
			if (status.is)
				return false;

			alert("회원가입 불가\n" + tag.attr("title") + " " + status.desc);
			tag.focus();
			return true;
		}

		$(".check-item").keyup(function(e) {
			if ($(this).attr("name") == "user_id" && e.keyCode == 13) {
				checkId();
			}

			member.showStatus($(this));
		});
		$("#idCheck").click(function() {
			checkId();
		});

		function checkId() {
			var _user_id = $("[name=user_id]");
			var status = member.tagStatus(_user_id);
			if (status.is) {
				$.ajax({
					url : "checkId",
					data : {
						user_id : _user_id.val()
					}
				}).done(
						function(response) {
							var status = response ? member.user_id.usable
									: member.user_id.unusable;
							_user_id.closest(".input-check").find(".desc")
									.text("아이디 " + status.desc).removeClass(
											"text-success text-danger")
									.addClass(
											status.is ? "text-success"
													: "text-danger");
						});
			} else {
				alert("아이디 조건이 불충분합니다\n아이디 " + status.desc);
				_user_id.focus();
			}
		}

		$(function() {
			$("table th span").addClass("me-2 text-danger");

			var today = new Date();
			var endDay = new Date(today.getFullYear() - 13, today.getMonth(),
					today.getDate() - 1);
			$("[name=birth]").datepicker("option", {
				"maxDate" : endDay,
				"showWeek" : true
			});
		})

		$("#btn-post")
				.click(
						function() {
							new daum.Postcode(
									{
										oncomplete : function(data) {
											$("[name=post]").val(data.zonecode);
											var address = data.userSelectedType == "R" ? data.roadAddress
													: data.jibunAddress;
											if (data.buildingName != null)
												address += " ("
														+ data.buildingName
														+ ")";
											$("[name=address]").val(address);
										}
									}).open();
						});
	</script>
</body>
</html>