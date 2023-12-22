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
	<h3 class="mb-4">고객정보</h3>
	<form action="update.cu" method="post">
		<input type="hidden" name="customer_id" value="${vo.customer_id }"/>
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
							<input class="form-control" type="text" name="name" value="${vo.name }" />
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td><div class="form-check form-check-inline">
						<label><input ${vo.gender eq '남' ? 'checked': '' }
							class="form-check-input" type="radio" name="gender" value="남" />
							남</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input ${vo.gender eq '여' ? 'checked': '' }
							class="form-check-input" type="radio" name="gender" value="여" />
							여</label>
					</div></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" name="email" type="text" value="${vo.email }" />
						</div>
					</div></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" name="phone" type="text" value="${vo.phone }" />
						</div>
					</div></td>
			</tr>
		</table>
		<div class="btn-toolbar justify-content-center gap-2">
			<input type="submit" value="정보변경" class="btn btn-primary" /> <input
				type="button" value="취소"
				onclick="location='<c:url value='/info.cu?customer_id=${vo.customer_id }'/>'"
				class="btn btn-outline-primary" />
		</div>
	</form>
</body>
</html>