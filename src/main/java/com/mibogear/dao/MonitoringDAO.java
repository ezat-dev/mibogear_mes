package com.mibogear.dao;

import java.util.List;

import com.mibogear.domain.Monitoring;

public interface MonitoringDAO {
	
	List<Monitoring> getAlarmList(Monitoring monitoring);
	List<Monitoring> getTempList(Monitoring monitoring);
	List<Monitoring> getAlarmRankingList(Monitoring monitoring);
	List<Monitoring> getAlarm1(Monitoring monitoring);
}
