<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<%
User user = (User) session.getAttribute("LoginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<title>success</title>
<style type="text/css">
	body{
		min-height:1000px;
		
	}
	main{
		height:810px;
		display:flex;
		text-align: center;
		flex-direction : column;
		
	}
	.success-name{
		margin-top : 100px;
		margin-bottom: 100px;
		font-size : 48px;
	}
	.success-btn{
		display: inline-flex;
    	align-items: center;
    	gap: 0.5rem;
    	padding: 0.75rem 2rem;
    	font-family: 'Noto Sans JP', sans-serif;
    	font-size: 0.9rem;
    	font-weight: 500;
    	letter-spacing: 0.05em;
    	cursor: pointer;
    	border: none;
    	border-radius: 2px;
    	text-decoration: none;
    	background: transparent;
    	color: rgb(232, 232, 240);
    	border: 1px solid rgb(85, 85, 106);
		font-size : 24px;
		margin : 100px auto;		
		margin-bottom: 100px;
	}
    .success-btn:hover {
    	border-color: rgb(255, 60, 60);
    	color: rgb(255, 60, 60);
    	transform: translateY(-2px);
	}
}


}


</style>
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
	<%
	String msg = (String) request.getAttribute("msg");
	if (msg != null) {
	%>
	<div style="color: green; font-weight: bold; border: 1px solid green; padding: 10px; margin-bottom: 10px;">
		<%=msg%>
	</div>
	<%
	// 一度表示したら消す（そうしないと、ずっと表示され続けてしまうため）
	request.removeAttribute("msg");
	}
	%>
	<h1 class="playfair-display success-name">Success</h1>
	
		<%
		if (session.getAttribute("afterLoginPage") != null || msg != null) {
		%>
		<button onclick="location.href='Login.jsp'" class="success-btn">ログイン画面</button>
		<%
		} else {
		%>
		<button onclick="location.href='top.jsp'" class="success-btn">ホームに戻る</button>
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