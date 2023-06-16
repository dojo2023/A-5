package model;
import java.util.Date;

public class Item {

	private int item_id;
	private int user_id;
	private String daily_name;
	private String daily_unit;
	private String item_name;
	private int item_price;
	private int item_volume;
	private String item_memo;
	private int item_his_id;
	private Date item_start;
	private Date item_due;
	private Date item_fin;
	private int item_period;
	private boolean item_flag;


	public int getItem_id() {
		return item_id;
	}
	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getDaily_name() {
		return daily_name;
	}
	public void setDaily_name(String daily_name) {
		this.daily_name = daily_name;
	}
	public String getDaily_unit() {
		return daily_unit;
	}
	public void setDaily_unit(String daily_unit) {
		this.daily_unit = daily_unit;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public int getItem_volume() {
		return item_volume;
	}
	public void setItem_volume(int item_volume) {
		this.item_volume = item_volume;
	}
	public String getItem_memo() {
		return item_memo;
	}
	public void setItem_memo(String item_memo) {
		this.item_memo = item_memo;
	}
	public int getItem_his_id() {
		return item_his_id;
	}
	public void setItem_his_id(int item_his_id) {
		this.item_his_id = item_his_id;
	}
	public Date getItem_start() {
		return item_start;
	}
	public void setItem_start(Date item_start) {
		this.item_start = item_start;
	}
	public Date getItem_due() {
		return item_due;
	}
	public void setItem_due(Date item_due) {
		this.item_due = item_due;
	}
	public Date getItem_fin() {
		return item_fin;
	}
	public void setItem_fin(Date item_fin) {
		this.item_fin = item_fin;
	}
	public int getItem_period() {
		return item_period;
	}
	public void setItem_period(int item_period) {
		this.item_period = item_period;
	}
	public boolean isItem_flag() {
		return item_flag;
	}
	public void setItem_flag(boolean item_flag) {
		this.item_flag = item_flag;
	}

}
