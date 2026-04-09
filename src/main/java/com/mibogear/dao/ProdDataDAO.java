package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mibogear.domain.PatternRequest;
import com.mibogear.domain.WorkOrder;

@Repository
public interface ProdDataDAO {
	
	List<Map<String, Object>> getWorkOrderList(Map<String, Object> params);
	
    WorkOrder getWorkOrderDetail(int wo_code);
    
    String getTodayLastLotSeq(String prefix);
    
    void insertWorkOrder(WorkOrder workOrder);
    
    void updateWorkOrder(WorkOrder workOrder);
    
    void updatePdfPath(WorkOrder workOrder);
    
    void deleteWorkOrder(int wo_code);
    
 // ── 패턴 요청
    PatternRequest getPattern();
    int getPatternStatus();
    void requestPattern(PatternRequest patternRequest);
    void completePattern();
    void resetPattern();

}
