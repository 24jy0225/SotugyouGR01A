<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者ページ</title>
</head>
<body>
	<header>
		<form action="AdminController" method="post">
			<p><input type="password" name="AdminPassword" value="Drive666"</p>
			<input type="submit" value="ログイン">
			<input type="hidden" name="command" value="login">
		</form>
	</header>
	
</html>