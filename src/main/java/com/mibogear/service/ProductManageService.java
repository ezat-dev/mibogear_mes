package com.mibogear.service;

import java.util.List;
import java.util.Map;

import com.mibogear.domain.Chulgo;
import com.mibogear.domain.DroppedGoods;
import com.mibogear.domain.Ipgo;
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
	
	
	List<Ipgo> getIpgoList(Ipgo ipgo);
    void insertIpgo(Ipgo ipgo);
    void updateIpgo(Ipgo ipgo);
    void deleteIpgo(int ord_code);
    
    List<Chulgo> getChulgoList(Chulgo chulgo);
    List<Chulgo> getIpgoForChulgo(Chulgo chulgo);
    void saveChulgoList(List<Chulgo> list);
    String getLastOchCodeToday();
    void updateChulgo(Chulgo chulgo);
    
    
    List<Map<String, Object>> getJanStatus(Ipgo param);
    List<Ipgo> getIpgoHist(Ipgo param);
    List<Chulgo> getChulgoHist(Chulgo param);
}
