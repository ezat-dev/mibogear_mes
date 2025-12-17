package com.mibogear.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mibogear.dao.MonitoringDAO;
import com.mibogear.domain.Monitoring;
import com.mibogear.domain.ProductManage;

@Service
public class MonitoringServiceImpl implements MonitoringService{
	
	@Autowired
	private MonitoringDAO monitoringDao;
	
    @Override
    public List<Monitoring> getAlarmList(Monitoring monitoring) {
        return monitoringDao.getAlarmList(monitoring);
    }
    @Override
    public List<Monitoring> getTempList(Monitoring monitoring) {
        return monitoringDao.getTempList(monitoring);
    }
    @Override
    public List<Monitoring> getAlarmRankingList(Monitoring monitoring) {
        return monitoringDao.getAlarmRankingList(monitoring);
    }
    @Override
    public List<Monitoring> getAlarm1(Monitoring monitoring) {
        return monitoringDao.getAlarm1(monitoring);
    }
    
    @Override
    public List<ProductManage> getLotList(ProductManage productManage) {
        return monitoringDao.getLotList(productManage);
    }
}
