<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="model.Reservation , java.time.format.DateTimeFormatter , java.time.LocalDate , java.time.temporal.ChronoUnit"%>
<%
Reservation r = (Reservation) session.getAttribute("cancelReserve");
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/reservation_cancel_completeStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<title>Reservation Cancellation Complete</title>
</head>

<body>
	<!-- ヘッダー -->
	<header class="header" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo"
				class="logo">
		</div>
		<button class="hamburger-menu" id="hamburgerBtn" aria-label="メニュー">
            <img src="./image/assets/user/hamburger.svg" alt="メニュー">
        </button>
		<!-- PC用ナビゲーション -->
        <nav class="nav-menu">
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> 
			<a href="./how_to_Use.jsp" class="nav-link">Use</a> 
			<a href="./system-introduction.jsp" class="nav-link">System</a>
			<a	href="./menu.jsp" class="nav-link">Menu</a> 
			<a href="./topics.jsp" class="nav-link">Topics</a> 
			<a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
			<%if (user != null) { %>
				<div class="nav-member-group">
					<a href="UserController?command=MyPage" class="nav-link">Member</a>
					<a href="UserController?command=logout" class="nav-logout-link">logout</a>
				</div>
			<% } else { %>
				<a href="./Login.jsp" class="nav-link">Login</a>
			<% } %>
		</nav>
        <!-- スマホ用ナビゲーション -->
        <nav class="mobile-nav" id="mobileNav">
            <a href="./whats_Shisha.jsp" class="mobile-nav-link">What's</a> 
			<a href="./how_to_Use.jsp" class="mobile-nav-link">Use</a> 
			<a href="./system-introduction.jsp" class="mobile-nav-link">System</a>
			<a	href="./menu.jsp" class="mobile-nav-link">Menu</a> 
			<a href="./topics.jsp" class="mobile-nav-link">Topics</a> 
			<a href="./contact.jsp" class="mobile-nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="mobile-nav-link">Reservation</a>
			<%if (user != null) { %>
				<a href="UserController?command=MyPage" class="mobile-nav-link">Member</a>
				<a href="UserController?command=logout" class="mobile-nav-link mobile-nav-logout">Logout</a>
			<% } else { %>
				<a href="./Login.jsp" class="mobile-nav-link">Login</a>
			<% } %>
        </nav>
	</header>
	<main>
		<%
		if (r != null) {
		%>
		<div class="complete-wrapper">
			<h1 class="complete-main-title">Reservation Cancellation</h1>
			<h2 class="complete-status">Completed</h2>

			<div class="complete-container">
				<div class="success-message">
					予約のキャンセルが完了しました。</div>

				<table class="reservation-info">
					<tr>
						<td class="info-title">キャンセル完了</td>
					</tr>
					<tr>
						<td class="info-label">予約番号:</td>
						<td class="info-value"><%=r.getReserveId()%></td>
					</tr>
					<tr>
						<td><img src="./image/assets/user/personicon.svg" alt="">
							<span class="info-label">予約者名:</span></td>
						<td class="info-value"><%=r.getUserName()%></td>
					</tr>
					<tr>
						<td><img src="./image/assets/user/personicon.svg" alt="">
							<span class="info-label">予約人数:</span></td>
						<td class="info-value"><%=r.getReservePeople()%>名</td>
					</tr>
					<tr>
						<td><img src="./image/assets/user/dayicon.svg" alt="">
							<span class="info-label">日付:</span></td>
						<td class="info-value"><%=r.getReserveDate().format(formatter)%>日</td>
					</tr>
					<tr>
						<td><img src="./image/assets/user/timeicon.svg" alt="">
							<span class="info-label">開始時間:</span></td>
						<td class="info-value"><%=r.getStartDateTime().format(timeFormatter)%></td>
					</tr>
					<tr>
						<td><img src="./image/assets/user/timeicon.svg" alt="">
							<span class="info-label">終了時間:</span></td>
						<td class="info-value"><%=r.getEndDateTime().format(timeFormatter)%></td>
					</tr>
					<tr>
						<td><img src="./image/assets/user/courseicon.svg" alt="">
							<span class="info-label">コース:</span></td>
						<td class="info-value"><%=ChronoUnit.MINUTES.between(r.getStartDateTime(), r.getEndDateTime())%>分</td>
					</tr>
					<tr>
						<td><img src="./image/assets/user/seaticon.svg" alt="">
							<span class="info-label">座席:</span></td>
						<td class="info-value">座席<%=r.getSeatId()%></td>
					</tr>
				</table>

				<button type="button" class="return-btn"
					onclick="location.href='./MyPage.jsp'">メンバーズ画面に戻る</button>
			</div>
		</div>
		<%
		} else {
		%>
		<button class="return-btn" onclick="location.href='./MyPage.jsp'">MyPageに戻る</button>
		<%
		}
		%>
	</main>
	<footer>
		<p>
			<small>&copy;The Shisha Honjin</small>
		</p>
	</footer>
</body>

</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>