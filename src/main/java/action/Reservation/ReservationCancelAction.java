package action.Reservation;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.ReservationDao;
import model.Reservation;

/**
 * Servlet implementation class ReservationCancelAction
 */
@WebServlet("/ReservationCancelAction")
public class ReservationCancelAction {
	public Reservation execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String action = (String) session.getAttribute("action");
		String reserveId;
		ReservationDao dao = new ReservationDao();
		switch (action) {
		case "ByAdmin":
			reserveId = (String) session.getAttribute("id");
		case "ByUser":
			reserveId = (String) session.getAttribute("reserveId");
			return dao.cancel(reserveId);
		}
		return null;
	}

}
