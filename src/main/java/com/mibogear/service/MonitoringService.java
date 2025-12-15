package com.mibogear.service;

import java.util.List;

import com.mibogear.domain.Monitoring;

public interface MonitoringService {
	
	List<Monitoring> getAlarmList(Monitoring monitoring);
	List<Monitoring> getTempList(Monitoring monitoring);
	List<Monitoring> getAlarmRankingList(Monitoring monitoring);
	List<Monitoring> getAlarm1(Monitoring monitoring);
}
