<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/topStyle.css">
    <title>管理者トップ</title>
</head>

<body>
    <div class="adtop_btn">
        <button onclick="location.href='ReservationManage.jsp'">予約管理</button>
        <button onclick="location.href='MemberManage.jsp'">顧客管理</button>
    </div>
    <br>
    <div class="adtop_btn">
        <button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
        <button onclick="location.href='DesignCustom.jsp'">Webサイト管理</button>
        <button onclick="location.href='TopicsManage.jsp'">お知らせ管理</button>
    </div>
</body>
</html>