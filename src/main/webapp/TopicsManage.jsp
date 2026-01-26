<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.* , model.Topics"%>
<%
List<Topics> topicsList = (List<Topics>) session.getAttribute("topicsList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/topicsStyle.css">
<title>管理者トピックス管理</title>
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

		<div class="add-topic">
			<div class="topics-head">
				<table>
					<tr>
						<td>トピックス管理</td>
					</tr>
					<tr>
						<td>トピックの追加、削除ができます</td>
					</tr>
				</table>
			</div>
			<form id="topicsAddForm" class="add-topic-form"
				onsubmit="return false;">
				<div class="topics-form-div">
					<label for="topics_title">トピックタイトル</label> <input type="text"
						name="topicsTitle" id="topics_title" placeholder="トピックタイトル"
						class="topic-title">
				</div>
				<div class="topics-form-div">
					<label for="topics_content">トピック内容</label>
					<textarea name="topicsContent" id="topics_content"
						placeholder="トピック内容" maxlength="1000" class="topic-content"></textarea>
				</div>
				<div class="topics-form-div">
					<label for="photo_id">画像</label> <input type="file"
						accept="image/png,image/jpeg,image/jpg" name="image" id="photo_id"
						class="topic-photo" onchange="previewImage(this)">
				</div>
				<div class="topics-form-div">
					<input type="button" onclick="addTopics()" value="＋　追加する"
						id="topic-submit" class="topic-submit"> <input
						type="hidden" name="command" value="topicsAdd">
				</div>
			</form>
		</div>

		<div class="midGrid"></div>

		<div class="rightGrid">
			<p class="preview-title">プレビュー</p>
			<img src="./image/assets/concrete.png" alt="プレビュー" id="preview_img"
				class="topics-preview" style="max-width: 100%; height: auto;">
		</div>

		<div class="bottomGrid">
			<p>登録済みトピックス</p>
			<div class="topics">
				<table>
					<tbody id="topicsTbody">
						<%
						if (topicsList != null) {
							for (Topics t : topicsList) {
						%>
						<tr>
							<th><%=t.getTopicsTitle()%></th>
							<td>
								<button type="button" class="topic-delete"
									onclick="deleteTopics(<%=t.getTopicsId()%>, this)">削除</button>
							</td>

						</tr>
						<tr>
							<td style="white-space: pre-wrap; word-wrap: break-word;"><%=t.getTopicsContent()%></td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</main>

	<script type="text/javascript">
        // 画像プレビュー用の関数
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('preview_img').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function addTopics() {
            const form = document.getElementById("topicsAddForm");
            // バリデーション（簡易）
            if(!document.getElementById("topics_title").value || !document.getElementById("topics_content").value){
                alert("タイトルと内容は必須です");
                return;
            }

            const formData = new FormData(form);
            
            // 画面表示用の一時変数
            const titleVal = document.getElementById("topics_title").value;
            const contentVal = document.getElementById("topics_content").value;

            fetch("AdminController", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if(response.ok) {
                    alert("登録成功！");
                    
                    // 入力をクリア
                    document.getElementById("topics_title").value = "";
                    document.getElementById("topics_content").value = "";
                    // 【修正】IDを photo_id に修正
                    document.getElementById("photo_id").value = ""; 
                    document.getElementById("preview_img").src = ""; // プレビューもクリア

                    // 行を増やす
                    // 【修正】HTML側に id="topicsTbody" を追加したので取得可能になる
                    const tbody = document.getElementById("topicsTbody");
                    if(tbody) {
                        const newRow = tbody.insertRow(0); // 0にすると一番上に追加される
                        // 注意: IDがないため、ここでの削除ボタンはリロードするまで機能しない（または仮IDが必要）
                        newRow.innerHTML = `
                            <td>${titleVal}</td>
                            <td style="white-space: pre-wrap; word-wrap: break-word;">${contentVal}</td>
                            <td><button type='button' disabled>リロード後に削除可</button></td>
                        `;
                    } else {
                        // tbodyが見つからない場合のフォールバック（リロード）
                        location.reload();
                    }
                } else {
                    alert("サーバーエラーが発生しました");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("通信エラーが発生しました");
            });
        }

        function deleteTopics(topicsId, btn) {
            if(!confirm("削除しますか？")) return;
            const params = new URLSearchParams();
            params.append("command", "deleteTopics");
            params.append("topicsId", topicsId);

            fetch("AdminController", {
                method: "POST",
                body: params,
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            })
            .then(res => {
                if(res.ok) {
                    const row = btn.closest("tr");
                    row.remove();
                } else {
                    alert("削除に失敗しました");
                }
            });
        }
    </script>
</body>
</html>