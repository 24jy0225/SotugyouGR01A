<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.* , model.Topics"%>
<%
List<Topics> topicsList = (List<Topics>) session.getAttribute("topicsList");
String meg = (String) session.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/admin/adminStyle.css">
<link rel="stylesheet" href="./css/admin/adminTopicsStyle.css">
<link rel="icon" href="./image/assets/Admin_logo.png">
<title>管理者トピックス管理</title>
</head>
<body>
	<header>
		<nav class="nav-menu">
			<button onclick="location.href='ReservationManage.jsp'">予約管理</button>
			<button onclick="location.href='UserManage.jsp'">顧客管理</button>
			<button onclick="location.href='CouponManage.jsp'">クーポン管理</button>
			<button onclick="location.href='TopicsManage.jsp'">お知らせ管理</button>
			<button onclick="location.href='DesignCustom.jsp'">Webサイト管理</button>
		</nav>
	</header>
	<%
	String msg = (String) session.getAttribute("message");
	if (msg != null) {
	%>
	<div id="status-message"
		style="color: green; font-weight: bold; border: 1px solid green; padding: 10px; margin-bottom: 10px;">
		<%=msg%>
	</div>
	<%
	// 一度表示したら消す（そうしないと、ずっと表示され続けてしまうため）
	session.removeAttribute("message");
	}
	%>
	<main>

		<div class="add-topic">
			<div class="topics-head">
				<table>
					<tr>
						<td>お知らせ管理</td>
					</tr>
					<tr>
						<td>お知らせの追加、削除ができます</td>
					</tr>
				</table>
			</div>
			<form id="topicsAddForm" class="add-topic-form"
				action="AdminController" method="POST" enctype="multipart/form-data"
				onsubmit="return addTopics();">
				<div class="topics-form-div">
					<label for="topics_title">タイトル</label> <input type="text"
						name="topicsTitle" id="topics_title" placeholder="トピックタイトル"
						class="topic-title">
				</div>
				<div class="topics-form-div">
					<label for="topics_content">内容</label>
					<textarea name="topicsContent" id="topics_content"
						placeholder="トピック内容" maxlength="1000" class="topic-content"></textarea>
				</div>
				<div class="topics-form-div">
					<label for="photo_id">画像</label> <input type="file"
						accept="image/png,image/jpeg,image/jpg" name="image" id="photo_id"
						class="topic-photo" onchange="previewImage(this)" required>
				</div>
				<div class="topics-form-div">
					<input type="submit" value="＋　追加する" id="topic-submit"
						class="topic-submit"> <input type="hidden" name="command"
						value="topicsAdd">
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
            
            // バリデーション
            const titleVal = document.getElementById("topics_title").value;
            const contentVal = document.getElementById("topics_content").value;
            const photoInput = document.getElementById("photo_id");

            if(!titleVal || !contentVal || !photoInput.value){
                alert("タイトル、内容、写真は必須です");
                return false;
            }
            return true;

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
                    const titleRow = btn.closest("tr");
                    const contentRow = titleRow.nextElementSibling; // 次の行（内容行）を取得
                    titleRow.remove();
                    if(contentRow) contentRow.remove();
                    const msgDiv = document.getElementById("status-message");
                    msgDiv.innerText = "お知らせを削除しました"; // メッセージを設定
                    msgDiv.style.display = "block";

                    setTimeout(() => {
                        msgDiv.style.display = "none";
                    }, 3000);
                    
                } else {
                    alert("削除に失敗しました");
                }
            });
        }
    </script>
</body>
</html>