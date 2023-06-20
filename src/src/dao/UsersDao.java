package dao;

//パッケージのインポート
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.User;

public class UsersDao {
//ログイン
	public boolean isLoginOK(String userName, String userPass) {
		Connection conn = null;//Connectionクラスのconn いったんnull
		boolean loginResult = false;
		User Login = new User();
		Login.setUser_id(null);
		//インスタンス化 Userというクラスをmodelで作っておく
		//それをLoginという名前にして呼び出す
		try {
			// JDBCドライバを読み込む
			Class.forName("org.h2.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");

			// SELECT文を準備する.ユーザー名とパスワードが一致してたら、ユーザーIDを取ってくる
			String sql = "select * from users where user_name = ? and user_pass = ?";

			//Connectionクラスのオブジェクト名conn.preparedStatement(引数でsql文を渡してあげる)
			PreparedStatement pStmt = conn.prepareStatement(sql);

			//?に値を挿入する ここで入力された値がisLoginOKの引数になる
			pStmt.setString(1, userName);
			pStmt.setString(2, userPass);

			// SELECT文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();

			//rsは直接取ってこれないからLoginに入れる
			//青いところはなんとなくSQLの列名が入ることが多い
			while(rs.next()) {
			Login.setUser_id(rs.getString("user_id"));
			Login.setUser_name(rs.getString("user_name"));
			Login.setUser_pass(rs.getString("user_pass"));
			}
			//LoginのUser_idに値が入ってたらtrue返す
			if(Login.getUser_id() != null)
			loginResult = true;
		}

		catch (SQLException e) {
			e.printStackTrace();
			loginResult = false;
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
			loginResult = false;
		}
		finally {
			// データベースを切断
			if (conn != null) {
				try {
					conn.close();
				}
				catch (SQLException e) {
					e.printStackTrace();
					loginResult = false;
				}
			}
		}
		// 結果を返す　Beans
		return loginResult;
	}
//新規登録
	//1 ユーザー名被りが無いか検索
	//2 無ければレコードを登録

	public boolean newAccount(String userName, String userPass) {
			Connection conn = null;
			boolean accountResult = false;

	  try {
		// JDBCドライバを読み込む
		Class.forName("org.h2.Driver");

		// データベースに接続する
		conn = DriverManager.getConnection("jdbc:h2:file:C:/pleiades/workspace/data/Yakou", "sa", "");


		//新規登録　被りがないか探すSQL文を準備
		String sql = "select * from users where user_name = ?";
		PreparedStatement pStmt = conn.prepareStatement(sql);

		//?に値を挿入
		pStmt.setString(1, userName);

		// SQL文を実行し、結果表を取得
		ResultSet rs = pStmt.executeQuery();

		//重複あり　失敗　ユーザー名
		if(rs.next()) {
			accountResult = false;
		}
		// 重複なし　SQL文２を準備する 自動採番はsql文に書かなくて良い
		else{
			 sql = "insert into users(user_name,user_pass) values(?,?)";

			 pStmt = conn.prepareStatement(sql);

			//?に値を挿入する ここで入力された値がデータベースに入る
			pStmt.setString(1, userName);
			pStmt.setString(2, userPass);

			// SQL文を実行
			if (pStmt.executeUpdate() == 1) {
				accountResult = true;
			}
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
			return accountResult;
			}





	}
