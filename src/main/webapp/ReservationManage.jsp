<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, java.time.format.DateTimeFormatter, model.Reservation, model.Seat"%>

<%
DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");

List<Reservation> list = (List<Reservation>) session.getAttribute("ReservationHistoryList");
List<Seat> seatList = (List<Seat>) session.getAttribute("Seat");

// 表示する時間軸の定義
String[] hours = {"20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "00:00", "00:30", "01:00",
		"01:30", "02:00", "02:30", "03:00", "03:30", "04:00"};
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/reservationStyle.css">
<title>管理者予約履歴</title>
<style>
	.reserved {
    /* border の代わりに box-shadow を使う */
    border: none !important; 
    box-shadow: inset 0 0 0 1px rgb(0,0,0) !important;
}
</style>

</head>
<body>
	<header>
		<nav class="nav-menu">
			<button onclick="location.href='ReservationManage.jsp'">予約管理</button>
			<button onclick="location.href='MemberManage.jsp'">顧客管理</button>
			<button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
			<button onclick="location.href='DesignCustom.jsp'">お知らせ管理</button>
			<button onclick="location.href='TopicsManage.jsp'">Webサイト管理</button>
		</nav>
	</header>

	<main class="main-content">
		<%-- メッセージ表示エリア --%>
		<%
		String msg = (String) session.getAttribute("message");
		if (msg != null) {
		%>
		<div
			style="color: white; text-align: center; background: #333; padding: 10px; margin-bottom: 10px;">
			<%=msg%>
		</div>
		<%
		session.removeAttribute("message");
		}
		%>

		<div id="controls-area">
			<label>予約スケジュール</label>
			<button class="date-nav-btn" onclick="prevDay()">&lt;</button>
			<input class="date-nav-btn" id="date-nav-input" type="date"
				value="2025-11-15" onchange="changeDate(this.value)">
			<button class="date-nav-btn" onclick="nextDay()">&gt;</button>
			<button class="date-nav-btn" id="date-nav-today" onclick="setToday()">今日</button>
		</div>

		<table class="schedule-table">
			<thead>
				<tr class="time-header">
					<th class="time-cell"></th>
					<%
					for (Seat s : seatList) {
					%>
					<th>座席<%=s.getSeatNumber()%></th>
					<%
					}
					%>
				</tr>
			</thead>
			<tbody>
				<%
				for (String h : hours) {
				%>
				<tr>
					<td class="time-cell"><%=h%></td>
					<%
					for (Seat s : seatList) {
					%>
					<td class="reservation-cell "
						data-seat="<%=s.getSeatId()%>" data-hour="<%=h%>" id="reservationIsEmpty"></td>
					<%
					}
					%>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</main>

	<script>
// JSPから渡されたデータをJS配列に変換
const reservations = [
    <%if (list != null) {
	for (Reservation r : list) {%>
        {
            id: "<%=r.getReserveId()%>",
            date: "<%=r.getStartDateTime().toLocalDate().format(dateFmt)%>",
            seatId: "<%=r.getSeatId()%>",
            start: "<%=r.getStartDateTime().toLocalTime().format(timeFmt)%>",
            end: "<%=r.getEndDateTime().toLocalTime().format(timeFmt)%>",
            name: "<%=r.getUserName()%>",
            count: <%=r.getReservePeople()%>
        },
    <%}
}%>
];
//初期引数

const hourList = ["20:00","20:30", "21:00","21:30", "22:00","22:30", "23:00","23:30", "00:00","00:30", "01:00","01:30", "02:00","02:30","03:00","03:30","04:00"];
let currentDate = new Date(); // 初期値（運用に合わせてnew Date()に変更してください）

function formatDate(d){
    return d.getFullYear() + "-" + String(d.getMonth() + 1).padStart(2, "0") + "-" + String(d.getDate()).padStart(2, "0");
}

// 補助関数: 時間を分に変換（深夜対応）
function getFixMin(timeStr) {
    const [h, m] = timeStr.split(":").map(Number);
    let total = h * 60 + m;
    if (h < 12) total += 1440; // 深夜は24時間加算
    return total;
}

function prevDay(){
    currentDate.setDate(currentDate.getDate() - 1);
    updateDateInput();
}

function nextDay(){
    currentDate.setDate(currentDate.getDate() + 1);
    updateDateInput();
}

function setToday(){
    currentDate = new Date();
    updateDateInput();
}

function changeDate(val){
    currentDate = new Date(val);
    paintDay();
}

function updateDateInput(){
    const ds = formatDate(currentDate);
    document.getElementById("date-nav-input").value = ds;
    paintDay();
}

function paintDay() {
	  const dateStr = formatDate(currentDate);

	  // 一旦リセット
	  document.querySelectorAll("td[data-seat]").forEach(td => {
	    td.innerHTML = "";
	    td.className = "reservation-cell";
	    td.rowSpan = 1;
	    td.style.display = ""; 
	  });

	  const cellMap = {};
	  document.querySelectorAll("td[data-seat]").forEach(td => {
	    const key = td.getAttribute("data-seat") + "_" + td.getAttribute("data-hour");
	    cellMap[key] = td;
	  });

	  reservations.forEach((r, idx) => {
	    // 【重要】営業日の判定
	    // 深夜0時から5時までの予約は「前日の夜からの営業」とみなす
	    let bDate = r.date;
	    const startH = parseInt(r.start.split(":")[0]);
	    if (startH < 6) {
	      let d = new Date(r.date);
	      d.setDate(d.getDate() - 1);
	      bDate = formatDate(d);
	    }

	    if (bDate !== dateStr) return;

	    // 時間の数値化
	    const startMin = getFixMin(r.start);
	    const endMin = getFixMin(r.end);
	    const span = (endMin - startMin) / 30; // 30分1コマなので30で割る

	    const startCell = cellMap[r.seatId + "_" + r.start];
	    if (startCell) {
	      const colorClass = "color-" + (idx % 3);
	      startCell.classList.add("reserved", colorClass);
	      startCell.rowSpan = span; // ここで結合！

	      // 表示内容
	      const diff = endMin - startMin;
	      const courseText = diff >= 60 ? (diff / 60) + "時間" : diff + "分";
	      startCell.innerHTML = `
	        <div class="reservation-info" >
	          <strong>\${r.name}</strong><br>
	          \${courseText} / \${r.count}名
	          <button type="button" class="delete-icon" onclick="deleteReservation('\${r.id}')">🗑️</button>
	        </div>
	      `;
	      

	      // 【重要】結合された下のセルを消すループ
	      for (let i = 1; i < span; i++) {
	        const currentTotalMin = startMin + (i * 30);
	        
	        // 分を "HH:mm" 形式の文字列に戻す
	        let h = Math.floor(currentTotalMin / 60);
	        if (h >= 24) h -= 24; // 24時なら00時、25時なら01時に変換
	        const m = currentTotalMin % 60;
	        const timeKey = String(h).padStart(2, '0') + ":" + String(m).padStart(2, '0');

	        const hiddenCell = cellMap[r.seatId + "_" + timeKey];
	        if (hiddenCell) {
	          hiddenCell.style.display = "none"; // 結合された部分を隠して表のズレを防ぐ
	        }
	      }
	    }
	  });
	}

function deleteReservation(reserveId) {
    if (!confirm('この予約を削除しますか？')) return;
    const params = new URLSearchParams();
    params.append("command", "reservationDelete");
    params.append("id", reserveId);

    fetch("AdminController", {
        method: "POST",
        body: params,
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
    })
    .then(response => {
        if (response.ok) {
            location.reload(); // 削除後はリストを再取得するためリロード推奨
        } else {
            alert("削除に失敗しました。");
        }
    });
}

// 初回実行
updateDateInput();
</script>
</body>
</html>