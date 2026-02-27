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
<link rel="stylesheet" href="./css/user/member-editStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<title>会員情報の変更</title>
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
	
	<%
	String msg = (String) session.getAttribute("message");
	if (msg != null) {
	%>
	<div
		style="color: green; font-weight: bold; border: 1px solid green; padding: 10px; margin-bottom: 10px;">
		<%=msg%>
	</div>
	<%
	// 一度表示したら消す（そうしないと、ずっと表示され続けてしまうため）
	session.removeAttribute("message");
	}
	%>
	<main>

		<div class="content-wrapper">
			<div class="page-header">
				<h1 class="page-title">会員情報の変更</h1>
				<p class="page-description">プロフィール情報を更新できます</p>
			</div>

			<div class="settings-container">
				<div class="section-header">
					<h2>アカウント設定</h2>
				</div>
				<p class="section-description">会員情報の確認と変更ができます</p>

				<form action="UserController" method="post">
					<div class="form-group">
						<label class="form-label" for="name">氏名</label> <input type="text"
							id="name" name="name" class="form-input"
							value="<%=user.getName()%>">
					</div>

					<div class="form-group">
						<label class="form-label" for="email">メールアドレス</label> <input
							type="email" id="email" name="email" class="form-input"
							value="<%=user.getUserEmail()%>">
					</div>

					<div class="form-group">
						<label class="form-label" for="phone">電話番号</label> <input
							type="tel" id="phone" name="tel" class="form-input"
							value="<%=user.getUserTel()%>">
					</div>

					<div class="button-group">
						<button type="submit" class="btn btn-save">
							<span>保存する</span>
						</button>
						<button class="btn btn-cancel" type="button"
							onclick="location.href='UserController?command=MyPage'">
							<span>MyPageに戻る</span>
						</button>
					</div>					
					<input type="hidden" name="preEmail" value="<%= user.getUserEmail() %>">
					<input type="hidden" name="command" value="userInfoEdit">
				</form>
			</div>
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
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>