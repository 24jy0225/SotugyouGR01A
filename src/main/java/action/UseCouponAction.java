package action;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;
import model.User;

/**
 * Servlet implementation class UseCouponAction
 */
@WebServlet("/UseCouponAction")
public class UseCouponAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UseCouponAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void execute(HttpServletRequest req , HttpServletResponse resp) throws Exception {
    	HttpSession session = req.getSession(false);
    	if (session == null || session.getAttribute("LoginUser") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }
    	User user = (User) session.getAttribute("LoginUser");
		String userId = user.getUserId();
        String couponNumber = req.getParameter("couponNumber");
        CouponDao dao = new CouponDao();
        // 1. DBのフラグを 0 に更新
        boolean success = dao.useCoupon(userId, couponNumber);

        if (success) {
            // 2. 完了メッセージをセットして再表示（リダイレクトがおすすめ）
            session.setAttribute("message", "クーポンを使用しました！");
            resp.sendRedirect("UserController?command=MyPage");
        } else {
        	session.setAttribute("errorMsg", "クーポンを使用できませんでした");
            resp.sendRedirect("Error.jsp");
        }
        
	}

}
