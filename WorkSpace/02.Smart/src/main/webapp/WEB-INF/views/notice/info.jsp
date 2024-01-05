<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table tb-row">
		<colgroup>
			<col width="180px">
			<col>
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
		</colgroup>
		<tr>
			<th>제목</th>
			<td colspan="5">${vo.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${vo.name }</td>
			<th>작성일자</th>
			<td>${vo.writedate }</td>
			<th>조회수</th>
			<td>${vo.readcnt }</td>
		</tr>
		<c:if test="${!empty vo.filename }">
			<tr>
				<th>첨부파일</th>
				<td colspan="5"><label role="button" class="file-download">${vo.filename }
						<i class="fa-solid fa-download fs-2 ms-3"></i>
				</label></td>
			</tr>
		</c:if>
		<tr>
			<th>내용</th>
			<td class="p-3" colspan="5">${fn : replace( vo.content , crlf,"<br/>" )}</td>
		</tr>
	</table>
	<div class="btn-toolbar justify-content-center gap-2">
		<button class="btn btn-outline-primary" id="btn-list">목록으로</button>
		<c:if test="${loginInfo.role eq 'ADMIN' }">
			<button class="btn btn-primary" id="btn-update">공지사항 수정</button>
			<button class="btn btn-danger" id="btn-delete">공지사항 삭제</button>
		</c:if>
	</div>
	<script type="text/javascript">
		$(".file-download").click(function() {
			location = "download?id=${vo.id}";
		});
		$("#btn-list").click(function() {
			location = "list";
		});
		$("#btn-update").click(function() {
			location = "updatePage";
		});
		$("#btn-delete").click(function() {
			if(confirm("정말 삭제하시겠습니까?")) location = "delete?id=${vo.id}";
		});
	</script>
</body>
</html>