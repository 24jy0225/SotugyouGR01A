<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.* , model.Topics"%>
<%
List<Topics> topicsList = (List<Topics>)session.getAttribute("topicsList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>お知らせ管理</title>
</head>
<body>
    <form id="topicsAddForm">
        <p>トピックタイトル</p>
        <p><input type="text" name="topicsTitle" id="titleField"></p>
        <p>説明</p>
        <p><textarea name="topicsContent" id="contentField" maxlength="254"></textarea></p>
        画像：<input type="file" name="image" id="imageField" accept="image/png, image/jpeg, image/jpg" ><br>
        
        <button type="button" onclick="addTopics()">追加</button>
        <input type="hidden" name="command" value="topicsAdd">
    </form>

    <p>登録済みトピックス</p>
    <table border="1">
        <thead>
            <tr><th>タイトル</th><th>内容</th><th>操作</th></tr>
        </thead>
        <tbody id="topicsTbody">
            <% if(topicsList != null){ %>
                <% for(Topics t : topicsList){ %>
                <tr>
                    <td><%= t.getTopicsTitle() %></td>
                    <td><%= t.getTopicsContent() %></td>
                    <td><button type="button" onclick="deleteTopics(<%= t.getTopicsId() %>, this)">削除</button></td>
                </tr>
                <% } %>
            <% } %>
        </tbody>
    </table>

    <script type="text/javascript">
        // ブラウザに「addTopicsという関数があるよ」と教える
        function addTopics() {
            const form = document.getElementById("topicsAddForm");
            const formData = new FormData(form);
            
            const titleVal = document.getElementById("titleField").value;
            const contentVal = document.getElementById("contentField").value;

            fetch("AdminController", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if(response.ok) {
                    // 入力をクリア
                    document.getElementById("titleField").value = "";
                    document.getElementById("contentField").value = "";
                    document.getElementById("imageField").value = "";

                    // 行を増やす
                    const tbody = document.getElementById("topicsTbody");
                    const newRow = tbody.insertRow();
                    newRow.innerHTML = `<td>\${titleVal}</td><td>\${contentVal}</td><td>(再読込後に削除可)</td>`;
                    alert("登録成功！");
                } else {
                    alert("サーバーエラーです");
                }
            })
            .catch(error => console.error("Error:", error));
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
                if(res.ok) btn.closest("tr").remove();
            });
        }
    </script>
</body>
</html>