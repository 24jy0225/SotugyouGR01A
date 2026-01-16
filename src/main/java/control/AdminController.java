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

import action.Coupon.CouponAction;
import action.Coupon.CouponCreateAction;
import action.Coupon.CouponDeleteAction;
import action.Coupon.CouponEditAction;
import action.Reservation.ReservationDeleteAction;
import action.Reservation.ReservationHistoryAction;
import action.Reservation.ReservationSeatAction;
import action.main.LoginAction;
import action.main.StoreAction;
import action.main.UserAction;
import model.Coupon;
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
		String nextPage = null;
		HttpSession session = req.getSession();
		String command = (String) req.getParameter("command");
		switch(command) {
		case "editCoupon" :
			nextPage = "CouponManage.jsp";
			List<Coupon> couponList = new ArrayList<>();
			CouponAction couponAction = new CouponAction();
			couponList = couponAction.execute(req);
			session.setAttribute("couponList", couponList);
		}

		if (nextPage != null) {
			RequestDispatcher rd = req.getRequestDispatcher(nextPage);
			rd.forward(req, resp);
		} else {
			// もしどこにも行く場所がなければデフォルトのページへ
			resp.sendRedirect("AdminMain.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nextPage = null;
		HttpSession session = req.getSession();
		String command = (String) req.getParameter("command");
		List<Reservation> reservationList = new ArrayList<>();
		ReservationHistoryAction action = new ReservationHistoryAction();
		if (command == null) {
			resp.sendRedirect("AdminLogin.jsp"); // とりあえず戻す
			return;
		}
		switch (command) {
		case "reservationDelete":
			String id = (String) req.getParameter("id");
			session.setAttribute("id", id);
			session.setAttribute("action", "ByAdmin");
			ReservationDeleteAction rda = new ReservationDeleteAction();
			boolean flag = rda.execute(req);
			reservationList = action.execute(req);
			if (flag && reservationList != null) {
				session.setAttribute("ReservationHistoryList", reservationList);
				session.setAttribute("message", "予約を削除しました。");
				resp.sendRedirect("ReservationManage.jsp");
				return;
			} else {
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

				List<Coupon> couponList = new ArrayList<>();
				CouponAction couponAction = new CouponAction();
				couponList = couponAction.execute(req);
				session.setAttribute("couponList", couponList);

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
		case "createCoupon":
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

			CouponCreateAction cca = new CouponCreateAction();
			flag = cca.execute(req);
			if (flag) {
				nextPage = "CreateCouponSuccess.jsp";
			} else {
				session.setAttribute("errorMsg", "クーポン作成エラー");
				nextPage = "Error.jsp";
			}
			break;
		case "editCoupon":
			String couponNumber = req.getParameter("couponNumber");
			boolean couponActive = Boolean.parseBoolean(req.getParameter("couponActive"));

			session.setAttribute("couponNumber", couponNumber);
			session.setAttribute("couponActive", couponActive);

			try {
				CouponEditAction editCouponAction = new CouponEditAction();
				editCouponAction.execute(req, resp);
				return;
			} catch (Exception e) {
				// エラーが発生した場合の処理
				e.printStackTrace();
				req.setAttribute("errorMsg", "クーポンのステータス変更処理でエラーが発生しました。");
				nextPage = "Error.jsp";
				break;
			}
		case "deleteCoupon" :
			couponNumber = req.getParameter("couponNumber");
			session.setAttribute("couponNumber", couponNumber);
			System.out.println(couponNumber);
			CouponDeleteAction couponDeleteAction = new CouponDeleteAction();
			flag = couponDeleteAction.execute(req);
			
			List<Coupon> couponList = new ArrayList<>();
			CouponAction couponAction = new CouponAction();
			couponList = couponAction.execute(req);
			
			if (flag && couponList != null) {
				session.setAttribute("couponList", couponList);
				session.setAttribute("message", "クーポンを削除しました。");
				resp.sendRedirect("CouponManage.jsp");
				return;
			} else {
				session.setAttribute("errorMsg", "クーポン削除エラー");
				nextPage = "Error.jsp";
			}
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
