<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="AdminController" method="post" enctype="multipart/form-data">
    カテゴリ： <select name="category">
        <option value="shop">店舗</option>
        <option value="goods">商品</option>
        <option value="banner">バナー</option>
    </select><br>
    画像：<input type="file" name="image" accept="image/png, image/jpeg, image/jpg" ><br>
    <button type="submit">登録</button>
    <input type="hidden" name="command" value="design">
</form>
</body>
</html>