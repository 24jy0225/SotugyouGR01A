package action.Reservation;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.ReservationDao;

/**
 * Servlet implementation class ReservationDeleteAction
 */
@WebServlet("/ReservationDeleteAction")
public class ReservationDeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReservationDeleteAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String action = (String) session.getAttribute("action");
		String reserveId;
		ReservationDao dao = new ReservationDao();
		switch (action) {
		case "ByAdmin":
			reserveId = (String) session.getAttribute("id");
			return dao.delete(reserveId);
		case "ByUser":
			reserveId = (String) session.getAttribute("reserveId");
			return dao.delete(reserveId);
		}
		return false;
	}

}
