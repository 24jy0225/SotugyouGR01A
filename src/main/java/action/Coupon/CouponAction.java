package action.Coupon;

import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;

import dao.CouponDao;
import model.Coupon;

/**
 * Servlet implementation class CouponAction
 */
@WebServlet("/CouponAction")
public class CouponAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CouponAction() {
        super();
        // TODO Auto-generated constructor stub
    }

public List<Coupon> execute(HttpServletRequest req) {
  
    	CouponDao dao = new CouponDao();
    	return dao.findAll();
        
	}

}
