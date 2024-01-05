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
	<form method="post" action="insert" enctype="multipart/form-data">
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
						title="내용" name="content" rows="10" value="${vo.content }"></textarea></td>
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
	</form>
	<div class="btn-toolbar justify-content-center gap-2">
		<button class="btn btn-primary" id="btn-insert">공지사항 등록</button>
		<button class="btn btn-danger" id="btn-cancle">취소</button>
	</div>
	<script type="text/javascript">
		$("#btn-insert").click(function() {
			if (notEmpty()) {
				$("form").submit();
			}
		});
		$("#btn-cancle").click(function() {
			location = "list";
		});
	</script>
</body>
</html>