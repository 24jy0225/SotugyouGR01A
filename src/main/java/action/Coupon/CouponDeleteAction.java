package action.Coupon;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;

/**
 * Servlet implementation class DeleteCouponAction
 */
@WebServlet("/DeleteCouponAction")
public class CouponDeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CouponDeleteAction() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		
		String couponNumber = (String)session.getAttribute("couponNumber");
		CouponDao dao = new CouponDao();
		return dao.delete(couponNumber);
	}

}
