<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<div id="comment-insert" class="my-4 justify-content-center">

	<div class="w-pct80 justify-content-between d-flex mb-2">
		<span>댓글 작성 [ <span class="writing">0</span> / 200 ]</span> <a
			class="btn btn-outline-primary btn-sm d-none btn-insert">댓글등록</a>
	</div>

	<div class="comment w-pct80">
		<div class="form-control py-3 text-center guide">${empty loginInfo ? '로그인 후 사용 가능합니다.':'댓글을 입력하세요.'}
		</div>
	</div>
</div>

<script>
	$("#comment-insert .comment").click(function() {
		if(${empty loginInfo}){
			if(confirm("로그인 하시겠습니까?")){
				$("form").attr("action","<c:url value='/member/loginPage'/>").submit();
			}
		} else {
			if($(this).children(".guide").length == 1){
				$(this).append("<textarea class='form-control'></textarea>");
				$(this).children(".guide").remove();
				$(this).children("textarea").focus();
			}
			
		}
	});
	
	$(document).on("keyup", "#comment-insert textarea", function() {
		var input = $(this).val();
		if(input.length > 200){
			alert("최대 200자 까지 입력할 수 있습니다.");
			input = input.substr(0,200);
			$(this).val(input);
		}
		$("#comment-insert .writing").text(input.length);
		if(input.length >0 ) $(".btn-insert").removeClass( "d-none");
		else $(".btn-insert").addClass("d-none");
	});
</script>
<style>
.comment textarea {
	height: 90px
}
</style>