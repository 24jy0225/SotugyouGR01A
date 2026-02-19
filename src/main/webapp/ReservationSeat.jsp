<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, java.util.ArrayList, model.Seat, model.User"%>
<%
String action = (String) session.getAttribute("action");
List<Seat> seatList = (List<Seat>) session.getAttribute("Seat");
String date = (String) session.getAttribute("date");

User user = (User) session.getAttribute("LoginUser");

// 送信先の判定
String formAction = "ByUser".equals(action) ? "UserController" : "AdminController";
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>予約登録システム - 席選択</title>
<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/reservation_seatStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<style>
.seat_submit_btn {
	background: none;
	border: none;
	padding: 0;
	width: 100%;
	cursor: pointer;
	font-family: inherit;
}

.seat_card:hover {
	transform: translateY(-5px);
	border: 1px solid #d4af37;
}
</style>
</head>
<body>
	<header class="header" data-name="ヘッダー">
	<% if(action.equals("ByUser")){ %>
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo" class="logo">
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
	<% } %>
	</header>
	<main>
		<div class="container">
			<div class="step_indicator">
				<h2>予約登録</h2>
				<div class="step_image">
					<img src="./image/assets/user/seatpage.svg" alt="">
				</div>
			</div>

			<div class="seat_selection_area">
				<h3>席を選択してください</h3>
				<p class="selected_date">
					選択日:<br><%=date != null ? date : "未選択"%></p>

				<form method="get" action="<%=formAction%>">
					<input type="hidden" name="command" value="Time">

					<div class="seat_grid">
						<%
						if (seatList != null) {
							for (Seat seat : seatList) {
						%>
						<button type="submit" name="seatId" value="<%=seat.getSeatId()%>"
							class="seat_submit_btn">
							<div class="seat_card">
								<div class="seat_icon">
									<img src="./image/assets/user/seaticon.svg" alt="座席">
								</div>
								<h4>
									席
									<%=seat.getSeatNumber()%></h4>
							</div>
						</button>
						<%
						}
						} else {
						%>
						<p>利用可能な席がありません。</p>
						<%
						}
						%>
					</div>
				</form>

				<div class="seat_layout_info">
					<p class="layout_title">座席レイアウト</p>
					<p class="layout_detail">1〜5番席:窓側</p>
					<p class="layout_detail">6〜10番席:通路側</p>
				</div>

				<a href="#" class="back_link"
					onclick="history.back(); return false;">← コース選択に戻る</a>
			</div>

			<button class="restart_button" onclick="location.href='UserController?command=reservationDate'">最初からやり直す</button>
		</div>
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