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
			User loginResult = UDao.isLoginOK(user_name, user_pass);
			//UsersDao  通称UDaoさんとこのisLoginOKさんに引数としてデータを渡す
			//nullか枝豆（int,str,strの3つが入っている）どっちかを返す

			//ログイン成功（nullじゃない＝枝豆取得）
			if(loginResult != null){
				HttpSession session = request.getSession();
				//IDだけをセッションスコープに保存
				session.setAttribute("user_id", loginResult.getUser_id());

				//ホームのjspに飛ぶ
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
				dispatcher.forward(request, response);

				//beanの中身を全部セッションスコープに保存する場合↓
				//session.setAttribute("loginResult", loginResult);//枝豆の房をセッションスコープに保存
				//JSPで表示させるEL式
				//${loginResult.user_id}${loginResult.user_name}${loginResult.user_pass}


			}
			// ログイン失敗
			else {
				request.setAttribute("error", "ユーザー名かパスワードに誤りがあります。");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
				dispatcher.forward(request, response);
			}

	}
}
