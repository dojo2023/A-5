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
		if (session.getAttribute("id") == null){
			response.sendRedirect("/dojo6/LoginServlet");
			return;
		}

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



}
