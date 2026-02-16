package action.Design;

import java.io.File;
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
public class DesignUpdateAction {

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DesignUpdateAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		HttpSession session = req.getSession();
		String category = (String) session.getAttribute("category");
		String webPath = (String) session.getAttribute("webPath");
		System.out.println("カテゴリ: " + category);

		PhotoDao dao = new PhotoDao();
		String dbPath = dao.findCurrentFileName(category);
		System.out.println("DBから取得したパス: " + dbPath);
		if (dbPath != null && !dbPath.isEmpty()) {

			String fileName = dbPath.substring(dbPath.lastIndexOf("/") + 1);
			String serverSaveDir = req.getServletContext().getRealPath("/image/photo");
			File serverFile = new File(serverSaveDir + File.separator + fileName);
			if (serverFile.exists()) {
				serverFile.delete();
			}

		}
		dao.update(category, webPath);

		resp.sendRedirect("DesignCustom.jsp");

	}

}
