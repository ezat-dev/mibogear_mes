package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mibogear.domain.Chulgo;
import com.mibogear.domain.DroppedGoods;
import com.mibogear.domain.Ipgo;
import com.mibogear.domain.Monitoring;
import com.mibogear.domain.ProdData;
import com.mibogear.domain.ProductManage;

@Repository
public interface ProdDataDAO {
	
	// 리스트 조회
    List<Map<String, Object>> getProdDataList(Map<String, Object> params);
    // 상세 조회
    ProdData getProdDataDetail(int pd_code);
    // 오늘 LOT 순번 조회
    int getTodayLotMaxSeq();
    // 저장
    void insertProdData(ProdData prodData);
    // 수정
    void updateProdData(ProdData prodData);
    // 삭제
    void deleteProdData(int pd_code);
    
    void updatePdfPath(ProdData prodData);

}
