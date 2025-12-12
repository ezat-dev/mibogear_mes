package com.mibogear.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mibogear.domain.Quality;

@Service
public interface QualityService {
    //일상점검일지
    List<Quality> getDailyCheckList(Quality quality);
    boolean dailyCheckUpdate(Quality quality);
    boolean dailyCheckDelete(Quality quality);
    boolean dailyCheckInsert(Quality quality);
    
    //온도균일성
    List<Quality> getTempUniformityList(Quality quality);
    boolean updateTempUniformity(Quality quality);
}
