package action.Coupon;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;

/**
 * Servlet implementation class DeleteCouponAction
 */
@WebServlet("/DeleteCouponAction")
public class CouponDeleteAction {
    
    public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		
		String couponId = (String)session.getAttribute("couponId");
		CouponDao dao = new CouponDao();
		return dao.delete(couponId);
	}

}
