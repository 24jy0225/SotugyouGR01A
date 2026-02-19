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
<title>新しいパスワード設定</title>
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
				class="nav-link">Topics</a> <a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
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

		<div class="modal-container">
			<a href="#" class="back-link"> <span>←</span> <span>戻る</span>
			</a>

			<h2 class="modal-title">新しいパスワードを設定</h2>
			<p class="modal-description">新しいパスワードを入力してください</p>

			<form method="post" action="UserController" id="passwordForm"
				onsubmit="return validatePassword()">
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
					<p id="error-msg" class="error-message">パスワードが一致しません</p>
				</div>

				<button type="submit" class="btn-submit">パスワードを再設定</button>
				<input type="hidden" name="command" value="passwordResetInput">
				<input type="hidden" name="token" value="${token}">
			</form>
	</main>
	<script>
		function validatePassword() {
			const pass = document.getElementById("new-password").value;
			const confirm = document.getElementById("confirm-password").value;
			const errorMsg = document.getElementById("error-msg");

			// 前後の空白を削除して比較（念のため）
			if (pass.trim() !== confirm.trim()) {
				errorMsg.style.display = "block"; // エラー表示
				return false;
			}

			// 8文字以上などのルールもJSでチェックしておくと親切です
			if (pass.length < 8) {
				alert("パスワードは8文字以上で入力してください。");
				return false;
			}

			errorMsg.style.display = "none";
			return true;
		}
	</script>
</body>
</html>