<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<c:choose>
	<c:when test="${category eq 'login' }">
		<c:set var="title" value="로그인: " />
	</c:when>
	<c:when test="${category eq 'find' }">
		<c:set var="title" value="비밀번호 찾기: " />
	</c:when>
</c:choose>
<title>${title}스마트IoT</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="<c:url value='/css/styles.css'/>" rel="stylesheet" />
<link href="<c:url value='/css/common.css?<%=new java.util.Date()%>>'/>"
	rel="stylesheet" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="<c:url value='/js/common.js?<%=new java.util.Date()%>>'/>"></script>
</head>
<body class="bg-primary">

	<div class="container-fluid p-4">
		<tiles:insertAttribute name="container"></tiles:insertAttribute>
	</div>
</body>
</html>