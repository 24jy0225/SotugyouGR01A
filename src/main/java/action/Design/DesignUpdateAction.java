package action.Design;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.PhotoDao;

/**
 * Servlet implementation class DesignUpdateAction
 */
@WebServlet("/DesignUpdateAction")
public class DesignUpdateAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DesignUpdateAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		HttpSession session = req.getSession();
		String fileName = (String)session.getAttribute("fileName");
		String category = (String)session.getAttribute("category");
		
		PhotoDao dao = new PhotoDao();
		dao.update(category,fileName);
		
		resp.sendRedirect("DesignCustom.jsp");
		
	}

}
