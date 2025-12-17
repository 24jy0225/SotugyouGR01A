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
import action.ReservationSeatAction;
import action.StoreAction;
import action.UserAction;
import model.Reservation;
import model.Seat;
import model.Store;
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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String date = (String) req.getParameter("date");
		String nextPage = "ReservationManage.jsp";
		HttpSession session = req.getSession();

		session.setAttribute("date", date);
		RequestDispatcher rd = req.getRequestDispatcher(nextPage);
		rd.forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nextPage = null;
		HttpSession session = req.getSession();

		User user = new User();
		try {
			session.setAttribute("adminId", "ADMIN");
			session.setAttribute("AdminPassword", req.getParameter("AdminPassword"));
			session.setAttribute("action", "ByAdmin");
			LoginAction loginAction = new LoginAction();
			user = loginAction.execute(req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (user != null) {
			nextPage = "AdminMain.jsp";
			
			List<Reservation> reservationList = new ArrayList<>();
			ReservationHistoryAction action = new ReservationHistoryAction();
			List<User> userList = new ArrayList<>();
			UserAction userAction = new UserAction();

			StoreAction storeAction = new StoreAction();
			List<Store> storeList = new ArrayList<>();
			storeList = storeAction.execute();
			session.setAttribute("storeList", storeList);

			ReservationSeatAction rsa = new ReservationSeatAction();
			List<Seat> seatList = rsa.execute(req);
			session.setAttribute("Seat", seatList);

			userList = userAction.execute(req);
			session.setAttribute("UserList", userList);

			reservationList = action.execute(req);
			session.setAttribute("ReservationHistoryList", reservationList);
		}

		RequestDispatcher rd = req.getRequestDispatcher(nextPage);
		rd.forward(req, resp);
	}

}
