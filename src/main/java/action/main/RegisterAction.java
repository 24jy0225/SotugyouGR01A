package action.main;

import java.util.UUID;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.User;
import util.MailUtil;

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
		
		String token = UUID.randomUUID().toString();
		
		User user = new User();
		user.setName(name);
		user.setUserTel(tel);
		user.setUserEmail(email);
		user.setPassword(password);
		user.setAuthenticate(false);
		user.setUrlToken(token);
		
		UserDao dao = new UserDao();
		boolean result = dao.createUser(user , token);
		
		if(result) {
			req.getSession().setAttribute("tempEmail", email);
			String requestURL = req.getRequestURL().toString();
            String baseURL = requestURL.substring(0, requestURL.lastIndexOf("/"));
            String authenticationURL = baseURL + "/UserController?command=authentication&token=" + token;

            // メール送信 (MailUtil呼び出し)
            MailUtil.sendWelcomeMail(email,authenticationURL);
		}
		
		return result;
		
	}
}
