package com.mibogear.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mibogear.dao.ProdDataDAO;
import com.mibogear.domain.ProdData;

@Service
public class ProdDataServiceImpl implements ProdDataService {

    @Autowired
    private ProdDataDAO prodDataDAO;

    @Override
    public List<Map<String, Object>> getProdDataList(Map<String, Object> params) {
        return prodDataDAO.getProdDataList(params);
    }

    @Override
    public ProdData getProdDataDetail(int pd_code) {
        return prodDataDAO.getProdDataDetail(pd_code);
    }

    @Override
    public Map<String, Object> saveProdData(ProdData prodData, String mode) {
        Map<String, Object> result = new HashMap<>();

        if ("insert".equalsIgnoreCase(mode)) {
            String today  = new SimpleDateFormat("yyMMdd").format(new Date());
            int    lastSeq = prodDataDAO.getTodayLotMaxSeq();
            String lotNo  = today + String.format("%03d", lastSeq + 1);
            prodData.setLot_no(lotNo);
            prodDataDAO.insertProdData(prodData);
        } else {
            prodDataDAO.updateProdData(prodData);
        }

        result.put("pd_code", prodData.getPd_code());
        result.put("lot_no",  prodData.getLot_no());
        return result;
    }

    @Override
    public void updatePdfPath(ProdData prodData) {
        prodDataDAO.updatePdfPath(prodData);
    }

    @Override
    public void deleteProdData(int pd_code) {
        prodDataDAO.deleteProdData(pd_code);
    }
}