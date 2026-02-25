<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% String errorMsg = (String)session.getAttribute("errorMsg"); %>
 <% String action = (String)session.getAttribute("action"); %>
 <% if(action == null){
	 action = "";
 } %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>エラーだお</title>
</head>
<body>
	<h1><%= errorMsg %></h1>
	<% if(action.equals("ByAdmin")){ %>
	<button onclick="location.href='AdminMain.jsp'">トップに戻る</button>
	<% }else{ %>
	<button onclick="location.href='index.jsp'">トップに戻る</button>
	<% } %>
</body>
</html>