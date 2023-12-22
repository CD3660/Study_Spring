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
						<select class="form-select" name="department_id" aria-label="Default select example">
							<option value="10" ${vo.department_id eq 10 ? 'selected' : ''}>Administration</option>
							<option value="20" ${vo.department_id eq 20 ? 'selected' : ''}>Marketing</option>
							<option value="30" ${vo.department_id eq 30 ? 'selected' : ''}>Purchasing</option>
							<option value="40" ${vo.department_id eq 40 ? 'selected' : ''}>Human Resources</option>
							<option value="50" ${vo.department_id eq 50 ? 'selected' : ''}>Shipping</option>
							<option value="60" ${vo.department_id eq 60 ? 'selected' : ''}>IT</option>
							<option value="70" ${vo.department_id eq 70 ? 'selected' : ''}>Public Relations</option>
							<option value="80" ${vo.department_id eq 80 ? 'selected' : ''}>Sales</option>
							<option value="90" ${vo.department_id eq 90 ? 'selected' : ''}>Executive</option>
							<option value="100" ${vo.department_id eq 100 ? 'selected' : ''}>Finance</option>
							<option value="110" ${vo.department_id eq 110 ? 'selected' : ''}>Accounting</option>
							<option value="120" ${vo.department_id eq 120 ? 'selected' : ''}>Treasury</option>
							<option value="130" ${vo.department_id eq 130 ? 'selected' : ''}>Corporate Tax</option>
							<option value="140" ${vo.department_id eq 140 ? 'selected' : ''}>Control And Credit</option>
							<option value="150" ${vo.department_id eq 150 ? 'selected' : ''}>Shareholder Services</option>
							<option value="160" ${vo.department_id eq 160 ? 'selected' : ''}>Benefits</option>
							<option value="170" ${vo.department_id eq 170 ? 'selected' : ''}>Manufacturing</option>
							<option value="180" ${vo.department_id eq 180 ? 'selected' : ''}>Construction</option>
							<option value="190" ${vo.department_id eq 190 ? 'selected' : ''}>Contracting</option>
							<option value="200" ${vo.department_id eq 200 ? 'selected' : ''}>Operations</option>
							<option value="210" ${vo.department_id eq 210 ? 'selected' : ''}>IT Support</option>
							<option value="220" ${vo.department_id eq 220 ? 'selected' : ''}>NOC</option>
							<option value="230" ${vo.department_id eq 230 ? 'selected' : ''}>IT Helpdesk</option>
							<option value="240" ${vo.department_id eq 240 ? 'selected' : ''}>Government Sales</option>
							<option value="250" ${vo.department_id eq 250 ? 'selected' : ''}>Retail Sales</option>
							<option value="260" ${vo.department_id eq 260 ? 'selected' : ''}>Recruiting</option>
							<option value="270" ${vo.department_id eq 270 ? 'selected' : ''}>Payroll</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th>업무명</th>
				<td>
					<div class="row">
						<select class="form-select" name="job_id" aria-label="Default select example">
							<option value="10" ${vo.job_id eq 10 ? 'selected' : ''}>One</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th>입사일</th>
				<td><div class="row">
						<div class="col-auto">
							<input class="form-control" name="hire_date" type="date"
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
				onclick="location='<c:url value='/info.cu?customer_id=${vo.customer_id }'/>'"
				class="btn btn-outline-primary" />
		</div>
	</form>
</body>
</html>