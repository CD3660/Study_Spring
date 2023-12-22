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
					<td><a href="<c:url value='/hr/info?employee_id=${vo.employee_id }'/>">${vo.employee_id }</a></td>
					<td>${vo.name }</td>
					<td>${vo.department_name }</td>
					<td>${vo.job_title }</td>
					<td>${vo.hire_date }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>