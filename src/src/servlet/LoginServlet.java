package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UsersDao;
import model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//ログインページにフォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// リクエストパラメータを取得する
				request.setCharacterEncoding("UTF-8");
				String user_name = request.getParameter("user_name");
				String user_pass = request.getParameter("user_pass");


		UsersDao UDao = new UsersDao(); //呼び出し
		User Login = UDao.isLoginOK(user_name, user_pass);

		//ユーザーIDが取得できていたらログイン成功
		if(Login.getUser_id() != null){
			HttpSession session = request.getSession();
			session.setAttribute("Login", Login);//枝豆の房をセッションスコープに保存
			// ホームサーブレットにリダイレクトする
			//今だけ　新規登録画面に飛ぶ
			response.sendRedirect("AccountServlet");
  		}
		// ログイン失敗
		else {
			response.sendRedirect("LoginServlet");
		}

	}
}
