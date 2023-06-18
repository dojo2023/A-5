package model;

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
}
