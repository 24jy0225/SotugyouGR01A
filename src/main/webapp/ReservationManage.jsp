<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, java.time.format.DateTimeFormatter , model.Reservation , model.Seat"%>

<%
DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");

List<Reservation> list = (List<Reservation>) session.getAttribute("ReservationHistoryList");
List<Seat> seatList = (List<Seat>) session.getAttribute("Seat");

String[] hours = {"20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "00:00", "00:30", "01:00",
		"01:30", "02:00", "02:30", "03:00", "03:30"};
%>

<html>
<head>
<meta charset="UTF-8">
<title>席予約</title>
<%
String msg = (String) session.getAttribute("message");
if (msg != null) {
%>
    <div style="color: yellow; text-align: center; background: #444; padding: 10px;">
        <%= msg %>
    </div>
<%
    // 一度表示したら消す（出しっぱなし防止）
    session.removeAttribute("message");
}
%>
<style>
body {
	background-color: #2c2c2c;
	font-family: "Helvetica Neue", Arial, sans-serif;
	color: #333;
}

#dateLabel {
	color: white;
	text-align: center;
}

/* テーブルのスタイル */
table {
	background: white;
	border-collapse: collapse;
	margin: 20px auto;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
}

th, td {
	border: 1px solid #ddd;
	width: 80px;
	height: 45px;
	text-align: center;
	font-size: 11px;
	position: relative; /* ゴミ箱配置用 */
}

th {
	background: #f4f4f4;
	color: #555;
}

/* 予約済みセルの色（お手本に合わせた3色） */
.reserved.color-0 {
	background-color: #f5d5b5;
} /* ベージュ */
.reserved.color-1 {
	background-color: #d1e8f5;
} /* 水色 */
.reserved.color-2 {
	background-color: #d1f5d1;
} /* 薄緑 */
.reserved {
	border: none !important;
	color: #444;
	vertical-align: middle;
	line-height: 1.3;
}

/* ゴミ箱アイコン */
.delete-icon {
    opacity: 0.6;
    transition: opacity 0.2s;
}
.delete-icon:hover {
    opacity: 1.0;
    transform: scale(1.2); /* 少し大きくしてクリックしやすく */
}
</style>
</head>

<body>

	<h3 id="dateLabel"></h3>
	<button onclick="prevDay()">←</button>
	<button onclick="nextDay()">→</button>

	<table>
		<thead>
			<tr>
				<th>時間</th>
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
				<th><%=h%></th>
				<%
				for (Seat s : seatList) {
				%>
				<td data-seat="<%=s.getSeatId()%>" data-hour="<%=h%>"></td>
				<%
				}
				%>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<script>
const hourList = ["20:00","20:30", "21:00","21:30", "22:00","22:30", "23:00","23:30", "00:00","00:30", "01:00","01:30", "02:00","02:30", "03:00","03:30"];

const reservations = [
<%for (Reservation r : list) {%>
{
  id: "<%= r.getReserveId() %>",
  date: "<%=r.getStartDateTime().toLocalDate().format(dateFmt)%>",
  seatId: "<%=r.getSeatId()%>",
  start: "<%=r.getStartDateTime().toLocalTime().format(timeFmt)%>",
  end: "<%=r.getEndDateTime().toLocalTime().format(timeFmt)%>",
  name: "<%=r.getUserName()%>",
  count: <%=r.getReservePeople()%>
},
<%}%>
];

let currentDate = new Date();

function formatDate(d){
  return d.getFullYear()+"-"+String(d.getMonth()+1).padStart(2,"0")+"-"+String(d.getDate()).padStart(2,"0");
}

function prevDay(){
  currentDate.setDate(currentDate.getDate()-1);
  paintDay();
}

function nextDay(){
  currentDate.setDate(currentDate.getDate()+1);
  paintDay();
}

function toMin(t){
  if(!t) return 0;
  const [h,m]=t.split(":").map(Number);
  return h*60+m;
}

function getFixMin(timeStr) {
  let m = toMin(timeStr);
  if (m < 12 * 60) m += 1440; 
  return m;
}

function getCourseName(start, end) {
  const s = getFixMin(start);
  const e = getFixMin(end);
  const diff = e - s; 

  if (diff >= 60) {
    const hours = diff / 60;
    return hours + "時間コース";
  } else {
    return diff + "分コース";
  }
}

function paintDay() {
  const dateStr = formatDate(currentDate);
  document.getElementById("dateLabel").innerText = dateStr;

  const cellMap = {};
  document.querySelectorAll("td[data-seat]").forEach(td => {
    td.innerHTML = "";
    td.className = ""; 
    const key = td.getAttribute("data-seat") + "_" + td.getAttribute("data-hour");
    cellMap[key] = td;
  });

  reservations.forEach((r, idx) => {
    let businessDate = r.date;
    if (toMin(r.start) < 12 * 60) {
      let d = new Date(r.date);
      d.setDate(d.getDate() - 1);
      businessDate = formatDate(d);
    }

    if (businessDate !== dateStr) return;

    const colorClass = "color-" + (idx % 3);

    hourList.forEach(h => {
      const s = getFixMin(r.start);
      const e = getFixMin(r.end);
      const slot = getFixMin(h);

      if (slot >= s && slot < e) {
        const targetCell = cellMap[r.seatId + "_" + h];
        if (targetCell) {
          targetCell.classList.add("reserved", colorClass);

          if (h === r.start) {
            const courseText = getCourseName(r.start, r.end);
            targetCell.innerHTML = `
              <div>会員番号<p>\${r.id}</p></div>
              <div style="font-weight:bold;">\${r.name}</div>
              <div>会員</div>
              <div style="color: #d63384; font-weight: bold;">\${courseText}</div>
              <div>\${r.count}人</div>
            `;
          }

          // 30分後の枠が終了時間ならゴミ箱を表示
          if (slot + 30 === e) {
            targetCell.innerHTML += `
				<form action="AdminController" method="post" onsubmit="return confirm('予約を削除しますか？')" style="position: absolute; bottom:2px; right: 2px; margin: 0;">
				<input type="hidden" name="command" value="reservationDelete">
				<input type="hidden" name="id" value="\${r.id}">
				<button type="submit" class="delete-icon" style="border:none; background:none; cursor:pointer; padding:0; font-size: 12px;">🗑️</button>
				</form>
				`;
          }
        }
      }
    });
  });
}


paintDay();
</script>

</body>
</html>
