package action.main;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;

import dao.UserDao;

/**
 * Servlet implementation class AuthenticateAction
 */
@WebServlet("/AuthenticateAction")
public class AuthenticateAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AuthenticateAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public boolean execute(HttpServletRequest req) {
		String token = req.getParameter("token");

		if (token == null || token.isEmpty()) {
			return false;
		}

		UserDao dao = new UserDao();
		
		return dao.completeEmailUpdate(token);

	}

}
