package action;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.ReservationDao;
import model.Reservation;
import model.User;

/**
 * Servlet implementation class ReservationHistoryAction
 */
@WebServlet("/ReservationHistoryAction")
public class ReservationHistoryAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReservationHistoryAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    public List<Reservation> execute(HttpServletRequest req) {
    	HttpSession session = req.getSession();
    	String action = (String)session.getAttribute("action");
    	ReservationDao dao = new ReservationDao();
    	switch(action) {   
    	case "ByUser":
    		List<Reservation> list = new ArrayList<>();
    		User user = (User)session.getAttribute("LoginUser");
    		list = dao.ReservationHistoryByUser(user.getUserId());
    		return list;
    	case "ByAdmin":
    		
    	}
    	return null;
    }
	
}
