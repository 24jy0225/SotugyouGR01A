<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/visualControlStyle.css">
<title>見た目変更</title>
</head>
<body>
	<header>
		<nav class="nav-menu">
			<button onclick="location.href='ReservationManage.jsp'">予約管理</button>
			<button onclick="location.href='MemberManage.jsp'">顧客管理</button>
			<button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
			<button onclick="location.href='TopicsManage.jsp'">お知らせ管理</button>
			<button onclick="location.href='DesignCustom.jsp'">Webサイト管理</button>
		</nav>
	</header>

	<main>
		<div class="leftGrid">
			<form action="AdminController" method="post"
				class="visual-change-form" enctype="multipart/form-data">
				<div class="visual-change-div">
					<label for="photo_category">変更内容選択</label> <select
						name="category" id="photo_category">
						<option value="" disabled selected>変更内容を選択</option>
						<option value="system">system</option>
						<option value="top">top</option>
						<option value="flavar">flavar</option>
						<option value="drink">drink</option>
						<option value="food">food</option>
					</select>
				</div>
				<div class="visual-change-div">
					<label for="photo_id">画像</label> <input type="file"
						accept="image/png,image/jpeg,image/jpg" name="image" id="photo_id"
						onchange="previewImage(this)" class="visual-photo"
						placeholder="画像を選択">
				</div>
				<input type="submit" name="" id="photo-submit" value="決定"> <input
					type="hidden" name="command" value="designUpdate">
			</form>
		</div>
		<div class="midGrid"></div>
		<div class="rightGrid">
			<p>現在表示中（またはプレビュー）</p>
			<img src="./image/assets/CSシステム通常800_Menu_2505-1_page-0001.jpg"
				alt="" class="preview" id="preview_target">
		</div>
		<div class="leftBottom"></div>
	</main>
	<script>
		function previewImage(obj) {
			// ファイルが選択されているか確認
			if (obj.files && obj.files[0]) {
				const reader = new FileReader();

				// ファイル読み込みが完了した時の処理
				reader.onload = function(e) {
					// プレビュー用imgタグのsrc属性を、読み込んだ画像データに書き換え
					document.getElementById('preview_target').src = e.target.result;
				}

				// ファイルを読み込む
				reader.readAsDataURL(obj.files[0]);
			}
		}
	</script>

</body>
</html>