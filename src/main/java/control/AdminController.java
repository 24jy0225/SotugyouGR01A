package control;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
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
import action.Design.DesignUpdateAction;
import action.Reservation.ReservationDeleteAction;
import action.Reservation.ReservationHistoryAction;
import action.Reservation.ReservationSeatAction;
import action.Topics.TopicsAction;
import action.Topics.TopicsAddAction;
import action.Topics.TopicsDeleteAction;
import action.main.CustomerDetailAction;
import action.main.LoginAction;
import action.main.StoreAction;
import action.main.UserAction;
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
			String id = req.getParameter("id");
			session.setAttribute("id", id);  
			session.setAttribute("action", "ByAdmin");
		    ReservationDeleteAction rda = new ReservationDeleteAction();
		    boolean flag = rda.execute(req);

		    if (flag) {
		        // 成功！Ajax側に「200 OK」を返す（画面遷移はしない）
		    	reservationList = action.execute(req);
		    	session.setAttribute("ReservationHistoryList", reservationList);
		        resp.setStatus(HttpServletResponse.SC_OK);
		    } else {
		        // 失敗！Ajax側に「500 Internal Server Error」などを返す
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
			break;
			
		case "designUpdate":
			Part part = req.getPart("image");
			String category = req.getParameter("category");
			String contentType = part.getContentType();

			if (!contentType.startsWith("image/")) {
				req.setAttribute("error", "画像ファイルのみアップロード可能です");
				req.getRequestDispatcher("noticeAdd.jsp").forward(req, resp);
				return;
			}
			if (part == null || part.getSize() == 0) {
				resp.sendRedirect("PhotoAdd.jsp");
				return;
			}
			
			String fileName = System.currentTimeMillis() + "_" + Paths.get(part.getSubmittedFileName()).getFileName().toString();
						
			session.setAttribute("category", category);
			session.setAttribute("fileName", fileName);
			
			// 修正後（より確実な方法）
			String saveDir = "Z:\\卒業制作\\SotugyouGR01A\\src\\main\\webapp\\image\\photo";
			File dir = new File(saveDir);
		    if (!dir.exists()) {
		        dir.mkdirs(); // フォルダがなければ作成
		    }
		    String fullPath = saveDir + File.separator + fileName;
		    System.out.println("★ここに保存します: " + fullPath);
	        
	        DesignUpdateAction designUpdateAction = new DesignUpdateAction();
	        designUpdateAction.execute(req , resp);
	        return;
			
		case "topicsAdd":
			Part topicsPart = req.getPart("image");
			contentType = topicsPart.getContentType();
			
			String topicsTitle = req.getParameter("topicsTitle");
			String topicsContent = req.getParameter("topicsContent");			

			if (!contentType.startsWith("image/")) {
				req.setAttribute("error", "画像ファイルのみアップロード可能です");
				req.getRequestDispatcher("NoticeAdd.jsp").forward(req, resp);
				return;
			}
			if (topicsPart == null || topicsPart.getSize() == 0) {
				resp.sendRedirect("PhotoAdd.jsp");
				return;
			}
			
			session.setAttribute("topicsTitle", topicsTitle);
			session.setAttribute("topicsContent", topicsContent);
			
			fileName = System.currentTimeMillis() + "_" +
			Paths.get(topicsPart.getSubmittedFileName()).getFileName().toString();
			
			session.setAttribute("fileName", fileName);
						
			saveDir = "Z:\\卒業制作\\SotugyouGR01A\\src\\main\\webapp\\image\\photo";
			dir = new File(saveDir);
		    if (!dir.exists()) {
		        dir.mkdirs(); // フォルダがなければ作成
		    }
		    fullPath = saveDir + File.separator + fileName;
		    topicsPart.write(fullPath);
		    
	        TopicsAddAction topicsAddAction = new TopicsAddAction();
	        boolean success = topicsAddAction.execute(req, resp);
	        
	        List<Topics> topicsList = new ArrayList<>();
			TopicsAction topicsAction = new TopicsAction();
			topicsList = topicsAction.execute();
			session.setAttribute("topicsList", topicsList);
	        
	        if (success) {
	            resp.setStatus(HttpServletResponse.SC_OK); // 200を返す
	        } else {
	            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500を返す
	        }
	        return;
	        
		case "deleteTopics":
			int topicsId = Integer.parseInt(req.getParameter("topicsId"));
			session.setAttribute("topicsId", topicsId);
			TopicsDeleteAction topicsDeleteAction = new TopicsDeleteAction();
			success = topicsDeleteAction.execute(req);
			
			topicsAction = new TopicsAction();
			topicsList = topicsAction.execute();
			session.setAttribute("topicsList", topicsList);
			
			if (success) {
		        resp.setStatus(HttpServletResponse.SC_OK);
		    } else {
		        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		    }
		    return;	
		case "customerDetail" :
			String userId = req.getParameter("userId");
			
			session.setAttribute("userId", userId);
			
			CustomerDetailAction customerDetailAction = new CustomerDetailAction();
			user = customerDetailAction.execute(req);
			session.setAttribute("targetUser", user);
			
			CouponUsageAction couponUsageAction = new CouponUsageAction();
			List<CouponUsage> couponUsageList = couponUsageAction.execute(req);
			
			session.setAttribute("couponUsageList", couponUsageList);
			
			if(user != null) {
				nextPage ="CustomerDetails.jsp";				
			}else {
				session.setAttribute("errorMsg", "顧客情報取得エラー");
				nextPage ="Error.jsp";
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
