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
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/customerStyle.css">
<title>管理者顧客詳細情報</title>
</head>

<body>
	<header>
		<nav class="nav-menu">
			<button
				onclick="location.href='../Reservation/Admin_ReservationControl.html'">予約管理</button>
			<button
				onclick="location.href='../Customer/Admin_CustomerControl.html'">顧客管理</button>
			<button onclick="location.href='../Coupon/Admin_CouponControl.html'">クーポン管理</button>
			<button onclick="location.href='../Topics/Admin_TopicsControl.html'">お知らせ管理</button>
			<button onclick="location.href='../Visual/Admin_VisualChange.html'">Webサイト管理</button>
		</nav>
	</header>
	<main>
		<div class="customer-details-main customer-top-margin">
			<table class="customer-details-table">
				<tr>
					<td></td>
				</tr>
				<tr>
					<td><%=user.getName()%></td>
					<td><%=user.getUserTel()%></td>
				</tr>
				<tr class="customer-stetas">
					<td></td>
					<td></td>
					<td><%=user.getRegistDate()%> 登録</td>
				</tr>
			</table>
			<div class="customer-details-btns">
				<button class="customer-edit-btn">
					<img src="./image/assets/edit.jpg" alt="" class="edit-icon">
					編集
				</button>
				<button class="customer-delete-btn">
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
				<button class="customer-add-reservation-btn">＋ 予約追加</button>
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
						<td class="reservation-endtime"><%= endTimeStr %></td>
						<td class="reservation-width"><%=r.getReservePeople()%>名</td>
						<td class="reservation-width">座席<%=r.getSeatId()%></td>
						<td>
							<button class="customer-edit-btn"
								onclick="location.href='../Reservation/Admin_ReservationEdit.html'">
								<img src="./image/assets/edit.jpg" alt="" class="edit-icon"> 編集
							</button>
						</td>
						<td class="reservation-delete-btn">
							<button class="customer-delete-btn">
								<img src="./image/assets/trash.png" alt="" class="trash-icon">
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
								<img src="../image/assets/edit.jpg" alt="" class="edit-icon"> 編集
							</button>
						</td>
						<td class="reservation-delete-btn">
							<button class="customer-delete-btn">
								<img src="./image/assets/trash.png" alt="" class="trash-icon">
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
				<p>有効クーポン</p>
				<div class="coupon-list">
					<%
					for (CouponUsage c : couponUsageList) {
						if (c.isCouponUsage() != true) {
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
							<button class="coupon-btn">無効にする</button>
						</div>
					</div>
					<%
					}
					%>
				</div>

				<p>無効クーポン</p>
				<div class="coupon-list">
					<%
					for (CouponUsage c : couponUsageList) {
						if (c.isCouponUsage() == true) {
							continue;
						}
					%>
					<div class="coupon-passive">
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
							<button class="coupon-btn">有効にする</button>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
	</main>
</body>

</html>