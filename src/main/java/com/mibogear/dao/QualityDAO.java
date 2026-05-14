package com.mibogear.dao;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.mibogear.domain.Quality;

@Repository
public interface QualityDAO {
    // 일상점검일지
    List<Quality> getDailyCheckList(Quality quality);
    boolean dailyCheckUpdate(Quality quality);
    boolean dailyCheckDelete(Quality quality);
    boolean dailyCheckInsert(Quality quality);
    void dailyCheckDeleteByEquip(String d_ym, String d_equip);

    // 온도균일성
    List<Quality> getTempUniformityList(Quality quality);
    boolean updateTempUniformity(Quality quality);
}