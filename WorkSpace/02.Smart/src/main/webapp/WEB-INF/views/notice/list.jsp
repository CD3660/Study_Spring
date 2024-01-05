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
	<h3 class="mb-4">공지사항</h3>
	<c:if test="${loginInfo.role eq 'ADMIN' }">
		<div class="row mb-2 ">
			<div class="col-auto">
				<button type="button" class="btn btn-primary" id="btn-insert">공지사항
					작성</button>
			</div>
		</div>
	</c:if>
	<table class="table tb-row tb-list">
		<colgroup>
			<col width="70px">
			<col>
			<col width="160px">
			<col width="160px">
			<col width="100px">
		</colgroup>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>첨부파일</th>
		</tr>

		<c:if test="${empty list }">
			<tr>
				<td colspan="4">공지사항이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${list }" var="vo">
			<tr>
				<td>${vo.no }</td>
				<td class="text-start"><a class="text-link"
					href="<c:url value='/notice/info?id=${vo.id }'/>">${vo.title }</a></td>
				<td>${vo.name }</td>
				<td>${vo.writedate }</td>
				<td><c:if test="${vo.filename != null}">
						<i class="fa-solid fa-paperclip"></i>
					</c:if></td>
			</tr>
		</c:forEach>

	</table>
	<script type="text/javascript">
		$("#btn-insert").click(function() {
			location = "insertPage";
		});
	</script>
</body>
</html>