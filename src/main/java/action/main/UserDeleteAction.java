package action.main;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;
import dao.ReservationDao;
import dao.UserDao;

/**
 * Servlet implementation class CustomerDeleteAction
 */
@WebServlet("/UserDeleteAction")
public class UserDeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserDeleteAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    public boolean execute(HttpServletRequest req) {
    	HttpSession session = req.getSession();
    	String userId = (String)session.getAttribute("userId");
    	CouponDao cDao = new CouponDao();
    	ReservationDao rDao = new ReservationDao();
    	if(cDao.deleteUserCoupon(userId) && rDao.deleteAll(userId) && rDao.cancelDeleteAll(userId)) {
    		UserDao dao = new UserDao();
        	return dao.delete(userId);
    	}
    	return false;
    	
    }

}
