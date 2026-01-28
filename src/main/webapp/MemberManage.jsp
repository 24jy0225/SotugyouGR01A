<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.* , model.User"%>
<%
List<User> userList = (List<User>) session.getAttribute("UserList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/customerStyle.css">
<title>管理者顧客管理</title>
</head>
<body>
	<header>
		<nav class="nav-menu">
			<button
				onclick="location.href='ReservationManage.jsp'">予約管理</button>
			<button
				onclick="location.href='MemberManage.jsp'">顧客管理</button>
			<button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
			<button onclick="location.href='DesignCustom.jsp'">お知らせ管理</button>
			<button onclick="location.href='TopicsManage.jsp'">Webサイト管理</button>
		</nav>
	</header>
	<main class="customer-main">
		<div>
			<p class="title">顧客一覧</p>
			<p class="subtitle">
				全<%=(userList.size() - 1)%>名の顧客
			</p>
		</div>
		<div class="customer-list">
			<%
			for (User u : userList) {
			%>
			<%
			if (u.getUserId().equals("ADMIN")) {
				continue;
			}
			%>
			<div class="customer"
				onclick="customerDetail('<%= u.getUserId() %>')">
				<svg xlns="http://www.w3.org/2000/svg" width="20" height="20"
					viewBox="0 0 20 20" fill="none" class="customer-icon">
                    <path
						d="M15.8332 17.5V15.8333C15.8332 14.9493 15.482 14.1014 14.8569 13.4763C14.2317 12.8512 13.3839 12.5 12.4998 12.5H7.49984C6.61578 12.5 5.76794 12.8512 5.14281 13.4763C4.51769 14.1014 4.1665 14.9493 4.1665 15.8333V17.5"
						stroke="#155DFC" stroke-width="1.66667" stroke-linecap="round"
						stroke-linejoin="round" />
                    <path
						d="M9.99984 9.16667C11.8408 9.16667 13.3332 7.67428 13.3332 5.83333C13.3332 3.99238 11.8408 2.5 9.99984 2.5C8.15889 2.5 6.6665 3.99238 6.6665 5.83333C6.6665 7.67428 8.15889 9.16667 9.99984 9.16667Z"
						stroke="#155DFC" stroke-width="1.66667" stroke-linecap="round"
						stroke-linejoin="round" />
                </svg>
				<table class="customer-table">
					<tr class="customer-head">
						<td class="customer-name"><%=u.getName()%></td>
						<td class="customer-id"><%=u.getUserId()%></td>
					</tr>
					<tr class="customer-info">
						<td><%=u.getUserTel()%></td>
						<td><%=u.getUserEmail()%></td>
					</tr>
				</table>
				<div class="customer-content">
					<div class="customer-reservation-btn"><%=u.getReserveCount()%>件の予約
					</div>
					<div class="customer-coupon-btn"><%=u.getCouponCount()%>件のクーポン
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<form id="customerDetailForm" action="AdminController" method="POST">
			<input type="hidden" name="command" id="targetCommand">
			<input type="hidden" name="userId" id="targetUserId"> 
		</form>
	</main>
	<script type="text/javascript">
		function customerDetail(userId){
			document.getElementById("targetCommand").value = "customerDetail";
			document.getElementById("targetUserId").value = userId;
			document.getElementById('customerDetailForm').submit();
			}
	</script>
</body>
</html>