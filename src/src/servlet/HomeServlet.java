package servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TaskDao;
import model.HW;
import model.Useful;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public HomeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		/*HttpSession session = request.getSession();
		if (session.getAttribute("user_id") == null) {
			response.sendRedirect("/A-five/LoginServlet");
			return;
		}*/

		//リクエストスコープに保存する奴(コピペ)
		//requestスコープにセットします("この名前で", このデータを)

		request.setCharacterEncoding("UTF-8");

		TaskDao Task = new TaskDao();

		List<HW> hwList = Task.select();

		Useful useful = new Useful();
		Date today = useful.getDate();
		Date tom = useful.getDatePlus();


		// 検索結果をリクエストスコープに格納する
		request.setAttribute("hwList", hwList);
		request.setAttribute("today", today);
		request.setAttribute("tom", tom);


		// ホームページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
		dispatcher.forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
