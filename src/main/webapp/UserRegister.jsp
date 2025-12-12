<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規登録だお</title>
</head>
<body>
	<form action="UserController" method="post">
		<p>名前<input type="text" name="name" required></p>
		<p>電話番号<input type="text" name="tel" required ></p>
		<p>メールアドレス<input type="text" name="email" required></p>
		<p>パスワード<input type="text" name="password" required></p>
		<p><input type="submit" value="登録" ></p>
		<input type="hidden" name="command" value="RegisterAction">
	</form>
</body>
</html>