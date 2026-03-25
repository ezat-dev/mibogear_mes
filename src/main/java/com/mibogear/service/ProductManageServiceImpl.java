package com.mibogear.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mibogear.dao.ProductManageDAO;
import com.mibogear.domain.Chulgo;
import com.mibogear.domain.DroppedGoods;
import com.mibogear.domain.Ipgo;
import com.mibogear.domain.Monitoring;
import com.mibogear.domain.ProductManage;

@Service
public class ProductManageServiceImpl implements ProductManageService{
	
	@Autowired
	private ProductManageDAO productManageDAO;
	
	@Override
  	public List<DroppedGoods> getDroppedGoodsList(){
  		return productManageDAO.getDroppedGoodsList();
  	}
	
	public void updateDroppedGoods(Map<String, Object> param) {
		productManageDAO.updateDroppedGoods(param);
  	}
	
	@Override
  	public List<ProductManage> getLotList(ProductManage productManage){
  		return productManageDAO.getLotList(productManage);
  	}
	
	@Override
  	public List<ProductManage> getLotListReport(ProductManage productManage){
  		return productManageDAO.getLotListReport(productManage);
  	}
	
	@Override
  	public List<ProductManage> integrationLotList(ProductManage productManage){
  		return productManageDAO.integrationLotList(productManage);
  	}
	
	@Override
  	public Monitoring integrationGetTemp(Monitoring monitoring){
  		return productManageDAO.integrationGetTemp(monitoring);
  	}
	
	@Override
  	public List<ProductManage> workDailyList(ProductManage productManage){
  		return productManageDAO.workDailyList(productManage);
  	}
	
	@Override
  	public List<ProductManage> workDailyListReport(ProductManage productManage){
  		return productManageDAO.workDailyListReport(productManage);
  	}
	
	@Override
    public List<Ipgo> getIpgoList(Ipgo ipgo) {
        return productManageDAO.getIpgoList(ipgo);
    }

	@Override
	public void insertIpgo(Ipgo ipgo) {
	   
	    String prefix = new java.text.SimpleDateFormat("yyMMdd")
	                        .format(new java.util.Date());

	   
	    String lastCode = productManageDAO.getLastOrdCodeToday();

	    String newCode;
	    if (lastCode == null || lastCode.isEmpty()) {
	       
	        newCode = prefix + "001";
	    } else {
	       
	        int seq = Integer.parseInt(lastCode.substring(6)) + 1;
	        newCode = prefix + String.format("%03d", seq);
	    }

	    ipgo.setOrd_code(newCode);
	    productManageDAO.insertIpgo(ipgo);
	}

    @Override
    public void updateIpgo(Ipgo ipgo) {
    	productManageDAO.updateIpgo(ipgo);
    }

    @Override
    public void deleteIpgo(int ord_code) {
    	productManageDAO.deleteIpgo(ord_code);
    }
    
    @Override
    public List<Chulgo> getChulgoList(Chulgo chulgo) {
        return productManageDAO.getChulgoList(chulgo);
    }

    @Override
    public List<Chulgo> getIpgoForChulgo(Chulgo chulgo) {
        return productManageDAO.getIpgoForChulgo(chulgo);
    }

    @Override
    public void saveChulgoList(List<Chulgo> list) {
        for (Chulgo chulgo : list) {
        	productManageDAO.insertChulgo(chulgo);
        }
    }

    @Override
    public String getLastOchCodeToday() {
        return productManageDAO.getLastOchCodeToday();
    }
    
    @Override
    public void updateChulgo(Chulgo chulgo) {
    	productManageDAO.updateChulgo(chulgo);
    }
    
    @Override
    public List<Map<String, Object>> getJanStatus(Ipgo param) {
        return productManageDAO.getJanStatus(param);
    }
    @Override
    public List<Ipgo> getIpgoHist(Ipgo param) {
        return productManageDAO.getIpgoHist(param);
    }
    @Override
    public List<Chulgo> getChulgoHist(Chulgo param) {
        return productManageDAO.getChulgoHist(param);
    }
}
