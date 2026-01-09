package action.Reservation;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import model.Reservation;
import model.User;

/**
 * Servlet implementation class ReservationConfirmAction
 */
@WebServlet("/ReservationConfirmAction")
public class ReservationConfirmAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReservationConfirmAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Reservation execute(HttpServletRequest req) {
		HttpSession session = req.getSession();
		int people = (Integer)session.getAttribute("people");
		LocalDate localDate = (LocalDate)session.getAttribute("localDate");
		LocalDateTime startDateTime = (LocalDateTime)session.getAttribute("selectedTime");
		int courseMinutes = (int) session.getAttribute("Course");
		LocalDateTime endDateTime = startDateTime.plusMinutes(courseMinutes);
		User user = (User)session.getAttribute("LoginUser");
		int seatId = (Integer)session.getAttribute("seatId");
		Reservation reservation = new Reservation(people,localDate,user.getUserId(),seatId,startDateTime,endDateTime);
		
		return reservation;
		
		
	}

}
