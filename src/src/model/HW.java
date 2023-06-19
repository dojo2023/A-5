package model;
import java.util.Date;

public class HW {

	private int hwId;
	private int userId;
	private String hwName;
	private int hwFreq;
	private String hwMemo;
	private int hwHisId;
	private Date hwDate;
	private Date hwDue;
	private boolean hwFlag;

	public HW(String hwName, int hwFreq, String hwMemo, Date hwDate) {
		super();
		this.hwName = hwName;
		this.hwFreq = hwFreq;
		this.hwMemo = hwMemo;
		this.hwDate = hwDate;
	}
	public HW() {
		super();
	};


	public int getHwId() {
		return hwId;
	}
	public void setHwId(int hwId) {
		this.hwId = hwId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getHwName() {
		return hwName;
	}
	public void setHwName(String hwName) {
		this.hwName = hwName;
	}
	public int getHwFreq() {
		return hwFreq;
	}
	public void setHwFreq(int hwFreq) {
		this.hwFreq = hwFreq;
	}
	public String getHwMemo() {
		return hwMemo;
	}
	public void setHwMemo(String hwMemo) {
		this.hwMemo = hwMemo;
	}
	public int getHwHisId() {
		return hwHisId;
	}
	public void setHwHisId(int hwHisId) {
		this.hwHisId = hwHisId;
	}
	public Date getHwDate() {
		return hwDate;
	}
	public void setHwDate(Date hwDate) {
		this.hwDate = hwDate;
	}
	public Date getHwDue() {
		return hwDue;
	}
	public void setHwDue(Date hwDue) {
		this.hwDue = hwDue;
	}
	public boolean getHwFlag() {
		return hwFlag;
	}
	public void setHwFlag(boolean hwFlag) {
		this.hwFlag = hwFlag;
	}

}
