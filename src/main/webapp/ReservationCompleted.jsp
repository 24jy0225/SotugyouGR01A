<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="model.Reservation , model.User , java.time.format.DateTimeFormatter , java.time.LocalDate , java.time.temporal.ChronoUnit"%>
<%
String action = (String)session.getAttribute("action");
User user = (User)session.getAttribute("LoginUser");
Reservation r = (Reservation) session.getAttribute("cancelReserve");

// --- 24時間表記の計算ロジック ---
java.time.LocalDateTime startDt = r.getStartDateTime();
java.time.LocalDateTime endDt = r.getEndDateTime();

int sHour = startDt.getHour();
int sMinute = startDt.getMinute();
java.time.LocalDate displayDate = startDt.toLocalDate();

// 0〜4時の場合は日付を1日戻し、時間を+24する
if (sHour < 5) {
	displayDate = displayDate.minusDays(1);
	sHour += 24;
}
String dateStr = displayDate.format(DateTimeFormatter.ofPattern("yyyy年MM月dd日"));
String startStr = String.format("%02d:%02d", sHour, sMinute);

// 終了時間の計算
int eHour = endDt.getHour();
int eMinute = endDt.getMinute();
if (eHour < 5) {
	eHour += 24;
}
String endStr = String.format("%02d:%02d", eHour, eMinute);
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="./image/assets/user/ロゴ完成_金色b.svg">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/reservation_completedStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<title>予約完了 - The Shisha Honjin</title>
</head>
<body>
	<!-- ヘッダー -->
	<header class="header" data-name="ヘッダー">
	<% if(action.equals("ByUser")){ %>
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
	<% } %>
	</header>
	<main>
		<!-- 予約登録システムタイトル -->
		<div class="system-title">
			<h1>予約登録システム</h1>
		</div>

		<!-- ステップインジケーター -->
		<div class="step_image">
			<img src="./image/assets/user/timepage.svg" alt="">
		</div>

		<!-- 予約完了カード -->
		<div class="completion-card">
			<div class="check-icon-wrapper">
				<img src="./image/assets/user/checkicon.svg" alt="">
			</div>
			<h2 class="completion-message">予約が完了しました!</h2>

			<div class="reservation-details">
				<p class="detail-item">
					日付:<%=dateStr%></p>
				<p class="detail-item">
					コース:<%=ChronoUnit.MINUTES.between(r.getStartDateTime(), r.getEndDateTime())%>分
				</p>
				<p class="detail-item">
					席番号:<%=r.getSeatId()%>番
				</p>
				<p class="detail-item">
					時間:<%=startStr%>〜<%=endStr%>
				</p>
			</div>
			<div>
				<% if(action.equals("ByUser")){%>
				<button onclick="location.href='UserController?command=MyPage'" class="reservation_compleated_send_mypage">MyPageへ</button>
				<% }else{ %>
				<a href="UserDetails.jsp">顧客情報画面に戻る</a>
				<% } %>
			</div>
			<div class="thank-you-message">
				<p>ご予約ありがとうございます。</p>
				<p>当日お待ちしております。</p>
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
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>