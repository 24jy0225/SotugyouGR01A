package action.Coupon;

import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;
import model.CouponUsage;
import model.User;

/**
 * Servlet implementation class UseCouponAction
 */
@WebServlet("/UseCouponAction")
public class CouponUseAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CouponUseAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
		String action = (String) session.getAttribute("action");
		switch (action) {
		case "ByUser":
			if (session == null || session.getAttribute("LoginUser") == null) {
				resp.sendRedirect("Login.jsp");
				return;
			}
			User user = (User) session.getAttribute("LoginUser");
			String userId = user.getUserId();
			String couponId = (String)session.getAttribute("couponId"); 
			CouponDao dao = new CouponDao();
			// 1. DBのフラグを 0 に更新
			boolean success = dao.useCoupon(userId, couponId);

			if (success) {
				CouponDao cDao = new CouponDao();
				List<CouponUsage> couponList = cDao.findById(userId);
				session.setAttribute("couponList", couponList);
				// 2. 完了メッセージをセットして再表示（リダイレクトがおすすめ）
				session.setAttribute("message", "クーポンを使用しました！");
				resp.sendRedirect("UserController?command=MyPage");
			} else {
				session.setAttribute("errorMsg", "クーポンを使用できませんでした");
				resp.sendRedirect("Error.jsp");
			}
			break;
		}

	}

	public boolean executeUpdate(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		String userId = (String) session.getAttribute("userId");

		String couponId = (String) session.getAttribute("couponId");

		boolean couponUsage = (boolean) session.getAttribute("couponUsage");
		CouponDao dao = new CouponDao();
		// 1. DBのフラグを 0 に更新
		return dao.changeCouponFlag(userId, couponId, couponUsage);

	}

}
