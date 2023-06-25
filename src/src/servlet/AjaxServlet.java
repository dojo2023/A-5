package servlet;

import java.io.IOException;
import java.util.ArrayList;
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
import dao.ItemDao;
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
		//家事の非同期
		if (request.getParameter("hwFlag") != null) {
			String strHwFlag = request.getParameter("hwFlag");
			boolean hwFlag = strHwFlag.equals("1");
			int hwHisId = Integer.parseInt(request.getParameter("hwHisId"));
			int hwId = Integer.parseInt(request.getParameter("hwId"));

			HWHisDao hwHisDao = new HWHisDao();
			//完了処理をDBに登録
			if (hwFlag) {
				if(hwHisDao.falseToTrue(hwHisId, hwFlag)) {
					hwHisDao.insertNextHw(hwId);
					result = true;
				};
			} else { //完了処理を取り消し
				if(hwHisDao.trueToFalse(hwHisId, hwFlag)) {
					/*hwHisDao.deleteNextHw(hwId);*/
					result = true;
				};
			}

		} else if (request.getParameter("itemFlag") != null) {
			String strItemFlag = request.getParameter("itemFlag");
			boolean itemFlag = strItemFlag.equals("1");
			int itemHisId = Integer.parseInt(request.getParameter("itemHisId"));
			int itemId = Integer.parseInt(request.getParameter("itemId"));
			System.out.println(itemId);
			String strRestock = request.getParameter("restart");
			boolean restock = strRestock.equals("true");

			ItemHisDao  IHDao = new ItemHisDao();
			if (itemFlag) {
				if(IHDao.falseToTrue(itemHisId, itemFlag)) {
					result = true;
				};
			} else {
				if(IHDao.trueToFalse(itemHisId, itemFlag)) {
					result = true;
				};
			}

		} else {
			String strItemId = request.getParameter("itemId");
			int itemId = Integer.parseInt(strItemId);
			List<Item> dailyList = new ArrayList<Item>();

			ItemDao IDao = new ItemDao();
			dailyList = IDao.getDailyItem(itemId);
			request.setAttribute("dailyList", dailyList);
			//配列をJavaScriptに返すためにJSONデータにする必要がある
			ObjectMapper mapper = new ObjectMapper();
			try {
			    //JavaオブジェクトからJSONに変換
			    String testJson = mapper.writeValueAsString(dailyList);
			    //JSONの出力
			    response.getWriter().write(testJson);
			} catch (JsonProcessingException e) {
			    e.printStackTrace();
			}

		}

	}
}
