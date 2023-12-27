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
					<form action="login" method="post">
						<div class="form-floating mb-3">
							<input class="form-control" id="user_id" type="text"
								name="user_id" placeholder="아이디"> <label for="user_id">아이디</label>
						</div>
						<div class="form-floating mb-3">
							<input class="form-control" id="user_pw" type="password"
								name="user_pw" placeholder="비밀번호"> <label for="user_pw">비밀번호</label>
						</div>
						<div class="d-flex align-items-center justify-content-between mt-4 mb-0">
							<input class="btn btn-primary form-control" type="submit" value="로그인" />
						</div>
						<hr>
						<div
							class="d-flex align-items-center justify-content-between mt-4 mb-0">
							<a class="small" href="password.html">회원가입</a>
							<a class="small" href="<c:url value='/member/findPw'/>">비밀번호 찾기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>