package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.HW;

public class HWDao {
	public List<String> getHwName() {
		Connection conn = null;
		List<String> hwNameList = new ArrayList<String>();

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
			String sql = "SELECT hw_name FROM HOUSEWORKS GROUP BY hw_name";
			PreparedStatement  pStmt = conn.prepareStatement(sql);

			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			while (rs.next()) {
				hwNameList.add(rs.getString("hw_name"));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			hwNameList = null;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			hwNameList = null;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					hwNameList = null;
				}
			}

		}
		return hwNameList;
	}

	public boolean insert(HW hw) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "insert into houseworks (user_id, hw_name, hw_freq, hw_memo) values (?, ?, ?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, 1);
			pStmt.setString(2, hw.getHwName());
			pStmt.setInt(3, hw.getHwFreq());
			pStmt.setString(4, hw.getHwMemo());



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
	public int getMaxHwId() {
		Connection conn = null;
		int MaxHwId = 0;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
			String sql = "SELECT MAX(hw_id) AS maxId FROM houseworks WHERE user_id = ? ";
			PreparedStatement  pStmt = conn.prepareStatement(sql);
			//user_idの？に1を入れる
			pStmt.setString(1, "1");


			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			// 結果を取得
			rs.next();
			MaxHwId = rs.getInt("maxId");
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
		return MaxHwId;
	}
}
