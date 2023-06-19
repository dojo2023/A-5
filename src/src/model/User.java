package model;
import java.io.Serializable;
//クラスをnewすること＝インスタンス化
//クラス（メソッドとフィールドが必要）
public class User implements Serializable {
	//フィールドの宣言をする
	private String user_id;	// ID
	private String user_name;	// ユーザー名
	private String user_pass;	// パスワード


//コンストラクタ （= 特別なメソッド）
//クラス名と同じ
//ここの引数は自由記述
//引数の値をフィールドにセットするコンストラクタ
	public User(String id, String name, String pass) {
		this.user_id = id; //this.(フィールドの変数) = (引数)
		this.user_name = name;
		this.user_pass = pass;
	}

//JavaBeansを作るのに必要
//引数なしコンストラクタ　何もしない
	public User() {
		this.user_id ="";
		this.user_name = "";
		this.user_pass = "";
	}

//メソッド
//ゲッター フィールド(上の)の値を取得するメソッド
//セッター フィールド(上の)に値を設定するメソッド
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_pass() {
		return user_pass;
	}
	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}
}
