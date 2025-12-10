<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="model.User"%>
<%
User user = (User) session.getAttribute("LoginUser");
int course = (int) session.getAttribute("Course");
int people = (int) session.getAttribute("people");
LocalDate localDate = (LocalDate) session.getAttribute("localDate");
int seatId = (int) session.getAttribute("seatId");
LocalDateTime selectedTime = (LocalDateTime) session.getAttribute("selectedTime");
DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
String startTime = selectedTime.format(timeFormatter);
String endTime = selectedTime.plusMinutes(course).format(timeFormatter);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>予約確認画面</title>
</head>
<body>
	<h1>予約確認画面</h1>
	<p>
		予約者:<%=user.getName()%></p>
	<p>
		予約人数:<%=people%></p>
	<p>
		予約日:<%=localDate%></p>
	<p>
		席番号:<%=seatId%></p>
	<p>
		予約時間:<%=startTime%>～<%=endTime%></p>
	<form action="Controller" method="post">
		<input type="submit" value="この内容で予約する"> <input type="hidden"
			name="command" value="Reserve">
	</form>

</body>
</html>