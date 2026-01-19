package action;

import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import dao.TopicsDao;
import model.Topics;

/**
 * Servlet implementation class TopicsAction
 */
@WebServlet("/TopicsAction")
public class TopicsAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopicsAction() {
        super();
        // TODO Auto-generated constructor stub
    }

public List<Topics> execute() {
    	TopicsDao dao = new TopicsDao();
    	return dao.findAll();
	}

}
