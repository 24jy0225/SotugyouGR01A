package action.Photo;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.PhotoDao;

/**
 * Servlet implementation class PhotoUpdateAction
 */
@WebServlet("/PhotoUpdateAction")
public class PhotoUpdateAction extends HttpServlet {
	public String execute(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String category = (String) session.getAttribute("category");
		PhotoDao dao = new PhotoDao();
		return dao.findCurrentFileName(category);
	}

}
