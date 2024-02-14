<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<div class="row justify-content-center">
	<div class="col-lg-5">
		<div class="card shadow-lg border-0 rounded-lg mt-5">
			<div class="card-header">
				<h3 class="text-center font-weight-light my-4">
					<a href="<c:url value='/'/>"><img
						src="<c:url value='/img/hanul.logo.png'/>" /> </a>
				</h3>
			</div>
			<div class="card-body">
				<h5>죄송합니다.<br>내부적인 오류가 발생하였습니다.</h5>
				<p>${error}</p>
				
			</div> 
		</div>
	</div>
</div>
