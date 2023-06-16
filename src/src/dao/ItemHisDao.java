package dao;

import java.sql.Connection;
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
			String sql = "SELECT item_due FROM item_history";
			PreparedStatement  pStmt = conn.prepareStatement(sql);


			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果表をコレクションにコピーする
			rs.next();
			while (rs.next()) {
				Item item = new Item();
				item.setItem_id(rs.getInt("NUMBER"));
				item.setUser_id(rs.getInt("NAME"));
				item.setDaily_name(rs.getString("COMPANY"));
				item.setDaily_unit(rs.getString("DEPART"));
				item.setItem_name(rs.getString("POSITION"));
				item.setItem_price(rs.getInt("ADDRESS"));
				item.setItem_volume(rs.getInt("TEL"));
				item.setItem_memo(rs.getString("MAIL"));
				item.setItem_his_id(rs.getInt("DEPART"));
				item.setItem_start(rs.getDate("POSITION"));
				item.setItem_due(rs.getDate("ADDRESS"));
				item.setItem_fin(rs.getDate("TEL"));
				item.setItem_period(rs.getInt("MAIL"));
				item.setItem_flag(rs.getBoolean("MAIL"));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			result = "SQLException";
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			result = "ClassNotFoundException";
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					result = "SQLException2";
				}
			}
		}

		// 結果を返す
		return result;
	}
}
