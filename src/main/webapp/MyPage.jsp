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
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo"
				class="logo">
		</div>
		<button class="hamburger-menu" id="hamburgerBtn" aria-label="メニュー">
			<img src="./image/assets/user/hamburger.svg" alt="メニュー">
		</button>
		<!-- PC用ナビゲーション -->
		<nav class="nav-menu">
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> <a
				href="./how_to_Use.jsp" class="nav-link">Use</a> <a
				href="./system-introduction.jsp" class="nav-link">System</a> <a
				href="./menu.jsp" class="nav-link">Menu</a> <a href="./topics.jsp"
				class="nav-link">Topics</a> <a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
			<%
			if (user != null) {
			%>
			<div class="nav-member-group">
				<a href="UserController?command=MyPage" class="nav-link">Member</a>
				<a href="UserController?command=logout" class="nav-logout-link">logout</a>
			</div>
			<%
			} else {
			%>
			<a href="./Login.jsp" class="nav-link">Login</a>
			<%
			}
			%>
		</nav>
		<!-- スマホ用ナビゲーション -->
		<nav class="mobile-nav" id="mobileNav">
			<a href="./whats_Shisha.jsp" class="mobile-nav-link">What's</a> <a
				href="./how_to_Use.jsp" class="mobile-nav-link">Use</a> <a
				href="./system-introduction.jsp" class="mobile-nav-link">System</a>
			<a href="./menu.jsp" class="mobile-nav-link">Menu</a> <a
				href="./topics.jsp" class="mobile-nav-link">Topics</a> <a
				href="./contact.jsp" class="mobile-nav-link">Contact</a> <a
				href="UserController?command=reservationDate"
				class="mobile-nav-link">Reservation</a>
			<%
			if (user != null) {
			%>
			<a href="UserController?command=MyPage" class="mobile-nav-link">Member</a>
			<a href="UserController?command=logout"
				class="mobile-nav-link mobile-nav-logout">Logout</a>
			<%
			} else {
			%>
			<a href="./Login.jsp" class="mobile-nav-link">Login</a>
			<%
			}
			%>
		</nav>
	</header>

	<main>

		<div class="member-info">
			<div class="member-inner">
				<div>
					<p>
						Name / 会員番号:<%=user.getUserId()%></p>
					<p class="member-data"><%=user.getName()%></p>
				</div>
				<div>
					<p>Mail address</p>
					<p class="member-data"><%=user.getUserEmail()%></p>
				</div>
				<div>
					<p>tel number</p>
					<p class="member-data">
						<%=(user.getUserTel() == null || user.getUserTel().isEmpty()) ? "未登録" : user.getUserTel()%></p>
				</div>
				<p class="member-information">
					<a href="UserInfoEdit.jsp">会員情報変更はこちら</a>
				</p>
				<p class="member-information">
					<a href="PasswordReset.jsp">パスワード変更はこちら</a>
				</p>
			</div>
		</div>

		<div class="member-couponlist">
			<%
			boolean hasValidCoupon = false;
			if (couponUsageList != null) {
				for (CouponUsage usage : couponUsageList) {
					LocalDate startDate = usage.getCoupon().getStartDate();
					LocalDate endDate = usage.getCoupon().getEndDate();
					// 期限外または非アクティブならスキップ
					if (today.isBefore(startDate) || today.isAfter(endDate) || !usage.getCoupon().getIsActive()
					|| !usage.isCouponUsage()) {
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
						data-id="<%=usage.getCoupon().getCouponId()%>"
						data-name="<%=usage.getCoupon().getCouponName()%>"
						onclick="showCouponModal(this)">クーポンを使用する</button>
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
				// ★開始時間・終了時間を取得
				java.time.LocalDateTime startDt = res.getStartDateTime();
				java.time.LocalDateTime endDt = res.getEndDateTime();

				// 過去の予約やキャンセル済みはスキップ
				if (startDt.toLocalDate().isBefore(today) || res.getCancelDate() != null) {
					continue;
				}

				// --- 開始時間の24時間表記ロジック ---
				int sHour = startDt.getHour();
				int sMinute = startDt.getMinute();
				java.time.LocalDate displayDate = startDt.toLocalDate();

				// 0〜4時の場合は日付を1日戻し、時間を+24する
				if (sHour < 5) {
					displayDate = displayDate.minusDays(1);
					sHour += 24;
				}
				String dateStr = displayDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
				String startStr = String.format("%02d:%02d", sHour, sMinute);

				// --- 終了時間の24時間表記ロジック ---
				int eHour = endDt.getHour();
				int eMinute = endDt.getMinute();
				if (eHour < 5) {
					eHour += 24; // 終了時間も同様に+24する
				}
				String endStr = String.format("%02d:%02d", eHour, eMinute);
			%>
			<div class="member-reservation">
				<table>
					<tr>
						<td><%=dateStr%></td>
						<td><%=res.getReservePeople()%>名</td>
						<td class="reservation-numbertitle">予約番号：</td>
						<td><%=res.getReserveId()%></td>
					</tr>
				</table>
				<table>
					<tr>
						<td>座席番号</td>
						<td>開始時間</td>
						<td>終了時間</td>
					</tr>
					<tr>
						<td><%=res.getSeatId()%></td>
						<td><%=startStr%></td>
						<td><%=endStr%></td>
					</tr>
				</table>
				<button class="reservation-cancel"
					onclick="location.href='UserController?command=cancelConfirm&reserveId=<%=res.getReserveId()%>'">キャンセルする</button>
			</div>
					<%
				}
				}
				%>
		/div>
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

    // 修正された関数
    function showCouponModal(element) { // 引数を 'element' にする
        // 引数で受け取った 'element' (ボタン自身) から data属性を取得
        const id = element.getAttribute('data-id');
        const name = element.getAttribute('data-name');
        
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