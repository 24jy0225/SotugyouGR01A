<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<%
User user = (User) session.getAttribute("LoginUser");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="../assets/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/password-resetStyle.css">
<title>パスワードリセット</title>
</head>

<body>

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
	<%
	String msg = (String) request.getAttribute("alertMsg");
	if (msg != null) {
	%>
	<div
		style="color: white; text-align: center; background: #333; padding: 10px; margin-bottom: 10px;">
		<%=msg%>
	</div>
	<%
	request.removeAttribute("alertMsg");
	}
	%>
	<main>

		<div class="modal-container">
			<h2 class="modal-title">パスワードの再設定</h2>
			<p class="modal-description">
				登録されているメールアドレスを入力してください。<br> パスワード再設定のリンクをお送りします。
			</p>

			<form method="post" action="UserController">
				<div class="form-group">
					<label class="form-label" for="email">メールアドレス</label>
					<div class="input-wrapper">
						<span class="input-icon">✉</span> <input type="email" id="email"
							name="email" class="form-input" placeholder="example@email.com">
					</div>
				</div>

				<button type="submit" class="btn-submit">再設定リンクを送信</button>

				<a href="#" class="back-link">戻る</a> <input type="hidden"
					name="command" value="passwordReset">
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