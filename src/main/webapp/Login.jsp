<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログインだお</title>
</head>
<body>
	<form action="UserController" method="post">
		<p>
			メールアドレス<input type="text" name="email">
		</p>
		<p>
			パスワード<input type="password" name="password">
		</p>
		<input type="hidden" name="command" value="LoginAction">
		<p>
			<input type="submit" value="ログイン">
		</p>
	</form>
	<button onclick="location.href='UserRegister.jsp'">新規登録</button>
</body>
</html>