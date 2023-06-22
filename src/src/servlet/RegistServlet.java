package servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HWDao;
import dao.HWHisDao;
import dao.ItemDao;
import dao.ItemHisDao;
import model.HW;
import model.Item;

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
		//HttpSession session = request.getSession();
		//session.getAttribute('userId');

		request.setCharacterEncoding("UTF-8");
		//ユーザーIDは必ず取得
		String submitBtn = request.getParameter("regist");
		System.out.println(submitBtn);
		boolean result = false;
		Calendar calendar = Calendar.getInstance();
		//日用品の登録処理
		if (submitBtn != null && submitBtn.equals("itemSubmit")) {
			int userId = 1;//とりあえず「１」にしている
			String dailyName = request.getParameter("dailyName");
			String itemName = request.getParameter("itemName");
			int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
			int itemVolume = Integer.parseInt(request.getParameter("itemVolume"));
			String dailyUnit = request.getParameter("dailyUnit");
			String itemMemo = request.getParameter("itemMemo");
			//使用開始日を取得
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date itemStart = null;
	        try {
	            itemStart = dateFormat.parse(request.getParameter("itemStart"));
	            System.out.println(itemStart);
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
	        int itemPeriod = Integer.parseInt(request.getParameter("itemPeriod"));
	        //使用開始日（ユーザーが入力）と終了予測日数（ユーザーが入力）から終了予測日を計算
	        calendar.setTime(itemStart);
	        calendar.add(Calendar.DATE, itemPeriod);
	        Date itemDue = calendar.getTime();
			// 登録処理
			ItemDao IDao = new ItemDao();
			ItemHisDao IHDao = new ItemHisDao();
			//情報テーブルにデータを保存できたら
			if (IDao.insert(new Item(userId, dailyName, dailyUnit, itemName, itemPrice, itemVolume, itemMemo))) {	// 登録成功
				result = true;				//直前に情報テーブルに保存したデータのitemIdを取得する（履歴テーブル入れるため）
				int itemId = IDao.getMaxItemId();
				if(IHDao.insertItemHis(itemId, itemStart ,itemDue)) {
					result = true;
					System.out.println("成功");
				};
			}
		//家事項目フォームから送信されたら
		} else if (submitBtn != null && submitBtn.equals("hwSubmit")) {
			String hwName = request.getParameter("hwName");
			int numFreq = Integer.parseInt(request.getParameter("hwFreq"));
			int freqUnit = Integer.parseInt(request.getParameter("freqUnit"));
			String hwMemo = request.getParameter("hwMemo");
			//頻度の数値と頻度の単位から頻度を日換算（1 + 週 = 7）
			int hwFreq = numFreq * freqUnit;
			HW hw = new HW();
			hw.setHwName(hwName);
			hw.setHwFreq(hwFreq);
			hw.setHwMemo(hwMemo);
			//現在日時と目標頻度を足して、期日を算出
			calendar.add(calendar.DATE, hwFreq);
			Date hwDue = calendar.getTime();


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
