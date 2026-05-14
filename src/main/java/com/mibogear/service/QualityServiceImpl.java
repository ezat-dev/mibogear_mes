package com.mibogear.service;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mibogear.dao.QualityDAO;
import com.mibogear.domain.Quality;

@Service
public class QualityServiceImpl implements QualityService {
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
    public boolean dailyCheckInitEquip(Map<String, Object> body) {
        try {
            String d_ym    = (String) body.get("d_ym");
            String d_equip = (String) body.get("d_equip");

            // 기존 해당 월/설비 데이터 삭제
            qualityDao.dailyCheckDeleteByEquip(d_ym, d_equip);

            // 설비별 항목 INSERT
            @SuppressWarnings("unchecked")
            List<Map<String, String>> items = (List<Map<String, String>>) body.get("items");
            for (Map<String, String> item : items) {
                Quality q = new Quality();
                q.setD_ym(d_ym);
                q.setD_equip(d_equip);
                q.setD_title(item.get("d_title"));
                q.setD_desc(item.get("d_desc"));
                qualityDao.dailyCheckInsert(q);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
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