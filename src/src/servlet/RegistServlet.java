package servlet;

import java.io.IOException;
import java.util.Calendar;
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
import dao.ItemDao;
import dao.ItemHisDao;
import model.HW;
import model.Item;
import model.Useful;

/**
 * Servlet implementation class RegistServlet
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
	/* public RegistServlet() {
	    super();
	    // TODO Auto-generated constructor stub
	}*/

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		HWDao HDao = new HWDao();
 		//items、item_historyの中のデータを全部持ってくる
		List<String> hwNameList = HDao.getHwName();
		request.setAttribute("hwNameList", hwNameList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/regist.jsp");
		dispatcher.forward(request, response);

		/*ObjectMapper mapper = new ObjectMapper();
		try {
		    //JavaオブジェクトからJSONに変換
		    String testJson = mapper.writeValueAsString(itemlist);
		    //JSONの出力
		    response.getWriter().write(testJson);
		} catch (JsonProcessingException e) {
		    e.printStackTrace();
		}
		//文字コードの設定（めんどいのでコピペでOK）
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "nocache");
		response.setCharacterEncoding("utf-8");*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//ユーザーIDは常に必要
		HttpSession session = request.getSession();
		int userId = (int) session.getAttribute("userId");

		request.setCharacterEncoding("UTF-8");
		//ユーザーIDは必ず取得
		String submitBtn = request.getParameter("regist");
		System.out.println(submitBtn);
		boolean result = false;
		Calendar calendar = Calendar.getInstance();
		//日用品の登録処理
		if (submitBtn != null && submitBtn.equals("itemSubmit")) {
			String dailyName = request.getParameter("dailyName");
			String itemName = request.getParameter("itemName");
			int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
			int itemVolume = Integer.parseInt(request.getParameter("itemVolume"));
			String dailyUnit = request.getParameter("dailyUnit");
			String itemMemo = request.getParameter("itemMemo");

			String strItemStart = request.getParameter("itemStart");

	        Useful useful = new Useful();
			//使用開始日を取得
			Date itemStart = useful.strToDate(strItemStart);
			int itemFreq = Integer.parseInt(request.getParameter("itemFreq"));
			Date itemDue = useful.getDueDate(itemStart, itemFreq);

			//既存の日用品か新しい日用品項目か
			String strItemExistFlag = request.getParameter("existFlag");
			boolean itemExsitFlag = Boolean.valueOf(strItemExistFlag);
			//使用開始日（ユーザーが入力）と終了予測日数（ユーザーが入力）から終了予測日を計算

			// 登録処理
			ItemDao IDao = new ItemDao();
			ItemHisDao IHDao = new ItemHisDao();
			System.out.println("予測日数" + itemFreq);
			if (IDao.insert(new Item(userId, dailyName, dailyUnit, itemName, itemPrice, itemVolume, itemMemo, itemFreq))) {
				System.out.println("予測日数(insert後)" + itemFreq);
				//新規の日用品はそのまま使用開始
				if (!itemExsitFlag) {
					int itemId = IDao.getMaxItemId(userId);
					if(IHDao.insertItemHis(itemId, itemStart ,itemDue)) {
						result = true;
					};
				}
				//既存の日用品の場合、itemsテーブルだけに保存する
				else {
					result = true;
				}			//直前に情報テーブルに保存したデータのitemIdを取得する（履歴テーブル入れるため）


			}
		//家事項目フォームから送信されたら
		} else if (submitBtn != null && submitBtn.equals("hwSubmit")) {
			String hwName = request.getParameter("hwName");
			int numFreq = Integer.parseInt(request.getParameter("hwFreq"));
			int freqUnit = Integer.parseInt(request.getParameter("freqUnit"));
			String hwMemo = request.getParameter("hwMemo");
			//頻度の数値と頻度の単位から頻度を日換算（1 + 週 = 7）
			int hwFreq = numFreq * freqUnit;
			Date currentDate = new Date();
			Useful useful = new Useful();
			Date hwDue = useful.getDueDate(currentDate, hwFreq);
			HW hw = new HW();
			hw.setHwName(hwName);
			hw.setHwFreq(hwFreq);
			hw.setHwMemo(hwMemo);

			HWDao HwDao = new HWDao();
			HWHisDao hwHisDao = new HWHisDao();
			if (HwDao.insert(hw)) {
				int hwId = HwDao.getMaxHwId();
				if(hwHisDao.insert(hwId, hwDue)) {
					result = true;
					System.out.println("成功");
				}

			}

		} else {
			System.out.println("失敗");
		}

		request.setAttribute("result",result);

		// 結果ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/regist.jsp");
		dispatcher.forward(request, response);




	}

}
