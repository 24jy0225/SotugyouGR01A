package action;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
		HttpSession session = req.getSession();
    	String action = (String)session.getAttribute("action");
    	User user = null;
    	UserDao dao = new UserDao();
    	switch(action){
    	case "Byuser":
    		String password = req.getParameter("password");
    		String email = req.getParameter("email");
    		user = dao.Login(email, password);
    		break;
    	case "ByAdmin":
    		String adminId = req.getParameter("adminId");
    		String adminPassword = req.getParameter("adminPassword");
    		user = dao.adminLogin(adminId, adminPassword);
    		
    	}
    	return user;
	}

}
