<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<form method="post" action="<c:url value='/${url }'/>">
		<input type="hidden" name="id" value="${id }" /> <input
			type="hidden" name="nowPage" value="${page.nowPage }" /> <input
			type="hidden" name="search" value="${page.search }" /> <input
			type="hidden" name="keyword" value="${page.keyword }" /> <input
			type="hidden" name="dataPerPage" value="${page.dataPerPage }" />
	</form>
	<script>
		$("form").submit();
	</script>