package action.Coupon;

import java.time.LocalDate;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;
import model.Coupon;

/**
 * Servlet implementation class CreateCouponAction
 */
@WebServlet("/CreateCouponAction")
public class CouponCreateAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CouponCreateAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String couponName = (String)session.getAttribute("couponName");
		String couponContent = (String)session.getAttribute("couponContent");
		LocalDate startDate = (LocalDate)session.getAttribute("startDate");
		LocalDate endDate = (LocalDate)session.getAttribute("endDate");
		Coupon coupon = new Coupon();
        coupon.setCouponName(couponName);
        coupon.setCouponContent(couponContent);
        coupon.setStartDate(startDate);
        coupon.setEndDate(endDate);
        CouponDao dao = new CouponDao();
        return dao.createCoupon(coupon);
        
	}
}
