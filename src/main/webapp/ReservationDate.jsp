<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Map , model.User"%>
<%
// セッションから権限を取得
String action = (String) session.getAttribute("action");
if (action == null)
	action = "ByUser";

User user = (User) session.getAttribute("LoginUser");

// Actionから渡されたステータスデータ(席の状況)を受け取る
Map<String, String> statusData = (Map<String, String>) request.getAttribute("statusData");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>席予約</title>
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/Reservation_DateStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'>
</script>
</head>
<body>
	<header class="header" data-name="ヘッダー">
		<%
		if (action.equals("ByUser")) {
		%>
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo"
				class="logo">
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
		<div class="container">
			<div class="step_indicator">
				<h2>予約登録</h2>
				<div class="step_image">
					<img src="./image/assets/user/daypage.svg" alt="ステップ">
				</div>
			</div>

			<div id="calendar-container">
				<h3 style="text-align: center; margin-bottom: 20px;">日付を選択してください</h3>
				<div id='calendar'></div>

				<div class="legend">
					<div class="legend-item">
						<div class="box"
							style="background: #f0fdf4; border: 1px solid lightgreen;"></div>
						空席あり
					</div>
					<div class="legend-item">
						<div class="box"
							style="background: #fff7ed; border: 1px solid #fdba74;"></div>
						残りわずか
					</div>
					<div class="legend-item">
						<div class="box"
							style="background: #fee2e2; border: 1px solid #fca5a5;"></div>
						満席
					</div>
					<div class="legend-item">
						<div class="box"
							style="background: #eff6ff; border: 1px solid #3b82f6;"></div>
						本日(予約不可)
					</div>
				</div>
			</div>
		</div>
	</main>

	<script>
			document.addEventListener('DOMContentLoaded', function() {
				// 1. JavaのMapをJavaScriptのオブジェクトに変換
				const dbStatusData = {
						<%if (statusData != null && !statusData.isEmpty()) {%>
							<%for (java.util.Map.Entry<String, String> entry : statusData.entrySet()) {%>
								"<%=entry.getKey()%>": "<%=entry.getValue()%>",
							<%}%>
						<%}%>
					};

				 console.log("受け取ったデータ:", dbStatusData);
				
					function formatDate(date) {
						if (!date) return "";
						// 日本時間に合わせた yyyy-mm-dd
						const offset = date.getTimezoneOffset();
						const d = new Date(date.getTime() - (offset * 60 * 1000));
						return d.toISOString().split('T')[0];
					}
					
					var calendarEl = document.getElementById('calendar');
					var calendar = new FullCalendar.Calendar(calendarEl, {
						initialView: 'dayGridMonth',
						locale: 'ja',
						height: 'auto',
						headerToolbar: { left: 'prev', center: 'title', right: 'next' },
						dayCellContent: function(arg) { return arg.date.getDate(); },
						
						// カレンダーのセルが描画される時の処理
						dayCellDidMount: function(info) {
							const today = new Date();
							// 時間を00:00:00に揃えて日付のみで比較できるようにする
							const todayZero = new Date(today.getFullYear(), today.getMonth(), today.getDate());
							const start = new Date(todayZero); start.setDate(todayZero.getDate() + 1);
							const end = new Date(todayZero); end.setDate(todayZero.getDate() + 14);
							
							const cellDate = new Date(info.date);
							// 比較用に時間をリセット
							const cellDateZero = new Date(cellDate.getFullYear(), cellDate.getMonth(), cellDate.getDate());
							const dateStr = formatDate(cellDate); // "yyyy-mm-dd"
							
							const frame = info.el.querySelector('.fc-daygrid-day-frame');
							const topElement = info.el.querySelector('.fc-daygrid-day-top');
							
							let statusClass = "is-available"; // 文字の初期値
							let labelText = "空席あり"; // 色の初期値
							
							// 可能期間外の判定
							if (cellDateZero < todayZero || cellDateZero > end) {
								frame.classList.add('is-disabled');
								return;S
							}
							
							// 本日の判定
							if (cellDateZero.getTime() === todayZero.getTime()) {
								statusClass = 'is-today';
								labelText = '本日';
							} 
							
							// 可能期間の判定
							else {
								const status = dbStatusData[dateStr];
								console.log(status);
								// 2. データに基づいて色と文字を決定
								if (status === 'is-full'){ 
									statusClass = 'is-full';
									labelText = '満席';
								} else if (status === 'is-warning'){
									statusClass = 'is-warning';
									labelText = '残りわずか';
								}
								
								
							} 
							
							// スタイルの適用とラベルの生成
							frame.classList.add(statusClass);
							const label = document.createElement('span');
							// CSSに合わせてクラス名を補正 (is-full -> status-full)
							label.className = 'status-label ' + statusClass.replace('is-', 'status-');
							label.innerText = labelText;
							topElement.appendChild(label);
						},
						
						// 日付クリック時の処理
						dateClick: function(info) {
							const clickedDate = info.date;
							const dateStr = info.dateStr;
							const today = new Date();
							const todayZero = new Date(today.getFullYear(), today.getMonth(), today.getDate());
							const start = new Date(todayZero); start.setDate(todayZero.getDate() + 1);
							const end = new Date(todayZero); end.setDate(todayZero.getDate() + 14);
							const clickedDateZero = new Date(clickedDate.getFullYear(), clickedDate.getMonth(), clickedDate.getDate());
							
							if (clickedDateZero.getTime() === todayZero.getTime()) {
								alert("当日の予約はできません。");
								return;
							}
							if (clickedDateZero < start || clickedDateZero > end) {
								alert("予約できる日付は【明日から2週間以内】です。");
								return;
							}
							
							// 満席の場合は予約不可
							if (dbStatusData[dateStr] === 'is-full') {
								alert("申し訳ございません。この日は満席です。");
								return;
							}
							
							const action = "<%=action%>";
							const controller = (action === "ByUser") ? "UserController" : "AdminController";
							window.location.href = controller + "?date=" + info.dateStr + "&command=Course";
						}
					});
					
					calendar.render();
				});
			</script>
	<footer>
		<p>
			<small>&copy;The Shisha Honjin</small>
		</p>
	</footer>
</body>
</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>