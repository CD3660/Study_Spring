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
	<h3 class="mb-5">고객목록</h3>
	<div class="row mb-2 justify-content-between">

		<div class="col-auto">
			<form action="list.cu" method="post">
				<div class="input-group">
					<label class="col-form-label me-2">고객명</label><input type="text"
						class="form-control me-2" name="name" value="${name }"> <input
						class="btn btn-primary" type="submit" value="검색" />
				</div>
			</form>
		</div>

		<div class="col-auto">
			<input type="button" class="btn btn-primary" value="고객등록"
				onclick="location='insertPage.cu'" />
		</div>
	</div>

	<table class="table tb-list">
		<thead>
			<tr>
				<th>이름</th>
				<th>성별</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty list }">
				<tr>
					<td colspan="3">데이터가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${list}" var="vo">
				<tr>
					<td><a href="info.cu?customer_id=${vo.customer_id }">${vo.name }</a></td>
					<td>${vo.gender }</td>
					<td>${vo.email }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>