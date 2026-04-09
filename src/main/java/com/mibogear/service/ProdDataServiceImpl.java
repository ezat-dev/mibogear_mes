
package com.mibogear.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mibogear.dao.ProdDataDAO;
import com.mibogear.domain.PatternRequest;
import com.mibogear.domain.WorkOrder;

@Service
public class ProdDataServiceImpl implements ProdDataService {

    @Autowired
    private ProdDataDAO prodDataDAO;

    @Override
    public List<Map<String, Object>> getWorkOrderList(Map<String, Object> params) {
        return prodDataDAO.getWorkOrderList(params);
    }
 
    @Override
    public WorkOrder getWorkOrderDetail(int wo_code) {
        return prodDataDAO.getWorkOrderDetail(wo_code);
    }
 
    @Override
    public Map<String, Object> saveWorkOrder(WorkOrder workOrder, String mode) {
        Map<String, Object> result = new HashMap<>();
 
        if ("insert".equalsIgnoreCase(mode)) {
            // LOT번호 자동생성: yyMMdd-BCFn-순번3자리
            String today = new SimpleDateFormat("yyMMdd").format(new Date());
            
            // bcf_hogi 값으로 설비코드 결정 (1→BCF1, 2→BCF2, 3→BCF3, 4→BCF4)
            String hogiCode = "BCF" + (workOrder.getBcf_hogi() != null ? workOrder.getBcf_hogi() : "0");
            
            // 오늘 + 해당 설비 기준으로 마지막 순번 조회
            String prefix = today + "-" + hogiCode + "-";
            String lastNo = prodDataDAO.getTodayLastLotSeq(prefix);
            
            int seq = 1;
            if (lastNo != null && !lastNo.isEmpty()) {
                // prefix 이후 숫자 3자리만 파싱
                String seqPart = lastNo.replace(prefix, "");
                try { seq = Integer.parseInt(seqPart) + 1; } catch (NumberFormatException e) { seq = 1; }
            }
            
            String lotNo = prefix + String.format("%03d", seq);
            workOrder.setLot_no(lotNo);
            prodDataDAO.insertWorkOrder(workOrder);
        } else {
        	prodDataDAO.updateWorkOrder(workOrder);
        }
 
        result.put("wo_code", workOrder.getWo_code());
        result.put("lot_no",  workOrder.getLot_no());
        return result;
    }
 
    @Override
    public void updatePdfPath(WorkOrder workOrder) {
    	prodDataDAO.updatePdfPath(workOrder);
    }
 
    @Override
    public void deleteWorkOrder(int wo_code) {
    	prodDataDAO.deleteWorkOrder(wo_code);
    }
    
    
    
    
    
    
    @Override
    public PatternRequest getPattern() {
        return prodDataDAO.getPattern();
    }
 
    @Override
    public int getPatternStatus() {
        return prodDataDAO.getPatternStatus();
    }
 
    @Override
    public void requestPattern(PatternRequest patternRequest) {
        prodDataDAO.requestPattern(patternRequest);
    }
 
    @Override
    public void completePattern() {
        prodDataDAO.completePattern();
    }
 
    @Override
    public void resetPattern() {
        prodDataDAO.resetPattern();
    }
    
    
}