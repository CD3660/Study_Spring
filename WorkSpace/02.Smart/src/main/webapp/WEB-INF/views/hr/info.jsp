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
	<table class="table tb-row">
		<colgroup>
			<col width="180px">
			<col>
		</colgroup>
		<tr>
			<th>사원번호</th>
			<td>${vo.employee_id }</td>
		</tr>
		<tr>
			<th>사원명</th>
			<td>${vo.name }</td>
		</tr>
		<tr>
			<th>부서명</th>
			<td>${vo.department_name }</td>
		</tr>
		<tr>
			<th>업무명</th>
			<td>${vo.job_title }</td>
		</tr>
		<tr>
			<th>입사일</th>
			<td>${vo.hire_date }</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${vo.email }</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${vo.phone_number }</td>
		</tr>
		<tr>
			<th>급여</th>
			<td>${vo.salary }</td>
		</tr>
	</table>
	<div class="btn-toolbar justify-content-center gap-2">
		<input type="button" value="사원목록"
			onclick="location='<c:url value='/hr/list'/>'"
			class="btn btn-secondary" /> <input type="button" value="정보변경"
			onclick="location='<c:url value='/hr/updatePage?employee_id=${vo.employee_id }'/>'"
			class="btn btn-primary" /> <input type="button" value="정보삭제"
			onclick="" class="btn btn-danger" />
	</div>
	<script type="text/javascript">
		function go_delete() {
			if(confirm('정말 ${vo.name} 고객정보를 삭제하시겠습니까?')){
				location='delete.cu?customer_id=${vo.employee_id }';
			} else {
				return false;
			}
		}
	
	</script>
</body>
</html>