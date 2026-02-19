<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, model.User, model.Reservation, model.CouponUsage, java.time.LocalDate, java.time.format.DateTimeFormatter"%>
<%
// セッションデータの取得
LocalDate today = LocalDate.now();
User user = (User) session.getAttribute("LoginUser");
List<Reservation> reservationList = (List<Reservation>) session.getAttribute("reservationHistory");
List<CouponUsage> couponUsageList = (List<CouponUsage>) session.getAttribute("couponList");
String msg = (String) session.getAttribute("message");

// Nullガード句（画面確認用）
if (user == null) {
	user = new User(); // 本来はRedirectすべきですが、確認用に空オブジェクトを作成
	user.setName("ゲスト");
}
if (reservationList == null)
	reservationList = new ArrayList<>();
if (couponUsageList == null)
	couponUsageList = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/memberStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
<title>マイページ - member</title>
</head>

<body>
	<header class="header" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo" class="logo">
		</div>
		<button class="hamburger-menu" id="hamburgerBtn" aria-label="メニュー">
            <img src="./image/assets/user/hamburger.svg" alt="メニュー">
        </button>
		<!-- PC用ナビゲーション -->
        <nav class="nav-menu">
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> 
			<a href="./how_to_Use.jsp" class="nav-link">Use</a> 
			<a href="./system-introduction.jsp" class="nav-link">System</a>
			<a	href="./menu.jsp" class="nav-link">Menu</a> 
			<a href="./topics.jsp" class="nav-link">Topics</a> 
			<a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
			<%if (user != null) { %>
				<div class="nav-member-group">
					<a href="UserController?command=MyPage" class="nav-link">Member</a>
					<a href="UserController?command=logout" class="nav-logout-link">logout</a>
				</div>
			<% } else { %>
				<a href="./Login.jsp" class="nav-link">Login</a>
			<% } %>
		</nav>
        <!-- スマホ用ナビゲーション -->
        <nav class="mobile-nav" id="mobileNav">
            <a href="./whats_Shisha.jsp" class="mobile-nav-link">What's</a> 
			<a href="./how_to_Use.jsp" class="mobile-nav-link">Use</a> 
			<a href="./system-introduction.jsp" class="mobile-nav-link">System</a>
			<a	href="./menu.jsp" class="mobile-nav-link">Menu</a> 
			<a href="./topics.jsp" class="mobile-nav-link">Topics</a> 
			<a href="./contact.jsp" class="mobile-nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="mobile-nav-link">Reservation</a>
			<%if (user != null) { %>
				<a href="UserController?command=MyPage" class="mobile-nav-link">Member</a>
				<a href="UserController?command=logout" class="mobile-nav-link mobile-nav-logout">Logout</a>
			<% } else { %>
				<a href="./Login.jsp" class="mobile-nav-link">Login</a>
			<% } %>
        </nav>
	</header>

	<main>
		<%
		if (msg != null) {
		%>
		<div
			style="color: #d4af37; font-weight: bold; border: 1px solid #d4af37; padding: 15px; margin: 20px auto; max-width: 800px; text-align: center; background: rgba(212, 175, 55, 0.1);">
			<%=msg%>
		</div>
		<%
		session.removeAttribute("message");
		%>
		<%
		}
		%>

		<div class="member-info">
			<div class="member-content">
				<p>
					Name / 会員番号:<%=user.getUserId()%></p>
				<p class="member-data"><%=user.getName()%></p>
			</div>
			<div class="member-content">
				<p>Mail address</p>
				<p class="member-data"><%=user.getUserEmail()%></p>
			</div>
			<div class="member-content">
				<p>tel number</p>
				<p class="member-data">
					<%=(user.getUserTel() == null || user.getUserTel().isEmpty()) ? "未登録" : user.getUserTel()%>
				</p>
			</div>
			<a href="UserInfoEdit.jsp" class="member-information">会員情報変更はこちら</a>
			<a href="PasswordReset.jsp" class="member-information">パスワード変更はこちら</a>
		</div>

		<div class="member-couponlist">
			<%
			boolean hasValidCoupon = false;
			if (couponUsageList != null) {
				for (CouponUsage usage : couponUsageList) {
					LocalDate startDate = usage.getCoupon().getStartDate();
					LocalDate endDate = usage.getCoupon().getEndDate();
					// 期限外または非アクティブならスキップ
					if (today.isBefore(startDate) || today.isAfter(endDate) || !usage.getCoupon().getIsActive()) {
				continue;
					}
					hasValidCoupon = true;
			%>
			<div class="coupon">
				<div class="coupon-head">
					<div class="coupon-content"></div>
				</div>
				<div class="coupon-body">
					<table class="coupon-table">
						<tr>
							<td><%=usage.getCoupon().getCouponName()%></td>
						</tr>
						<tr>
							<td><%=usage.getCoupon().getCouponContent()%></td>
						</tr>
					</table>
					<table class="coupon-table">
						<tr>
							<td>有効期限</td>
						</tr>
						<tr>
							<td><%=startDate%> ~ <%=endDate%></td>
						</tr>
					</table>
					<button type="button" class="coupon-use"
						onclick="showCouponModal('<%=usage.getCoupon().getCouponId()%>', '<%=usage.getCoupon().getCouponName()%>')">
						クーポンを使用する</button>
				</div>
			</div>
			<%
			}
			}
			if (!hasValidCoupon) {
			%>
			<p style="text-align: center; color: #fff; width: 100%;">利用可能なクーポンはありません。</p>
			<%
			}
			%>
		</div>

		<div class="member-reservation-list">
			<p>予約一覧</p>
			<%
			if (reservationList.isEmpty()) {
			%>
			<p style="color: #fff; padding: 20px;">現在ご予約はありません。</p>
			<%
			} else {
			for (Reservation res : reservationList) {
				if(res.getReserveDate().isBefore(today) || res.getCancelDate() != null){ continue; }
			%>
			<div class="member-reservation">
				<table>
					<tr>
						<td><%=res.getReserveDate()%></td>
						<td><%=res.getReservePeople()%>名</td>
						<td class="reservation-numbertitle">予約番号：</td>
						<td><%=res.getReserveId()%></td>
					</tr>
				</table>
				<button class="reservation-cancel"
					onclick="location.href='UserController?command=cancel&reserveId=<%=res.getReserveId()%>'">キャンセルする</button>
			</div>
			<%
			}
			}
			%>
		</div>
	</main>

	<form id="useForm" action="UserController" method="POST"
		style="display: none;">
		<input type="hidden" name="command" value="useCoupon"> <input
			type="hidden" name="couponNumber" id="targetCouponNumber">
	</form>

	<dialog id="confirmModal">
	<h2 class="modal-title">クーポンを使用しますか？</h2>
	<p class="modal-description">一度使用すると取り消しできません。</p>
	<div class="coupon-box">
		<div class="coupon-label">クーポン</div>
		<div id="modal-coupon-name" class="coupon-name">クーポン名</div>
		<div class="coupon-discount">CONFIRM</div>
	</div>
	<div class="button-group">
		<button type="button" class="btn btn-use" id="finalConfirmButton">使用する</button>
		<button type="button" class="btn btn-cancel" id="closeButton">キャンセル</button>
	</div>
	</dialog>

	<footer>
		<p>
			<small>&copy;The Shisha Honjin</small>
		</p>
	</footer>

	<script>
        const modal = document.getElementById('confirmModal');
        const targetInput = document.getElementById('targetCouponNumber');
        const modalCouponName = document.getElementById('modal-coupon-name');

        // モーダルを開く関数
        function showCouponModal(id, name) {
            targetInput.value = id;
            modalCouponName.textContent = name;
            modal.showModal();
        }

        // 「キャンセル」で閉じる
        document.getElementById('closeButton').addEventListener('click', () => {
            modal.close();
        });

        // 「使用する」でフォーム送信
        document.getElementById('finalConfirmButton').addEventListener('click', () => {
            document.getElementById('useForm').submit();
        });
    </script>
</body>
</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>