<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<%
	// セッションからメアドを取り出してみる
	String tempEmail = (String) session.getAttribute("tempEmail");
    if(tempEmail == null){
        tempEmail = "";
    }
    User user = (User)session.getAttribute("LoginUser");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="../assets/ロゴマーク_金色b.webp">
    <link rel="stylesheet" href="./css/user/style.css">
    <link rel="stylesheet" href="./css/user/registration-Mail-SentStyle.css">
    <link rel="stylesheet" href="./css/user/hamburgerStyle.css">
    <title>会員登録メール送信</title>
</head>

<body>
    <header class="header" data-name="ヘッダー">
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
							<a href="./menu.jsp" class="nav-link">Menu</a>
							<a href="./topics.jsp" class="nav-link">Topics</a>
							<a href="./contact.jsp" class="nav-link">Contact</a>
							<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
							<%if (user !=null) { %>
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
							<a href="./menu.jsp" class="mobile-nav-link">Menu</a>
							<a href="./topics.jsp" class="mobile-nav-link">Topics</a>
							<a href="./contact.jsp" class="mobile-nav-link">Contact</a>
							<a href="UserController?command=reservationDate" class="mobile-nav-link">Reservation</a>
							<%if (user !=null) { %>
								<a href="UserController?command=MyPage" class="mobile-nav-link">Member</a>
								<a href="UserController?command=logout"
									class="mobile-nav-link mobile-nav-logout">Logout</a>
								<% } else { %>
									<a href="./Login.jsp" class="mobile-nav-link">Login</a>
									<% } %>
						</nav>
					</header>
    <main>
        <div class="page-wrapper">
            <h1 class="page-title">メール送信完了</h1>

            <div class="mail-sent-container">
                <h2 class="main-title">認証メールを送信しました</h2>

                <p class="description">
                    以下のメールアドレス宛に、会員登録を完了するためのURLを送信しました。
                </p>

                <div class="email-display">
                    <%= tempEmail %>
                </div>

                <p class="instruction">
                    メールに記載されているURLをクリックして、会員登録を完了してください。
                </p>

                <div class="notice-box">
                    <div class="notice-title">【ご注意】</div>
                    <div>メールが届かない場合は、迷惑メールフォルダをご確認ください</div>
                    <div>URLの有効期限は24時間です</div>
                    <div>URLをクリックすると登録が完了します</div>
                </div>

                <button type="button" class="resend-button">メールを再送する</button>
            </div>
        </div>
    </main>
    <footer>
        <p><small>&copy;The Shisha Honjin</small></p>
    </footer>
</body>

</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>