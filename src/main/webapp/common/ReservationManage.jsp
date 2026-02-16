<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, java.time.format.DateTimeFormatter, model.Reservation, model.Seat"%>

<%
DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");

List<Reservation> list = (List<Reservation>) session.getAttribute("ReservationHistoryList");
List<Seat> seatList = (List<Seat>) session.getAttribute("Seat");

// 表示する時間軸の定義（JS側でも共通で利用）
String[] hours = {"20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "00:00", "00:30", "01:00",
		"01:30", "02:00", "02:30", "03:00", "03:30", "04:00"};
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/admin/adminStyle.css">
<link rel="stylesheet" href="./css/admin/adminReservationStyle.css">
<title>管理者予約管理</title>
<style>
.reserved {
	border: none !important;
	box-shadow: inset 0 0 0 1px rgb(0, 0, 0) !important;
}
/* 削除成功時のフェードアウト用（オプション） */
.fade-out {
	opacity: 0;
	transition: opacity 0.5s ease;
}
</style>
</head>
<body>
	<header>
		<nav class="nav-menu">
			<button onclick="location.href='ReservationManage.jsp'">予約管理</button>
			<button onclick="location.href='UserManage.jsp'">顧客管理</button>
			<button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
			<button onclick="location.href='DesignCustom.jsp'">お知らせ管理</button>
			<button onclick="location.href='TopicsManage.jsp'">Webサイト管理</button>
		</nav>
	</header>

	<main class="main-content">
		<%-- メッセージ表示エリア（HTMLミス修正済み） --%>
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
				onchange="changeDate(this.value)">
			<button class="date-nav-btn" onclick="nextDay()">&gt;</button>
			<button class="date-nav-btn" id="date-nav-today" onclick="setToday()">今日</button>

			<button class="date-nav-btn" onclick="refreshKeepDate()"id="date-nav-today" >更新</button>
			<a href="AdminSeat.jsp" >席管理</a>
		</div>

		<table class="schedule-table">
			<thead>
				<tr class="time-header">
					<th class="time-cell"></th>
					<%
					if (seatList != null) {
						for (Seat s : seatList) {
					%>
					<th>座席<%=s.getSeatNumber()%></th>
					<%
					}
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
					if (seatList != null) {
						for (Seat s : seatList) {
					%>
					<td class="reservation-cell" data-seat="<%=s.getSeatId()%>"
						data-hour="<%=h%>"></td>
					<%
					}
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
// 1. JSPから渡されたデータを保持
let reservations = [
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

// 時間軸配列
const hourList = [<%for (int i = 0; i < hours.length; i++) {%>"<%=hours[i]%>"<%=i < hours.length - 1 ? "," : ""%><%}%>];
let currentDate = new Date(); // ここは初期値。onloadで書き換わります

function formatDate(d){
    return d.getFullYear() + "-" + String(d.getMonth() + 1).padStart(2, "0") + "-" + String(d.getDate()).padStart(2, "0");
}

function refreshKeepDate() {
    const selectedDate = document.getElementById("date-nav-input").value;
    
    // JSPを直接開くのではなく、Controllerを経由させる
    // これにより、Java側で DBからの最新取得(execute) が走り、セッションが新しくなります
    location.href = "AdminController?command=reservationManage&refDate=" + selectedDate;
}

function prevDay(){ currentDate.setDate(currentDate.getDate() - 1); updateDateInput(); }
function nextDay(){ currentDate.setDate(currentDate.getDate() + 1); updateDateInput(); }
function setToday(){ 
    // 今日ボタンを押したときは、URLのパラメータを消してリロードするのが確実です
	location.href = "AdminController?command=reservationManage";
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

// 描画ロジック
function paintDay() {
    const dateStr = formatDate(currentDate);
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
        let bDate = r.date;
        const startH = parseInt(r.start.split(":")[0]);
        if (startH < 6) {
            let d = new Date(r.date);
            d.setDate(d.getDate() - 1);
            bDate = formatDate(d);
        }

        if (bDate !== dateStr) return;

        const startIndex = hourList.indexOf(r.start);
        const endIndex = hourList.indexOf(r.end);
        if (startIndex === -1) return;

        const effectiveEndIndex = (endIndex === -1) ? hourList.length : endIndex;
        const span = effectiveEndIndex - startIndex;

        const startCell = cellMap[r.seatId + "_" + r.start];
        if (startCell && span > 0) {
            const colorClass = "color-" + (idx % 3);
            startCell.classList.add("reserved", colorClass);
            startCell.rowSpan = span;

            startCell.innerHTML = `
                <div class="reservation-info">
                    <strong>\${r.name}</strong><br>
                    \${r.count}名 / \${r.start}-\${r.end}
                    <button type="button" class="delete-icon" onclick="deleteReservation('\${r.id}')">🗑️</button>
                </div>
            `;

            for (let i = 1; i < span; i++) {
                const nextTime = hourList[startIndex + i];
                const hiddenCell = cellMap[r.seatId + "_" + nextTime];
                if (hiddenCell) hiddenCell.style.display = "none";
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
            reservations = reservations.filter(r => r.id !== reserveId);
            paintDay();
        } else {
            alert("削除に失敗しました。");
        }
    });
}

// ★★★ ページ読み込み時の初期化処理（ここがキモ） ★★★
window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    const refDate = urlParams.get('refDate');

    if (refDate) {
        // URLに日付があればそれをセット
        currentDate = new Date(refDate);
    } else {
        // なければ今日
        currentDate = new Date();
    }
    updateDateInput();
};
</script>
</body>
</html>