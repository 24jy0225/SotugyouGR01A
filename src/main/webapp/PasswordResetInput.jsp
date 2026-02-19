<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<%
User user = (User) session.getAttribute("LoginUser");
String action = (String) session.getAttribute("action");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="../assets/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/new-passwordStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<title>新しいパスワード設定</title>
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

		<div class="modal-container">
			<a href="#" class="back-link"> <span>←</span> <span>戻る</span>
			</a>

			<h2 class="modal-title">新しいパスワードを設定</h2>
			<p class="modal-description">新しいパスワードを入力してください</p>

			<form method="post" action="UserController" id="passwordForm">
				<div class="form-group">
					<label class="form-label" for="new-password">新しいパスワード</label>
					<div class="input-wrapper">
						<span class="input-icon">🔒</span> <input type="password"
							id="new-password" name="password" class="form-input" required
							placeholder="パスワード">
					</div>
					<p class="password-hint">パスワードは英字大文字・小文字・数字を含む8文字以上で入力してください。</p>
				</div>

				<div class="form-group">
					<label class="form-label" for="confirm-password">パスワードの確認</label>
					<div class="input-wrapper">
						<span class="input-icon">🔒</span> <input type="password"
							id="confirm-password" name="confirmPassword" class="form-input"
							placeholder="パスワードを再入力" required>
					</div>
				</div>

				<button type="submit" class="btn-submit">パスワードを再設定</button>
				<input type="hidden" name="command" value="passwordResetInput">
				<input type="hidden" name="token" value="${token}">
			</form>
		</div>
	</main>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const form = document.getElementById("passwordForm");
			const passInput = document.getElementById("new-password");
			const confirmInput = document.getElementById("confirm-password");

			form.addEventListener("submit", function(event) {
				const pass = passInput.value;
				const confirm = confirmInput.value;

				// 1. 一致チェック
				if (pass !== confirm) {
					event.preventDefault(); // 送信中止
					alert("パスワードが一致しません！");
					return false;
				}

				// 2. 文字数チェック
				if (pass.length < 8) {
					event.preventDefault(); // 送信中止
					alert("パスワードは8文字以上で入力してください。");
					return false;
				}

				// 成功時はそのまま送信される
				console.log("送信を開始します...");
			});
		});
	</script>
</body>
</html>
<script type="text/javascript" src="../javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>