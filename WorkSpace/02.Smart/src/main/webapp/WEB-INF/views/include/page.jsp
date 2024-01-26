<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<body>
	<nav aria-label="Page navigation">
		<ul class="pagination justify-content-center">
			<c:if test="${page.nowBlock > 1}">
				<li class="page-item"><a class="page-link"
					onclick="go_page(${1})"><i class="fa-solid fa-angles-left"></i></a></li>
				<li class="page-item"><a class="page-link"
					onclick="go_page(${page.beginPage-page.pagePerBlock})"><i
						class="fa-solid fa-angle-left"></i></a></li>
			</c:if>
			<c:forEach begin="${page.beginPage }" end="${page.endPage }" var="no"
				step="1">
				<c:if test="${no eq page.nowPage }">
					<li class="page-item"><a class="page-link active" href="#">${no}</a></li>
				</c:if>
				<c:if test="${no ne page.nowPage }">
					<li class="page-item"><a class="page-link"
						onclick="go_page(${no})">${no}</a></li>
				</c:if>
			</c:forEach>
			<c:if test="${page.nowBlock < page.totalBlock }">
				<li class="page-item"><a class="page-link"
					onclick="go_page(${page.endPage+1})"><i
						class="fa-solid fa-angle-right"></i></a></li>
				<li class="page-item"><a class="page-link"
					onclick="go_page(${page.totalPage})"><i
						class="fa-solid fa-angles-right"></i></a></li>
			</c:if>
		</ul>
	</nav>
	<script type="text/javascript">
		function go_page(no){
			$("[name=nowPage]").val(no);
			$("form").submit();
		}
	</script>
</body>
</html>