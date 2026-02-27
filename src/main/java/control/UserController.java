package control;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
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
import action.Photo.PhotoAction;
import action.Reservation.ReservationCancelAction;
import action.Reservation.ReservationConfirmAction;
import action.Reservation.ReservationDateAction;
import action.Reservation.ReservationHistoryAction;
import action.Reservation.ReservationSeatAction;
import action.Reservation.ReservationTimeAction;
import action.Reservation.ReserveAction;
import action.Reservation.ReserveFindAction;
import action.Topics.TopicsAction;
import action.main.AuthenticateAction;
import action.main.LoginAction;
import action.main.PasswordResetAction;
import action.main.RegisterAction;
import action.main.StoreAction;
import action.main.UserInfoEditAction;
import dao.UserDao;
import model.CouponUsage;
import model.Photo;
import model.Reservation;
import model.Seat;
import model.Store;
import model.Topics;
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String command = req.getParameter("command");
		String nextPage = null;

		if (command == null) {
			resp.sendRedirect("index.jsp");
			return;
		}

		List<String> noLoginRequired = List.of(
				"LoginAction", "UserRegister", "RegisterAction", "goMain",
				"passwordReset", "passwordResetInput",
				"authentication", "Course", "Seat", "Time", "reservationDate");

		if (!noLoginRequired.contains(command)) {

			HttpSession session = req.getSession(false);

			if (session == null || session.getAttribute("LoginUser") == null) {

				req.setAttribute("errorMsg", "一定時間操作がなかったため、自動的にログアウトしました。再度ログインしてください。");
				RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
				rd.forward(req, resp);
				return;
			}
		}
		HttpSession session = req.getSession();
		switch (command) {
		case "Course":
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
		case "authentication":
			AuthenticateAction authenticateAction = new AuthenticateAction();
			boolean authenticateResult = authenticateAction.execute(req);
			if (authenticateResult) {
				if (session != null) {
					session.invalidate();
				}
				req.setAttribute("msg", "認証が完了しました。ログインしてください。");
				nextPage = "Success.jsp";
			} else {
				session.setAttribute("errorMsg", "無効なリンクか、有効期限切れです。");
				nextPage = "Error.jsp";
			}
			break;
		case "passwordReset":
			req.setAttribute("token", req.getParameter("token"));
			nextPage = "PasswordResetInput.jsp";
			break;
		case "reservationDate":
			ReservationDateAction reservationDateAction = new ReservationDateAction();
			reservationDateAction.execute(req);
			nextPage = "ReservationDate.jsp";
			break;
		case "goMain":
			TopicsAction topicsAction = new TopicsAction();
			List<Topics> topicsList = topicsAction.execute();
			PhotoAction photoAction = new PhotoAction();
			List<Photo> photoList = photoAction.execute();
			Collections.reverse(topicsList);
			List<Topics> top4List = new ArrayList<>();
			int limit = Math.min(4, topicsList.size());

			for (int i = 0; i < limit; i++) {
				top4List.add(topicsList.get(i));
			}
			session.setAttribute("top4List", top4List);
			session.setAttribute("topicsList", topicsList);
			session.setAttribute("photoList", photoList);
			nextPage = "top.jsp";
			break;
		case "cancelConfirm":
			nextPage = "reservation_cancel.jsp";
			String reserveId = req.getParameter("reserveId");
			session.setAttribute("reserveId", reserveId);
			ReserveFindAction reservationFindAction = new ReserveFindAction();
			Reservation r = reservationFindAction.execute(req);
			session.setAttribute("findReserve", r);
			break;
		case "cancel":
			reserveId = req.getParameter("reserveId");
			session.setAttribute("cancelReserveId", reserveId);
			ReservationCancelAction reservationCancelAction = new ReservationCancelAction();
			r = reservationCancelAction.execute(req);
			if (r != null) {
				session.setAttribute("cancelReserve", r);
				resp.sendRedirect("ReservationCancelComplete.jsp");
				return;
			} else {
				nextPage = "Error.jsp";
				session.setAttribute("errorMsg", "cancelできませんでした");
				break;
			}
		case "logout":
			nextPage = "index.jsp";
			session = req.getSession();
			if (session != null) {
				session.invalidate();
			}
			break;

		default:
			nextPage = "Error.jsp"; // 例としてエラーページを設定
			session.setAttribute("errorMsg", "無効なGETコマンド: " + command);
			break;
		}
		RequestDispatcher rd = req.getRequestDispatcher(nextPage);
		rd.forward(req, resp);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");

		HttpSession session = null;
		String nextPage = null;
		String command = req.getParameter("command");
		if (command == null) {
			resp.sendRedirect("index.jsp");
			return;
		}

		List<String> noLoginRequired = List.of(
				"LoginAction", "UserRegister", "RegisterAction", "goMain",
				"passwordReset", "passwordResetInput", "Reserve");

		if (!noLoginRequired.contains(command)) {

			session = req.getSession(false);

			if (session == null || session.getAttribute("LoginUser") == null) {

				req.setAttribute("errorMsg", "一定時間操作がなかったため、自動的にログアウトしました。再度ログインしてください。");
				RequestDispatcher rd = req.getRequestDispatcher("Login.jsp");
				rd.forward(req, resp);
				return;
			}
		}
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
				nextPage = "UserAuthentication.jsp";
			} else {
				nextPage = "Error.jsp";
				req.setAttribute("errorMsg", "登録処理またはメール送信に失敗しました");
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
					nextPage = "top.jsp"; // 普通のログイン時
				}

			} else {
				nextPage = "Error.jsp";
				session.setAttribute("errorMsg", "ユーザーが見つかりませんでした");
			}

			break;
		case "Reserve":

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
				ReservationConfirmAction reservationConfirmAction = new ReservationConfirmAction();
				Reservation reservation = reservationConfirmAction.execute(req);
				session.setAttribute("Reservation", reservation);
				ReserveAction action = new ReserveAction();
				if (action.execute(req)) {

					nextPage = "ReservationCompleted.jsp";
				} else {
					nextPage = "Error.jsp";
					req.setAttribute("errorMsg", "予約失敗");
				}
			} else {
				// 未ログイン → ログイン後に戻る画面を保存
				session.setAttribute("afterLoginPage", "ReservationTime.jsp");
				nextPage = "Login.jsp";
			}

			break;
		case "History":
			nextPage = "UserReservationHistory.jsp";
			session = req.getSession();
			List<Reservation> list = new ArrayList<>();
			ReservationHistoryAction reservationHistoryAction = new ReservationHistoryAction();
			list = reservationHistoryAction.execute(req);
			session.setAttribute("reservationHistory", list);
			break;
		case "useCoupon":
			try {
				session = req.getSession();
				String couponId = req.getParameter("couponNumber");
				session.setAttribute("couponId", couponId);
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
		case "passwordReset":
			PasswordResetAction passwordResetAction = new PasswordResetAction();
			if (passwordResetAction.execute(req)) {
				req.setAttribute("alertMsg", "再設定用のメールを送信しました。30分以内に確認してください。");
			} else {
				req.setAttribute("alertMsg", "メール送信に失敗しました。アドレスが正しいか確認してください。");
			}
			nextPage = "PasswordReset.jsp";
			break;
		case "passwordResetInput":
			session = req.getSession();
			String token = req.getParameter("token");
			String newPass = req.getParameter("password");
			String confirm = req.getParameter("confirmPassword");
			if (newPass != null && newPass.equals(confirm)) {
				UserDao dao = new UserDao();
				if (dao.updatePassword(token, newPass)) {
					nextPage = "PasswordResetCompleted.jsp";
				} else {
					nextPage = "Error.jsp";
					session.setAttribute("errorMsg", "有効期限切れか、不正なアクセスです。");
				}
			} else {
				session.setAttribute("message", "パスワードが一致しませんでした。");
				resp.sendRedirect("PasswordResetInput.jsp");
				return;
			}
			break;
		case "userInfoEdit":
			//次やるところ
			session = req.getSession();
			String email = req.getParameter("email");
			String preEmail = req.getParameter("preEmail");
			String tel = req.getParameter("tel");
			String name = req.getParameter("name");
			session.setAttribute("email", email);
			session.setAttribute("tel", tel);
			session.setAttribute("name", name);
			UserInfoEditAction userInfoEditAction = new UserInfoEditAction();
			if (preEmail.equals(email)) {
				user = userInfoEditAction.execute(req);
				if (user != null) {
					session.setAttribute("LoginUser", user);
					session.setAttribute("message", "会員情報を変更しました！");
					resp.sendRedirect("UserInfoEdit.jsp");
					return;
				} else {
					session.setAttribute("errorMsg", "変更失敗");
					nextPage = "Error.jsp";
					break;
				}
			} else if (!preEmail.equals(email)) {
				session.setAttribute("tempEmail", email);
				boolean result = userInfoEditAction.update(req);
				if (result) {
					req.setAttribute("msg", "名前・電話番号を更新し、新しいアドレスに確認メールを送信しました。");
					nextPage = "UserAuthentication.jsp";
				} else {
					req.setAttribute("errorMsg", "更新処理またはメール送信に失敗しました。");
					nextPage = "Error.jsp";
				}
				break;
			}
			break;
		default:
			nextPage = "Error.jsp";
			req.setAttribute("errorMsg", "不正なポストコマンド: " + command);
			break;
		}

		RequestDispatcher rd = req.getRequestDispatcher(nextPage);
		rd.forward(req, resp);
	}

}
