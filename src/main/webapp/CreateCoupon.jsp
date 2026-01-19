<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>クーポン作成</title>
</head>
<body>
	<h1>新規クーポン作成</h1>
	<form action="AdminController" method="post">
		<input type="hidden" name="command" value="createCoupon">
		<p>クーポン名</p>
		<p><input type="text" name="couponName"></p>
		<p>クーポン内容</p>
		<p><textarea name="couponContent" maxlength="100"></textarea></p>
		<p>開始日<input type="date" name="startDate"></p>
		<p>有効期限<input type="date" name="endDate"></p>
		<p><button type="submit">クーポンを作成する</button></p>
	</form>
</body>
</html>