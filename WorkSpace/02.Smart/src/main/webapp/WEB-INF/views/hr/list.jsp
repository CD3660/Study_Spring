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
	<h3 class="mb-5">사원목록</h3>
	<div class="row mb-2 justify-content-between">
		<div class="col-auto d-flex">
			<form class="form-inline" action="list">
				<select class="form-select" name="department_id"
					aria-label="Default select example" onchange="submit()">
					<option value="-1">전체 조회</option>
					<c:forEach items="${dept}" var="d">
						<option value="${d.department_id}" ${d.department_id == department_id ? 'selected':''}>${d.department_name}</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="col-auto">
			<input type="button" class="btn btn-primary" value="사원등록"
				onclick="location='<c:url value='/hr/insertPage'/>'" />
		</div>
	</div>

	<table class="table tb-list">
		<thead>
			<tr>
				<th>사번</th>
				<th>사원명</th>
				<th>부서</th>
				<th>업무</th>
				<th>입사일자</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty list }">
				<tr>
					<td colspan="5">데이터가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${list}" var="vo">
				<tr>
					<td>${vo.employee_id }</td>
					<td><a class="text-link"
						href="<c:url value='/hr/info?employee_id=${vo.employee_id }'/>">${vo.name }</a></td>
					<td>${vo.department_name }</td>
					<td>${vo.job_title }</td>
					<td>${vo.hire_date }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>