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

import dao.HWDao;
import dao.HWHisDao;
import model.HW;
import model.Useful;

/**
 * Servlet implementation class HWEditServlet
 */
@WebServlet("/HWEditServlet")
public class HWEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("id") == null) {
			response.sendRedirect("/dojo6/src/LoginServlet");
			return;
		}

		HWHisDao HHDao = new HWHisDao();
		List<HW> HWList = HHDao.select();

		HWList.forEach(hw -> System.out.println(hw.getHWName()));
		request.setAttribute("HWList", HWList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/HWEdit.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("id") == null) {
			response.sendRedirect("/dojo6/src/LoginServlet");
			return;
		}

		request.setCharacterEncoding("UTF-8");
		String HWName = request.getParameter("hwName");
		String HWDate = request.getParameter("hwDate");
		String HWFreq = request.getParameter("hwFreq");
		int freq = Integer.parseInt(hwFreq);
		String HWMemo = request.getParameter("HWMemo");

		Useful useful = new Useful();
		Date hwDate = useful.strToDate(HWDate);

		HWDao hwDao = new HWDao();
		HW hw = new HW(HWName, hwDate, freq, HWMemo);
		boolean result = false;

		if (request.getParameter("SUBMIT").equals("更新")) {
			if (hwDao.update(hw)) {
				result = true;
				System.out.println("成功");
				request.setAttribute("hw", hw);
			}
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/HWEdit.jsp");
		request.setAttribute("result", result);
		dispatcher.forward(request, response);
	}
}
