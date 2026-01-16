<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お知らせ管理</title>
</head>
<body>
	<form action="AdminController" method="POST">
		<p>トピックタイトル</p>
		<p><input type="text" name="topicsTitle"></p>
		<p>説明</p>
		<p><input type="text" name="topicsContent"></p>
		<p>画像</p>
		<p><input type="file" name="photoFileName" required ></p>
		<input type="submit" value="追加する">
		<input type="hidden" name="command" value="topicsAdd">
	</form>
</body>
</html>