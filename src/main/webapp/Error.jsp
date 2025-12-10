<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% String errorMsg = (String)request.getAttribute("errorMsg"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>エラーだお</title>
</head>
<body>
	<h1><%= errorMsg %></h1>
	<button onclick="location.href='Main.jsp'">トップに戻る</button>
</body>
</html>