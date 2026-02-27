package action.main;

import java.util.UUID;

import jakarta.servlet.http.HttpServletRequest;

import dao.UserDao;
import util.MailUtil;

public class PasswordResetAction {
	public boolean execute(HttpServletRequest req) {
		String email = req.getParameter("email");
		String token = UUID.randomUUID().toString();

		UserDao dao = new UserDao();

		if (dao.setPasswordResetToken(email, token)) {
			String requestURL = req.getRequestURL().toString();
			String baseURL = requestURL.substring(0, requestURL.lastIndexOf("/"));
			String resetURL = baseURL + "/UserController?command=passwordReset&token=" + token;

			MailUtil.sendPasswordResetMail(email, resetURL);

			return true;
		}
		return false;
	}

}
