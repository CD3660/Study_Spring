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
	<h2>첫번째 테스트 결과(Model객체 사용)</h2>
	<p>현재 날짜 : ${today }</p>
	<p>현재 시각 : ${now }</p>
	<p>객체 타입 : ${type }</p>
	
</body>
</html>