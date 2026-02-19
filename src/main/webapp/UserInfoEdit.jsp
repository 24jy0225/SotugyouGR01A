<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="../assets/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/member-editStyle.css">
<title>会員情報の変更</title>
</head>

<body>
	<!-- ヘッダー -->
	<header class="systemheader" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.html'">
			<img src="../assets/ロゴタイプ_金色b.svg" alt="logo" class="logo">
		</div>
		<nav class="system-nav-menu">
			<a href="./login.html" class="nav-link">Login</a>
		</nav>
	</header>
	<main>

		<div class="content-wrapper">
			<div class="page-header">
				<h1 class="page-title">会員情報の変更</h1>
				<p class="page-description">プロフィール情報を更新できます</p>
			</div>

			<div class="settings-container">
				<div class="section-header">
					<h2>アカウント設定</h2>
				</div>
				<p class="section-description">会員情報の確認と変更ができます</p>

				<form>
					<div class="form-group">
						<label class="form-label" for="name">氏名</label> <input type="text"
							id="name" class="form-input" placeholder="山田 太郎">
					</div>

					<div class="form-group">
						<label class="form-label" for="furigana">フリガナ</label> <input
							type="text" id="furigana" class="form-input"
							placeholder="ヤマダ タロウ">
					</div>

					<div class="form-group">
						<label class="form-label" for="email">メールアドレス</label> <input
							type="email" id="email" class="form-input"
							placeholder="yamada.taro@example.com">
					</div>

					<div class="form-group">
						<label class="form-label" for="phone">電話番号</label> <input
							type="tel" id="phone" class="form-input"
							placeholder="090-1234-5678">
					</div>

					<div class="button-group">
						<button type="submit" class="btn btn-save">
							<span>保存する</span>
						</button>
						<button type="button" class="btn btn-cancel">
							<span class="icon">✕</span> <span>キャンセル</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<footer>
		<p>
			<small>&copy;The Shisha Honjin</small>
		</p>
	</footer>
</body>

</html>
<script type="text/javascript" src="../javascript/logoScript.js"></script>