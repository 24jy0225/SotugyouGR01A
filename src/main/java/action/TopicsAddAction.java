package action;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.TopicsDao;

/**
 * Servlet implementation class TopicsAddAction
 */
@WebServlet("/TopicsAddAction")
public class TopicsAddAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopicsAddAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		HttpSession session = req.getSession();
		String fileName = (String)session.getAttribute("fileName");
		String category = (String)session.getAttribute("category");
		
		TopicsDao dao = new TopicsDao();
		dao.update(category,fileName);
		
		resp.sendRedirect("PhotoList.jsp");
		
	}

}
