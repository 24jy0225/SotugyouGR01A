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
		String command = (String) session.getAttribute("action");
		Reservation reservation;
		int people , courseMinutes , seatId;
		User user;
		LocalDate localDate;
		LocalDateTime startDateTime,endDateTime;
		switch (command) {
		case "ByAdmin":
			people = (Integer) session.getAttribute("people");
			localDate = (LocalDate) session.getAttribute("localDate");
			startDateTime = (LocalDateTime) session.getAttribute("selectedTime");
			courseMinutes = (int) session.getAttribute("Course");
			endDateTime = startDateTime.plusMinutes(courseMinutes);
			user = (User) session.getAttribute("targetUser");
			seatId = (Integer) session.getAttribute("seatId");
			break;
		default:
			people = (Integer) session.getAttribute("people");
			localDate = (LocalDate) session.getAttribute("localDate");
			startDateTime = (LocalDateTime) session.getAttribute("selectedTime");
			courseMinutes = (int) session.getAttribute("Course");
			endDateTime = startDateTime.plusMinutes(courseMinutes);
			user = (User) session.getAttribute("LoginUser");
			seatId = (Integer) session.getAttribute("seatId");
			break;
		}
		reservation = new Reservation(people, localDate, user.getUserId(), seatId, startDateTime,
				endDateTime, user.getName());

		return reservation;

	}

}
