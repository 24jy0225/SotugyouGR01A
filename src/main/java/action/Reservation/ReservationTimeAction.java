package action.Reservation;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.ReservationTimeDao;

/**
 * Servlet implementation class ReservationTimeAction
 */
@WebServlet("/ReservationTimeAction")
public class ReservationTimeAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReservationTimeAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	public List<LocalDateTime> execute(HttpServletRequest req) {
		HttpSession session = req.getSession();
		Integer seatId = (Integer) session.getAttribute("seatId");
		Integer course = (Integer) session.getAttribute("Course");
		LocalDate localDate = (LocalDate)session.getAttribute("localDate");
		//System.out.println(seatId);
		//System.out.println(course);
		//System.out.println(localDate);
		if (localDate == null || seatId == 0 || course == 0) {
		    return null;  
		}
		List<LocalDateTime> list = new ArrayList<>();
		ReservationTimeDao dao = new ReservationTimeDao();
		 list = dao.findAvailableSlots(localDate , seatId , course);
		 return list;
	}

}
