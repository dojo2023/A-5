package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDao;
import dao.ItemHisDao;
import model.Item;

/**
 * Servlet implementation class RegistServlet
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
	/* public RegistServlet() {
	    super();
	    // TODO Auto-generated constructor stub
	}*/

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		ItemHisDao IHDao = new ItemHisDao();
		List<Item> itemlist = IHDao.select();
		System.out.println(itemlist.size()+"bbbbbb");
		//一覧検索
		request.setAttribute("itemlist", itemlist);


		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/regist.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//ユーザーIDは常に必要
		//HttpSession session = request.getSession();
		//session.getAttribute('userId');


		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		int userId = 1;
		String dailyName = request.getParameter("dailyName");
		String dailySelect = request.getParameter("dailySelect");
		String itemName = request.getParameter("itemName");
		int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
		int itemVolume = Integer.parseInt(request.getParameter("itemVolume"));
		String dailyUnit = request.getParameter("dailyUnit");
		String itemMemo = request.getParameter("itemMemo");

		if (!(dailySelect.equals("create"))) {
			dailyName = dailySelect;
		}

		// 登録処理を行う
		ItemDao IDao = new ItemDao();
		boolean result = false;
		if (IDao.insert(new Item(userId, dailyName, dailyUnit, itemName, itemPrice, itemVolume, itemMemo))) {	// 登録成功
			result = true;
		}
		request.setAttribute("result",result);

		// 結果ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/regist.jsp");
		dispatcher.forward(request, response);
	}

}
