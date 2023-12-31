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
	<h3 class="mb-4">사원정보</h3>
	<form action="<c:url value='/hr/update'/>" method="post">
		<input type="hidden" name="employee_id" value="${vo.employee_id }" />
		<table class="table tb-update">
			<colgroup>
				<col width="180px">
				<col>
			</colgroup>
			<tr>
				<th>사원명</th>
				<td>
					<div class="row">
						<div class="col-auto">
							<input class="form-control" type="text" name="first_name"
								value="${vo.first_name }" />
						</div>
						<div class="col-auto">
							<input class="form-control" type="text" name="last_name"
								value="${vo.last_name }" />
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>부서명</th>
				<td>
					<div class="row">
						<div class="col-auto">
							<select class="form-select" name="department_id"
								aria-label="Default select example">
								<option value="-1">부서 없음</option>
								<c:forEach items="${department_list }" var="d">
									<option value="${d.department_id}"
										${vo.department_id eq d.department_id ? 'selected':'' }>${d.department_name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>업무명</th>
				<td>
					<div class="row">
						<div class="col-auto">
							<select class="form-select" name="job_id"
								aria-label="Default select example">
								<c:forEach items="${job_list }" var="j">
									<option value="${j.job_id}"
										${vo.job_id eq j.job_id ? 'selected':'' }>${j.job_title}</option>
								</c:forEach>
							</select>
						</div>
					</div>

				</td>
			</tr>
			<tr>
				<th>입사일</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control date" name="hire_date" type="text"
								value="${vo.hire_date }" />
						</div>
					</div></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" name="email" type="text"
								value="${vo.email }" />
						</div>
					</div></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" name="phone_number" type="text"
								value="${vo.phone_number }" />
						</div>
					</div></td>
			</tr>
			<tr>
				<th>급여</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" name="salary" type="number"
								value="${vo.salary }" />
						</div>
					</div></td>
			</tr>
		</table>
		<div class="btn-toolbar justify-content-center gap-2">
			<input type="submit" value="정보변경" class="btn btn-primary" /> <input
				type="button" value="취소"
				onclick="location='<c:url value='/hr/info?employee_id=${vo.employee_id }'/>'"
				class="btn btn-outline-primary" />
		</div>
	</form>
</body>
</html>