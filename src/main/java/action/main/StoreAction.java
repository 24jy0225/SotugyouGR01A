package action.main;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import dao.StoreDao;
import model.Store;

/**
 * Servlet implementation class StoreAction
 */
@WebServlet("/StoreAction")
public class StoreAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StoreAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	public List<Store> execute(){
		List<Store> list = new ArrayList<>();
		StoreDao dao = new StoreDao();
		list = dao.findAll();
		return list;
	}

}
