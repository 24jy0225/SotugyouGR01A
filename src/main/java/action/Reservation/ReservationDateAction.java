package action.Reservation;

import java.time.LocalDate;
import java.util.Map;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;

import dao.ReservationDao;

public class ReservationDateAction extends HttpServlet {
	public void execute(HttpServletRequest req) {
		ReservationDao dao = new ReservationDao();
		LocalDate now = LocalDate.now();

		// 修正：今月1日からではなく、「今日」からでOK（過去分は不要なため）
		LocalDate start = now;

		// 修正：末日までではなく、予約可能期間である「14日後」を確実に含める
		// カレンダーの表示に合わせて、余裕を持って「今月の末日」と「14日後」の遅い方を取るのが安全です
		LocalDate end = now.plusDays(14);

		// DAOを呼び出してMapを取得
		Map<String, String> statusData = dao.getMonthlyStatus(start, end);

		req.setAttribute("statusData", statusData);
	}

}
