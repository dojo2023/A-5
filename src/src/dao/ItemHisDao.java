package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Item;
public class ItemHisDao {
	public List<Item> select() {
		Connection conn = null;
		List<Item> itemlist = new ArrayList<Item>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
			String sql = "SELECT it.item_id, it.item_name, it.user_id, it.daily_name,it.daily_unit, it.item_price, it.item_volume, it.item_memo, his.item_his_id, his.item_start, his.item_due, his.item_fin, his.item_period, his.item_flag FROM item_history AS his JOIN items AS it ON his.item_id = it.item_id";
			PreparedStatement  pStmt = conn.prepareStatement(sql);


			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				System.out.println(rs.getString("ITEM_NAME")+"aaaaaaaa");
				Item item = new Item();
				item.setItemId(rs.getInt("ITEM_ID"));
				item.setUserId(rs.getInt("USER_ID"));
				item.setDailyName(rs.getString("DAILY_NAME"));
				item.setDailyUnit(rs.getString("DAILY_UNIT"));
				item.setItemName(rs.getString("ITEM_NAME"));
				item.setItemPrice(rs.getInt("ITEM_PRICE"));
				item.setItemVolume(rs.getInt("ITEM_VOLUME"));
				item.setItemMemo(rs.getString("ITEM_MEMO"));
				item.setItemHisId(rs.getInt("ITEM_HIS_ID"));
				item.setItemStart(rs.getDate("ITEM_START"));
				item.setItemDue(rs.getDate("ITEM_DUE"));
				item.setItemFin(rs.getDate("ITEM_FIN"));
				item.setItemPeriod(rs.getInt("ITEM_PERIOD"));
				item.setItemFlag(rs.getBoolean("ITEM_FLAG"));
				itemlist.add(item);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			itemlist = null;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			itemlist = null;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					itemlist = null;
				}
			}
		}

		// 結果を返す
		return itemlist;
	}
	//AjaxServletに使う。日用品項目と単位を取得してJavaScriptでマッピング。
	public List<Item> getDaily() {
		Connection conn = null;
		List<Item> itemlist = new ArrayList<Item>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
			String sql = "SELECT daily_name, daily_unit FROM ITEMS WHERE user_id = ? GROUP BY daily_name, daily_unit";
			PreparedStatement  pStmt = conn.prepareStatement(sql);
			//user_idの？に1を入れる
			pStmt.setString(1, "1");

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			while (rs.next()) {
				Item item = new Item();
				item.setDailyName(rs.getString("DAILY_NAME"));
				item.setDailyUnit(rs.getString("DAILY_UNIT"));
				itemlist.add(item);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			itemlist = null;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			itemlist = null;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					itemlist = null;
				}
			}
		}

		// 結果を返す
		return itemlist;
	}

	public boolean editUpdate(Item editItem) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
			conn.setAutoCommit(false);//トランザクションの手動制御のため、自動コミットを無効

			// SQL文を準備する
			//使用開始日を変更するSQL
			String sql1 = "UPDATE item_history SET item_start = ? WHERE item_his_id = ?";
			//日用品項目の名前を変えるためのSQL
			String sql2 = "UPDATE items SET daily_name = ? WHERE itemId = 1";
			PreparedStatement pStmt1 = conn.prepareStatement(sql1);
			PreparedStatement pStmt2 = conn.prepareStatement(sql2);

			// SQL文を完成させる
			Item item = new Item();
			pStmt1.setDate(1, (Date) item.getItemStart());
			pStmt1.setInt(2, item.getItemHisId());

			pStmt2.setString(1, item.getDailyName());

			pStmt1.executeUpdate();
			pStmt2.executeUpdate();

			conn.commit();
			result = true;
		}
		catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e3) {
					e3.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
	}

	public List<Item> itemDetail() {
		Connection conn = null;
		List<Item> itemlist = new ArrayList<Item>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
			String sql = "SELECT his.item_his_id, his.item_id, his.item_start, his.item_due, his.item_fin,his.item_period, his.item_flag,it.user_id, it.daily_name, it.daily_unit,it.item_name, it.item_price,it.item_volume, it.item_freq, it.item_memo FROM item_history AS his JOIN items AS it  ON his.item_id = it.item_id WHERE his.item_flag = 0 and it.user_id =1 GROUP BY his.item_id ORDER BY item_due asc";
			PreparedStatement  pStmt = conn.prepareStatement(sql);

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			while (rs.next()) {
				System.out.println(rs.getString("ITEM_NAME")+"aaaaaaaa");
				Item item = new Item();
				item.setItemId(rs.getInt("ITEM_ID"));
				item.setUserId(rs.getInt("USER_ID"));
				item.setDailyName(rs.getString("DAILY_NAME"));
				item.setDailyUnit(rs.getString("DAILY_UNIT"));
				item.setItemName(rs.getString("ITEM_NAME"));
				item.setItemPrice(rs.getInt("ITEM_PRICE"));
				item.setItemVolume(rs.getInt("ITEM_VOLUME"));
				item.setItemFreq(rs.getInt("ITEM_FREQ"));
				item.setItemMemo(rs.getString("ITEM_MEMO"));
				item.setItemHisId(rs.getInt("ITEM_HIS_ID"));
				item.setItemStart(rs.getDate("ITEM_START"));
				item.setItemDue(rs.getDate("ITEM_DUE"));
				item.setItemFin(rs.getDate("ITEM_FIN"));
				item.setItemPeriod(rs.getInt("ITEM_PERIOD"));
				item.setItemFlag(rs.getBoolean("ITEM_FLAG"));
				itemlist.add(item);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			itemlist = null;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			itemlist = null;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					itemlist = null;
				}
			}

		}
		return itemlist;
	}

	//登録時に履歴テーブル新規レコードを挿入
	public boolean insertItemHis(int itemId, java.util.Date itemStart, java.util.Date itemDue) {
		boolean result = false;
		Connection conn = null;
		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "insert into item_history (item_id, item_start, item_due) values(?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			java.sql.Date sqlItemStart = new java.sql.Date(itemStart.getTime());
			java.sql.Date sqlItemDue = new java.sql.Date(itemDue.getTime());

			// SQL文を完成させる
			pStmt.setInt(1,  itemId);
			pStmt.setDate(2, sqlItemStart);
			pStmt.setDate(3, sqlItemDue);



			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return result;
	}

	//フラグを0→1に。実施日も追加。
    public boolean falseToTrue(int itemHisId, boolean itemFlag) {
    	Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "update item_history set item_fin = CURRENT_DATE, item_period = datediff('DAY', item_start, CURRENT_DATE ), item_flag = ? where item_his_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setBoolean(1, itemFlag);
			pStmt.setInt(2, itemHisId);


			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
    }
    //フラグを1→0に。更新日をnullに。
    public boolean trueToFalse(int itemHisId, boolean itemFlag) {
    	Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "update item_history set item_fin=NULL, item_period=NULL, item_flag=? where item_his_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setBoolean(1, itemFlag);
			pStmt.setInt(2, itemHisId);


			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
    }
    //次のitemを使い始める
    public boolean insertNextItem(int hwId) {
    	Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "insert into item_history (item_id, item_start, item_due)values(?, current_date, current_date + (select  item_freq from items where item_id =?)::integer)";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			/*java.sql.Date sqlHwDue = new java.sql.Date(hwDue.getTime());*/

			pStmt.setInt(1, hwId);
			pStmt.setInt(2, hwId);


			// SQL文を実行する
			if (pStmt.executeUpdate() == 1) {
				result = true;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		// 結果を返す
		return result;
    }
}