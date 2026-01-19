<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.* , model.User , model.Reservation , model.CouponUsage"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.Duration"%>
<%
LocalDate today = LocalDate.now();
List<Reservation> list = new ArrayList<>();
list = (List<Reservation>) session.getAttribute("reservationHistory");
User user = (User) session.getAttribute("LoginUser");
List<CouponUsage> couponList = (List<CouponUsage>) session.getAttribute("couponList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
</head>
<body>
	<%
	String msg = (String) session.getAttribute("message");
	if (msg != null) {
	%>
	<div
		style="color: green; font-weight: bold; border: 1px solid green; padding: 10px; margin-bottom: 10px;">
		<%=msg%>
	</div>
	<%
	// 一度表示したら消す（そうしないと、ずっと表示され続けてしまうため）
	session.removeAttribute("message");
	}
	%>
	<p><%=user.getName()%>様
	</p>
	<p>会員番号:<%=user.getUserId()%></p>
	<p>メールアドレス:<%=user.getUserEmail()%></p>
	<p>
	電話番号:
	<% if(user.getUserTel().isEmpty()){ %>
	電話番号は登録されていません
	<%}else{ %>
	<%=user.getUserTel()%>
	<%} %>
	</p>
	<p>クーポン</p>
	<%
	if (couponList != null && !couponList.isEmpty()) {
		for (CouponUsage usage : couponList) {
			LocalDate startDate = usage.getCoupon().getStartDate();
			LocalDate endDate = usage.getCoupon().getEndDate();
			if (today.isBefore(startDate) || today.isAfter(endDate) || usage.getCoupon().getIsActive() != true) {
                continue; 
            }
	%>
	<h4><%=usage.getCoupon().getCouponName()%></h4>
	<p><%=usage.getCoupon().getCouponContent()%></p>
	<p>
		期限：<%=usage.getCoupon().getEndDate()%>まで</p>
	<button type="button"
		onclick="confirmUse('<%=usage.getCoupon().getCouponId()%>','<%=usage.getCoupon().getCouponName()%>')"
		style="background-color: #ff4757; color: white; padding: 10px; border: none; cursor: pointer;">
		このクーポンを使用する</button>
	<%
	}
	} else {
	%>
	<p>利用可能なクーポンはありません。</p>
	<%
	}
	%>

	<form id="useForm" action="UserController" method="POST">
		<input type="hidden" name="command" value="useCoupon"> <input
			type="hidden" name="couponNumber" id="targetCouponNumber">
	</form>

	<script type="text/javascript">
		function confirmUse(number, name) {
			if (confirm(name + "を使用しますか？\n一度使用すると取り消しできません。")) {
				document.getElementById('targetCouponNumber').value = number;
				document.getElementById('useForm').submit();
			}

		}
	</script>
	
</body>
</html>