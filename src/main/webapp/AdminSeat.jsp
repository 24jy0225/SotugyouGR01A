<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/admin/adminStyle.css">
    <link rel="stylesheet" href="./css/admin/adminseatStyle.css">
    <title>席</title>
</head>

<body>
    <header>
        <nav class="nav-menu">
            <button onclick="location.href='../Reservation/Admin_ReservationControl.html'">予約管理</button>
            <button onclick="location.href='../Customer/Admin_CustomerControl.html'">顧客管理</button>
            <button onclick="location.href='../Coupon/Admin_CouponControl.html'">クーポン管理</button>
            <button onclick="location.href='../Topics/Admin_TopicsControl.html'">お知らせ管理</button>
            <button onclick="location.href='../Visual/Admin_VisualChange.html'">Webサイト管理</button>
        </nav>
    </header>
    <main class="seat_main">
        <div class="seat_main_head">
            <table>
                <tr>
                    <td>座席管理</td>
                </tr>
                <tr>
                    <td>全10席</td>
                </tr>
            </table>
            <button onclick="location.href=''">＋　新規クーポン作成</button>
        </div>
        <div class="seat_main_body">
            <table>
                <tr>
                    <td>座席番号</td>
                    <td>店舗名</td>
                    <td class="table-seat-status">ステータス</td>
                    <td class="table-seat-delete">削除</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>新宿店</td>
                    <td class="table-seat-status"><button class="active-btn">有効</button></td>
                    <td class="table-seat-delete"><button class="delete-btn">削除</button></td>
                </tr>
            </table>
        </div>
    </main>
</body>

</html>