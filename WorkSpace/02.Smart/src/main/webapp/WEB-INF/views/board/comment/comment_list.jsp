<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<body>
	<c:if test="${empty list }">
		<div class="py-3 text-center">
			<div class="fs-5">등록된 댓글이 없습니다.</div>
			<div>첫번째 댓글을 남겨주세요.</div>
		</div>
	</c:if>
	<c:forEach items="${list }" var="vo">
		<div class="comment w-pct80 py-3 border-bottom">
			<div class="d-flex justify-content-between">
				<div class="d-flex align-items-center mb-2">
					<span class="me-2"> <c:if test="${empty vo.profile}">
							<i class="fa-solid fa-circle-user font-profile"></i>
						</c:if> <c:if test="${!empty vo.profile}">
							<img class="profile" src="${vo.profile }">
						</c:if>
					</span> <span>${vo.name } [${vo.writedate }]</span>
				</div>
				<div>
					<c:if test="${vo.writer eq loginInfo.user_id }">
						<span class="me-4">댓글수정 [ <span class="writing">${fn: length(vo.content) }</span> /
							200 ]
						</span>
						<a class="btn btn-outline-info btn-sm btn-update-save">수정</a>
						<a class="btn btn-outline-danger btn-sm btn-delete-cancle">삭제</a>
					</c:if>
				</div>

			</div>
			<div class="content">${fn : replace( fn:replace(vo.content , lf,"<br/>" ), crlf,"<br/>")}</div>
			<div class="hidden d-none"></div>
		</div>
	</c:forEach>
	<script>
		$(".btn-update-save").click(function() {
			var _comment = $(this).closest(".comment");
			if ($(this).text() == "수정") {
				updateStatus(_comment);
			} else {
				
			}
		})
		$(".btn-delete-cancle").click(function() {
			var _comment = $(this).closest(".comment");
			if ($(this).text() == "취소") {
				infoStatus(_comment);
			} else {
				
			}
		})

		function updateStatus(_comment) {
			_comment.find(".btn-update-save").text("저장").removeClass(
					"btn-outline-info").addClass("btn-primary");
			_comment.find(".btn-delete-cancle").text("취소").removeClass(
					"btn-outline-danger").addClass("btn-danger");

			var _content = _comment.find(".content");
			var content = _content.html().replace(/<br>/g, "\n");
			_content
					.html(`<textarea class="form-control">\${content}</textarea>`);
			_comment.find(".writing").text(content.length);
			_comment.find(".hidden").html( `\${content}` );
		}
		function infoStatus(_comment) {
			_comment.find(".btn-update-save").text("수정").removeClass(
					"btn-primary").addClass("btn-outline-info");
			_comment.find(".btn-delete-cancle").text("삭제").removeClass(
					"btn-danger").addClass("btn-outline-danger");
			var _content = _comment.find(".content");
			//var content = _content.find("textarea").val().replace(/\n/g, "<br>");
			var content = _comment.find(".hidden").html().replace(/\n/g, "<br>");
			_content.html(content);
			_comment.find(".writing").text(_comment.find(".hidden").text().length);
			_comment.find(".hidden").empty();
		}
	</script>
</body>
</html>