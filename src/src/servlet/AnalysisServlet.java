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

import dao.TaskDao;
import model.HW;
import model.Useful;

/**
 * Servlet implementation class AnalysisServlet
 */
@WebServlet("/AnalysisServlet")
public class AnalysisServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public AnalysisServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		TaskDao Task = new TaskDao();
		List<HW> hwList = Task.select();

		Useful useful = new Useful();
		Date today = useful.getDate();
		Date tom = useful.getDatePlus();


		// 検索結果をリクエストスコープに格納する
		request.setAttribute("hwList", hwList);
		request.setAttribute("today", today);
		request.setAttribute("tom", tom);

		for(HW h : hwList) {
			System.out.println(h.getHwDue());
			System.out.println(today+"今日");
			System.out.println(tom+"明日");
		}

		// 分析ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/analysis.jsp");
		dispatcher.forward(request, response);


	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
