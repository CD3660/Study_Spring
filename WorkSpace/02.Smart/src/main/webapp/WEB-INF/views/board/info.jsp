<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
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
		<tr>
			<th>첨부파일${i.index+1}</th>
			<td colspan="5"><c:forEach items="${vo.fileList }" var="file"
					varStatus="i">
					<div class="row  py-1">
						<div class="col-auto">
							<label role="button" class="file-download"
								onclick="location='download?id=${file.id}'"
								data-file="${file.id }">${file.filename } <i
								class="fa-solid fa-download fs-2 ms-3"></i>
							</label>
						</div>
					</div>
				</c:forEach></td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="p-3" colspan="5">${fn : replace( vo.content , crlf,"<br/>" )}</td>
		</tr>
	</table>
	<div class="btn-toolbar justify-content-center gap-2">
		<button class="btn btn-outline-primary" id="btn-list">목록으로</button>
		<c:if test="${loginInfo.user_id eq vo.writer }">
			<button class="btn btn-primary" id="btn-updatePage">방명록 수정</button>
			<button class="btn btn-danger" id="btn-delete">방명록 삭제</button>
		</c:if>
	</div>
	<form method="post">
		<input type="hidden" name="id" value="${vo.id }" /> <input
			type="hidden" name="nowPage" value="${page.nowPage }" /> <input
			type="hidden" name="search" value="${page.search }" /> <input
			type="hidden" name="keyword" value="${page.keyword }" /> <input
			type="hidden" name="dataPerPage" value="${page.dataPerPage }" /><input
			type="hidden" name="url" value="board/info" />
	</form>
	<jsp:include page="comment.jsp"></jsp:include>
	<script type="text/javascript">
		$(".file-download").click(function() {
			location = "download?id=" + $(this).data("file");
		});
		$("#btn-list, #btn-updatePage, #btn-delete").click(function() {
			var id = $(this).attr("id");
			id = id.substr(id.indexOf("-") + 1);
			$("form").attr("action", id);
			if (id == "delete") {
				if (confirm("정말 삭제하시겠습니까?")) {
					$("form").submit();
				}
			} else {
				$("form").submit();
			}
		})
	</script>
</body>
</html>