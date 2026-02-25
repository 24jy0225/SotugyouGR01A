package action.Reservation;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.ReservationDao;
import model.Reservation;

/**
 * Servlet implementation class ReserveFindAction
 */
@WebServlet("/ReserveFindAction")
public class ReserveFindAction{
	public Reservation execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String reserveId = (String)session.getAttribute("reserveId");
		ReservationDao dao = new ReservationDao();
		return dao.findByRid(reserveId);
	}

}
