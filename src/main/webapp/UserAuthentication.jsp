<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// セッションからメアドを取り出してみる
	String tempEmail = (String) session.getAttribute("tempEmail");
	%>

	<%
	if (tempEmail != null) {
	%>
	<div
		style="margin-top: 15px; padding: 10px; background-color: #f8f9fa; border: 1px solid #ddd;">
		<p style="margin: 0;">認証メールが届きませんか？</p>

		<form action="UserController" method="post" style="margin-top: 5px;">
			<input type="hidden" name="command" value="ResendMail">
			<button type="submit">メールを再送する</button>
		</form>
	</div>
	<%
	}
	%>
</body>
</html>