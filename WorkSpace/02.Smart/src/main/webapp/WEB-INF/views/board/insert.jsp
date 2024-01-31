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
		<input type="hidden" name="writer" value="${loginInfo.user_id }" />
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
				<td>
					<div class="row">
						<div>
							<label> 
								<input class="form-control" style="display: none;" id="file-multiple"
								type="file" name="files" multiple> 
								<i role="button"
								class="fa-solid fa-file fs-8 me-4"></i>
							</label>
							<div class="form-control py-2 mt-2 mb-2 file-drag">
								<div class="py-3 text-center">첨부할 파일을 마우스로 끌어오세요</div>
							</div>
							<!-- <div class="col-auto d-flex align-items-center">
								<span class="file-name me-3"></span> <i role="button"
									class="d-none fa-solid fa-trash-can fs-8 text-danger remover"></i>
							</div> -->
						</div>
					</div>
				</td>
			</tr>
		</table>
	</form>
	<div class="btn-toolbar justify-content-center gap-2">
		<button class="btn btn-primary" id="btn-insert">방명록 등록</button>
		<button class="btn btn-danger" id="btn-cancle">취소</button>
	</div>
	<c:set var="params"
		value="nowPage=${page.nowPage }&search=${page.search }&keyword=${page.keyword }" />
	<script type="text/javascript">
		var fileList = new FileList();
		
	
		$("#btn-insert").click(function() {
			if (notEmpty()) {
				multipleFileUpload();
				console.log($('#file-multiple').val());
				$("form").submit();
			}
		});
		$("#btn-cancle").click(function() {
			location = "list?${params}";
		});
	</script>
</body>
</html>