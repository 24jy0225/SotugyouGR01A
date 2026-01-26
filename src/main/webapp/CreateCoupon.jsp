<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/couponStyle.css">
<title>管理者クーポン発行</title>
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
	<main class="coupon-add">
		<div>
			<table>
				<tr>
					<td>新規クーポン作成</td>
				</tr>
				<tr>
					<td class="color-gray">クーポンの詳細を入力してください</td>
				</tr>
			</table>
			<form action="AdminController" method="post" class="add-coupon-form">
				<input type="hidden" name="command" value="createCoupon">
				<div class="coupon-form-div">
					<label for="coupon-name">クーポン名</label> <input type="text"
						name="couponName" id="coupon_name">
				</div>
				<div class="coupon-form-div">
					<label for="coupon-content">クーポン内容</label>
					<textarea name="couponContent" id="coupon-content" maxlength="100"></textarea>
				</div>
				<div class="coupon-form-div">
					<label for="coupon-start">クーポン開始日</label> <input type="date"
						name="startDate" id="coupon-start">
				</div>
				<div class="coupon-form-div">
					<label for="coupon-end">クーポン期限日</label> <input type="date"
						name="endDate" id="coupon-end">
				</div>
				<input type="submit" value="クーポンを発行" id="coupon-submit">
			</form>
		</div>
	</main>

</body>
</html>