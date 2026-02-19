package control;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import action.Coupon.CouponAction;
import action.Coupon.CouponCreateAction;
import action.Coupon.CouponDeleteAction;
import action.Coupon.CouponEditAction;
import action.Coupon.CouponUsageAction;
import action.Coupon.CouponUseAction;
import action.Design.DesignUpdateAction;
import action.Reservation.ReservationConfirmAction;
import action.Reservation.ReservationDateAction;
import action.Reservation.ReservationDeleteAction;
import action.Reservation.ReservationHistoryAction;
import action.Reservation.ReservationSeatAction;
import action.Reservation.ReservationTimeAction;
import action.Reservation.ReserveAction;
import action.Seat.SeatAction;
import action.Seat.SeatAddAction;
import action.Seat.SeatEditAction;
import action.Topics.TopicsAction;
import action.Topics.TopicsAddAction;
import action.Topics.TopicsDeleteAction;
import action.main.LoginAction;
import action.main.StoreAction;
import action.main.UserAction;
import action.main.UserDeleteAction;
import action.main.UserDetailAction;
import model.Coupon;
import model.CouponUsage;
import model.Reservation;
import model.Seat;
import model.Store;
import model.Topics;
import model.User;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/AdminController")
@MultipartConfig
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminController() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String nextPage = null;
		HttpSession session = req.getSession();
		String command = (String) req.getParameter("command");
		if (command == null) {
			resp.sendRedirect("AdminLogin.jsp");
			return;
		}
		switch (command) {

		case "editCoupon":
			nextPage = "CouponManage.jsp";
			List<Coupon> couponList = new ArrayList<>();
			CouponAction couponAction = new CouponAction();
			couponList = couponAction.execute(req);
			session.setAttribute("couponList", couponList);
			break;
		case "Course":
			nextPage = "ReservationCourse.jsp";
			String date = req.getParameter("date");
			session.setAttribute("date", date);
			StoreAction storeAction = new StoreAction();
			List<Store> storeList = new ArrayList<>();
			storeList = storeAction.execute();
			session.setAttribute("storeList", storeList);
			break;
		case "Seat":
			nextPage = "ReservationSeat.jsp";
			int storeNumber = Integer.parseInt(req.getParameter("storeNumber"));
			int course = Integer.parseInt(req.getParameter("course"));
			session.setAttribute("Course", course);
			session.setAttribute("storeNumber", storeNumber);
			session.setAttribute("action", "ByUser");
			ReservationSeatAction rsa = new ReservationSeatAction();
			List<Seat> SeatList = rsa.execute(req);
			session.setAttribute("Seat", SeatList);
			session.setAttribute("action", "ByAdmin");
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
		case "reservationManage":
			nextPage = "ReservationManage.jsp";
			ReservationHistoryAction action = new ReservationHistoryAction();
			List<Reservation> reservationList = action.execute(req);
			session.setAttribute("ReservationHistoryList", reservationList);
			break;
		}

		if (nextPage != null) {
			RequestDispatcher rd = req.getRequestDispatcher(nextPage);
			rd.forward(req, resp);
		} else {
			resp.sendRedirect("AdminLogin.jsp");
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String nextPage = null;
		HttpSession session = req.getSession();
		String command = (String) req.getParameter("command");
		List<Reservation> reservationList = new ArrayList<>();
		ReservationHistoryAction action = new ReservationHistoryAction();
		boolean success;
		if (command == null) {
			resp.sendRedirect("AdminLogin.jsp");
			return;
		}
		switch (command) {
		case "reservationDelete":
			String id = req.getParameter("id");
			session.setAttribute("id", id);
			session.setAttribute("action", "ByAdmin");
			ReservationDeleteAction rda = new ReservationDeleteAction();
			boolean flag = rda.execute(req);
			if (flag) {
				reservationList = action.execute(req);
				session.setAttribute("ReservationHistoryList", reservationList);
				resp.setStatus(HttpServletResponse.SC_OK);
			} else {
				resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			}
			return;

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
				List<Topics> topicsList = new ArrayList<>();
				TopicsAction topicsAction = new TopicsAction();
				topicsList = topicsAction.execute();
				session.setAttribute("topicsList", topicsList);
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
			String couponContent = req.getParameter("couponContent");
			String startDateStr = req.getParameter("startDate");
			String endDateStr = req.getParameter("endDate");
			LocalDate startDate = LocalDate.parse(startDateStr);
			LocalDate endDate = LocalDate.parse(endDateStr);
			session.setAttribute("couponName", couponName);
			session.setAttribute("couponContent", couponContent);
			session.setAttribute("startDate", startDate);
			session.setAttribute("endDate", endDate);
			CouponCreateAction cca = new CouponCreateAction();
			flag = cca.execute(req);
			if (flag) {
				List<Coupon> couponList = new ArrayList<>();
				CouponAction couponAction = new CouponAction();
				couponList = couponAction.execute(req);
				session.setAttribute("couponList", couponList);
				nextPage = "CouponManage.jsp";
			} else {
				session.setAttribute("errorMsg", "クーポン作成エラー");
				nextPage = "Error.jsp";
			}
			break;

		case "editCoupon":
			String couponId = req.getParameter("couponId");
			boolean couponActive = Boolean.parseBoolean(req.getParameter("couponActive"));
			session.setAttribute("couponId", couponId);
			session.setAttribute("couponActive", couponActive);
			try {
				CouponEditAction editCouponAction = new CouponEditAction();
				editCouponAction.execute(req, resp);
				return;
			} catch (Exception e) {
				e.printStackTrace();
				req.setAttribute("errorMsg", "クーポンのステータス変更処理でエラーが発生しました。");
				nextPage = "Error.jsp";
				break;
			}

		case "deleteCoupon":
			couponId = req.getParameter("couponNumber");
			session.setAttribute("couponNumber", couponId);
			CouponDeleteAction couponDeleteAction = new CouponDeleteAction();
			flag = couponDeleteAction.execute(req);
			List<Coupon> couponList = new ArrayList<>();
			CouponAction couponAction = new CouponAction();
			couponList = couponAction.execute(req);
			UserAction userAction = new UserAction();
			List<User> userList = userAction.execute(req);
			if (flag && couponList != null) {
				session.setAttribute("couponList", couponList);
				session.setAttribute("userList", userList);
				session.setAttribute("message", "クーポンを削除しました。");
				resp.sendRedirect("CouponManage.jsp");
				return;
			} else {
				session.setAttribute("errorMsg", "クーポン削除エラー");
				nextPage = "Error.jsp";
			}
			break;

		case "designUpdate":
			Part part = req.getPart("image");
			String category = req.getParameter("category");

			String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
			String saveDir = getServletContext().getRealPath("/image/photo");
			String webPath = req.getContextPath() + "/image/photo/" + fileName;

			try {

				File dir = new File(saveDir);
				if (!dir.exists())
					dir.mkdirs();

				part.write(saveDir + File.separator + fileName);

			} catch (IOException e) {
				e.printStackTrace();
				resp.sendRedirect("Error.jsp");
				return;
			}

			session.setAttribute("category", category);
			session.setAttribute("webPath", webPath);

			DesignUpdateAction designUpdateAction = new DesignUpdateAction();
			designUpdateAction.execute(req, resp);
			return;

		case "topicsAdd":
			Part topicsPart = req.getPart("image");
			String topicsTitle = req.getParameter("topicsTitle");
			String topicsContent = req.getParameter("topicsContent");

			String contentType = topicsPart.getContentType();
			if (!contentType.startsWith("image/")) {
				req.setAttribute("error", "画像ファイルのみアップロード可能です");
				return;
			}
			if (topicsPart == null || topicsPart.getSize() == 0) {

				resp.sendRedirect("Error.jsp");
				return;
			}

			String tName = topicsPart.getSubmittedFileName();
			String tExt = "";
			int tDot = tName.lastIndexOf(".");
			if (tDot >= 0) {
				tExt = tName.substring(tDot).toLowerCase();
			}
			String tFileName = System.currentTimeMillis() + tExt;

			String tSaveDir = getServletContext().getRealPath("/image/photo");
			String tWebPath = req.getContextPath() + "/image/photo/" + tFileName;

			try {

				File dir = new File(tSaveDir);
				if (!dir.exists())
					dir.mkdirs();

				topicsPart.write(tSaveDir + File.separator + tFileName);

			} catch (IOException e) {
				e.printStackTrace();
				session.setAttribute("errorMsg", "画像の保存に失敗しました");
				resp.sendRedirect("Error.jsp");
				return;
			}

			session.setAttribute("topicsTitle", topicsTitle);
			session.setAttribute("topicsContent", topicsContent);
			session.setAttribute("webPath", tWebPath);

			TopicsAddAction topicsAddAction = new TopicsAddAction();
			success = topicsAddAction.execute(req, resp);

			if (success) {
				resp.setStatus(HttpServletResponse.SC_OK);
			} else {
				resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			}
			return;

		case "deleteTopics":
			int topicsId = Integer.parseInt(req.getParameter("topicsId"));
			session.setAttribute("topicsId", topicsId);
			TopicsDeleteAction topicsDeleteAction = new TopicsDeleteAction();
			success = topicsDeleteAction.execute(req);

			TopicsAction topicsAction = new TopicsAction();
			List<Topics> topicsList = topicsAction.execute();
			session.setAttribute("topicsList", topicsList);

			if (success) {
				resp.setStatus(HttpServletResponse.SC_OK);
			} else {
				resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			}
			return;

		case "userDetail": 
			String userId = req.getParameter("userId");
			session.setAttribute("userId", userId);
			UserDetailAction userDetailAction = new UserDetailAction();
			user = userDetailAction.execute(req);
			session.setAttribute("targetUser", user);
			CouponUsageAction couponUsageAction = new CouponUsageAction();
			List<CouponUsage> couponUsageList = couponUsageAction.execute(req);
			session.setAttribute("couponUsageList", couponUsageList);
			if (user != null) {
				nextPage = "UserDetails.jsp"; // CustomerDetails.jsp -> UserDetails.jsp
			} else {
				session.setAttribute("errorMsg", "ユーザー情報取得エラー");
				nextPage = "Error.jsp";
			}
			break;

		case "deleteUser": // customerDelete -> userDelete
			userId = req.getParameter("userId");
			session.setAttribute("userId", userId);
			UserDeleteAction userDeleteAction = new UserDeleteAction();
			success = userDeleteAction.execute(req);
			if (success) {
				userAction = new UserAction();
				userList = userAction.execute(req);
				session.setAttribute("UserList", userList);
				nextPage = "UserManage.jsp"; // CustomerManage.jsp -> UserManage.jsp
				session.setAttribute("message", "ユーザーを削除しました！");
			} else {
				nextPage = "Error.jsp";
				session.setAttribute("errorMsg", "ユーザーを削除できませんでした");
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

			User targetUser = (User) session.getAttribute("targetUser");
			if (targetUser != null) {
				ReservationConfirmAction reservationConfirmAction = new ReservationConfirmAction();
				Reservation reservation = reservationConfirmAction.execute(req);
				session.setAttribute("Reservation", reservation);
				ReserveAction reserveAction = new ReserveAction();
				if (reserveAction.execute(req)) {
					reservationList = action.execute(req);
					session.setAttribute("ReservationHistoryList", reservationList);
					nextPage = "ReservationCompleted.jsp";
				} else {
					nextPage = "Error.jsp";
					session.setAttribute("errorMsg", "予約失敗");
				}
			} else {
				session.setAttribute("errorMsg", "セッション切れ");
				nextPage = "Error.jsp";
			}

			break;

		case "makeUserReserve": // customerReserve -> userReserve
			nextPage = "ReservationDate.jsp";
			session.setAttribute("action", "ByAdmin");
			userId = req.getParameter("userId");
			session.setAttribute("userId", userId);
			userDetailAction = new UserDetailAction();
			user = userDetailAction.execute(req);
			session.setAttribute("targetUser", user);
			ReservationDateAction reservationDateAction = new ReservationDateAction();
			reservationDateAction.execute(req);
			break;

		case "deleteUserReserve": // customerDeleteReserve -> userDeleteReserve
			String reservationId = req.getParameter("reservationId");
			session.setAttribute("id", reservationId);
			ReservationDeleteAction reservationDeleteAction = new ReservationDeleteAction();
			success = reservationDeleteAction.execute(req);
			if (success) {
				userAction= new UserAction();
				userDetailAction = new UserDetailAction();
				userList = userAction.execute(req);
				user = userDetailAction.execute(req);
				reservationList = action.execute(req);				
				session.setAttribute("UserList", userList);
				session.setAttribute("targetUser", user);
				session.setAttribute("ReservationHistoryList", reservationList);
				nextPage = "UserDetails.jsp"; // CustomerDetails.jsp -> UserDetails.jsp
			} else {
				nextPage = "Error.jsp";
				session.setAttribute("errorMsg", "予約削除失敗");
			}
			break;
		case "changeCouponFlag":
			session.setAttribute("action", "ByAdmin");
			couponId = req.getParameter("couponId");
			userId = req.getParameter("userId");
			boolean couponUsage = Boolean.parseBoolean(req.getParameter("couponUsage"));

			session.setAttribute("couponUsage", couponUsage);
			session.setAttribute("couponId", couponId);
			session.setAttribute("userId", userId);

			CouponUseAction couponUseAction = new CouponUseAction();
			success = couponUseAction.executeUpdate(req, resp);

			if (success) {
				couponUsageAction = new CouponUsageAction();
				couponUsageList = couponUsageAction.execute(req);
				session.setAttribute("couponUsageList", couponUsageList);
				nextPage = "UserDetails.jsp";
				session.setAttribute("message", "クーポンのステータスを変更しました！");
			} else {
				session.setAttribute("errorMsg", "ステータス変更失敗");
				nextPage = "Error.jsp";
			}
			break;
		case "editSeat":
			int seatId = Integer.parseInt(req.getParameter("SeatId"));
			boolean active = Boolean.parseBoolean(req.getParameter("SeatActive"));

			session.setAttribute("seatId", seatId);
			session.setAttribute("seatActive", active);

			SeatEditAction seatEditAction = new SeatEditAction();
			success = seatEditAction.execute(req, resp);
			if (success) {
				SeatAction seatAction = new SeatAction();
				List<Seat> seatList = seatAction.execute();
				session.setAttribute("Seat", seatList);
				session.setAttribute("message", "座席のステータスを変更しました！");
				nextPage = "AdminSeat.jsp";
			} else {
				nextPage = "Error.jsp";
				session.setAttribute("errorMsg", "席のステータス変更失敗");
			}
			break;
		/*
		case "deleteSeat" :
			seatId = Integer.parseInt(req.getParameter("SeatId"));
			session.setAttribute("seatId", seatId);
			
			SeatDeleteAction seatDeleteAction = new SeatDeleteAction();
			success = seatDeleteAction.execute(req);
			if(success) {
				SeatAction seatAction = new SeatAction();
				List<Seat> seatList = seatAction.execute();
				session.setAttribute("Seat", seatList);
				session.setAttribute("message", "座席を削除しました！");
				nextPage = "AdminSeat.jsp";
			}else {
				nextPage = "Error.jsp";
				session.setAttribute("errorMsg", "座席削除失敗");
			}
			break;
		*/
		case "addSeat":
			SeatAction seatAction = new SeatAction();
			List<Seat> seatList = seatAction.execute();
			int seatCount = seatList.size();
			session.setAttribute("seatCount", seatCount);
			SeatAddAction seatAddAction = new SeatAddAction();
			success = seatAddAction.execute(req);
			if (success) {
				seatAction = new SeatAction();
				seatList = seatAction.execute();
				session.setAttribute("Seat", seatList);
				session.setAttribute("message", "座席を追加しました");
				nextPage = "AdminSeat.jsp";
			} else {
				nextPage = "Error.jsp";
				session.setAttribute("errorMsg", "座席の追加失敗");
			}
			break;
		}

		if (nextPage != null) {
			RequestDispatcher rd = req.getRequestDispatcher(nextPage);
			rd.forward(req, resp);
		} else {
			resp.sendRedirect("AdminMain.jsp");
		}
	}

}