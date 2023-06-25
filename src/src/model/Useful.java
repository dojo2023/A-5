package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Useful {
	public Map<String, String> getMappingData(List<Item> itemlist) {
		Map<String, String> mappingData = new HashMap<>();
		for (Item item : itemlist) {
			mappingData.put(item.getDailyName(), item.getDailyUnit());
		}
		return mappingData;
	}

	//リクエストパラメータで取得したString型の変数をDate型にする
	public Date strToDate(String str) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date itemStart = null;
        try {
            itemStart = dateFormat.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return itemStart;
	}
	//開始日時と頻度や予測使用日数から期日を算出する
	public Date getDueDate(Date start, int addedDays) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(start);
		calendar.add(Calendar.DATE, addedDays);
		Date itemDue = calendar.getTime();
		return itemDue;
	}
}
