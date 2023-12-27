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
					<h4 class="text-center">비밀번호 찾기</h4>
				</div>
				<div class="card-body">
					<form action="resetPw" method="post">
						<div class="form-floating mb-3">
							<input class="form-control" id="user_id" type="text" required
								name="user_id" placeholder="아이디"> <label for="user_id">아이디</label>
						</div>
						<div class="form-floating mb-3">
							<input class="form-control" id="email" type="text" required
								name="email" placeholder="이메일"> <label for="email">이메일</label>
						</div>
						<div
							class="d-flex align-items-center justify-content-between mt-4 mb-0">
							<input class="btn btn-primary" type="submit"
								value="임시 비밀번호 발급하기" />
								<input class="btn btn-outline-primary" type="text" onclick="history.go(-1)"
								value="취소" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>