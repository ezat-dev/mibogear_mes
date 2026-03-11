package com.mibogear.dao;

import java.util.List;
import java.util.Map;

import com.mibogear.domain.AnnualCheck;
import com.mibogear.domain.Bega;
import com.mibogear.domain.SparePart;
import com.mibogear.domain.Suri;

public interface PreservationDAO {
	
	List<SparePart> getSparePartList(SparePart sparePart);
	
	SparePart sparePartDetail(SparePart sparePart);
	
	void sparePartInsertSave(SparePart sparePart);
	
	void sparePartUpdateSave(SparePart sparePart);
	
	void sparePartDelete(String spp_code);
	
	
	
	
	List<Bega> getBegaInsertList(Bega bega);
	
	Bega begaInsertDetail(Bega bega);
	
	void begaInsertSave(Bega bega);
	
	void begaUpdateSave(Bega bega);
	
	void begaDelete(String fstp_code);
	
	
	List<Suri> getSuriHistoryList(Suri srui);
	
	Suri suriHistoryDetail(Suri srui);
	
	void suriHistoryInsertSave(Suri srui);
	
	void suriHistoryUpdateSave(Suri srui);
	
	void suriHistoryDelete(String ffx_no);
	
	
	// ===================== PreservationDAO.java (인터페이스 추가분) =====================
	List<AnnualCheck> getAnnualCheckSummary(AnnualCheck annualCheck);
	List<AnnualCheck> getCheckResultByMonth(AnnualCheck annualCheck);
	AnnualCheck       getCheckResultById(int id);
	int               insertCheckResult(AnnualCheck annualCheck);
	int               updateCheckResult(AnnualCheck annualCheck);
	int               deleteCheckResult(int id);
	int updateCheckResultCell(Map<String, Object> params);
	
}
