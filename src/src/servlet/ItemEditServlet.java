package servlet;

import java.io.IOException;
import java.net.http.HttpResponse;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HWDao;
import dao.ItemDao;
import dao.ItemHisDao;
import model.HW;
import model.Item;


/**
 * Servlet implementation class ItemEditServlet
 */
@WebServlet("/ItemEditServlet")
public class ItemEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	 /**
     * @see HttpServlet#doget(httpSelveletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession();
			//if (session.getAttribute("id") == null){
				//response.sendRedirect("/dojo6/LoginServlet");
				//ret
        ItemHisDao IHDao = new ItemHisDao();
 		//items、item_historyの中のデータを全部持ってくる
		List<Item> itemlist = IHDao.select();
		//foreachをコンソールに出して中身を確認
		itemlist.forEach(event -> System.out.println(event.getDailyName()));
		request.setAttribute("itemlist", itemlist);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ItemEdit.jsp");
		dispatcher.forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
		if (session.getAttribute("id") == null){
			response.sendRedirect("/dojo6/LoginServlet");
			return;
		}

		request.setCharacterEncoding("UTF-8");
		String itemName = request.getParameter("itemName");
		String itemCapacity = request.getParameter("itemCapacity");
		String itemUnit = request.getParameter("itemUnit");
		String itemPrice = request.getParameter("itemPrice");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String Itemremarks = request.getParameter("Itemremarks");

		
        //フォワード処理

	}

}
