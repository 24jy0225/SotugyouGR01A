<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.* , model.Coupon "%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.Duration"%>
<% 
List<Coupon> couponList = (List<Coupon>)session.getAttribute("couponList") ;
LocalDate today = LocalDate.now();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>クーポン管理</title>
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
	<button onclick="location.href='CreateCoupon.jsp'">クーポン作成</button>
	<table>
		<tr>
			<th>クーポン名</th>
			<th>クーポン内容</th>
			<th>有効期限</th>
			<th>ステータス</th>
			<th>操作</th>
		</tr>
		<tr>
	<% for(Coupon coupon : couponList){ %>
		<td><%= coupon.getCouponName() %></td>
		<td><%= coupon.getCouponContent() %></td>
		<td><%= coupon.getStartDate() %> ～ <%= coupon.getEndDate() %></td>
	<% if(!coupon.getEndDate().isAfter(today)){ %>
			<td style="background-color: red; color: white; padding: 10px; border: none;">期限切れ</td>
	<% }else if(!coupon.getEndDate().isBefore(today) && coupon.getIsActive() != false){ %>
		<td><button type="button"
		onclick="editCoupon('<%=coupon.getCouponId()%>' , '<%=coupon.getIsActive()%>')"
		style="background-color: green; color: white; padding: 10px; border: none; cursor: pointer;">
		有効</button></td>
	<% }else{ %>
		<td><button type="button"
		onclick="editCoupon('<%=coupon.getCouponId()%>' , '<%=coupon.getIsActive()%>')"
		style="background-color: black; color: white; padding: 10px; border: none; cursor: pointer;">
		無効</button></td>
	<% } %>
	<td>
            <button type="button" 
                    onclick="deleteCoupon('<%=coupon.getCouponId()%>')"
                    style="background-color: #f44336; color: white; padding: 10px; border: none; cursor: pointer;">
                削除
            </button>
        </td>
	</tr>
	<% } %>
	
	</table>
	
	<form id="editCouponForm" action="AdminController" method="POST">
		<input type="hidden" name="command" id="targetCommand">
		<input type="hidden" name="couponNumber" id="targetCouponNumber">
		<input type="hidden" name="couponActive" id="targetCouponActive">
	</form>

	<script type="text/javascript">
		function editCoupon(number , active) {
			if (confirm("現在のステータスから変更しますか？")) {
				document.getElementById('targetCommand').value = "editCoupon";
				document.getElementById('targetCouponNumber').value = number;
				document.getElementById('targetCouponActive').value = active;
				document.getElementById('editCouponForm').submit();
			}

		}

		function deleteCoupon(number) {
	        if (confirm("本当にこのクーポンを削除しますか？\nこの操作は取り消せません。")) {
	            document.getElementById('targetCommand').value = "deleteCoupon"; // commandを削除用に書き換え
	            document.getElementById('targetCouponNumber').value = number;
	            document.getElementById('editCouponForm').submit();
	        }
	    }
	</script>
</body>
</html>