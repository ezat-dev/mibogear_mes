package com.mibogear.service;

import java.util.List;
import java.util.Map;

import com.mibogear.domain.DroppedGoods;
import com.mibogear.domain.Monitoring;
import com.mibogear.domain.ProductManage;

public interface ProductManageService {
	
	List<DroppedGoods> getDroppedGoodsList();
	
	void updateDroppedGoods(Map<String, Object> param);
	
	List<ProductManage> getLotList(ProductManage productManage);

	List<ProductManage> getLotListReport(ProductManage productManage);
	List<ProductManage> integrationLotList(ProductManage productManage);
	Monitoring integrationGetTemp(Monitoring monitoring);
	List<ProductManage> workDailyList(ProductManage productManage);
	List<ProductManage> workDailyListReport(ProductManage productManage);
}
