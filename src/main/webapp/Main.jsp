<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<%
	User user = (User)session.getAttribute("LoginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規会員登録</title>
</head>
<body>
	<%
	if (user != null) {
	%>
	<h1>
		ようこそ<%=user.getName()%>さん
	</h1>
	<form action="Controller" method="post">
		<input type="submit" value="ログアウト">
		<input type="hidden" name="command" value="Logaut">
	</form>
	<form action="Controller" method="post">
		<input type="submit" value="予約履歴を表示">
		<input type="hidden" name="command" value="History">
	</form>
	
	<%
	} else {
	%>
	<h2>新規会員登録</h2>

	<form action="Controller" method="post">
		<button type="submit">新規登録</button>
		<input type="hidden" name="command" value="UserRegister">
	</form>

	<button onclick="location.href='Login.jsp'">ログイン</button>
	<%
	}
	%>
	<button onclick="location.href='ReservationDate.jsp'">席予約</button>
</body>
</html>