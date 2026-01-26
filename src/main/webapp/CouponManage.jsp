<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.* , model.Coupon "%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.Duration"%>
<%
List<Coupon> couponList = (List<Coupon>) session.getAttribute("couponList");
LocalDate today = LocalDate.now();
%>
<%
// ---------------------------------------------------------
// リストの並べ替え処理 (ここを追加)
// ---------------------------------------------------------
if (couponList != null && !couponList.isEmpty()) {
    Collections.sort(couponList, new Comparator<Coupon>() {
        @Override
        public int compare(Coupon c1, Coupon c2) {
            // 今日の日付を取得 (scope外で定義されている場合は不要ですが念のため)
            LocalDate now = LocalDate.now();

            // 優先度を数値化する関数 (小さいほど上に来る)
            // 1: 有効, 2: 無効, 3: 期限切れ
            int p1 = getPriority(c1, now);
            int p2 = getPriority(c2, now);

            if (p1 != p2) {
                return Integer.compare(p1, p2); // ステータスで比較
            } else {
                // ステータスが同じなら、有効期限が「早い順」に並べる
                return c1.getEndDate().compareTo(c2.getEndDate());
            }
        }

        // 状態から優先度を判定するヘルパーメソッド
        private int getPriority(Coupon c, LocalDate now) {
            boolean isExpired = c.getEndDate().isBefore(now);
            if (isExpired) {
                return 3; // 期限切れ (一番下)
            }
            if (c.getIsActive()) {
                return 1; // 有効 (一番上)
            }
            return 2; // 無効 (真ん中)
        }
    });
}
// ---------------------------------------------------------
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/couponStyle.css">
<title>クーポン管理</title>
</head>
<body>
	<%
	String msg = (String) session.getAttribute("message");
	if (msg != null) {
	%>
	<div
		style="color: green; font-weight: bold; border: 1px solid green; padding: 10px; margin-bottom: 10px;">
		<%=msg%>
	</div>
	<%
	// 一度表示したら消す（そうしないと、ずっと表示され続けてしまうため）
	session.removeAttribute("message");
	}
	%>
	<header>
		<nav class="nav-menu">
			<button onclick="location.href='ReservationManage.jsp'">予約管理</button>
			<button onclick="location.href='MemberManage.jsp'">顧客管理</button>
			<button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
			<button onclick="location.href='TopicsManage.jsp'">お知らせ管理</button>
			<button onclick="location.href='DesignCustom.jsp'">Webサイト管理</button>
		</nav>
	</header>
	<main class="coupon-main">
		<div class="coupon-main-head">
			<table>
				<tr>
					<td>クーポン管理</td>
				</tr>
				<tr>
					<td>全<%=couponList.size()%>件のクーポン
					</td>
				</tr>
			</table>
			<button onclick="location.href='CreateCoupon.jsp'">＋
				新規クーポン作成</button>
		</div>
		<div class="coupon-main-body">
			<table>
				<tr>
					<td class="table-coupon-name">クーポン名</td>
					<td class="table-coupon-id">クーポンID</td>
					<td class="table-coupon-content">クーポン内容</td>
					<td class="table-coupon-expiration">クーポン有効期限</td>
					<td></td>
					<td class="table-coupon-expiration"></td>
					<td class="table-coupon-status">ステータス</td>
					<td class="table-coupon-delete">削除</td>
				</tr>



				<%
				for (Coupon coupon : couponList) {
				%>
				<tr>
					<td class="table-coupon-name"><%=coupon.getCouponName()%></td>
					<td class="table-coupon-id"><%=coupon.getCouponId()%></td>
					<td class="table-coupon-content"><%=coupon.getCouponContent()%></td>
					<td class="table-coupon-expiration"><%=coupon.getStartDate()%>
					<td>~</td>
					<td class="table-coupon-expiration"><%=coupon.getEndDate()%></td>
					<%
					if (!coupon.getEndDate().isAfter(today)) {
					%>
					<td class="table-coupon-status">期限切れ</td>
					<%
					} else if (!coupon.getEndDate().isBefore(today) && coupon.getIsActive() != false) {
					%>
					<td class="table-coupon-status"><button class="active-btn"
							onclick="editCoupon('<%=coupon.getCouponId()%>' , '<%=coupon.getIsActive()%>')">有効</button></td>
					<%
					} else {
					%>
					<td class="table-coupon-status"><button class="passive-btn"
							onclick="editCoupon('<%=coupon.getCouponId()%>' , '<%=coupon.getIsActive()%>')">無効</button></td>
					<%
					}
					%>
					<td class="table-coupon-delete">
						<button class="delete-btn"
							onclick="deleteCoupon('<%=coupon.getCouponId()%>')">削除</button>
					</td>
				</tr>
				<%
				}
				%>

			</table>
		</div>
	</main>

	<form id="editCouponForm" action="AdminController" method="POST">
		<input type="hidden" name="command" id="targetCommand"> <input
			type="hidden" name="couponNumber" id="targetCouponNumber"> <input
			type="hidden" name="couponActive" id="targetCouponActive">
	</form>

	<script type="text/javascript">
		function editCoupon(number, active) {
			if (confirm("現在のステータスから変更しますか？")) {
				document.getElementById('targetCommand').value = "editCoupon";
				document.getElementById('targetCouponNumber').value = number;
				document.getElementById('targetCouponActive').value = active;
				document.getElementById('editCouponForm').submit();
			}

		}

		function deleteCoupon(number) {
			if (confirm("本当にこのクーポンを削除しますか？\nこの操作は取り消せません。")) {
				document.getElementById('targetCommand').value = "deleteCoupon"; // commandを削除用に書き換え
				document.getElementById('targetCouponNumber').value = number;
				document.getElementById('editCouponForm').submit();
			}
		}
	</script>
</body>
</html>