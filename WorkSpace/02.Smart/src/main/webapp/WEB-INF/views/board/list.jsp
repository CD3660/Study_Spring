<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<body>
	<h3 class="mt-4">방명록</h3>
	<form action="list" method="post">
		<div class="row mb-2 justify-content-between">
			<div class="col-auto">
				<div class="input-group">
					<select class="form-select" name="search">
						<option value="s1" ${page.search eq 's1' ? 'selected':''}>전체</option>
						<option value="s2" ${page.search eq 's2' ? 'selected':''}>제목</option>
						<option value="s3" ${page.search eq 's3' ? 'selected':''}>내용</option>
						<option value="s4" ${page.search eq 's4' ? 'selected':''}>작성자</option>
					</select> <input class="form-control" type="text" name="keyword"
						value="${page.keyword }" /> <input type="submit"
						class="btn btn-primary" value="검색" />
				</div>
			</div>
			<div class="col-auto">
				<select name="dataPerPage" class="form-select">
					<c:forEach var="i" begin="1" end="5">
						<option value="${10*i }">${10*i }개씩</option>
					</c:forEach>
				</select>
			</div>
			<c:if test="${not empty loginInfo.role}">
				<div class="col-auto">
					<button type="button" class="btn btn-primary" id="btn-insert">글쓰기</button>
				</div>
			</c:if>
		</div>
		<input type="hidden" name="nowPage" value="1" /> <input type="hidden"
			name="id">
	</form>
	<table class="table tb-list">
		<colgroup>
			<col width="100px">
			<col>
			<col width="120px">
			<col width="120px">
			<col width="100px">
		</colgroup>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>조회수</th>
		</tr>
		<c:if test="${empty page.list }">
			<tr>
				<td colspan="5">방명록 글이 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${page.list }" var="vo">
			<tr>
				<td>${vo.no }</td>
				<td class="text-start"><a class="text-link"
					href="javascript:info(${vo.id })">${vo.title }${vo.filecnt>0 ? ' <i class="fa-solid fa-paperclip"></i>':'' }</a></td>
				<%-- info?id=${vo.id}&nowPage=${page.nowPage }&search=${page.search }&keyword=${page.keyword } --%>
				<td>${vo.writer }</td>
				<td>${vo.writedate }</td>
				<td>${vo.readcnt }</td>
			</tr>
		</c:forEach>
	</table>
	<div class="">
		<jsp:include page="/WEB-INF/views/include/page.jsp" />
	</div>
	<script type="text/javascript">
		$("[name=dataPerPage]").change(function() {
			$("form").submit();
		})
		$("[name=dataPerPage]").val(${page.dataPerPage}).prop("selected",true);
	
		function info(id) {
			$("[name=id]").val(id);
			$("[name=nowPage]").val(${page.nowPage});
			$("form").attr("action", "info");
			$("form").submit();
		}
		$("#btn-insert")
				.click(
						function() {
							location = "insertPage?nowPage=${page.nowPage }&search=${page.search }&keyword=${page.keyword }";
						});
	</script>
</body>
</html>