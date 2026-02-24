package com.mibogear.service;

import java.util.List;
import java.util.Map;

import com.mibogear.domain.Monitoring;
import com.mibogear.domain.ProductManage;

public interface MonitoringService {
	
	List<Monitoring> getAlarmList(Monitoring monitoring);
	List<Monitoring> getTempList(Monitoring monitoring);
	List<Monitoring> getAlarmRankingList(Monitoring monitoring);
	List<Monitoring> getAlarm1(Monitoring monitoring);
	
	List<ProductManage> getLotList(ProductManage productManage);
	boolean trendMemoInsert(Monitoring monitoring);
	
	
	Map<String, Object> getOverviewData();
}
