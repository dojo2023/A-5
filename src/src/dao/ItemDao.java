package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Item;

public class ItemDao {
	// 引数cardで指定されたレコードを登録し、成功したらtrueを返す

		public boolean insert(Item item) {
			Connection conn = null;
			boolean result = false;

			try {
				// JDBCドライバを読み込む
				Class.forName("org.h2.Driver");

				// データベースに接続する
				conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

				// SQL文を準備する
				String sql = "insert into items (user_id, daily_name, daily_unit, item_name, item_price, item_volume, item_memo) values (?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement pStmt = conn.prepareStatement(sql);

				// SQL文を完成させる
				pStmt.setInt(1, item.getUserId());
				pStmt.setString(2, item.getDailyName());
				pStmt.setString(3, item.getDailyUnit());
				pStmt.setString(4, item.getItemName());
				pStmt.setInt(5, item.getItemPrice());
				pStmt.setInt(6, item.getItemVolume());
				pStmt.setString(7, item.getItemMemo());



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
