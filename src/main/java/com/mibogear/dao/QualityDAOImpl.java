package com.mibogear.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mibogear.domain.Quality;

@Repository
public class QualityDAOImpl implements QualityDAO{
	@Resource(name="session")
	private SqlSession sqlSession;
	
	@Override
	public List<Quality> getDailyCheckList(Quality params) {
		return sqlSession.selectList("quality.getDailyCheckList", params);
	}
  	@Override
  	public boolean dailyCheckUpdate(Quality quality) {
  		int result = sqlSession.update("quality.dailyCheckUpdate",quality);
  		if(result <= 0) {
  			return false;
  		}
  		return true;
  	}
  	@Override
  	public boolean dailyCheckDelete(Quality quality) {
  		int result = sqlSession.delete("quality.dailyCheckDelete",quality);
  		if(result <= 0) {
  			return false;
  		}
  		return true;
  	}
  	@Override
  	public boolean dailyCheckInsert(Quality quality) {
  		int result = sqlSession.insert("quality.dailyCheckInsert",quality);
  		if(result <= 0) {
  			return false;
  		}
  		return true;
  	}
	@Override
	public List<Quality> getTempUniformityList(Quality quality) {
		return sqlSession.selectList("quality.getTempUniformityList", quality);
	}
  	@Override
  	public boolean updateTempUniformity(Quality quality) {
  		int result = sqlSession.update("quality.updateTempUniformity",quality);
  		if(result <= 0) {
  			return false;
  		}
  		return true;
  	}
}
