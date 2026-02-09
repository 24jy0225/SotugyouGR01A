package action.Seat;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.SeatDao;

/**
 * Servlet implementation class SeatEditAction
 */
@WebServlet("/SeatEditAction")
public class SeatEditAction{
public boolean execute(HttpServletRequest req , HttpServletResponse resp) throws IOException {
    	
    	HttpSession session = req.getSession();
    	int seatId = (int)session.getAttribute("seatId");
    	boolean seatActive = (boolean)session.getAttribute("seatActive");
    	SeatDao dao = new SeatDao();
    	return dao.editCoupon(seatId, seatActive);
        
	}

}
