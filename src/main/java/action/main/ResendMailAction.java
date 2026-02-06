package action.main;

import java.util.UUID;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.UserDao;
import util.MailUtil;

/**
 * Servlet implementation class ResendMailAction
 */
@WebServlet("/ResendMailAction")
public class ResendMailAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResendMailAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    public boolean execute(HttpServletRequest req) {
        // 1. セッションからメアドを取得
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("tempEmail");

        // セッション切れ対策（時間が経ちすぎて消えていたら失敗にする）
        if (email == null) {
            return false;
        }
        
        // 2. 新しいトークンを作る
        String newToken = UUID.randomUUID().toString();
        
        // 3. DAOでDBを更新
        UserDao dao = new UserDao();
        boolean result = dao.reissueToken(email, newToken); // DAOはさっき作ったやつそのままでOK
        
        if (result) {
            // 4. メール再送
            String requestURL = req.getRequestURL().toString();
            String baseURL = requestURL.substring(0, requestURL.lastIndexOf("/"));
            String authenticationURL = baseURL + "/UserController?command=authenticateion&token=" + newToken;

            MailUtil.send(email, authenticationURL);
            return true;
        } else {
            return false;
        }
    }
    
}
