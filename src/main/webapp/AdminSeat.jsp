<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Seat , java.util.*"%>
<%
List<Seat> seatList = (List<Seat>) session.getAttribute("Seat");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/admin/adminStyle.css">
<link rel="stylesheet" href="./css/admin/adminSeatStyle.css">
<title>席</title>
</head>

<body>
	<header>
		<nav class="nav-menu">
			<button onclick="location.href='ReservationManage.jsp'">予約管理</button>
			<button onclick="location.href='UserManage.jsp'">顧客管理</button>
			<button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
			<button onclick="location.href='TopicsManage.jsp'">お知らせ管理</button>
			<button onclick="location.href='DesignCustom.jsp'">Webサイト管理</button>
		</nav>
	</header>
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
	<main class="seat_main">
		<div class="seat_main_head">
			<table>
				<tr>
					<td>座席管理</td>
				</tr>
				<tr>
					<td>全<%=seatList.size()%>席
					</td>
				</tr>
			</table>
			<button onclick="addSeat()" class="">座席追加</button>
		</div>
		<div class="seat_main_body">
			<table>
				<tr>
					<td>座席番号</td>
					<td>店舗名</td>
					<td class="table-seat-status">ステータス</td>
				</tr>
				<%
				for (Seat s : seatList) {
				%>
				<tr>
					<td><%=s.getSeatNumber()%></td>
					<td><%=s.getStore().getStoreName()%></td>
					<%
					if (s.getIsActive() == true) {
					%>
					<td class="table-seat-status"><button class="active-btn"
							onclick="editSeat('<%=s.getSeatId()%>','<%=s.getIsActive()%>')">有効</button></td>
					<%
					} else {
					%>
					<td class="table-seat-status"><button class="inactive-btn"
							onclick="editSeat('<%=s.getSeatId()%>','<%=s.getIsActive()%>')">無効</button></td>
					<%
					}
					%>
				</tr>
				<%
				}
				%>
			</table>
		</div>
	</main>
	<form id="editSeatForm" action="AdminController" method="POST">
		<input type="hidden" name="command" id="targetCommand"> <input
			type="hidden" name="SeatId" id="targetSeatId"> <input
			type="hidden" name="SeatActive" id="targetSeatActive">
	</form>

	<script type="text/javascript">
		function editSeat(SeatId, active) {
			if (confirm("現在のステータスから変更しますか？")) {
				document.getElementById('targetCommand').value = "editSeat";
				document.getElementById('targetSeatId').value = SeatId;
				document.getElementById('targetSeatActive').value = active;
				document.getElementById('editSeatForm').submit();
			}

		}

		function addSeat() {
			if (confirm("座席を追加しますか？")) {
				document.getElementById('targetCommand').value = "addSeat";
				document.getElementById('editSeatForm').submit();
			}

		}
	</script>
</body>

</html>