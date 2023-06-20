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
		User Login = new User();
		boolean loginResult = UDao.isLoginOK(user_name, user_pass);
		//UsersDao  通称UDaoさんとこのisLoginOKさんに引数としてデータを渡し、
		//loginResultの結果を聞く

		Login.setUser_id(null);
		//ユーザーIDが取得できていたらログイン成功
		if(loginResult == true){
			HttpSession session = request.getSession();
			session.setAttribute("Login", Login);//枝豆の房をセッションスコープに保存

			//今はホームのjspに飛ぶ
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
			dispatcher.forward(request, response);
  		}
		// ログイン失敗
		else {
			request.setAttribute("error", "ユーザー名かパスワードに誤りがあります。");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
			dispatcher.forward(request, response);
		}

	}
}
