package action;

import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;
import model.CouponUsage;
import model.User;

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

    public List<CouponUsage> execute(HttpServletRequest req) {
    	HttpSession session = req.getSession(false);
    	String action = (String)session.getAttribute("action");
    	switch(action) {
    	case "ByUser":
    		User user = (User)session.getAttribute("LoginUser");
    		CouponDao dao = new CouponDao();
    		return dao.findById(user.getUserId());
    	case "Admin":
    		break;
    	
    	}
        return null;
	}

}
