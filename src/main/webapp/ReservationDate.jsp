<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String action = (String) session.getAttribute("action");
%>
<!DOCTYPE html>
<html>
<head>
<style>
#calendar {
	width: 350px;
	height: 350px;
	margin: 20px:auto;
	margin
}
</style>
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css'
	rel='stylesheet' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<meta charset="UTF-8">
<title>席予約</title>
</head>
<body>
	<div id='calendar'></div>
	<script>
	
	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');

	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',

	        dateClick: function(info) {
	            const clickedDate = info.date;
	            const today = new Date();
	            const todayZero = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	            const start = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
	            const end = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 14);

	            // 今日なら赤だけど予約不可
	            if (clickedDate.getTime() === todayZero.getTime()) {
	                alert("当日の予約はできません。");
	                return;
	            }

	            // 明日〜14日後以外
	            if (clickedDate < start || clickedDate > end) {
	                alert("予約できる日付は【明日から2週間以内】です。");
	                return;
	            }

	            const date = info.dateStr;
	            if(<%=action.equals("ByUser")%> ){
	            	window.location.href = "UserController?date=" + date + "&command=" + "Cource";
		        }else if(<%=action.equals("ByAdmin")%>){
	            	window.location.href = "AdminController?date=" + date + "&command=" + "Cource";
			        }
	        },

	        // ここでセルに色を付ける
	        dayCellDidMount: function(info) {
	            const today = new Date();
	            const todayZero = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	            const start = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
	            const end = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 14);
	            const cellDate = info.date;

	            if (cellDate.getTime() === todayZero.getTime()) {
	                info.el.style.backgroundColor = "#ffb3b3"; // 🔴 今日 → 赤
	                info.el.style.color = "#b20000";
	            } else if (cellDate >= start && cellDate <= end) {
	                info.el.style.backgroundColor = "#b7f3b1"; // 🟢 明日〜2週間後 → 緑
	            } else {
	                info.el.style.backgroundColor = "#e7e7e7"; // ⚪ 予約不可 → グレー
	                info.el.style.color = "#888";
	            }
	        }
	    });

	    calendar.render();
	});
</script>
</body>
</html>