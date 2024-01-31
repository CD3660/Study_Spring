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
	<form method="post" action="reply" enctype="multipart/form-data">

		<table class="table tb-row">
			<colgroup>
				<col width="180px">
				<col>
			</colgroup>
			<tr>
				<th>제목</th>
				<td><div class="row">
						<div>
							<input class="form-control check-empty" type="text" name="title"
								title="제목" autofocus>
						</div>
					</div></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea class="form-control mt-2 mb-2 check-empty"
						title="내용" name="content" rows="10"></textarea></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><div class="row">
						<div class="col-auto d-flex file-info align-items-center">
							<label> <input class="form-control" id="file-single"
								type="file" name="file"> <i role="button"
								class="fa-solid fa-file fs-8 me-4"></i>
							</label>
							<div class="col-auto d-flex align-items-center">
								<span class="file-name me-3"></span> <i role="button"
									class="d-none fa-solid fa-trash-can fs-8 text-danger remover"></i>
							</div>
						</div>
					</div></td>
			</tr>
		</table>
		<input type="hidden" name="nowPage" value="${page.nowPage}" /> 
		<input type="hidden" name="search" value="${page.search}" /> 
		<input type="hidden" name="keyword" value="${page.keyword}" /> 
		<input type="hidden" value="${vo.id }" name="rid" /> 
		<input type="hidden" value="${vo.root }" name="root" />
		<input type="hidden" value="${vo.step }" name="step" />
		<input type="hidden" value="${vo.indent }" name="indent" />
	</form>
	<div class="btn-toolbar justify-content-center gap-2">
		<button class="btn btn-primary" id="btn-reply">답글 등록</button>
		<button class="btn btn-danger" id="btn-cancle">취소</button>
	</div>
	<c:set var="params"
		value="nowPage=${page.nowPage }&search=${page.search }&keyword=${page.keyword }" />
	<script type="text/javascript">
		$("#btn-reply").click(function() {
			if (notEmpty()) {
				$("form").submit();
			}
		});
		$("#btn-cancle").click(function() {
			location = "info?id=${id}&${params}";
		});
	</script>
</body>
</html>