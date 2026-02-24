<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User , java.util.*"%>
<%
User user = (User) session.getAttribute("LoginUser");
String action = (String) session.getAttribute("action");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/membership-Registration-ConfirmationStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<title>会員登録確認</title>
</head>

<body>
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
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> <a
				href="./how_to_Use.jsp" class="nav-link">Use</a> <a
				href="./system-introduction.jsp" class="nav-link">System</a> <a
				href="./menu.jsp" class="nav-link">Menu</a> <a href="./topics.jsp"
				class="nav-link">Topics</a> <a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
			<%
			if (user != null) {
			%>
			<div class="nav-member-group">
				<a href="UserController?command=MyPage" class="nav-link">Member</a>
				<a href="UserController?command=logout" class="nav-logout-link">logout</a>
			</div>
			<%
			} else {
			%>
			<a href="./Login.jsp" class="nav-link">Login</a>
			<%
			}
			%>
		</nav>
		<!-- スマホ用ナビゲーション -->
		<nav class="mobile-nav" id="mobileNav">
			<a href="./whats_Shisha.jsp" class="mobile-nav-link">What's</a> <a
				href="./how_to_Use.jsp" class="mobile-nav-link">Use</a> <a
				href="./system-introduction.jsp" class="mobile-nav-link">System</a>
			<a href="./menu.jsp" class="mobile-nav-link">Menu</a> <a
				href="./topics.jsp" class="mobile-nav-link">Topics</a> <a
				href="./contact.jsp" class="mobile-nav-link">Contact</a> <a
				href="UserController?command=reservationDate"
				class="mobile-nav-link">Reservation</a>
			<%
			if (user != null) {
			%>
			<a href="UserController?command=MyPage" class="mobile-nav-link">Member</a>
			<a href="UserController?command=logout"
				class="mobile-nav-link mobile-nav-logout">Logout</a>
			<%
			} else {
			%>
			<a href="./Login.jsp" class="mobile-nav-link">Login</a>
			<%
			}
			%>
		</nav>
	</header>
	<main>
		<div class="confirm-container">
			<h1 class="confirm-title">登録確認画面</h1>

			<form action="UserController" method="post">
				<div class="form-group">
					<label class="form-label">氏名</label> <input type="text"
						class="form-input" name="name" placeholder="山田 太郎" required>
				</div>

				<div class="form-group">
					<label class="form-label">メールアドレス</label> <input type="email"
						class="form-input" name="email" placeholder="example@email.com"
						required>
				</div>

				<div class="form-group">
					<label class="form-label">電話番号</label> <input type="tel"
						class="form-input" name="tel" placeholder="09012345678(ハイフンなし)"
						required>
				</div>

				<div class="form-group">
					<label class="form-label">パスワード</label>
					<div class="input-wrapper">
						<input type="password" id="password" class="form-input"
							name="password" placeholder="********" required>
					</div>
				</div>

				<div class="button-group">
					<button type="submit" class="btn btn-primary">登録</button>
					<button type="button" class="btn btn-secondary">戻る</button>
				</div>
				<input type="hidden" name="command" value="RegisterAction">
			</form>
		</div>
	</main>
	<footer>
		<p>
			<small>&copy;The Shisha Honjin</small>
		</p>
	</footer>

</body>

</html>
<script type="text/javascript" src="../javascript/logoScript.js"></script>