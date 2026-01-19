package action;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.TopicsDao;

/**
 * Servlet implementation class TopicsDeleteAction
 */
@WebServlet("/TopicsDeleteAction")
public class TopicsDeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopicsDeleteAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		
		int topicsId = (int)session.getAttribute("topicsId");
		TopicsDao dao = new TopicsDao();
		return dao.delete(topicsId);
	}

}
