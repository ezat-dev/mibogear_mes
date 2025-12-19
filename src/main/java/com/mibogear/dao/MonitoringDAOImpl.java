package com.mibogear.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mibogear.domain.Monitoring;
import com.mibogear.domain.ProductManage;

@Repository
public class MonitoringDAOImpl implements MonitoringDAO{
	
	@Resource(name="session")
	private SqlSession sqlSession;

	@Override
	public List<Monitoring> getAlarmList(Monitoring monitoring) {
		return sqlSession.selectList("monitoring.getAlarmList", monitoring);
	}
	@Override
	public List<Monitoring> getTempList(Monitoring monitoring) {
		return sqlSession.selectList("monitoring.getTempList", monitoring);
	}
	@Override
	public List<Monitoring> getAlarmRankingList(Monitoring monitoring) {
		return sqlSession.selectList("monitoring.getAlarmRankingList", monitoring);
	}
	@Override
	public List<Monitoring> getAlarm1(Monitoring monitoring) {
		return sqlSession.selectList("monitoring.getAlarm1", monitoring);
	}
	
	@Override
	public List<ProductManage> getLotList(ProductManage productManage) {
		return sqlSession.selectList("monitoring.getLotList", productManage);
	}
	@Override
	public boolean trendMemoInsert(Monitoring monitoring) {
		int result =  sqlSession.insert("monitoring.trendMemoInsert", monitoring);
		if(result <= 0) {
			return false;
		}
		return true;
	}
}
