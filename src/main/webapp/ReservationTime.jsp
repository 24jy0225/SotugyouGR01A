<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, java.util.ArrayList, model.User, java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%
String action = (String) session.getAttribute("action");
if (action == null)
	action = "ByUser";

List<LocalDateTime> slots = (List<LocalDateTime>) session.getAttribute("timeList");
if (slots == null)
	slots = new ArrayList<>();

String date = (String) session.getAttribute("date");
if (date == null)
	date = "未選択";

// 一旦Objectで受けてから、nullなら0を代入（これでコンパイルエラーが消えます）
Object courseObj = session.getAttribute("Course");
int course = (courseObj != null) ? (int) courseObj : 0;

Object seatObj = session.getAttribute("seatId");
int seatId = (seatObj != null) ? (int) seatObj : 0;

User user = (User) session.getAttribute("LoginUser");
User targetUser = (User) session.getAttribute("targetUser");

String formAction = "ByAdmin".equals(action) ? "AdminController" : "UserController";
String buttonText = (user != null || ("ByAdmin".equals(action) && targetUser != null)) ? "この内容で予約する" : "ログイン画面へ";
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>予約登録システム - 時間選択</title>
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/reservation_timeStyle.css">
<link rel="icon" href="../assets/ロゴ完成_金色b.svg">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<style>

/* ラジオボタンをボタン形式のデザインにするための調整 */
.time_slot_input {
	display: none;
}

.time_slot {
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}
/* 選択された時のスタイル（CSSがすでにあれば不要ですが、念のため） */
.time_slot_input:checked+.time_slot {
	background-color: #d4af37;
	color: white;
	border-color: #d4af37;
}

.people_input_area {
	margin: 20px 0;
	text-align: center;
}

.people_input_area input {
	padding: 5px;
	width: 60px;
}
</style>
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
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> <a
				href="./how_to_Use.jsp" class="nav-link">Use</a> <a
				href="./system-introduction.jsp" class="nav-link">System</a> <a
				href="./menu.jsp" class="nav-link">Menu</a> <a href="./topics.jsp"
				class="nav-link">Topics</a> <a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
			<%
			if (user != null) {
			%>
			<div class="nav-member-group">
				<a href="UserController?command=MyPage" class="nav-link">Member</a>
				<a href="UserController?command=logout" class="nav-logout-link">logout</a>
			</div>
			<%
			} else {
			%>
			<a href="./Login.jsp" class="nav-link">Login</a>
			<%
			}
			%>
		</nav>
		<!-- スマホ用ナビゲーション -->
		<nav class="mobile-nav" id="mobileNav">
			<a href="./whats_Shisha.jsp" class="mobile-nav-link">What's</a> <a
				href="./how_to_Use.jsp" class="mobile-nav-link">Use</a> <a
				href="./system-introduction.jsp" class="mobile-nav-link">System</a>
			<a href="./menu.jsp" class="mobile-nav-link">Menu</a> <a
				href="./topics.jsp" class="mobile-nav-link">Topics</a> <a
				href="./contact.jsp" class="mobile-nav-link">Contact</a> <a
				href="UserController?command=reservationDate"
				class="mobile-nav-link">Reservation</a>
			<%
			if (user != null) {
			%>
			<a href="UserController?command=MyPage" class="mobile-nav-link">Member</a>
			<a href="UserController?command=logout"
				class="mobile-nav-link mobile-nav-logout">Logout</a>
			<%
			} else {
			%>
			<a href="./Login.jsp" class="mobile-nav-link">Login</a>
			<%
			}
			%>
		</nav>
		<%
		}
		%>
	</header>

	<main>
		<div class="container">
			<div class="step_indicator">
				<h2>予約登録</h2>
				<div class="step_image">
					<img src="./image/assets/user/timepage.svg" alt="">
				</div>
			</div>

			<div class="time_selection_area">
				<h3>時間を選択してください</h3>
				<div class="selection_info">
					<p>
						選択日:<%=date%></p>
					<p>
						コース:<%=course%>分のコース
					</p>
					<p>
						座席番号:<%=seatId%>番
					</p>
				</div>

				<form action="<%=formAction%>" method="post" id="reservationForm">
					<input type="hidden" name="command" value="Reserve">

					<div class="time_slots">
						<%
						if (slots != null && !slots.isEmpty()) {
							for (LocalDateTime timeSlot : slots) {
								int hour = timeSlot.getHour();
								int minute = timeSlot.getMinute();
								String timeStr;

								// ★ 0時〜4時台の場合は +24 して「24:00〜28:59」表記にする
								if (hour < 5) {
							timeStr = String.format("%02d:%02d", hour + 24, minute);
								} else {
							timeStr = String.format("%02d:%02d", hour, minute);
								}
						%>
						<label> <input type="radio" name="selectedTime"
							value="<%=timeSlot%>" class="time_slot_input"
							data-display="<%=timeStr%>" required>
							<div class="time_slot">
								<img src="./image/assets/user/timeicon.svg" alt="時計"> <span><%=timeStr%></span>
							</div>
						</label>
						<%
						}
						} else {
						%>
						<div class="no-slots-message"
							style="color: #ff4d4d; text-align: center; padding: 20px; grid-column: 1/-1;">
							<p>申し訳ございません。選択された条件で予約可能な時間枠がありません。</p>
							<p>別の日付、コース、または席を選択し直してください。</p>
						</div>
						<%
						}
						%>
					</div>

					<div class="people_input_area">
						人数: <input type="number" name="people" value="1" max="4" min="1"
							required> 名様
					</div>

					<div class="reservation_confirmation">
						<h4>予約内容の確認</h4>
						<div class="confirmation_details">
							<p>
								日付:<%=date%></p>
							<p>
								コース:<%=course%>分のコース
							</p>
							<p>
								座席番号:<%=seatId%>番
							</p>
							<p>
								開始時間:<span id="display-start-time">--:--</span>
							</p>
							<p>
								終了予定時間:<span id="display-end-time">--:--</span>
							</p>
						</div>
						<%
						if (!slots.isEmpty() && slots != null) {
						%>
						<button type="submit" class="confirm_button"><%=buttonText%></button>
						<%
						}
						%>
					</div>
				</form>

				<a href="#" class="back_link"
					onclick="history.back(); return false;">← 席選択に戻る</a>
			</div>

			<button class="restart_button"
				onclick="location.href='UserController?command=reservationDate'">最初からやり直す</button>
		</div>
	</main>
	<footer>
		<p>
			<small>&copy;The Shisha Honjin</small>
		</p>
	</footer>

</body>
<script>
    const radioButtons = document.querySelectorAll('.time_slot_input');
    const startDisplay = document.getElementById('display-start-time');
    const endDisplay = document.getElementById('display-end-time');
    
    const courseMinutes = <%=course%>;

    radioButtons.forEach(radio => {
        radio.addEventListener('change', () => {
            const startTimeStr = radio.getAttribute('data-display');
            startDisplay.textContent = startTimeStr;

            if (startTimeStr) {
                // "25:30" などの文字列を数値(hour: 25, minute: 30)に分割
                const [hours, minutes] = startTimeStr.split(':').map(Number);
                
                // ★ 24時間超過表記を維持するため、JSのDateを使わずに「分」だけで計算する
                const totalMinutes = (hours * 60) + minutes + courseMinutes;
                
                const endHours = Math.floor(totalMinutes / 60);
                const endMinutes = totalMinutes % 60;
                
                // 0埋めして表示（例: 25:30 + 120分 = 27:30）
                endDisplay.textContent = 
                    String(endHours).padStart(2, '0') + ':' + 
                    String(endMinutes).padStart(2, '0');
            }
        });
    });
</script>
</html>
<script type="text/javascript" src="../javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>