package action;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.ReservationDao;
import model.Reservation;

/**
 * Servlet implementation class ReserveAction
 */
@WebServlet("/ReserveAction")
public class ReserveAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReserveAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    public boolean execute(HttpServletRequest req) {
    	HttpSession session = req.getSession();
    	Reservation r = (Reservation) session.getAttribute("Reservation");
    	ReservationDao dao = new ReservationDao();
		 return dao.insert(r);
    }

}
