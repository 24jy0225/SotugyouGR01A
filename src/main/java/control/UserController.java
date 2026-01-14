package control;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import action.Coupon.CouponUsageAction;
import action.Coupon.CouponUseAction;
import action.Reservation.ReservationConfirmAction;
import action.Reservation.ReservationHistoryAction;
import action.Reservation.ReservationSeatAction;
import action.Reservation.ReservationTimeAction;
import action.Reservation.ReserveAction;
import action.main.LoginAction;
import action.main.RegisterAction;
import action.main.StoreAction;
import model.CouponUsage;
import model.Reservation;
import model.Seat;
import model.Store;
import model.User;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String command = req.getParameter("command");
		String nextPage = null;
		HttpSession session = req.getSession();
		switch (command) {
		case "Cource":
			nextPage = "ReservationCourse.jsp";
			String date = req.getParameter("date");
			session.setAttribute("date", date);
			StoreAction storeAction = new StoreAction();
			List<Store> storeList = new ArrayList<>();
			storeList = storeAction.execute();
			session.setAttribute("storeList", storeList);
			session.setAttribute("action", "ByUser");
			break;
		case "Seat":
			nextPage = "ReservationSeat.jsp";
			
			int storeNumber = Integer.parseInt(req.getParameter("storeNumber"));
			int course = Integer.parseInt(req.getParameter("course"));
			
			session.setAttribute("Course", course);
			session.setAttribute("storeNumber", storeNumber);
			
			ReservationSeatAction rsa = new ReservationSeatAction();
			List<Seat> SeatList = rsa.execute(req);
			session.setAttribute("Seat", SeatList);
			
			break;
		case "Time":
			nextPage = "ReservationTime.jsp";
			int seatId = Integer.parseInt(req.getParameter("seatId"));
			String date2 = (String) session.getAttribute("date");
			DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE;
			LocalDate localDate = LocalDate.parse(date2, formatter);
			session.setAttribute("seatId", seatId);
			session.setAttribute("localDate", localDate);
			ReservationTimeAction reservationTimeAction = new ReservationTimeAction();
			List<LocalDateTime> list = reservationTimeAction.execute(req);
			session.setAttribute("timeList", list);
			break;
		case "MyPage":
			nextPage = "MyPage.jsp";
			session = req.getSession();
			session.setAttribute("action", "ByUser");
			ReservationHistoryAction reservationHistoryAction = new ReservationHistoryAction();
			List<Reservation> reservationList = reservationHistoryAction.execute(req);						
			session.setAttribute("reservationHistory", reservationList);
			CouponUsageAction couponAction = new CouponUsageAction();
			List<CouponUsage> couponList = couponAction.execute(req);
			session.setAttribute("couponList", couponList);
			break;
		default:
			nextPage = "Error.jsp"; // 例としてエラーページを設定
			req.setAttribute("errorMsg", "無効なGETコマンド: " + command);
			break;
		}
		RequestDispatcher rd = req.getRequestDispatcher(nextPage);
		rd.forward(req, resp);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");

		HttpSession session = null;
		String nextPage = null;
		String command = req.getParameter("command");

		switch (command) {
		case "UserRegister":
			nextPage = "UserRegister.jsp";

			session = req.getSession();
			if (session != null) {
				session.invalidate();
			}
			break;
		case "RegisterAction":
			RegisterAction ra = new RegisterAction();
			boolean regResult = ra.execute(req);

			if (regResult) {
				nextPage = "Success.jsp";
			} else {
				nextPage = "Error.jsp";
				req.setAttribute("errorMsg", "登録失敗");
			}
			break;
		case "LoginAction":
			session = req.getSession();
			session.setAttribute("action", "ByUser");

			LoginAction loginAction = new LoginAction();
			User user = loginAction.execute(req);

			String after = (String) session.getAttribute("afterLoginPage");

			if (user != null) {
				session.setAttribute("action", "ByUser");
				session.setAttribute("LoginUser", user);
				if (after != null) {
					nextPage = after;
					session.removeAttribute("afterLoginPage");
				} else {
					nextPage = "Main.jsp"; // 普通のログイン時
				}

			} else {
				nextPage = "Error.jsp";
				req.setAttribute("errorMsg", "ユーザーが見つかりませんでした");
			}

			break;
		case "Logaut":
			nextPage = "Main.jsp";
			session = req.getSession();
			if (session != null) {
				session.invalidate();
			}
			break;
		case "Confirm":
			session = req.getSession();

			String selectTime = req.getParameter("selectedTime");
			String peopleStr = req.getParameter("people");

			if (selectTime != null) {
				DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
				LocalDateTime selectedTime = LocalDateTime.parse(selectTime, format);
				session.setAttribute("selectedTime", selectedTime);
			}

			if (peopleStr != null) {
				int people = Integer.parseInt(peopleStr);
				session.setAttribute("people", people);
			}

			User loginUser = (User) session.getAttribute("LoginUser");

			if (loginUser != null) {
				// ログイン済み
				nextPage = "Confirm.jsp";
				
			} else {
				// 未ログイン → ログイン後に戻る画面を保存
				session.setAttribute("afterLoginPage", "Confirm.jsp");
				nextPage = "Login.jsp";
			}

			break;
		case "Reserve":
			
			session = req.getSession();
			
			ReservationConfirmAction reservationConfirmAction = new ReservationConfirmAction();
			Reservation reservation = reservationConfirmAction.execute(req);

			session.setAttribute("Reservation", reservation);
			ReserveAction action = new ReserveAction();
			if (action.execute(req)) {
				nextPage = "ReservationSuccess.jsp";
			} else {
				nextPage = "Error.jsp";
				req.setAttribute("errorMsg", "予約失敗");
			}

			break;
		case "History":
			nextPage = "paipai.jsp";
			session = req.getSession();
			List<Reservation> list = new ArrayList<>();
			ReservationHistoryAction reservationHistoryAction = new ReservationHistoryAction();
			list = reservationHistoryAction.execute(req);						
			session.setAttribute("reservationHistory", list);
			break;
		case "useCoupon":
			try {
		        CouponUseAction useAction = new CouponUseAction();
		        useAction.execute(req, resp);
		        
		        return; 

		    } catch (Exception e) {
		        // エラーが発生した場合の処理
		        e.printStackTrace();
		        req.setAttribute("errorMsg", "クーポンの使用処理でエラーが発生しました。");
		        nextPage = "Error.jsp";
		        break;
		    }
		default:
            nextPage = "Error.jsp";
            req.setAttribute("errorMsg", "不正なポストコマンド: " + command);
            break;
		}

		RequestDispatcher rd = req.getRequestDispatcher(nextPage);
		rd.forward(req, resp);
	}

}
