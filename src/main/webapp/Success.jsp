<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<%
User user = (User)session.getAttribute("LoginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成功だお</title>
</head>
<body>
<% if(session.getAttribute("afterLoginPage") != null){%>
	<button onclick="location.href='Login.jsp'">ログイン画面</button>
<% }else{ %>
	<button onclick="location.href='Main.jsp'">ホームに戻る</button>
<% } %>
</body>
</html>