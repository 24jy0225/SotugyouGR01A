<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.format.DateTimeFormatter , model.Reservation , model.Seat"%>
<%
	DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
	List<Reservation> list = (List<Reservation>)session.getAttribute("ReservationHistoryList");
	List<Seat> seatList = (List<Seat>)session.getAttribute("Seat");
%>
<html>
<head>
<meta charset="UTF-8">
<title>席予約</title>
</head>
<body>
	<h3 id="dateLabel"></h3>
	<button onclick="prevDay()">←</button>
	<button onclick="nextDay()">→</button>
	<p><%= list %></p>
	<table id="reserveTable">
		<thead>
			<tr>
				<th>時間</th>
				<% for(Seat s : seatList){ %>
				<th><%= s.getSeatNumber() %></th>
				<% } %>
			</tr>
		</thead>
		<tbody id="tableBody"></tbody>
	</table>
	
	<script type="text/javascript">

		let currentDate = new Date(); // 今日

		showDay(currentDate);

		const allReservations = [
			
			<%
			for (Reservation r : list) {
			%>
			{
				date: "<%=r.getStartDateTime().toLocalDate().format(dateFmt)%>" ,
				seatId: "<%=r.getSeatId()%>" ,
				start: "<%=r.getStartDateTime().toLocalTime().format(timeFmt)%>" ,
				end: "<%=r.getEndDateTime().toLocalTime().format(timeFmt)%>" 
			},
			<%
			}
			%>
			];

		const seatArray = [
			<%
			for (Seat s : seatList) {
			%>
			    {
			        seatId: "<%= s.getSeatId() %>",
			        seatNumber: "<%= s.getSeatNumber() %>"
			    },
			<%
			}
			%>
			];

		function createHourSlots(){
			const hours = [];

			for(let h=20; h<24; h++){
				hours.push(h + ":00");
			}

			for(let h=0; h<4; h++){
				hours.push(h + ":00")
				}
			return hours;
		}
		
		function prevDay() {
			currentDate.setDate(currentDate.getDate() - 1);
			showDay(currentDate);
			}

		function nextDay(){
			currentDate.setDate(currentDate.getDate() + 1);
			showDay(currentDate);
			}

		function showDay(dateObj){
				const yyyyMMdd = dateObj.toISOString().split("T")[0];

				document.getElementById("dateLabel").innerText = yyyyMMdd;

				const dayReservations = [];

				for(let i=0; i<allReservations.length; i++){
					if(allReservations[i].date === yyyyMMdd){
						dayReservations.push(allReservations[i]);
						}
					}

					drawTable(dayReservations);
		}

		function drawEmptyTable() {
			  const tbody = document.getElementById("tableBody");
			  tbody.innerHTML = "";

			  const hours = createHourSlots();

			  for (let i = 0; i < hours.length; i++) {
			    const tr = document.createElement("tr");

			    // 時間列
			    const timeTd = document.createElement("td");
			    timeTd.textContent = hours[i];
			    tr.appendChild(timeTd);

			    // 席列
			    for (let seatId = 0; seatId<seatArray.length ; seatId++) {
			      const td = document.createElement("td");
			      td.className = "cell free";
			      td.dataset.seatId = seatArray[s].seatId;
			      td.dataset.time = hours[i];
			      tr.appendChild(td);
			    }

			    tbody.appendChild(tr);
			  }
			}
		
		function showDay(dateObj) {
			  const yyyyMMdd = dateObj.toISOString().split("T")[0];
			  document.getElementById("dateLabel").innerText = yyyyMMdd;

			  drawEmptyTable();
			}

		
		
	</script>
</body>
</html>
