package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Item;

public class ItemDao {
	// 引数cardで指定されたレコードを登録し、成功したらtrueを返す
		//登録フォームで入力されたデータを入れる
		public boolean insert(Item item) {
			Connection conn = null;
			boolean result = false;

			try {
				// JDBCドライバを読み込む
				Class.forName("org.h2.Driver");

				// データベースに接続する
				conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

				// SQL文を準備する
				String sql = "insert into items (user_id, daily_name, daily_unit, item_name, item_price, item_volume, item_freq, item_memo) values (?, ?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement pStmt = conn.prepareStatement(sql);
				// SQL文を完成させる


				pStmt.setInt(1, item.getUserId());
				pStmt.setString(2, item.getDailyName());
				pStmt.setString(3, item.getDailyUnit());
				pStmt.setString(4, item.getItemName());
				pStmt.setInt(5, item.getItemPrice());
				pStmt.setInt(6, item.getItemVolume());
				pStmt.setInt(7, item.getItemFreq());
				pStmt.setString(8, item.getItemMemo());




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
		//登録時、履歴テーブルに新規レコードを挿入する用のitem_idを取得
		public int getMaxItemId(int userId) {
			Connection conn = null;
			int maxItemId = 0;

			try {
				// JDBCドライバを読み込む
				Class.forName("org.h2.Driver");

				// データベースに接続する
				conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
				String sql = "SELECT MAX(item_id) AS maxId FROM items WHERE user_id = ? ";
				PreparedStatement  pStmt = conn.prepareStatement(sql);
				//user_idの？に1を入れる
				pStmt.setInt(1, userId);


				// SQL文を実行し、結果表を取得する
				ResultSet rs = pStmt.executeQuery();

				// 結果を取得
				rs.next();
				maxItemId = rs.getInt("maxId");
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
			return maxItemId;
		}
		//任意の日用品項目の商品情報データを取得する
		public List<Item> getDailyItem(int itemId) {
			Connection conn = null;
			List<Item> itemlist = new ArrayList<Item>();


			try {
				// JDBCドライバを読み込む
				Class.forName("org.h2.Driver");

				// データベースに接続する
				conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
				String sql = "WITH sub AS (SELECT daily_name FROM items WHERE item_id = ?) SELECT * FROM items WHERE daily_name = SELECT daily_name FROM sub";
				PreparedStatement  pStmt = conn.prepareStatement(sql);
				//user_idの？に1を入れる
				pStmt.setInt(1, itemId);


				// SQL文を実行し、結果表を取得する
				ResultSet rs = pStmt.executeQuery();

				// 結果を取得
				while (rs.next()) {
					Item item = new Item();
					item.setItemId(rs.getInt("ITEM_ID"));
					item.setUserId(rs.getInt("USER_ID"));
					item.setDailyName(rs.getString("DAILY_NAME"));
					item.setDailyUnit(rs.getString("DAILY_UNIT"));
					item.setItemName(rs.getString("ITEM_NAME"));
					item.setItemPrice(rs.getInt("ITEM_PRICE"));
					item.setItemVolume(rs.getInt("ITEM_VOLUME"));
					item.setItemMemo(rs.getString("ITEM_MEMO"));
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
					}
				}
			}

			// 結果を返す
			return itemlist;
		}

		public boolean startUseItem(int itemId) {
			Connection conn = null;
			boolean result = false;

			try {
				// JDBCドライバを読み込む
				Class.forName("org.h2.Driver");

				// データベースに接続する
				conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
				String sql = "WITH sub AS (SELECT item_freq FROM items WHERE item_id = ?) INSERT INTO item_history (item_id, item_start, item_due) VALUES (?, current_date, current_date + (SELECT item_freq FROM sub))";
				PreparedStatement  pStmt = conn.prepareStatement(sql);
				//user_idの？に1を入れる
				pStmt.setInt(1, itemId);


				// SQL文を実行し、結果表を取得する
				ResultSet rs = pStmt.executeQuery();

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

}
