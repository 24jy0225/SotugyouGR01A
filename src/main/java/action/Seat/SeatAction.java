package action.Seat;

import java.util.List;

import jakarta.servlet.annotation.WebServlet;

import dao.SeatDao;
import model.Seat;

/**
 * Servlet implementation class SeatAction
 */
@WebServlet("/SeatAction")
public class SeatAction {
	public List<Seat> execute() {
		SeatDao dao = new SeatDao();
		return dao.findAll();
	}

}
