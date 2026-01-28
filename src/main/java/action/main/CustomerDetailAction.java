package action.main;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.UserDao;
import model.User;

/**
 * Servlet implementation class CustomerDetailAction
 */
@WebServlet("/CustomerDetailAction")
public class CustomerDetailAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerDetailAction() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public User execute(HttpServletRequest req) {
    	HttpSession session = req.getSession();
    	String userId = (String)session.getAttribute("userId");
    	UserDao dao = new UserDao();
    	return dao.findById(userId);
    }

}
