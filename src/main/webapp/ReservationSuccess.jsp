<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String action = (String)session.getAttribute("action"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>予約完了画面</title>
</head>
<body>
	<% if(action.equals("ByUser")){ %>
	<button onclick="location.href='Main.jsp'">ホームに戻る</button>
	<%}else if(action.equals("ByAdmin")){ %>
	<button onclick="location.href='CustomerDetails.jsp'">顧客管理に戻る</button>
	<% } %>
</body>
</html>