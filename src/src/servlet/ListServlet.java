package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HWHisDao;
import model.HW;

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

		request.setCharacterEncoding("UTF-8");

		HWHisDao hwHis = new HWHisDao();
		List<HW> hwList = hwHis.select();


		// 検索結果をリクエストスコープに格納する
		request.setAttribute("hwList", hwList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/list.jsp");
		dispatcher.forward(request, response);


		/*
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy--MM-dd");
		    Date date = sdf.parse(item_start);
		    System.out.println(date);
				} catch (java.text.ParseException e) {
					e.printStackTrace();
				}*/

	}
}