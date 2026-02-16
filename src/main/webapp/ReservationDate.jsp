<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Map , model.User"%>
<%
// セッションから権限を取得
String action = (String) session.getAttribute("action");
if (action == null)
	action = "ByUser";

User user = (User) session.getAttribute("LoginUser");

// Actionから渡されたステータスデータを受け取る
Map<String, String> statusData = (Map<String, String>) request.getAttribute("statusData");


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>席予約</title>
<link rel="stylesheet" href="./css/user/mainstyles.css">
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>

<style>
/* ページ全体のベース設定 */
body {
	background-color: #111;
	margin: 0;
	padding: 0;
	font-family: "Helvetica Neue", Arial, sans-serif;
	color: #fff;
}

/* レイアウト崩れ防止：メインコンテンツを中央に配置 */
main {
	display: block !important;
	width: 100%;
	padding: 20px 0;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

/* --- ステップインジケーターのスタイル --- */
.step_indicator {
	text-align: center;
	margin-bottom: 40px;
	margin-top: 20px;
}

.step_indicator h2 {
	font-size: 20px;
	font-weight: normal;
	margin-bottom: 20px;
	color: #FFFFFF;
}

.step_image {
	display: flex;
	justify-content: center;
	align-items: center;
}

.step_image img {
	max-width: 100%;
	height: auto;
}

/* --- カレンダーのスタイル --- */
#calendar-container {
	max-width: 800px;
	margin: 0 auto 40px;
	background-color: #fff;
	padding: 25px;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
	color: #333;
}

/* フルカレンダー内部の調整 */
.fc-daygrid-day-frame {
	margin: 3px;
	border-radius: 8px;
	min-height: 90px !important;
	background-color: #f9f9f9;
	transition: 0.2s;
}

.fc-daygrid-day-top {
	display: flex !important;
	flex-direction: column !important;
	align-items: center !important;
	padding-top: 10px !important;
}

.status-label {
	display: inline-block;
	padding: 2px 8px;
	font-size: 0.65em;
	border-radius: 4px;
	font-weight: bold;
	margin-top: 4px;
}

/* 各ステータスの色 */
.is-available {
	background-color: #f0fdf4 !important;
	border: 2px solid lightgreen !important;
}

.is-available:hover {
	transform: translateY(-3px);
}

.status-available {
	background-color: #d1fae5;
	color: #059669;
}

.is-warning {
	background-color: #fff7ed !important;
	border: 2px solid #fdba74 !important;
}

.status-warning {
	background-color: #ffedd5;
	color: #ea580c;
}

.is-full {
	background-color: #fee2e2 !important;
	border: 2px solid #fca5a5 !important;
}

.status-full {
	background-color: #fecaca;
	color: #b91c1c;
}

.is-today {
	background-color: #eff6ff !important;
	border: 2px solid #3b82f6 !important;
}

.is-disabled {
	background-color: #eeeeee !important;
	opacity: 0.4;
}

.legend {
	display: flex;
	justify-content: center;
	gap: 15px;
	margin-top: 20px;
	font-size: 0.8em;
	color: #777;
}

.legend-item {
	display: flex;
	align-items: center;
	gap: 5px;
}

.box {
	width: 12px;
	height: 12px;
	border-radius: 2px;
}
</style>
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
	
	<main>
		<div class="container">
			<div class="step_indicator">
				<h2>予約登録システム</h2>
				<div class="step_image">
					<img src="./image/assets/user/coursepage.svg" alt="ステップ">
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
					<%if (statusData != null && !statusData.isEmpty()) {
	for (java.util.Map.Entry<String, String> entry : statusData.entrySet()) {%>
							"<%=entry.getKey()%>": "<%=entry.getValue()%>",
							<%}
}%>
					};
					
					function formatDate(date) {
						if (!date) return "";
						// 日本時間に合わせた yyyy-mm-dd を確実に作る
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
							
							let statusClass = "is-available"; // デフォルトは緑
							let labelText = "空席あり"; // デフォルトの文字
							
							// A. 過去または期間外の判定（最優先）
							if (cellDateZero < todayZero || cellDateZero > end) {
								frame.classList.add('is-disabled');
								return; // 描画不要な日はここで終了
							}
							
							// B. 本日の判定
							if (cellDateZero.getTime() === todayZero.getTime()) {
								statusClass = 'is-today';
								labelText = '本日';
								// ※もし本日も満席表示などをしたい場合は、ここに判定を追加します
							} 
							// C. 予約可能期間（明日〜14日後）の判定
							else {
								// ★修正ポイント：ロジックを整理しました
								// 1. まず生のデータを取得
								const status = dbStatusData[dateStr];
								
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