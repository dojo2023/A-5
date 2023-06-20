package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UsersDao;

/**
 * Servlet implementation class AccountServlet
 */
@WebServlet("/AccountServlet")
public class AccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/account.jsp");
		dispatcher.forward(request, response);
	}
	 boolean accountResult;

		//User Login  = session.getAttribute("Login");

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//登録処理


		// リクエストパラメータを取得する= フォームで入力された文字列を取得してる
		request.setCharacterEncoding("UTF-8");
		String user_name = request.getParameter("user_name");
		String user_pass = request.getParameter("user_pass");

		UsersDao UDao = new UsersDao(); //呼び出し
		boolean Account = UDao.newAccount(user_name, user_pass);
		//UDao会社のとこの従業員newAccountさんが引数をもらって仕事する　結果はboolで返す
		/*
		新規登録できているなら、
		新規登録成功と
		パスワードを何かに控えるようアラート表示
		OKが押されたら、
		ユーザー名を保持したまま
		ログイン画面に飛ぶ
		*/
		if(Account == true) {
			request.setAttribute("good", "新規登録が完了しました！");

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
			dispatcher.forward(request, response);
		}

		//このユーザー名はすでに使用されていますと表示
		else {
			request.setAttribute("error", "このユーザー名はすでに使用されています");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/account.jsp");
			dispatcher.forward(request, response);
		}

	}

}
