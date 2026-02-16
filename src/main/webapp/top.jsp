<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="model.Photo , java.util.* , model.Topics , model.User"%>
<%
List<Photo> photoList = (List<Photo>) session.getAttribute("photoList");
%>
<%
List<Topics> topicsList = (List<Topics>) session.getAttribute("topicsList");
%>
<%
User user = (User) session.getAttribute("LoginUser");
String topImageName = "burning_coal.jpg";

//2. リストを回して "top" カテゴリを探す
if (photoList != null) {
	for (Photo p : photoList) {
		// "top" と p.getPhotoCategory() が一致するかチェック
		if ("top".equals(p.getPhotoCategory())) {
	topImageName = p.getPhotoFileName(); // ファイル名を取得
	break; // 見つかったらループを抜ける
		}
	}
}
%>

<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Top - The Shisha Honjin</title>
<link rel="icon" href="../assets/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/mainstyles.css">
<link rel="stylesheet" href="./css/user/top-styles.css">
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

	<!-- メインコンテンツ -->
	<main class="main-content top-main-content" data-name="main2">
		<!-- ヒーローセクション -->
		<div class="hero-section">
			<div class="hero-background-image">
				<img
					src="<%= topImageName %>"
					alt="シーシャの炭">
			</div>
			<div class="logo-image">
				<img src="./image/assets/user/ロゴ完成_金色b.svg" alt="ロゴ">
			</div>
		</div>

		<!-- 日本人に合ったシーシャ セクション -->
		<section class="section japanese-section">
			<h1 class="japanese-title">日本人に合ったシーシャを</h1>
			<div class="japanese-content">
				<div class="japanese-image">
					<img src="./image/assets/user/シーシャ写真1.jpeg" alt="シーシャ">
				</div>
				<div class="japanese-text">
					<p>日本人の感性に寄り添った空間設計と、きめ細やかなサービスをもって、日本人が求める「清潔感」「静けさ」「心地よい距離感」を大切にした店づくりを続け、「一人でも安心して過ごせる」「初めてでも気後れしない」「何度来ても新鮮な発見がある」、そんな居場所を世に出し続けています。
					</p>
					<p>&nbsp;</p>
					<p>また、日本産の上質な素材にこだわり、何度でも飽きない、心地の良い味を常に追い求め品質管理のレベルを上げて守り続けています。</p>
					<p>&nbsp;</p>
					<p>創業以来、スタッフの教育を徹底。「毎日通いたくなる、自分だけの特等席のような場所」を世に出し続けています。</p>
				</div>
			</div>
		</section>

		<!-- What's the shisha セクション -->
		<section class="section whats-section">
			<div class="section-title-container">
				<hr>
				<h1 class="section-title">What's the shisha</h1>
				<hr>
			</div>
			<div class="whats-content">
				<div class="whats-text">
					<p>若者を中心に愛好者が増えちょっとした流行となっているシーシャはタバコの葉をシロップに漬け込むことで、甘くフルーティーな香りを出しています。</p>
					<p>&nbsp;</p>
					<p>タバコ特有の臭いや、肺へのストレスの要素をカットし、フルーツやスイーツなど、お好みに合わせたフレーバーのアレンジやアルコールの追加、冷やしシーシャなどのオプションも楽しめます。</p>
				</div>
				<div class="whats-image">
					<img src="./image/assets/user/whatsshisha.jpeg" alt="シーシャ">
				</div>
			</div>
			<div class="more-btn-container">
				<button class="more-btn">MORE</button>
			</div>
		</section>

		<!-- How to Use セクション -->
		<section class="section how-to-use-section">
			<div class="section-title-container">
				<hr>
				<h1 class="section-title">How to Use</h1>
				<hr>
			</div>
			<div class="how-to-use-cards">
				<div class="use-card">
					<img src="./image/assets/user/imgi_73_shishen_frankfurt-1920w.jpeg"
						alt="シーシャの選び方">
					<p class="use-card-title">シーシャだけでも</p>
				</div>
				<div class="use-card">
					<img src="./image/assets/user/imgi_29_bar_frankfurt-1920w.jpeg"
						alt="シーシャの楽しみ方">
					<p class="use-card-title">シーシャとお酒で</p>
				</div>
				<div class="use-card">
					<img src="./image/assets/user/imgi_5_maxsonmedia-9-2048x1365.jpeg"
						alt="店舗の雰囲気">
					<p class="use-card-title">お酒だけで</p>
				</div>
			</div>
			<p class="use-description">当店は様々な方法でお楽しみいただけます。</p>
			<div class="more-btn-container">
				<button class="more-btn">MORE</button>
			</div>
		</section>

		<!-- System セクション -->
		<section class="section system-section">
			<div class="section-title-container">
				<hr>
				<h1 class="section-title">System</h1>
				<hr>
			</div>
			<div class="system-content">
				<div class="system-basic">
					<h2 class="system-subtitle">基本料金</h2>
					<div class="system-prices">
						<p>
							<span class="price-label">ショートシーシャ(1時間)</span><br> <span
								class="price-value">￥1,200(税込)</span><br> <span
								class="price-label">レギュラーシーシャ(1.5時間)</span>
						</p>
						<p class="price-value">￥1,800(税込)</p>
						<p class="price-label">スペシャルシーシャ(2時間)</p>
						<p class="price-value">￥2,200(税込)</p>
					</div>
				</div>
				<div class="system-charge">
					<h2 class="system-subtitle">チャージ料金</h2>
					<div class="system-charge-content">
						<p>
							<span class="price-label">おひとり様：</span><span class="price-value">￥1,100(税込)</span><br>
							<span class="price-label">(1時間ごとではありません)</span>
						</p>
						<p>&nbsp;</p>
						<p>
							<span class="price-label">シーシャをご注文にならない場合<br>別途お通し代
							</span><span class="price-value">￥300(税込)</span><br> <span
								class="price-label">頂戴いたします。</span>
						</p>
					</div>
				</div>
			</div>
			<div class="system-detail-link">
				<p>詳しくはこちら</p>
			</div>
			<div class="more-btn-container">
				<button class="more-btn">MORE</button>
			</div>
		</section>

		<!-- Flavor セクション -->
		<section class="section flavor-section">
			<div class="section-title-container">
				<hr>
				<h1 class="section-title">Flavor</h1>
				<hr>
			</div>
			<div class="flavor-image">
				<img src="./image/assets/user/flavar.png" alt="フレーバー">
			</div>
			<div class="more-btn-container">
				<button class="more-btn">MORE</button>
			</div>
		</section>

		<!-- Drink セクション -->
		<section class="section drink-section">
			<div class="section-title-container">
				<hr>
				<h1 class="section-title">Drink</h1>
				<hr>
			</div>
			<div class="drink-content">
				<div class="drink-image">
					<img
						src="./image/assets/user/imgi_42_drinks_frankfurt-9d10b135.jpg"
						alt="ドリンク">
				</div>
				<div class="drink-text">
					<p>バーのみでもご利用いただける本格ドリンクをリーズナブルにご提供</p>
					<p>カクテル、ワイン、生ビール、サワーなど</p>
					<p>豊富なメニューを取り揃えています。</p>
				</div>
			</div>
			<div class="more-btn-container">
				<button class="more-btn">MORE</button>
			</div>
		</section>

		<!-- Food セクション -->
		<section class="section food-section">
			<div class="section-title-container">
				<hr>
				<h1 class="section-title">Food</h1>
				<hr>
			</div>
			<div class="food-content">
				<div class="food-text">
					<p>お酒やシーシャに合うスナックやフルーツを多数ご用意</p>
					<p>その他持ち込みOK!</p>
					<p>ご自分のシチュエーションに合わせてご注文ください</p>
				</div>
				<div class="food-image">
					<img src="./image/assets/user/imgi_58_obstplatte_frankfurt.jpg"
						alt="フード">
				</div>
			</div>
			<div class="more-btn-container">
				<button class="more-btn">MORE</button>
			</div>
		</section>

		<!-- Topics セクション -->
		<section class="section topics-section">
			<div class="section-title-container">
				<hr>
				<h1 class="section-title">Topics</h1>
				<hr>
			</div>
			<div class="topics-cards">
				<%
				// リストが存在するか(nullじゃないか)を先にチェックする
				if (topicsList != null && topicsList.size() != 0) {
					for (Topics t : topicsList) {
				%>
				<div class="topic-card">
					<div class="topic-card-header">
						<p><%=t.getTopicsTitle()%></p>
					</div>
					<div class="topic-card-image">
						<img src="./image/photo/<%=t.getPhotoId().getPhotoFileName()%>"
							alt="トピック1">
					</div>
				</div>
				<%
				}
				%>
				<%
				}
				%>
			</div>
			<div class="more-btn-container">
				<button class="more-btn">MORE</button>
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