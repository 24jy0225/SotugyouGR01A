<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.User"%>
<%
String action = (String)session.getAttribute("action"); 
User user = (User) session.getAttribute("LoginUser");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>How to Use - The Shisha Honjin</title>
<link rel="icon" href="../assets/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/mainstyles.css">
<link rel="stylesheet" href="./css/user/how-to-use-styles.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
</head>

<body>
	<header class="header" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo" class="logo">
		</div>
		<button class="hamburger-menu" id="hamburgerBtn" aria-label="メニュー">
            <img src="./image/assets/user/hamburger.svg" alt="メニュー">
        </button>
		<nav class="nav-menu">
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> 
			<a href="./how_to_Use.jsp" class="nav-link">Use</a> 
			<a href="./system-introduction.jsp" class="nav-link">System</a>
			<a	href="./menu.jsp" class="nav-link">Menu</a> 
			<a href="./topics.jsp" class="nav-link">Topics</a> 
			<a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
			<%if (user != null) { %>
				<a href="UserController?command=MyPage" class="nav-link">Member</a>
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
			<% } else { %>
				<a href="./Login.jsp" class="mobile-nav-link">Login</a>
			<% } %>
        </nav>
	</header>

	<!-- メインコンテンツ -->
	<main class="main-content how-to-use-main-content">
		<div class="hero-section">
			<div class="hero-background-image">
				<img src="./image/assets/user/imgi_7_whats-shisha_mv.webp">
			</div>
			<div class="logo-image">
				<img src="./image/assets/user/ロゴ完成_金色b.svg" alt="ロゴ">
			</div>
		</div>
		<!-- How to Use セクション -->
		<section class="section how-to-use-section">
			<div class="section-title-container">
				<hr>
				<h1 class="section-title">How to Use</h1>
				<hr>
			</div>
			<h2 class="section-subtitle">ご利用方法</h2>

			<!-- 紹介文 -->
			<div class="intro-text">
				<p>
					当店は単なるシーシャ店ではなく、お客様が思い思いの時間を過ごせる<strong>「大人の居場所」</strong>でありたいと考えています。
				</p>
				<p>その日の気分に寄り添う、3つの過ごし方をご紹介します。</p>
			</div>

			<!-- Shisha & Alcohol セクション -->
			<div class="use-method-section shisha-alcohol-section">
				<div class="method-image">
					<img src="./image/assets/user/imgi_5_maxsonmedia-9-2048x1365.jpeg"
						alt="Shisha & Alcohol">
				</div>
				<div class="method-content">
					<h3 class="method-title">Shisha & Alcohol</h3>
					<div class="method-description">
						<p>揺らぐ煙と、美酒の共演 シーシャの芳醇な香りと、アルコールの陶酔感。</p>
						<p>この2つが重なり合うことで生まれる高揚感は、当店だからこそ味わえる特別な体験です。</p>
						<p>ウイスキーの琥珀色と紫煙のコントラストを眺めながら、友人や恋人と語り合う。五感を満たす、優雅なマリアージュをご堪能ください。</p>
					</div>
				</div>
			</div>

			<!-- Shisha Only セクション -->
			<div class="use-method-section shisha-only-section">
				<div class="method-image">
					<img src="./image/assets/user/imgi_73_shishen_frankfurt-1920w.jpeg"
						alt="Shisha Only">
				</div>
				<div class="method-content">
					<h3 class="method-title">Shisha Only</h3>
					<div class="method-description">
						<p>シーシャという「体験」に没頭する アルコールがなくとも、夜は十分に楽しめます。
							雑踏から離れ、深呼吸をするように煙を吸い込む。</p>
						<p>ただそれだけで、心身が解き放たれる感覚を味わえるはずです。</p>
						<p>ノンアルコールカクテルやこだわりのカフェメニューを片手に、自分自身と向き合う静謐な時間をお過ごしください。</p>
					</div>
				</div>
			</div>

			<!-- Alcohol Only セクション -->
			<div class="use-method-section alcohol-only-section">
				<div class="method-image">
					<img src="./image/assets/user/imgi_29_bar_frankfurt-1920w.jpeg"
						alt="Alcohol Only">
				</div>
				<div class="method-content">
					<h3 class="method-title">Alcohol Only</h3>
					<div class="method-description">
						<p>Barとしての美学を愉しむ 「今夜は煙の気分ではない」という日も、当店の扉を開けてください。</p>
						<p>カウンターでグラスを傾けるだけの時間もまた、当店の日常です。</p>
						<p>オーセンティックなバーに引けを取らないラインナップと技術で、極上の一杯をご提供します。喧騒を忘れさせる空間で、美酒に酔いしれるひとときを。</p>
						<p>注意：Alcohol Onlyの場合予約不可です。</p>
					</div>
				</div>
			</div>
		</section>
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
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>