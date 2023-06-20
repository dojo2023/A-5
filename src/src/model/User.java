package model;
import java.io.Serializable;
//クラスをnewすること＝インスタンス化
//クラス（メソッドとフィールドが必要）
public class User implements Serializable {
	//フィールドの宣言をする
	private String userId;	// ID
	private String userName;	// ユーザー名
	private String userPass;	// パスワード


//コンストラクタ （= 特別なメソッド）
//クラス名と同じ
//ここの引数は自由記述
//引数の値をフィールドにセットするコンストラクタ
	public User(String id, String name, String pass) {
		this.userId = id; //this.(フィールドの変数) = (引数)
		this.userName = name;
		this.userPass = pass;
	}

//JavaBeansを作るのに必要
//引数なしコンストラクタ　何もしない
	public User() {
		this.userId ="";
		this.userName = "";
		this.userPass = "";
	}

//メソッド
//ゲッター フィールド(上の)の値を取得するメソッド
//セッター フィールド(上の)に値を設定するメソッド
	public String getUser_id() {
		return userId;
	}

	public void setUser_id(String userId) {
		this.userId = userId;
	}

	public String getUser_name() {
		return userName;
	}
	public void setUser_name(String userName) {
		this.userName = userName;
	}

	public String getUser_pass() {
		return userPass;
	}
	public void setUser_pass(String userPass) {
		this.userPass = userPass;
	}
}
