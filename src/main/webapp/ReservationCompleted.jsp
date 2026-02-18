<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="model.Reservation , java.time.format.DateTimeFormatter , java.time.LocalDate , java.time.temporal.ChronoUnit"%>
<%
Reservation r = (Reservation) session.getAttribute("Reservation");
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日");
DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="./image/assets/user/ロゴ完成_金色b.svg">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/reservation_completedStyle.css">
<title>予約完了 - The Shisha Honjin</title>
</head>
<body>
	<!-- ヘッダー -->
	<header class="systemheader" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.html'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo" class="logo">
		</div>
		<nav class="system-nav-menu">
			<a href="./login.html" class="nav-link">Login</a>
		</nav>
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
					日付:<%=r.getStartDateTime().format(formatter)%></p>
				<p class="detail-item">
					コース:<%=ChronoUnit.MINUTES.between(r.getStartDateTime(), r.getEndDateTime())%>分
				</p>
				<p class="detail-item">
					席番号:<%=r.getSeatId()%>番
				</p>
				<p class="detail-item">
					時間:<%=r.getStartDateTime().format(timeFormatter)%>〜
				</p>
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