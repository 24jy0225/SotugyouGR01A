<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Photo , java.util.* , model.User"%>
<%
List<Photo> photoList = (List<Photo>) session.getAttribute("photoList");
%>
<%
User user = (User) session.getAttribute("LoginUser");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/user/mainstyles.css">
<link rel="stylesheet" href="./css/user/menuStyle.css">
<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<title>menu</title>
</head>

<body>
	<!-- ヘッダー -->
	<header class="header" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo"
				class="logo">
		</div>
		<nav class="nav-menu">
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> <a
				href="./how_to_Use.jsp" class="nav-link">Use</a> <a
				href="./system-introduction.jsp" class="nav-link">System</a> <a
				href="./menu.jsp" class="nav-link">Menu</a> <a href="./topics.jsp"
				class="nav-link">Topics</a> <a href="./contact.jsp"
				class="nav-link">Contact</a> <a href="./ReservationDate.jsp"
				class="nav-link">Reservation</a>
			<%
			if (user != null) {
			%>
			<a href="UserController?command=MyPage" class="nav-link">Member</a>
			<%
			} else {
			%>
			<a href="./Login.jsp" class="nav-link">Login</a>
			<%
			}
			%>
		</nav>
	</header>
	<main>
		<div class="hero-section">
			<div class="hero-background-image">
				<img src="./image/assets/user/menutop.jpeg" alt="シーシャの炭">
			</div>
			<div class="logo-image">
				<img src="./image/assets/user/ロゴ完成_金色b.svg" alt="ロゴ">
			</div>
		</div>
		<div class="section-title-container">
			<hr>
			<h1 class="section-title">Flavar</h1>
			<hr>
		</div>
		<div class="flavor-content">
			<%
			if (photoList.size() != 0) {
				for (Photo p : photoList) {
					if (p.getPhotoCategory() != "flavar") {
				continue;
					}
			%>
			<img src="./image/photo/<%=p.getPhotoFileName()%>" alt="flavor">
			<%
			}
			} else {
			%>
			<img src="./image/assets/user/フレーバーメニュー.webp" alt="flavor">
			<%
			}
			%>
		</div>
		<div class="section-title-container">
			<hr>
			<h1 class="section-title">Drink</h1>
			<hr>
		</div>
		<div class="drink-back">
			<div class="drink-content">
				<div class="slide-item" id="drinkSliderTrack">
					<%
					if (photoList.size() != 0) {
						for (Photo p : photoList) {
							if (p.getPhotoCategory() != "drink") {
						continue;
							}
					%>
					<img src="./image/photo<%=p.getPhotoFileName()%>" alt="">
					<%
					}
					} else {
					%>
					<img src="./image/assets/user/menu/alcoholdrink1.webp" alt="">
					<%
					}
					%>
				</div>
			</div>
		</div>
		<div class="section-title-container">
			<hr>
			<h1 class="section-title">Food</h1>
			<hr>
		</div>
		<div class="food-back">

			<div class="food-content">
				<div class="slider-wrapper">
					<div class="slide-item" id="foodSliderTrack">
						<%
						if (photoList.size() != 0) {
							for (Photo p : photoList) {
								if (p.getPhotoCategory() != "food") {
							continue;
								}
						%>
						<img src="./image/photo/<%=p.getPhotoFileName()%>" alt="">
						<%
						}
						} else {
						%>
						<img src="./image/assets/user/menu/food1.webp" alt="">
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- フッター -->
	<footer class="footer" data-name="フッター">
		<div class="footer-content">
			<div class="footer-logo">
				<img src="./image/assets/user/ロゴ完成_金色b.svg" alt="フッターロゴ">
			</div>
			<button class="footer-reservation-btn">ご予約</button>
			<table class="footer-info">
				<tr>
					<th>店名</th>
					<td>：</td>
					<td>The Shisha Honjin</td>
				</tr>
				<tr>
					<th>住所</th>
					<td>：</td>
					<td>東京都新宿区歌舞伎町1丁目14 林ビル 3F</td>
				</tr>
				<tr>
					<th>電話番号</th>
					<td>：</td>
					<td>03-1234-5678</td>
				</tr>
				<tr>
					<th>営業時間</th>
					<td>：</td>
					<td>20:00~04:00</td>
				</tr>
				<tr>
					<th>定休日</th>
					<td>：</td>
					<td>年中無休</td>
				</tr>
				<tr>
					<th>決済方法</th>
					<td>：</td>
					<td>現金/クレジットカード</td>
				</tr>
			</table>
		</div>
		<nav class="footer-nav">
			<a href="#" class="footer-nav-link">What's</a> <a href="#"
				class="footer-nav-link">Use</a> <a href="#" class="footer-nav-link">System</a>
			<a href="#" class="footer-nav-link">Menu</a> <a href="#"
				class="footer-nav-link">Topics</a> <a href="#"
				class="footer-nav-link">contact</a>
		</nav>
		<p class="footer-copyright">
			<small>&copy;The Shisha Honjin</small>
		</p>
	</footer>
</body>

</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/drinkScript.js"></script>
<script type="text/javascript" src="./javascript/foodScript.js"></script>