<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.Duration" %>
<%@ page import="model.User"%>
<%@ page import="model.Reservation"%>

<%
List<Reservation> list = new ArrayList<>();
list = (List<Reservation>) session.getAttribute("reservationHistory");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>paipaidao</title>
</head>
<body>
	<%
	if (list != null) {
	%>

	<table>
		<tr>
			<th>予約日</th>
			<th>開始時間</th>
			<th>コース</th>
			<th>予約人数</th>
			<th>席番号</th>
		</tr>
		<%
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("M月d日");
		long durationMinutes;
		for (Reservation r : list) {	
			Duration duration = Duration.between(r.getStartDateTime(), r.getEndDateTime());
			durationMinutes = duration.toMinutes();
		%>
		<tr>
			<td><%=r.getReserveDate().format(dateFormatter)%></td>
			<td><%=r.getStartDateTime().format(timeFormatter)%></td>
			<td><%=durationMinutes%>分コース</td>
			<td><%=r.getReservePeople()%>人</td>
			<td><%=r.getSeatId()%></td>
		</tr>
		<%
		}
		%>
		<%
		}else{
		%>
		<p>予約がありません</p>
		<% } %>
	</table>
	<button onclick="location.href='Main.jsp'">ホームに戻る</button>
</body>
</html>