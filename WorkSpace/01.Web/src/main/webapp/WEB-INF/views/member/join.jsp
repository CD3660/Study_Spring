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
	<a href="<c:url value='/'/>">홈으로</a>
	<hr/>
	<h3>회원가입</h3>
	<form method="post" action="joinRequest">
		<table border="solid 1px">
			<tr>
				<td>성명</td>
				<td><input type="text" name="name"/></td>
			</tr>
			<tr>
				<td>성별</td>
				<td>
					<input type="radio" checked name="gender" id="male" value="남"><label for="male">남</label>
					<label><input type="radio" name="gender" value="여">여</label>
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email"/></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input type="text" name="age"/></td>
			</tr>
		</table>
		<input type="submit" value="회원가입(HttpServletRequest)"/>
		<input type="submit" value="회원가입(@RequestParam)" onclick="action='joinParam'"/>
		<input type="submit" value="회원가입(DataObject)" onclick="action='joinData'"/>
	</form>
</body>
</html>