package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mibogear.domain.Chulgo;
import com.mibogear.domain.DroppedGoods;
import com.mibogear.domain.Ipgo;
import com.mibogear.domain.Monitoring;
import com.mibogear.domain.ProdData;
import com.mibogear.domain.ProductManage;

@Repository
public class ProdDataDAOImpl implements ProdDataDAO {
	
	@Resource(name="session")
	private SqlSession sqlSession;
	
	@Override
    public List<Map<String, Object>> getProdDataList(Map<String, Object> params) {
        return sqlSession.selectList("prodData.getProdDataList", params);
    }

    @Override
    public ProdData getProdDataDetail(int pd_code) {
        return sqlSession.selectOne("prodData.getProdDataDetail", pd_code);
    }

    @Override
    public int getTodayLotMaxSeq() {
        Integer result = sqlSession.selectOne("prodData.getTodayLotMaxSeq");
        return result != null ? result : 0;
    }

    @Override
    public void insertProdData(ProdData prodData) {
        sqlSession.insert("prodData.insertProdData", prodData);
    }

    @Override
    public void updateProdData(ProdData prodData) {
        sqlSession.update("prodData.updateProdData", prodData);
    }

    @Override
    public void deleteProdData(int pd_code) {
        sqlSession.delete("prodData.deleteProdData", pd_code);
    }
	
    @Override
    public void updatePdfPath(ProdData prodData) {
        sqlSession.update("prodData.updatePdfPath", prodData);
    }
}
