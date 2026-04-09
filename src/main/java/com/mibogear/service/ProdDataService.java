package com.mibogear.service;

import java.util.List;
import java.util.Map;

import com.mibogear.domain.PatternRequest;
import com.mibogear.domain.WorkOrder;

public interface ProdDataService {

	List<Map<String, Object>> getWorkOrderList(Map<String, Object> params);
	
    WorkOrder getWorkOrderDetail(int wo_code);
    
    Map<String, Object> saveWorkOrder(WorkOrder workOrder, String mode);
    
    void updatePdfPath(WorkOrder workOrder);
    
    void deleteWorkOrder(int wo_code);
    
    
    PatternRequest getPattern();
    int getPatternStatus();
    void requestPattern(PatternRequest patternRequest);
    void completePattern();
    void resetPattern();
}