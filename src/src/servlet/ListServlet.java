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

import dao.HWHisDao;
import dao.ItemHisDao;
import model.HW;
import model.Item;
import model.Useful;

/**
 * Servlet implementation class ListServlet
 */
@WebServlet("/ListServlet")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		/*	HttpSession session = request.getSession();
			if (session.getAttribute("user_id") == null) {
				response.sendRedirect("/A-five/LoginServlet");
			}*/
		request.setCharacterEncoding("UTF-8");

		HWHisDao hwHis = new HWHisDao();

		List<HW> hwList = hwHis.select();


		// 検索結果をリクエストスコープに格納する
		request.setAttribute("hwList", hwList);

		Useful useful = new Useful();
		Date today = useful.getDate();
		Date tom = useful.getDatePlus();

		request.setAttribute("today", today);
		request.setAttribute("tom", tom);

		/*
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy--MM-dd");
		    Date date = sdf.parse(item_start);
		    System.out.println(date);
				} catch (java.text.ParseException e) {
					e.printStackTrace();
				}*/

		ItemHisDao itemHis =new ItemHisDao();
		List<Item> itemlist =itemHis.select();

		request.setAttribute("itemlist", itemlist);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/list.jsp");
		dispatcher.forward(request, response);

	}
}