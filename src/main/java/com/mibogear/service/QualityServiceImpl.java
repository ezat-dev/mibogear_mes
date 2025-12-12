package com.mibogear.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mibogear.dao.QualityDAO;
import com.mibogear.domain.Quality;

@Service
public class QualityServiceImpl implements QualityService{
	@Autowired
	private QualityDAO qualityDao;
	
    @Override
    public List<Quality> getDailyCheckList(Quality quality) {
        return qualityDao.getDailyCheckList(quality);
    }
  	@Override
  	public boolean dailyCheckUpdate(Quality quality) {
  		return qualityDao.dailyCheckUpdate(quality);
  	}
  	@Override
  	public boolean dailyCheckDelete(Quality quality) {
  		return qualityDao.dailyCheckDelete(quality);
  	}
  	@Override
  	public boolean dailyCheckInsert(Quality quality) {
  		return qualityDao.dailyCheckInsert(quality);
  	}
    @Override
    public List<Quality> getTempUniformityList(Quality quality) {
        return qualityDao.getTempUniformityList(quality);
    }
  	@Override
  	public boolean updateTempUniformity(Quality quality) {
  		return qualityDao.updateTempUniformity(quality);
  	}
}
