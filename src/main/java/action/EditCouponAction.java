package action;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.CouponDao;

/**
 * Servlet implementation class EditCouponAction
 */
@WebServlet("/EditCouponAction")
public class EditCouponAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCouponAction() {
        super();
        // TODO Auto-generated constructor stub
    }

public void execute(HttpServletRequest req , HttpServletResponse resp) throws IOException {
    	
    	HttpSession session = req.getSession(false);
    	String couponNumber = (String)session.getAttribute("couponNumber");
    	boolean couponActive = (boolean)session.getAttribute("couponActive");
    	CouponDao dao = new CouponDao();
    	boolean success = dao.editCoupon(couponNumber, couponActive);
        
    	if (success) {
            // 2. 完了メッセージをセットして再表示（リダイレクトがおすすめ）
            session.setAttribute("message", "クーポンのステータスを変更しました！");
            resp.sendRedirect("AdminController?command=editCoupon");
        } else {
        	session.setAttribute("errorMsg", "クーポンのステータスを変更できませんでした");
            resp.sendRedirect("Error.jsp");
        }
	}

}
