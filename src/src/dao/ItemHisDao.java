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

	// 引数cardで指定されたレコードを登録し、成功したらtrueを返す
	public boolean insert(Item item) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/myBC", "sa", "");

			// SQL文を準備する
			String sql = "insert into BC (NAME, COMPANY, DEPART, POSITION, ADDRESS, TEL, MAIL, ANIMAL) values (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setString(1, card.getName());
			pStmt.setString(2, card.getCompany());
			pStmt.setString(3, card.getDepart());
			pStmt.setString(4, card.getPosition());
			pStmt.setString(5, card.getAddress());
			pStmt.setString(6, card.getTel());
			pStmt.setString(7, card.getMail());
			pStmt.setString(8, card.getAnimal());



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
