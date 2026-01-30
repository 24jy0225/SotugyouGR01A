<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="model.User, java.util.*, java.time.*, java.time.format.DateTimeFormatter, model.Reservation, model.CouponUsage"%>
<%
User user = (User) session.getAttribute("targetUser");
DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
int year, month, day;
LocalDate today = LocalDate.now();
List<Reservation> reservationList = (List<Reservation>) session.getAttribute("ReservationHistoryList");
List<CouponUsage> couponUsageList = (List<CouponUsage>) session.getAttribute("couponUsageList");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/admin/adminStyle.css">
<link rel="stylesheet" href="./css/admin/adminCustomerStyle.css">
<title>管理者顧客詳細情報</title>
</head>

<body>
	<header>
		<nav class="nav-menu">
			<button onclick="location.href='ReservationManage.jsp'">予約管理</button>
			<button onclick="location.href='CustomerManage.jsp'">顧客管理</button>
			<button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
			<button onclick="location.href='DesignCustom.jsp'">お知らせ管理</button>
			<button onclick="location.href='TopicsManage.jsp'">Webサイト管理</button>
		</nav>
	</header>
	
	<main>
		<div class="customer-details-main customer-top-margin">
			<table class="customer-details-table">
				<tr>
					<td><%=user.getName()%></td>
				</tr>
				<tr class="customer-stetas">
					<td><%=user.getUserTel()%></td>
					<td><%=user.getUserEmail() %></td>
					<td><%=user.getRegistDate()%> 登録</td>
				</tr>
			</table>
			<div class="customer-details-btns">

				<button class="customer-delete-btn"
					onclick="customerDelete('<%=user.getUserId()%>')">
					<img src="./image/assets/trash.png" alt="" class="trash-icon">
				</button>
			</div>
		</div>
		<div class="customer-details-main customer-reservation-history">
			<div class="customer-details-reservation-count">
				<table class="customer-details-reservation-count-table">
					<tr>
						<td>予約履歴</td>
					</tr>
					<tr>
						<td>全<%=user.getReserveCount()%>件の予約
						</td>
					</tr>
				</table>
				<button class="customer-add-reservation-btn" onclick="customerReserv('<%=user.getUserId() %>>')">＋ 予約追加</button>
			</div>
			<p>今後の予約</p>
			<%
			for (Reservation r : reservationList) {
				if (r.getUserId() != user.getUserId() && r.getStartDateTime().isBefore(today.atStartOfDay())) {
					continue;
				}
				java.time.LocalDateTime start = r.getStartDateTime();
				java.time.LocalDateTime end = r.getEndDateTime();
				year = start.getYear();
				month = start.getMonthValue();
				day = start.getDayOfMonth();

				String startTimeStr = start.format(timeFmt);
				String endTimeStr = end.format(timeFmt);
			%>
			<div class="customer-reservation-info">
				<table class="customer-details-reservation-table">
					<tr>
						<td class="reservation-days"><%=year%>年</td>
						<td class="reservation-days"><%=month%>月</td>
						<td class="reservation-days reservation-day"><%=day%>日</td>
						<td class="reservation-starttime"><%=startTimeStr%></td>
						<td class="reservation-timebr">~</td>
						<td class="reservation-endtime"><%=endTimeStr%></td>
						<td class="reservation-width"><%=r.getReservePeople()%>名</td>
						<td class="reservation-width">座席<%=r.getSeatId()%></td>
						<td>
							<button class="customer-edit-btn"
								onclick="location.href='../Reservation/Admin_ReservationEdit.html'">
								<img src="./image/assets/edit.jpg" alt="" class="edit-icon">
								編集
							</button>
						</td>
						<td class="reservation-delete-btn">
							<button class="customer-delete-btn">
								<img src="./image/assets/trash.png" alt=""
									class="trash-icon">
							</button>
						</td>
					</tr>
				</table>
			</div>
			<%
			}
			%>
			<p>過去の予約</p>
			<%
			for (Reservation r : reservationList) {
				if (r.getUserId() != user.getUserId() && r.getStartDateTime().isAfter(today.atStartOfDay())) {
					continue;
				}
				java.time.LocalDateTime start = r.getStartDateTime();
				java.time.LocalDateTime end = r.getEndDateTime();
				year = start.getYear();
				month = start.getMonthValue();
				day = start.getDayOfMonth();

				String startTimeStr = start.format(timeFmt);
				String endTimeStr = end.format(timeFmt);
			%>
			<div class="customer-reservation-info">
				<table class="customer-details-reservation-table">
					<tr>

						<td class="reservation-days"><%=year%>年</td>
						<td class="reservation-days"><%=month%>月</td>
						<td class="reservation-days  reservation-day"><%=day%>日</td>
						<td class="reservation-starttime"><%=startTimeStr%></td>
						<td class="reservation-timebr">~</td>
						<td class="reservation-endtime"><%=endTimeStr%></td>
						<td class="reservation-width"><%=r.getReservePeople()%>名</td>
						<td class="reservation-width">座席<%=r.getSeatId()%></td>
						<td>
							<button class="customer-edit-btn"
								onclick="location.href='../Reservation/Admin_ReservationEdit.html'">
								<img src="./image/assets/edit.jpg" alt="" class="edit-icon">
								編集
							</button>
						</td>
						<td class="reservation-delete-btn">
							<button class="customer-delete-btn">
								<img src="./image/assets/trash.png" alt=""
									class="trash-icon">
							</button>
						</td>
					</tr>
				</table>
			</div>
			<%
			}
			%>
			<div class="customer-details-main coupon-frame">
			
				<table>
					<tr>
						<td>クーポン</td>
					</tr>
					<tr>
						<td>全<%=user.getCouponCount()%>件のクーポン
						</td>
					</tr>
				</table>
				
				<p>未使用クーポン</p>
				<div class="coupon-list">
					<%
					for (CouponUsage c : couponUsageList) {
						if (c.isCouponUsage() == false) {
							continue;
						}
					%>
					<div class="coupon-active">
						<img src="./image/assets/coupon.png" class="coupon-img">
						<table>
							<tr>
								<td class="coupon-value"><%=c.getCoupon().getCouponName()%></td>
							</tr>
							<tr>
								<td class="coupon-value"><%=c.getCoupon().getCouponId()%></td>
								<td class="expiration-date">有効期限</td>
							</tr>
							<tr>
								<td class="coupon-value"><%=c.getCoupon().getCouponContent()%></td>
								<td class="coupon-start"><%=c.getCoupon().getStartDate()%></td>
								<td class="coupon-br">~</td>
								<td class="coupon-end"><%=c.getCoupon().getEndDate()%></td>
							</tr>
						</table>
						<div class="coupon-content">
							<button class="coupon-btn">使用状態にする</button>
						</div>
					</div>
					<%
					}
					%>
				</div>
				
				<p>使用済みクーポン</p>
				<div class="coupon-list">
					<%
					for (CouponUsage c : couponUsageList) {
						if (c.isCouponUsage() != false) {
							continue;
						}
					%>
					<div class="coupon-active">
						<img src="./image/assets/coupon.png" class="coupon-img">
						<table>
							<tr>
								<td class="coupon-value"><%=c.getCoupon().getCouponName()%></td>
							</tr>
							<tr>
								<td class="coupon-value"><%=c.getCoupon().getCouponId()%></td>
								<td class="expiration-date">有効期限</td>
							</tr>
							<tr>
								<td class="coupon-value"><%=c.getCoupon().getCouponContent()%></td>
								<td class="coupon-start"><%=c.getCoupon().getStartDate()%></td>
								<td class="coupon-br">~</td>
								<td class="coupon-end"><%=c.getCoupon().getEndDate()%></td>
							</tr>
						</table>
						<div class="coupon-content">
							<button class="coupon-btn">未使用状態にする</button>
						</div>
					</div>
					<%
					}
					%>
				</div>
				
			</div>
			<form id="editCustomerForm" action="AdminController" method="POST">
				<input type="hidden" name="command" id="targetCommand"> <input
					type="hidden" name="userId" id="targetUserId"> <input
					type="hidden" name="couponId" id="targetCouponId"> <input
					type="hidden" name="ReservationId" id="targetReservationId">
			</form>
	</main>
	<script type="text/javascript">
		function customerDelete(userId) {
			if (confirm("ユーザーを削除しますか？\n*予約とクーポンも削除されます*")) {
				document.getElementById("targetCommand").value = "customerDelete";
				document.getElementById("targetUserId").value = userId;
				document.getElementById("editCustomerForm").submit();
			}
		}

		function customerReserve(userId){
			document.getElementById("targetCommand").value = "customerReserve";
			document.getElementById("targetUserId").value = userId;
			document.getElementById("editCustomerForm").submit();
			
			}
	</script>
</body>

</html>