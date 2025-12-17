package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mibogear.domain.DroppedGoods;
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

}
