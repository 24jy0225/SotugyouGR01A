package action.Seat;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.SeatDao;

/**
 * Servlet implementation class SeatAddAction
 */
@WebServlet("/SeatAddAction")
public class SeatAddAction  {
	public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession();
		int seatCount = (int)session.getAttribute("seatCount");
		SeatDao dao = new SeatDao();
		return dao.insert(seatCount+1);
	}

}
