<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, java.util.ArrayList,model.User,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<%
String action = (String) session.getAttribute("action");
List<LocalDateTime> slots = (List<LocalDateTime>) session.getAttribute("timeList");
User user = (User) session.getAttribute("LoginUser");
User targetUser = (User) session.getAttribute("targetUser");
String date = (String) session.getAttribute("date");
%>
<html>
<head>
<meta charset="UTF-8">
<title>予約時間</title>
</head>
<body>
	<h2><%=date%>の予約可能時間
	</h2>
	<%
	if (action.equals("ByUser")) {
	%>
	<form action="UserController" method="post">
		<ul>
			<%
			DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
			for (LocalDateTime timeSlot : slots) {
				String timeStr = timeSlot.format(timeFormatter);
			%>
			<p>
				<input type="radio" name="selectedTime" value="<%=timeSlot%>">
				<%=timeStr%></p>
			<%
			}
			%>
		</ul>

		人数:<input type="number" name="people" max="4" min="1" value="1">
		<%
		if (user != null) {
		%>
		<button type="submit">確認画面へ</button>
		<%
		} else {
		%>
		<button type="submit">ログイン画面</button>
		<%
		}
		%>
		<input type="hidden" name="command" value="Confirm">
	</form>
	<%
	} else if (action.equals("ByAdmin")) {
	%>
	<form action="AdminController" method="post">
		<ul>
			<%
			DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
			for (LocalDateTime timeSlot : slots) {
				String timeStr = timeSlot.format(timeFormatter);
			%>
			<p>
				<input type="radio" name="selectedTime" value="<%=timeSlot%>">
				<%=timeStr%></p>
			<%
			}
			%>
		</ul>

		人数:<input type="number" name="people" value="1" max="4" min="1" required>
		<%
		if (user != null || targetUser != null) {
		%>
		<button type="submit">確認画面へ</button>
		<%
		} else {
		%>
		<button type="submit">ログイン画面</button>
		<%
		}
		%>
		<input type="hidden" name="command" value="Confirm">
	</form>
	<%
	}
	%>



</body>
</html>