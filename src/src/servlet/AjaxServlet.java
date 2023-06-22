package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import dao.HWHisDao;
import dao.ItemHisDao;
import model.Item;
import model.Useful;

/**
 * Servlet implementation class Ajax
 */
@WebServlet("/AjaxServlet")
public class AjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//文字コードの設定（めんどいのでコピペでOK）
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "nocache");
		response.setCharacterEncoding("utf-8");
		ItemHisDao IHDao = new ItemHisDao();
		Useful useful = new Useful();
		List<Item> itemlist = IHDao.getDaily();

		Map<String, String> mappingData = useful.getMappingData(itemlist);
		ObjectMapper mapper = new ObjectMapper();
		try {
            //JavaオブジェクトからJSONに変換
            String dailyJson = mapper.writeValueAsString(mappingData);
            //JSONの出力
            response.getWriter().write(dailyJson);
            request.setAttribute("dailyJson", dailyJson);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
		response.setHeader("Cache-Control", "nocache");
		response.setCharacterEncoding("utf-8");
		boolean result = false;
		System.out.println(request.getParameter("flag"));
		String strHwFlag = request.getParameter("flag");
		boolean hwFlag = strHwFlag.equals("1");
		System.out.println(hwFlag);
		int hwHisId = Integer.parseInt(request.getParameter("id"));

		HWHisDao hwHisDao = new HWHisDao();
		if(hwHisDao.updateDateAndFlag(hwHisId, hwFlag)) {
			result = true;
		};
	}
}
