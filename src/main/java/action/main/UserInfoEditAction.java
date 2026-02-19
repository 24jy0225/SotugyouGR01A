package action.main;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.UserDao;
import model.User;

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

}
