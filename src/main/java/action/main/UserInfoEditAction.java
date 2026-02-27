package action.main;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.UserDao;
import model.User;
import util.MailUtil;

/**
 * Servlet implementation class UserInfoEditAction
 */
@WebServlet("/UserInfoEditAction")
public class UserInfoEditAction {
	public User execute(HttpServletRequest req) {
    	UserDao dao = new UserDao();
    	HttpSession session = req.getSession();
    	String email = (String) session.getAttribute("email");
    	String tel = (String) session.getAttribute("tel");
    	String name = (String) session.getAttribute("name");
    	User user = (User)session.getAttribute("LoginUser");
    	return dao.update(user.getUserId(), name,tel,email);
    }
	
	public boolean update(HttpServletRequest req) {
    	UserDao dao = new UserDao();
    	HttpSession session = req.getSession();
    	String token = java.util.UUID.randomUUID().toString();
    	String email = (String) session.getAttribute("email");
    	String tel = (String) session.getAttribute("tel");
    	String name = (String) session.getAttribute("name");
    	User user = (User)session.getAttribute("LoginUser");
    	boolean result = dao.updateProfileWithTempEmail(user.getUserId(), name, tel, email, token);
    	if(result) {
            // 2. ログイン中のユーザー情報（セッション用）も最新の名前・電話番号に更新しておく
            user.setName(name);
            user.setUserTel(tel);

            // 3. メール送信URL組み立て
            String requestURL = req.getRequestURL().toString();
            String baseURL = requestURL.substring(0, requestURL.lastIndexOf("/"));
            String authenticationURL = baseURL + "/UserController?command=authentication&token=" + token;

            // 4. 新しいアドレスに送信
            MailUtil.sendWelcomeMail(email,authenticationURL);
        }
        return result;
    }

}
