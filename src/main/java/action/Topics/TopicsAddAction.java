package action.Topics;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.TopicsDao;
import model.Topics;

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

	public boolean execute(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		HttpSession session = req.getSession();
		String topicsTitle = (String) session.getAttribute("topicsTitle");
		String topicsContent = (String) session.getAttribute("topicsContent");
		String fileName = (String) session.getAttribute("fileName");

		try {
			TopicsDao dao = new TopicsDao();
			int photoId = dao.insertPhoto(fileName);

			if (photoId != -1) {
				dao.insertTopic(photoId, topicsTitle, topicsContent);
				
				List<Topics> topicsList = new ArrayList<>();
				topicsList = dao.findAll();
				session.setAttribute("topicsList", topicsList);
				return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
