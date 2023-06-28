package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import model.HW;

public class HWHisDao {
    public List<HW> select() {
        Connection conn = null;
        List<HW> hwList = new ArrayList<HW>();

        try {
			 // JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");
			String sql = "SELECT hw.hw_id, hw.user_id,hw.hw_freq, hw.hw_name, hw.hw_memo, his.hw_his_id, his.hw_date, his.hw_due, his.hw_flag FROM hw_history AS his JOIN houseworks AS hw ON his.hw_id = hw.hw_id group by hw_id order by his.hw_due ";


        	PreparedStatement pStmt = conn.prepareStatement(sql);
			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

            // 結果表をコレクションにコピーする
			 while (rs.next()) {
			    System.out.println(rs.getString("HW_NAME") + "完了");
			    HW hw = new HW();
			    hw.setHwId(rs.getInt("HW_ID"));
			    hw.setUserId(rs.getInt("USER_ID"));
			    hw.setHwName(rs.getString("HW_NAME"));
			    hw.setHwFreq(rs.getInt("HW_FREQ"));
			    hw.setHwMemo(rs.getString("HW_MEMO"));
			    hw.setHwHisId(rs.getInt("HW_HIS_ID"));
			    hw.setHwDue(rs.getDate("HW_DUE"));
			    hw.setHwDate(rs.getDate("HW_DATE"));
			    hw.setHwFlag(rs.getBoolean("HW_FLAG"));
			    hwList.add(hw);

			}
        } catch (SQLException e) {
            e.printStackTrace();
            hwList = null;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            hwList = null;
        } finally {
            // データベースを切断
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    hwList = null;
                }
            }
        }

        return hwList;
    }
    //直前に登録した家事の家事IDと、「目標頻度と登録日時から算出した実施期日」を履歴テーブルに新規登録
    public boolean insert(int hwId, Date hwDue) {
    	Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "insert into hw_history (hw_id, hw_due) values (?, ?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			java.sql.Date sqlHwDue = new java.sql.Date(hwDue.getTime());

			pStmt.setInt(1, hwId);
			pStmt.setDate(2, sqlHwDue);


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

    public boolean insertNextHw(int hwId) {
    	Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "insert into hw_history (hw_id, hw_due)values(?,current_date + (select  hw_freq from houseworks where hw_id =?)::integer)";
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

    //フラグを0→1に。実施日も追加。
    public boolean falseToTrue(int hwHisId, boolean hwFlag) {
    	Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "update hw_history set hw_date=CURRENT_DATE, hw_flag=? where hw_his_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setBoolean(1, hwFlag);
			pStmt.setInt(2, hwHisId);


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

    public boolean deleteNextHw(int hwId) {

    	Connection conn = null;
		boolean result = false;


		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "DELETE FROM hw_history WHERE hw_his_id = (SELECT MAX(hw_his_id) FROM hw_history WHERE hw_id =? )";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, hwId);

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

    //フラグを1→0に。更新日をnullに。
    public boolean trueToFalse(int hwHisId, boolean hwFlag) {
    	Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "update hw_history set hw_date=NULL, hw_flag=? where hw_his_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setBoolean(1, hwFlag);
			pStmt.setInt(2, hwHisId);


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

    public boolean delete(int hwHisId) {
		Connection conn = null;
		boolean result = false;

		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SQL文を準備する
			String sql = "delete from hw_history where hw_his_id=?";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			// SQL文を完成させる
			pStmt.setInt(1, hwHisId);

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

