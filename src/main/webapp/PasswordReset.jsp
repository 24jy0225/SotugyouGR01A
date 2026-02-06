<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>パスワード再設定リクエスト</title>
</head>
<body>
    <h2>パスワード再設定</h2>
    <p>ご登録済みのメールアドレスを入力してください。<br>
       再設定用のリンクをメールでお送りします。</p>

    <form action="UserController" method="post">
        <input type="hidden" name="command" value="passwordReset">
        
        <p>
            メールアドレス：<br>
            <input type="email" name="email" required style="width: 250px;">
        </p>
        
        <button type="submit">送信する</button>
    </form>
    
    <br>
    <a href="Login.jsp">ログイン画面へ戻る</a>
</body>
</html>