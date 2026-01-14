<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.List, java.util.ArrayList,model.Seat"
    %>
    <%
List<Seat> seatList = (List<Seat>)session.getAttribute("Seat");
String date = (String) session.getAttribute("date");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seat</title>
</head>
<body>
	<form method="get" action="UserController">
	<input type="hidden" name="command" value="Time">
		<ul>
			<% for(Seat seat : seatList)  {%>
				<p><input type	="submit" name="seatId" id=<%= seat.getSeatId() %> value=<%= seat.getSeatId() %>></p>
			<% } %>
		</ul>
	</form>
</body>
</html>