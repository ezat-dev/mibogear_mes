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
import com.mibogear.domain.ProductManage;

@Repository
public class ProductManageDAOImpl implements ProductManageDAO {
	
	@Resource(name="session")
	private SqlSession sqlSession;
	
	@Override
	public List<DroppedGoods> getDroppedGoodsList() {
		return sqlSession.selectList("droppedGoods.getDroppedGoodsList");
	}
	
	public void updateDroppedGoods(Map<String, Object> param) {
  		sqlSession.update("droppedGoods.updateDroppedGoods",param);
  	}
	
	@Override
	public List<ProductManage> getLotList(ProductManage productManage){
		System.out.println("lot DAO 로그");
		System.out.println(productManage.getFac_no());
		System.out.println(productManage.getFac_no_save());
		return sqlSession.selectList("productManage.getLotList", productManage);
	}
	
	@Override
	public List<ProductManage> getLotListReport(ProductManage productManage){
		return sqlSession.selectList("productManage.getLotListReport", productManage);
	}
	
	@Override
	public List<ProductManage> integrationLotList(ProductManage productManage){
		return sqlSession.selectList("productManage.integrationLotList", productManage);
	}
	
	@Override
	public Monitoring integrationGetTemp(Monitoring monitoring){
		return sqlSession.selectOne("productManage.integrationGetTemp", monitoring);
	}
	
	@Override
	public List<ProductManage> workDailyList(ProductManage productManage){
		return sqlSession.selectList("productManage.workDailyList", productManage);
	}

	@Override
	public List<ProductManage> workDailyListReport(ProductManage productManage){
		return sqlSession.selectList("productManage.workDailyListReport", productManage);
	}
	
	
	@Override
    public List<Ipgo> getIpgoList(Ipgo ipgo) {
        return sqlSession.selectList("ipgo.getIpgoList", ipgo);
    }

    @Override
    public void insertIpgo(Ipgo ipgo) {
        sqlSession.insert("ipgo.insertIpgo", ipgo);
    }

    @Override
    public void updateIpgo(Ipgo ipgo) {
        sqlSession.update("ipgo.updateIpgo", ipgo);
    }

    @Override
    public void deleteIpgo(int ord_code) {
        sqlSession.delete("ipgo.deleteIpgo", ord_code);
    }
    
    @Override
    public String getLastOrdCodeToday() {
        return sqlSession.selectOne("ipgo.getLastOrdCodeToday");
    }
	
	
	
    @Override
    public List<Chulgo> getChulgoList(Chulgo chulgo) {
        return sqlSession.selectList("chulgo.getChulgoList", chulgo);
    }

    @Override
    public List<Chulgo> getIpgoForChulgo(Chulgo chulgo) {
        return sqlSession.selectList("chulgo.getIpgoForChulgo", chulgo);
    }

    @Override
    public void insertChulgo(Chulgo chulgo) {
        sqlSession.insert("chulgo.insertChulgo", chulgo);
    }

    @Override
    public String getLastOchCodeToday() {
        return sqlSession.selectOne("chulgo.getLastOchCodeToday");
    }
    
    @Override
    public void updateChulgo(Chulgo chulgo) {
        sqlSession.update("chulgo.updateChulgo", chulgo);
    }
    
    @Override
    public List<Map<String, Object>> getJanStatus(Ipgo param) {
        return sqlSession.selectList("ipChulgoStatus.getJanStatus", param);
    }
    @Override
    public List<Ipgo> getIpgoHist(Ipgo param) {
        return sqlSession.selectList("ipChulgoStatus.getIpgoHist", param);
    }
    @Override
    public List<Chulgo> getChulgoHist(Chulgo param) {
        return sqlSession.selectList("ipChulgoStatus.getChulgoHist", param);
    }
	
}
