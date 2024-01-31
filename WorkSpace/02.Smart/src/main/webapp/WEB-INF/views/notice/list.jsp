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
	<form action="list" method="post">
		<input type="hidden" name="nowPage" value="1" />
		<div class="row mb-2 justify-content-between">
			<div class="col-auto">
				<div class="input-group">
					<select class="form-select" name="search">
						<option value="all" ${page.search eq 'all' ? 'selected':''}>전체</option>
						<option value="title" ${page.search eq 'title' ? 'selected':''}>제목</option>
						<option value="content"
							${page.search eq 'content' ? 'selected':''}>내용</option>
						<option value="writer" ${page.search eq 'writer' ? 'selected':''}>작성자</option>
					</select> <input class="form-control" type="text" name="keyword"
						value="${page.keyword }" /> <input type="submit"
						class="btn btn-primary" value="검색" />
				</div>
			</div>
			<c:if test="${loginInfo.role eq 'ADMIN' }">
				<div class="col-auto">
					<button type="button" class="btn btn-primary" id="btn-insert">공지사항
						작성</button>
				</div>
			</c:if>
		</div>

	</form>
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

		<c:if test="${empty page.list }">
			<tr>
				<td colspan="4">공지사항이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${page.list }" var="vo">
			<tr>
				<td>${vo.no }</td>
				<td class="text-start">
				<span style="margin-left:${(vo.indent)*15}px"></span>
				${vo.indent >0 ? '<i class="fa-regular fa-comment-dots me-3"></i>':'' }<a class="text-link"
					href="<c:url value='/notice/info?id=${vo.id }&nowPage=${page.nowPage }&search=${page.search }&keyword=${page.keyword }'/>">${vo.title }</a></td>
				<td>${vo.name }</td>
				<td>${vo.writedate }</td>
				<td><c:if test="${vo.filename != null}">
						<i class="fa-solid fa-paperclip"></i>
					</c:if></td>
			</tr>
		</c:forEach>

	</table>
	<div class="">
		<jsp:include page="/WEB-INF/views/include/page.jsp" />
	</div>
	<script type="text/javascript">
		$("#btn-insert").click(function() {
			location = "insertPage";
		});
	</script>
</body>
</html>