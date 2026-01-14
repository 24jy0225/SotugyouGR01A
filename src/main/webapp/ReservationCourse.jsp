<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Store , java.util.*"%>
<% 
List<Store> storeList = new ArrayList<>();
storeList = (List<Store>)session.getAttribute("storeList"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>コース選択</title>
</head>
<body>
	<form action="UserController" method="get">
		<input type="checkbox" name="course" value="60">60分コース
		<input type="checkbox" name="course" value="90">90分コース
		<input type="checkbox" name="course" value="120">120分コース
		<select name="storeNumber">
			<% for(Store store : storeList){ %>
			<option value="<%= store.getStoreNumber()%>">
				<%= store.getStoreName() %>
			</option>
			<% } %>
		</select>
		<input type="submit" value="送信">
		<input type="hidden" name="command" value="Seat">
	</form>
</body>
</html>