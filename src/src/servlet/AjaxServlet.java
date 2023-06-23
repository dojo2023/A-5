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
					hwHisDao.deleteNextHw(hwId);
					result = true;
				};
			}

		} else {
			String strItemFlag = request.getParameter("itemFlag");
			boolean itemFlag = strItemFlag.equals("1");
			int itemHisId = Integer.parseInt(request.getParameter("itemHisId"));
			int itemId = Integer.parseInt(request.getParameter("itemId"));

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

		}

	}
}
