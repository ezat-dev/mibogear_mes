package com.mibogear.service;

import java.util.List;
import java.util.Map;

import com.mibogear.domain.ProdData;

public interface ProdDataService {

    List<Map<String, Object>> getProdDataList(Map<String, Object> params);

    ProdData getProdDataDetail(int pd_code);

    Map<String, Object> saveProdData(ProdData prodData, String mode);

    void updatePdfPath(ProdData prodData);

    void deleteProdData(int pd_code);
}