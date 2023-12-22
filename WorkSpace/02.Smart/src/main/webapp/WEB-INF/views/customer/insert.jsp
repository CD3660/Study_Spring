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
	<h3 class="mb-4">회원 등록</h3>
	<form action="insert.cu" method="post">
		<table class="table tb-update">
			<colgroup>
				<col width="180px">
				<col>
			</colgroup>
			<tr>
				<th>고객명</th>
				<td>
					<div class="row">
						<div class="col-auto">
							<input class="form-control" type="text" name="name" />
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td><div class="form-check form-check-inline">
						<label><input class="form-check-input" type="radio"
							name="gender" value="남" /> 남</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="radio"
							name="gender" value="여" /> 여</label>
					</div></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" name="email" type="text" />
						</div>
					</div></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" name="phone" type="text" />
						</div>
					</div></td>
			</tr>
		</table>
		<div class="btn-toolbar justify-content-center gap-2">
			<input type="submit" value="회원 등록" class="btn btn-primary" /> <input
				type="button" value="취소" onclick="location='list.cu'"
				class="btn btn-outline-primary" />
		</div>
	</form>
</body>
</html>