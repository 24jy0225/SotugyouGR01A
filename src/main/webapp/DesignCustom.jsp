<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Webサイト管理</title>
</head>
<body>
	<form action="AdminController" method="post" enctype="multipart/form-data">
    カテゴリ： <select name="category">
        <option value="top">top</option>
        <option value="flavar">flavar</option>
        <option value="drink">drink</option>
        <option value="food">food</option>
    </select><br>
    画像：<input type="file" name="image" accept="image/png, image/jpeg, image/jpg" ><br>
    <button type="submit">登録</button>
    <input type="hidden" name="command" value="designUpdate">
</form>
</body>
</html>