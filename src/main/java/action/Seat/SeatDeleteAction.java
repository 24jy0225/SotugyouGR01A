package action.Seat;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.SeatDao;

/**
 * Servlet implementation class SeatDeleteAction
 */
@WebServlet("/SeatDeleteAction")
public class SeatDeleteAction {
	public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		int seatId = (int)session.getAttribute("seatId");
		SeatDao dao = new SeatDao();
		return dao.delete(seatId);
	}

}
