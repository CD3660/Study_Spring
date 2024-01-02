<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>스마트 IoT 미들웨어 서버 프로그램</h1>
	<h3>고객관리</h3>
	<div>
		<a target="_blank" href="<c:url value='/customer/list'/>">전체목록조회</a>
	</div>
	<div>
		<input type="text" id="query" /><a target="_blank" id="search"
			href="">검색목록조회</a>
	</div>
	<div>
		<input type="text" id="id" /><a target="_blank" id="info" href="">고객조회</a>
	</div>
	<div>
		<a target="_blank" id="delete" href="">삭제</a>
	</div>
	<hr />
	<div>안드로이드에서 데이터 객체에 담아 json 문자열로 만들어 vo라는 파라미터로 보냄</div>
	<div>
		고객번호: <input type="text" id="customer_id" value="61" />
	</div>
	<div>
		고객명: <input type="text" id="name" value="변경이름" />
	</div>
	<div>
		성별: <input type="text" id="gender" value="남" />
	</div>
	<div>
		이메일: <input type="text" id="email" value="AA" />
	</div>
	<div>
		전화먼호: <input type="text" id="phone" value="0000" />
	</div>
	<div>
		<button id="change">정보변경</button>
	</div>
	<div>
		<button id="insert">신규등록</button>
	</div>
	<hr />
	<h3>회원관리</h3>
	<div>
		아이디: <input type="text" id="user_id" /> 비밀번호: <input type="password"
			id="user_pw" /><a id="login" target="_blank" href="">로그인</a>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.js"
		integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		$("#login").click(
				function() {
					$(this).attr(
							"href",
							"<c:url value='/member/login'/>?user_id="
									+ $("#user_id").val()
									+"&user_pw="
									+$("#user_pw").val())
				});
		$("#search").click(
				function() {
					$(this).attr(
							"href",
							"<c:url value='/customer/list'/>?query="
									+ $("#query").val())
				});
		$("#delete").click(
				function() {
					$(this).attr(
							"href",
							"<c:url value='/customer/delete'/>?customer_id="
									+ $("#query").val())
				});
		$("#info").click(
				function() {
					$(this).attr(
							"href",
							"<c:url value='/customer/info'/>?customer_id="
									+ $("#id").val())
				});
		$('#query').keydown(
				function(event) {
					if (event.keyCode === 13) {
						var url = "<c:url value='/customer/list'/>?query="
								+ $("#query").val();

						window.open(url, '_blank');
					}
				});
		$("#change").click(function() {
			var info = {};
			info.name = $("#name").val();
			info.customer_id = $("#customer_id").val();
			info.gender = $("#gender").val();
			info.email = $("#email").val();
			info.phone = $("#phone").val();
			$.ajax({
				url : "<c:url value='/customer/update'/>",
				data : {
					vo : JSON.stringify(info)
				}
			}).done(function() {

			})
		});
		$("#insert").click(function() {
			var info = {};
			info.name = $("#name").val();
			info.gender = $("#gender").val();
			info.email = $("#email").val();
			info.phone = $("#phone").val();
			$.ajax({
				url : "<c:url value='/customer/insert'/>",
				data : {
					vo : JSON.stringify(info)
				}
			}).done(function() {

			})
		});
	</script>
</body>
</html>
