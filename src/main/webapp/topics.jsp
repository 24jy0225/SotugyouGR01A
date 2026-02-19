<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Photo , java.util.* , model.Topics , model.User"%>
<%
String action = (String)session.getAttribute("action"); 
List<Topics> topicsList = (List<Topics>) session.getAttribute("topicsList");
User user = (User)session.getAttribute("LoginUser");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/mainstyles.css">
<link rel="stylesheet" href="./css/user/topicsStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<title>topics</title>
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
		<!-- ヒーローセクション -->
		<div class="hero-section">
			<div class="hero-background-image">
				<img src="./image/assets/user/imgi_12_mainview-5.webp" alt="シーシャの炭">
			</div>
			<div class="logo-image">
				<img src="./image/assets/user/ロゴ完成_金色b.svg" alt="ロゴ">
			</div>
		</div>
		<div class="section-title-container">
			<hr>
			<h1 class="section-title">Topics</h1>
			<hr>
		</div>
		<div class="topics_list">
			<div class="topics_container">
				<%
				if (topicsList.size() != 0) {
				%>
				<%
				for (Topics t : topicsList) {
				%>
				<!-- トピック1 -->
				<div class="topic_item">
					<div class="topic_image">
						<img src="<%=t.getPhotoId().getPhotoFileName()%>"
							alt="特定期間お得な予約イベント">
					</div>
					<div class="topic_content">
						<h3 class="topic_title"><%=t.getTopicsTitle()%></h3>
						<p class="topic_description">
							<%=t.getTopicsContent()%>
						</p>
					</div>
				</div>
				<%
				}
				} else {
				%>
				<!-- トピック2 -->
				<div class="topic_item">
					<div class="topic_image">
						<img
							src="./image/assets/user/topics/imgi_11_A1_メニューPOP_20251003.jpeg"
							alt="Shisha Club 料金システム改正">
					</div>
					<div class="topic_content">
						<h3 class="topic_title">Shisha Club 料金システム改正のお知らせ</h3>
						<p class="topic_description">
							2/1午前0:00から料金システムが少し改変になります。<br> ご注意ください。
						</p>
					</div>
				</div>

				<!-- トピック3 -->
				<div class="topic_item">
					<div class="topic_image">
						<img
							src="./image/assets/user/topics/imgi_13_A4_TSH大宮_ハロウィンフレーバー_20250925.jpg"
							alt="Season Recommend Flavor">
					</div>
					<div class="topic_content">
						<h3 class="topic_title">ハロウィン限定フレーバー販売中</h3>
						<p class="topic_description">
							ハロウィンの新定フレーバー特集実施中！<br> 期間限定ですので、ぜひお早めに！
						</p>
					</div>
				</div>

				<!-- トピック4 -->
				<div class="topic_item">
					<div class="topic_image">
						<img
							src="./image/assets/user/topics/imgi_12_A4_ESC_ハロウィンメニュー_20251003.jpg"
							alt="Halloween Special Flavor">
					</div>
					<div class="topic_content">
						<h3 class="topic_title">赤いハロウィンのシーシャ包装無料キャンペーン中</h3>
						<p class="topic_description">
							ネットでハロウィンパッケージも配布中キャンペーンが<br> 実施中！！
						</p>
					</div>
				</div>

				<!-- トピック5 -->
				<div class="topic_item">
					<div class="topic_image">
						<img src="./image/assets/user/topics/imgi_6_大宮女子会シーシャ.jpg"
							alt="Girls Party Plan">
					</div>
					<div class="topic_content">
						<h3 class="topic_title">「女子会プラン」限定企画実施中</h3>
						<p class="topic_description">
							料金：1人当たり￥2,000<br> 時間：22:00以降は延長<br> <br> プラン内容<br>
							ドレンクを好きなだけ<br> 3チャート水あり<br> スイートパック追加料金無料
						</p>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
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
			<a href="#" class="footer-nav-link">What's</a> 
			<a href="#" class="footer-nav-link">Use</a> 
			<a href="#" class="footer-nav-link">System</a>
			<a href="#" class="footer-nav-link">Menu</a> 
			<a href="#" class="footer-nav-link">Topics</a> 
			<a href="#" class="footer-nav-link">contact</a>
		</nav>
		<p class="footer-copyright">
			<small>&copy;The Shisha Honjin</small>
		</p>
	</footer>
</body>
</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>