package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mibogear.domain.PatternRequest;
import com.mibogear.domain.WorkOrder;

@Repository
public class ProdDataDAOImpl implements ProdDataDAO {

    @Resource(name = "session")
    private SqlSession sqlSession;

    @Override
    public List<Map<String, Object>> getWorkOrderList(Map<String, Object> params) {
        return sqlSession.selectList("workOrder.getWorkOrderList", params);
    }
 
    @Override
    public WorkOrder getWorkOrderDetail(int wo_code) {
        return sqlSession.selectOne("workOrder.getWorkOrderDetail", wo_code);
    }
 
    public String getTodayLastLotSeq(String prefix) {
        return sqlSession.selectOne("workOrder.getTodayLastLotSeq", prefix);
    }
 
    @Override
    public void insertWorkOrder(WorkOrder workOrder) {
        sqlSession.insert("workOrder.insertWorkOrder", workOrder);
    }
 
    @Override
    public void updateWorkOrder(WorkOrder workOrder) {
        sqlSession.update("workOrder.updateWorkOrder", workOrder);
    }
 
    @Override
    public void updatePdfPath(WorkOrder workOrder) {
        sqlSession.update("workOrder.updatePdfPath", workOrder);
    }
 
    @Override
    public void deleteWorkOrder(int wo_code) {
        sqlSession.delete("workOrder.deleteWorkOrder", wo_code);
    }
    
    @Override
    public PatternRequest getPattern() {
        return sqlSession.selectOne("patternRequest.getPattern");
    }
 
    @Override
    public int getPatternStatus() {
        Integer status = sqlSession.selectOne("patternRequest.getPatternStatus");
        return status != null ? status : 0;
    }
 
    @Override
    public void requestPattern(PatternRequest patternRequest) {
        sqlSession.update("patternRequest.requestPattern", patternRequest);
    }
 
    @Override
    public void completePattern() {
        sqlSession.update("patternRequest.completePattern");
    }
 
    @Override
    public void resetPattern() {
        sqlSession.update("patternRequest.resetPattern");
    }
    
    
    
    
    
    
    
    
}