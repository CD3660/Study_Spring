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
	<h3>회원정보 [${method }]</h3>
	<table border="solid 1px">
		<tr>
			<td>성명</td>
			<td>${name }${vo.name }</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>${gender }${vo.gender }</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${email }${vo.email }</td>
		</tr>
		<tr>
			<td>나이</td>
			<td>${age }${vo.age }</td>
		</tr>
	</table>
	<input type="button" value="회원가입화면" onclick="go_join()">
	<script type="text/javascript">
		function go_join() {
			location='<c:url value="/member"/>';
		}
	</script>
</body>
</html>