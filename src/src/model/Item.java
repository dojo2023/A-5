package model;
import java.util.Date;

public class Item {

	private int itemId;
	private int userId;
	private String dailyName;
	private String dailyUnit;
	private String itemName;
	private int itemPrice;
	private int itemVolume;
	private String itemMemo;
	private int itemFreq;
	private int itemHisId;
	private Date itemStart;
	private Date itemDue;
	private Date itemFin;
	private int itemPeriod;
	private boolean itemFlag;
	private int itemCapacity;
	private String itemUnit;
	private Date startDate;
	private Date endDate;
	private String itemRemarks;

	public Item(int userId, String dailyName, String dailyUnit, String itemName, int itemPrice, int itemVolume, String itemMemo, int itemFreq) {
		super();
		this.userId = userId;
		this.dailyName = dailyName;
		this.dailyUnit = dailyUnit;
		this.itemName = itemName;
		this.itemPrice = itemPrice;
		this.itemVolume = itemVolume;
		this.itemMemo = itemMemo;

	}

	public Item(String itemName, int itemCapacity, String itemUnit, int itemPrice, Date startDate, Date endDate, String itemRemarks ){
		super();
		this.itemName = itemName;
		this.itemCapacity = itemCapacity;
		this.itemUnit = itemUnit;
		this.itemPrice = itemPrice;
		this.startDate= startDate;
		this.endDate = endDate;
		this.itemRemarks = itemRemarks;
	}
	public Item() {
		super();
	};

	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getDailyName() {
		return dailyName;
	}
	public void setDailyName(String dailyName) {
		this.dailyName = dailyName;
	}
	public String getDailyUnit() {
		return dailyUnit;
	}
	public void setDailyUnit(String dailyUnit) {
		this.dailyUnit = dailyUnit;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public int getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}
	public int getItemVolume() {
		return itemVolume;
	}
	public void setItemVolume(int itemVolume) {
		this.itemVolume = itemVolume;
	}
	public String getItemMemo() {
		return itemMemo;
	}
	public void setItemMemo(String itemMemo) {
		this.itemMemo = itemMemo;
	}
	public int getItemHisId() {
		return itemHisId;
	}
	public void setItemHisId(int itemHisId) {
		this.itemHisId = itemHisId;
	}
	public Date getItemStart() {
		return itemStart;
	}
	public void setItemStart(Date itemStart) {
		this.itemStart = itemStart;
	}
	public Date getItemDue() {
		return itemDue;
	}
	public void setItemDue(Date itemDue) {
		this.itemDue = itemDue;
	}
	public Date getItemFin() {
		return itemFin;
	}
	public void setItemFin(Date itemFin) {
		this.itemFin = itemFin;
	}
	public int getItemPeriod() {
		return itemPeriod;
	}
	public void setItemPeriod(int itemPeriod) {
		this.itemPeriod = itemPeriod;
	}
	public boolean isItemFlag() {
		return itemFlag;
	}
	public void setItemFlag(boolean itemFlag) {
		this.itemFlag = itemFlag;
	}

	public int getItemCapacity() {
		return itemCapacity;
	}

	public void setItemCapacity(int itemCapacity) {
		this.itemCapacity = itemCapacity;
	}

	public String getItemUnit() {
		return itemUnit;
	}

	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getItemRemarks() {
		return itemRemarks;
	}

	public void setItemRemarks(String itemRemarks) {
		this.itemRemarks = itemRemarks;

	}

	public int getItemFreq() {
		return itemFreq;
	}

	public void setItemFreq(int itemFreq) {
		this.itemFreq = itemFreq;
	}

}