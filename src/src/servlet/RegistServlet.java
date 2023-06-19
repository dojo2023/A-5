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
 		//items、item_historyの中のデータを全部持ってくる
		List<Item> itemlist = IHDao.getDaily();
		itemlist.forEach(event -> System.out.println(event.getDailyName()));
		request.setAttribute("itemlist", itemlist);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/regist.jsp");
		dispatcher.forward(request, response);

		/*ObjectMapper mapper = new ObjectMapper();
		try {
		    //JavaオブジェクトからJSONに変換
		    String testJson = mapper.writeValueAsString(itemlist);
		    //JSONの出力
		    response.getWriter().write(testJson);
		} catch (JsonProcessingException e) {
		    e.printStackTrace();
		}
		//文字コードの設定（めんどいのでコピペでOK）
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "nocache");
		response.setCharacterEncoding("utf-8");*/
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
		String itemName = request.getParameter("itemName");
		int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
		int itemVolume = Integer.parseInt(request.getParameter("itemVolume"));
		String dailyUnit = request.getParameter("dailyUnit");
		String itemMemo = request.getParameter("itemMemo");


		// 登録処理を行う
		ItemDao IDao = new ItemDao();
		boolean result = false;
		if (IDao.insert(new Item(userId, dailyName, dailyUnit, itemName, itemPrice, itemVolume, itemMemo))) {	// 登録成功
			result = true;
			System.out.println("成功");
		}
		request.setAttribute("result",result);

		// 結果ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/regist.jsp");
		dispatcher.forward(request, response);
	}

}
