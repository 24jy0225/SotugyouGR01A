<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.Map"%>
<%
// セッションから権限を取得
String action = (String) session.getAttribute("action");
if (action == null)
	action = "ByUser";

// Actionから渡されたステータスデータを受け取る
Map<String, String> statusData = (Map<String, String>) request.getAttribute("statusData");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>席予約</title>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>

<style>
/* CSSは変更なし */
body {
	background-color: #111;
	margin: 0;
	padding: 0;
	font-family: "Helvetica Neue", Arial, sans-serif;
}

#calendar-container {
	max-width: 800px;
	margin: 40px auto;
	background-color: #fff;
	padding: 25px;
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
	color: #333;
}

.fc-daygrid-day {
	border: none !important;
}

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
	justify-content: center !important;
	align-items: center !important;
	padding-top: 15px !important;
}

.fc-daygrid-day-number {
	float: none !important;
	padding: 0 !important;
	font-size: 1.1em;
	color: #333;
	font-weight: bold;
	margin-bottom: 4px;
}

.fc-day-today {
	background-color: #ffffff !important;
}

.status-label {
	display: inline-block;
	padding: 2px 8px;
	font-size: 0.65em;
	border-radius: 4px;
	font-weight: bold;
	margin-top: 4px;
}

.is-available {
	background-color: #f0fdf4 !important;
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

.fc-toolbar-title {
	font-size: 1.2em !important;
	color: #444;
}

.fc-button-primary {
	background-color: #374151 !important;
	border: none !important;
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

	<div id="calendar-container">
		<h3 style="text-align: center; margin-bottom: 20px;">日付を選択してください</h3>
		<div id='calendar'></div>

		<div class="legend">
			<div class="legend-item">
				<div class="box"
					style="background: #f0fdf4; border: 1px solid #d1fae5;"></div>
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
// 確認用：ブラウザのF12コンソールにこれが出るか見てください
console.log("受け取ったデータ:", dbStatusData);

	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        locale: 'ja',
	        height: 'auto',
	        headerToolbar: { left: 'prev', center: 'title', right: 'next' },
	        dayCellContent: function(arg) { return arg.date.getDate(); },

	        dayCellDidMount: function(info) {
	            const today = new Date();
	            const todayZero = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	            const start = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
	            const end = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 14);
	            const cellDate = info.date;
	            const dateStr = info.dateStr; // "yyyy-mm-dd"
	            
	            const frame = info.el.querySelector('.fc-daygrid-day-frame');
	            const topElement = info.el.querySelector('.fc-daygrid-day-top');

	            let statusClass = "";
	            let labelText = "";

	            // A. 本日の判定
	            if (cellDate.getTime() === todayZero.getTime()) {
	                statusClass = 'is-today';
	            } 
	            // B. 予約可能期間（明日〜14日後）の判定
	            else if (cellDate >= start && cellDate <= end) {
	                // Mapからステータスを取得。2月7日なら "is-full" が入るはず
	                statusClass = dbStatusData[dateStr] || "is-available";
	                
	                if (statusClass === 'is-full'){ 
		                labelText = '満席';
	                }else if (statusClass === 'is-warning'){
		                 labelText = '残りわずか';
	                }else{
		                 labelText = '空席あり';
	                }
	                console.log(statusClass);
		 	    } 
	            // C. 過去または期間外
	            else {
	                frame.classList.add('is-disabled');
	                return; // 描画不要な日はここで終了
	            }

	            // スタイルの適用とラベルの生成
	            frame.classList.add(statusClass);
	            const label = document.createElement('span');
	            // CSSに合わせてクラス名を補正 (is-full -> status-full)
	            label.className = 'status-label ' + statusClass.replace('is-', 'status-');
	            label.innerText = labelText;
	            topElement.appendChild(label);
	        },

	        dateClick: function(info) {
	            const clickedDate = info.date;
	            const dateStr = info.dateStr;
	            const today = new Date();
	            const todayZero = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	            const start = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
	            const end = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 14);

	            if (clickedDate.getTime() === todayZero.getTime()) {
	                alert("当日の予約はできません。");
	                return;
	            }
	            if (clickedDate < start || clickedDate > end) {
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
	            window.location.href = controller + "?date=" + info.dateStr + "&command=Cource";
	        }
	    });

	    calendar.render();
	});
</script>
</body>
</html>