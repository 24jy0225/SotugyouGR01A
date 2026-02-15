<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, java.util.ArrayList, model.User, java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%
String action = (String) session.getAttribute("action");
if (action == null)
	action = "ByUser";

List<LocalDateTime> slots = (List<LocalDateTime>) session.getAttribute("timeList");
if (slots == null)
	slots = new ArrayList<>(); // Null落ち防止

String date = (String) session.getAttribute("date");
if (date == null)
	date = "未選択";

String course = (String) session.getAttribute("course");
if (course == null)
	course = "0"; // JavaScript計算用に0を入れておく

String seatId = (String) session.getAttribute("seatId");
if (seatId == null)
	seatId = "-";

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
	<!-- ヘッダー -->
    <header class="systemheader" data-name="ヘッダー">
        <div class="logos" id="logo" onclick="location.href='./top.html'">
            <img src="../assets/ロゴタイプ_金色b.svg" alt="logo" class="logo">
        </div>
        <nav class="system-nav-menu">
            <a href="./login.html" class="nav-link">Login</a>
        </nav>
    </header>
	<main>
		<div class="container">
			<div class="step_indicator">
				<h2>予約登録システム</h2>
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
					<input type="hidden" name="command" value="Confirm">

					<div class="time_slots">
						<%
						DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
						if (slots != null) {
							for (LocalDateTime timeSlot : slots) {
								String timeStr = timeSlot.format(timeFormatter);
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
						<button type="submit" class="confirm_button"><%=buttonText%></button>
					</div>
				</form>

				<a href="#" class="back_link"
					onclick="history.back(); return false;">← 席選択に戻る</a>
			</div>

			<button class="restart_button" onclick="location.href='./top.jsp'">最初からやり直す</button>
		</div>
	</main>
	<footer>
        <p><small>&copy;The Shisha Honjin</small></p>
    </footer>
	<script>
        // 時間が選ばれたら下の確認欄を更新するスクリプト
        const radioButtons = document.querySelectorAll('.time_slot_input');
        const startDisplay = document.getElementById('display-start-time');
        const endDisplay = document.getElementById('display-end-time');
        const courseMinutes = <%=course != null ? course : "0"%>;

        radioButtons.forEach(radio => {
            radio.addEventListener('change', () => {
                const startTimeStr = radio.getAttribute('data-display');
                startDisplay.textContent = startTimeStr;

                // 終了時間の計算
                if (startTimeStr) {
                    const [hours, minutes] = startTimeStr.split(':').map(Number);
                    const startDate = new Date();
                    startDate.setHours(hours, minutes, 0);
                    
                    const endDate = new Date(startDate.getTime() + courseMinutes * 60000);
                    const endHours = String(endDate.getHours()).padStart(2, '0');
                    const endMinutes = String(endDate.getMinutes()).padStart(2, '0');
                    
                    endDisplay.textContent = endHours + ':' + endMinutes;
                }
            });
        });
    </script>
</body>
</html>
<script type="text/javascript" src="../javascript/logoScript.js"></script>