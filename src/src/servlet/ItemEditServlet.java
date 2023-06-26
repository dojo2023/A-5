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
import javax.servlet.http.HttpSession;

import dao.ItemDao;
import dao.ItemHisDao;
import model.Item;
import model.Useful;

/**
 * Servlet implementation class ItemEditServlet
 */
@WebServlet("/ItemEditServlet")
public class ItemEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*HttpSession session = request.getSession();
		if (session.getAttribute("id") == null) {
			response.sendRedirect("/dojo6/src/LoginServlet");
			return;
		}*/

		ItemHisDao IHDao = new ItemHisDao();
		List<Item> itemList = IHDao.select();
		itemList.forEach(item -> System.out.println(item.getDailyName()));
		request.setAttribute("itemList", itemList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/itemEdit.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		/*if (session.getAttribute("id") == null) {
			response.sendRedirect("/dojo6/src/LoginServlet");
			return;
		}*/

		request.setCharacterEncoding("UTF-8");
		String itemName = request.getParameter("itemName");
		String itemCapacity = request.getParameter("itemCapacity");
		int capacity = Integer.parseInt(itemCapacity);
		String itemUnit = request.getParameter("itemUnit");
		String itemPrice = request.getParameter("itemPrice");
		int price = Integer.parseInt(itemPrice);
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String itemMemo = request.getParameter("itemMemo");

		Useful useful = new Useful();
		Date start = useful.strToDate(startDate);
		Date end = useful.strToDate(endDate);

		ItemDao itemDao = new ItemDao();
		Item item = new Item(itemName, capacity, itemUnit, price, start, end, itemMemo);
		boolean result = false;

		if (request.getParameter("SUBMIT").equals("更新")) {
			/*if (itemDao.update(item)) {
				result = true;
				request.setAttribute("item", item);
			}*/
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/itemEdit.jsp");
		request.setAttribute("result", result);
		dispatcher.forward(request, response);
	}

}
