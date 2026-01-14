package action.main;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.User;

/**
 * Servlet implementation class RegisterAction
 */
@WebServlet("/RegisterAction")
public class RegisterAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	public boolean execute(HttpServletRequest req) {
		String name = req.getParameter("name");
		String tel = req.getParameter("tel");
		if(tel == null) {
			tel = "";
		}
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		if(name == null  || email == null || password == null ) {
			return false;
		}
		
		User user = new User();
		user.setName(name);
		user.setUserTel(tel);
		user.setUserEmail(email);
		user.setPassword(password);
		
		UserDao dao = new UserDao();
		return dao.createUser(user);
	}
}
