<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, java.util.ArrayList, model.Seat"%>
<%
String action = (String) session.getAttribute("action");
List<Seat> seatList = (List<Seat>) session.getAttribute("Seat");
String date = (String) session.getAttribute("date");

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
	<header class="systemheader" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.html'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo" class="logo">
		</div>
		<nav class="system-nav-menu">
			<a href="./login.html" class="nav-link">Login</a>
		</nav>
	</header>
	<main>
		<div class="container">
			<div class="step_indicator">
				<h2>予約登録システム</h2>
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
									<%=seat.getSeatId()%></h4>
								<p class="availability">空き</p>
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

			<button class="restart_button" onclick="location.href='./top.jsp'">最初からやり直す</button>
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