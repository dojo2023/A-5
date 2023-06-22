package servlet;

import java.io.IOException;
import java.net.http.HttpClient;
import java.net.http.HttpResponse;
import java.util.List;

import javax.management.monitor.StringMonitor;
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
 * Servlet implementation class HWEditServlet
 */
@WebServlet("/HWEditServlet")
public class HWEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#doget(httpSelveletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession();
		HWhisdao HHDao = new HWHisdao();
		list<HW> HWlist = HHDao.select();
		
		HWlist.forEach(event -> System.out.println(event.getHWName()));
		request.setAttribute("HWlist", HWlist);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/HWEdit.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("id") == null) {
			response.sendRedirect("/dojo6/LoginServlet");
			return;
	    }

		request.setCharacterEncoding("UTF-8");
		String HWName = request.getParameter("HWName");
		String HWDate = request.getParameter("HWDate");
		Date HWdate = 
		String HWFreq = request.getParameter("HWFreq");
		int number = Integer.parseInt(HWFreq);
		String HWMemo = request.getParameter("HWMemo");

		HWDao  HDao = new HWdao();
		HW H = new HW();
		boolean result = false;
	if (request.getParameter("SUBMIT").equals("更新")){

		if (HDao.update(new H(HWName, HWDate, HWFreq, HWMemo))){
			request = True;
			
			request.setAttribute("H");
	    }
	}

	RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/HWEdit.jsp");
	dispatcher.forward(request,response);
    }
}
