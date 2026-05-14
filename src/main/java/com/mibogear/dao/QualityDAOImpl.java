package com.mibogear.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.mibogear.domain.Quality;

@Repository
public class QualityDAOImpl implements QualityDAO {
    @Resource(name = "session")
    private SqlSession sqlSession;

    @Override
    public List<Quality> getDailyCheckList(Quality params) {
        return sqlSession.selectList("quality.getDailyCheckList", params);
    }

    @Override
    public boolean dailyCheckUpdate(Quality quality) {
        int result = sqlSession.update("quality.dailyCheckUpdate", quality);
        return result > 0;
    }

    @Override
    public boolean dailyCheckDelete(Quality quality) {
        int result = sqlSession.delete("quality.dailyCheckDelete", quality);
        return result > 0;
    }

    @Override
    public boolean dailyCheckInsert(Quality quality) {
        int result = sqlSession.insert("quality.dailyCheckInsert", quality);
        return result > 0;
    }

    @Override
    public void dailyCheckDeleteByEquip(String d_ym, String d_equip) {
        Map<String, String> params = new HashMap<>();
        params.put("d_ym",    d_ym);
        params.put("d_equip", d_equip);
        sqlSession.delete("quality.dailyCheckDeleteByEquip", params);
    }

    @Override
    public List<Quality> getTempUniformityList(Quality quality) {
        return sqlSession.selectList("quality.getTempUniformityList", quality);
    }

    @Override
    public boolean updateTempUniformity(Quality quality) {
        int result = sqlSession.update("quality.updateTempUniformity", quality);
        return result > 0;
    }
}