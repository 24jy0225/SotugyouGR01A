package control;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import action.CreateCouponAction;
import action.LoginAction;
import action.ReservationDeleteAction;
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
		doPost(req , resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nextPage = null;
		HttpSession session = req.getSession();
		String command = (String)req.getParameter("command");
		List<Reservation> reservationList = new ArrayList<>();
		ReservationHistoryAction action = new ReservationHistoryAction();
		if (command == null) {                                                                                                                                                                                                                     
	        resp.sendRedirect("AdminLogin.jsp"); // とりあえず戻す
	        return; 
	    }
		switch (command) {
		case "delete":
			String id = (String)req.getParameter("id");
			session.setAttribute("id", id);
			session.setAttribute("action", "ByAdmin");
			ReservationDeleteAction rda = new ReservationDeleteAction();
			boolean flag = rda.execute(req);
			reservationList = action.execute(req);
			if(flag && reservationList != null) {
				session.setAttribute("ReservationHistoryList", reservationList);
				session.setAttribute("message", "予約を削除しました。");
				resp.sendRedirect("ReservationManage.jsp");		
				return;
			}else {
				session.setAttribute("errorMsg", "予約削除エラー");
				nextPage = "Error.jsp";
			}
			break;
		case "login":			
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
			break;
		case "createCoupon" :
			String couponName = req.getParameter("couponName");
			String couponDetail = req.getParameter("couponDetail");
			String startDateStr = req.getParameter("startDate");
		    String endDateStr = req.getParameter("endDate");
		    LocalDate startDate = LocalDate.parse(startDateStr);
		    LocalDate endDate = LocalDate.parse(endDateStr);
		    
		    session.setAttribute("couponName", couponName);
		    session.setAttribute("couponDetail", couponDetail);
		    session.setAttribute("startDate", startDate);
		    session.setAttribute("endDate", endDate);

			CreateCouponAction cca = new CreateCouponAction();
			flag = cca.execute(req);
			if(flag) {
				nextPage = "CreateCouponSuccess.jsp";	
			}else {
				session.setAttribute("errorMsg", "クーポン作成エラー");
				nextPage = "Error.jsp";
			}
			break;
		}
		if (nextPage != null) {
	        RequestDispatcher rd = req.getRequestDispatcher(nextPage);
	        rd.forward(req, resp);
	    } else {
	        // もしどこにも行く場所がなければデフォルトのページへ
	        resp.sendRedirect("AdminMain.jsp");
	    }
	}

}
