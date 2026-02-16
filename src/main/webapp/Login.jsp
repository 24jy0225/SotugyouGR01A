<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<% User user = (User)session.getAttribute("LoginUser"); %>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="../assets/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/loginStyle.css">
<title>Login</title>
</head>

<body>
	<header class="header" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo" class="logo">
		</div>
		<nav class="nav-menu">
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> 
			<a href="./how_to_Use.jsp" class="nav-link">Use</a> 
			<a href="./system-introduction.jsp" class="nav-link">System</a>
			<a	href="./menu.jsp" class="nav-link">Menu</a> 
			<a href="./topics.jsp" class="nav-link">Topics</a> 
			<a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="ReservationDate.jsp" class="nav-link">Reservation</a>
			<%if (user != null) { %>
				<a href="UserController?command=MyPage" class="nav-link">Member</a>
			<% } else { %>
				<a href="./Login.jsp" class="nav-link">Login</a>
			<% } %>
		</nav>
	</header>
	
	<main>

		<div class="login-container">
			<h1 class="login-title">Welcome Back</h1>
			<p class="login-subtitle">続行するにはログインしてください</p>

			<form action="UserController" method="post">
				<div class="form-group">
					<label class="form-label" for="email">Email Address</label> <input
						type="email" id="email" class="form-input" name="email"
						placeholder="Placeholder" required>
				</div>

				<div class="form-group">
					<label class="form-label" for="password">Password</label>
					<div class="input-wrapper">
						<input type="password" id="password" class="form-input"
							name="password" placeholder="Placeholder text" required> <span
							class="password-toggle" onclick="togglePassword()">不</span>
					</div>
					<p class="password-hint">パスワードは英字大文字・小文字・数字を含む8文字以上で入力してください。</p>
				</div>

				<div class="form-options">
					<label class="remember-me"> <input type="checkbox"
						id="remember"> <span>Remember me</span>
					</label> <a href="PasswordReset.jsp" class="forgot-password">Forgot
						Password?</a>
				</div>

				<button type="submit" class="login-button">Log In</button>

				<div class="signup-link">
					No account yet? <a href="UserRegister.jsp">Sign Up</a>
				</div>
				<input type="hidden" name="command" value="LoginAction">
			</form>
		</div>
	</main>

	<script>
		function togglePassword() {
			const passwordInput = document.getElementById('password');
			const passwordToggle = document.querySelector('.password-toggle');

			if (passwordInput.type === 'password') {
				passwordInput.type = 'text';
				passwordToggle.textContent = '可';
			} else {
				passwordInput.type = 'password';
				passwordToggle.textContent = '不';
			}
		}
	</script>
</body>

</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>