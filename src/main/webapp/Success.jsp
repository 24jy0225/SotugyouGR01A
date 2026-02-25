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
<%
	String msg = (String) request.getAttribute("msg");
	if (msg != null) {
	%>
	<div
		style="color: green; font-weight: bold; border: 1px solid green; padding: 10px; margin-bottom: 10px;">
		<%=msg%>
	</div>
	<%
	// 一度表示したら消す（そうしないと、ずっと表示され続けてしまうため）
	session.removeAttribute("msg");
	}
	%>

<% if(session.getAttribute("afterLoginPage") != null || msg != null){%>
	<button onclick="location.href='Login.jsp'">ログイン画面</button>
<% }else{ %>
	<button onclick="location.href='top.jsp'">ホームに戻る</button>
<% } %>
</body>
</html>