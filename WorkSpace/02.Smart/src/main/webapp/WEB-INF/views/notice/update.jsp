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
	<h3>공지사항 수정</h3>
	<form method="post" action="update" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${vo.id }" />
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
								title="제목" value="${vo.title }" autofocus>
						</div>
					</div></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea class="form-control mt-2 mb-2 check-empty"
						title="내용" name="content" rows="10">${fn : replace( vo.content , crlf,'<br/>' )}</textarea></td>
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
								<span class="file-name me-3">${vo.filename }</span> <i
									role="button"
									class="${empty vo.filename ?'d-none ':''}fa-solid fa-trash-can fs-8 text-danger remover"></i>
							</div>
						</div>
					</div></td>
			</tr>
		</table>
		<input type="hidden" name="filename" value="${vo.filename}" />
	</form>
	<div class="btn-toolbar justify-content-center gap-2">
		<button class="btn btn-primary" id="btn-update">공지사항 수정</button>
		<button class="btn btn-danger" id="btn-cancle">취소</button>
	</div>
	<script type="text/javascript">
		$("#btn-update").click(function() {
			if (notEmpty()) {
				$("[name=filename]").val( $(".file-name").text());
				$("form").submit();
			}
		});
		$("#btn-cancle").click(function() {
			location = "info?id=${vo.id}";
		});
	</script>
</body>
</html>