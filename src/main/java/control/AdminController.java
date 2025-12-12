package control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import action.LoginAction;
import action.ReservationHistoryAction;
import action.UserAction;
import model.Reservation;
import model.User;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nextPage = "AdminMain.jsp";
		HttpSession session = req.getSession();
		User user = new User();
		try {
			session.setAttribute("action", "ByAdmin");
			LoginAction loginAction = new LoginAction();
			user =loginAction.execute(req);
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(user != null) {
			List<Reservation> reservationList = new ArrayList<>();
			ReservationHistoryAction action = new ReservationHistoryAction();
			List<User> userList = new ArrayList<>();
			UserAction userAction = new UserAction();
			userList = userAction.execute(req);
			session.setAttribute("userList", userList);
			
			reservationList = action.execute(req);
			session.setAttribute("ReservationHistory", reservationList);
			
			
		}
		

		RequestDispatcher rd = req.getRequestDispatcher(nextPage);
		rd.forward(req, resp);
	}

}
