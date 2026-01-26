<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/loginStyle.css">
    <title>管理者ログイン</title>
</head>

<body>
    <main id="login">
        <div id="login_margin">
            <div id="login_header">
                <h2>Welcome Back</h2>
                <p>続行するにはログインしてください</p>
            </div>
            <div id="login_main">
                <form action="AdminController" method="post">
                    <label id="login_word">
                        <legend>Password</legend>
                        <input type="password" name="AdminPassword" id="password" placeholder="Password" value="Drive666">
                    </label>
                    <input type="submit" id="login_submit" value="Log In">
                    <hr id="login_line">
                    <input type="hidden" name="command" value="login">
                </form>
            </div>
        </div>
    </main>
</body>

</html>