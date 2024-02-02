<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<div id="comment-insert" class="row my-4 justify-content-center">

	<div class="w-pct80 justify-content-between d-flex pb-2 h-px40">
		<span>댓글 작성 [ <span class="writing">0</span> / 200 ]
		</span> <a class="btn btn-outline-primary btn-sm d-none btn-insert">댓글등록</a>
	</div>

	<div class="comment w-pct80">
		<div class="form-control py-3 text-center guide">${empty loginInfo ? '로그인 후 사용 가능합니다.':'댓글을 입력하세요.'}
		</div>
	</div>
</div>
<div id="comment-list" class="row justify-content-center mx-0">
	
</div>
<script>
	commentList();
	
	function commentList() {
		$.ajax({
			url:"comment/list/${vo.id}",
		}).done(function(resp) {
			$("#comment-list").html(resp);
		})
	}

	$(".btn-insert").click(function() {
		$.ajax({
			url:"comment/insert",
			data:{
				board_id:${vo.id},
				content:$("#comment-insert textarea").val(),
				writer: "${loginInfo.user_id}"
			}
		}).done(function(resp) {
			if(resp){
				alert("댓글이 등록되었습니다.");
				initComment();
				commentList();
			} else {
				alert("오류 발생 다시 시도하세요.");
			}
		})
	})
	
	function initComment() {
		$("#comment-insert .writing").text(0);
		$(".btn-insert").addClass("d-none");
		$("#comment-insert .comment").html(
			`<div class="form-control py-3 text-center guide">
				${empty loginInfo ? '로그인 후 사용 가능합니다.':'댓글을 입력하세요.'}
			</div>	`
		);	
	}

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
		var input = writing($(this));
		
		$("#comment-insert .writing").text(input.length);
		if(input.length >0 ) $(".btn-insert").removeClass( "d-none");
		else $(".btn-insert").addClass("d-none");
	}).on("contextmenu", "#comment-insert textarea", function(e) {
		e.preventDefault();
	}).on("keyup", "#comment-list textarea", function() {
		var input = writing($(this));
		$(this).closest(".comment").find(".writing").text(input.length);
	});
	
	function writing(tag) {
		var input = tag.val();
		if(input.length > 200){
			alert("최대 200자 까지 입력할 수 있습니다.");
			input = input.substr(0,200);
			tag.val(input);
		}
		return input;
	}
</script>
<style>
.comment textarea {
	height: 90px
}

.h-px40 {
	height: 40px
}
</style>