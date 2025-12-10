package action;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;

import dao.UserDao;
import model.User;

/**
 * Servlet implementation class LoginAction
 */
@WebServlet("/LoginAction")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	public User execute(HttpServletRequest req) {
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		
		UserDao dao = new UserDao();
		User user = dao.Login(email, password);
	
		return user;
	}

}
