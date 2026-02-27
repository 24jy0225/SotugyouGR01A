<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.User"%>
	<% User user = (User) session.getAttribute("LoginUser"); %>
	<% String errorMsg=(String)session.getAttribute("errorMsg"); %>
		<% String action=(String)session.getAttribute("action"); %>
			<% if(action==null){ action="" ; } %>
			<% if(errorMsg == null){
				errorMsg = "不明なエラーが出ました";
			} %>
				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="UTF-8">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
					<link rel="stylesheet" href="./css/user/style.css">
					<link rel="stylesheet" href="./css/user/password-reset-completeStyle.css">
					<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
					<title>ERROR発生</title>
				</head>

				<body>
					<header class="header" data-name="ヘッダー">
<%
		if (action.equals("ByUser")) {
		%>
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
        <%
		}
		%>
	</header>
					<main>
						<h1 class="complete-title">ERROR</h1>
						<h3 class="errorCodeLabel">
							<%= errorMsg %>
						</h3>
						<div class="info-box">
							<p class="error-message">
								申し訳ありません。<strong>処理中にエラーが発生</strong>し、ページを遷移できませんでした。<br>
								一時的な問題の可能性があります。しばらく経ってから再度お試しください。
							</p>
						</div>
						<% if(action.equals("ByAdmin")){ %>
						<button onclick="location.href='AdminMain.jsp'" class="errorbtn">トップに戻る</button>
						<% }else{ %>
						<button onclick="location.href='index.jsp'" class="errorbtn">トップに戻る</button>
						<% } %>
					</main>
					<footer>
						<p><small>&copy;The Shisha Honjin</small></p>
					</footer>
				</body>

				</html>

				<script type="text/javascript" src="./javascript/logoScript.js"></script>
				<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>