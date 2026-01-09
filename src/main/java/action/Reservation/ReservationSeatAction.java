package action.Reservation;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.SeatDao;
import model.Seat;

/**
 * Servlet implementation class ReservationSeatAction
 */
@WebServlet("/ReservationSeatAction")
public class ReservationSeatAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReservationSeatAction() {
        super();
        // TODO Auto-generated constructor stub
    }
    public List<Seat> execute(HttpServletRequest req) {
    	HttpSession session = req.getSession();
    	List<Seat> list = new ArrayList<>();
    	String action = (String)session.getAttribute("action");
    	SeatDao dao = new SeatDao();
    	switch(action) {
    	case "ByUser":
    		int storeNumber = (int)session.getAttribute("storeNumber");    		
    		list = dao.findByStoreNumber(storeNumber);
    		break;
    	case "ByAdmin":
    		list = dao.findAll();
    	}
		 return list;
    }
}
