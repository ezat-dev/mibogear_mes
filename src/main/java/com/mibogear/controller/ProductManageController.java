package com.mibogear.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mibogear.domain.DroppedGoods;
import com.mibogear.domain.Monitoring;
import com.mibogear.domain.ProductManage;
import com.mibogear.service.MonitoringService;
import com.mibogear.service.ProductManageService;

//import net.sf.jasperreports.engine.JasperCompileManager;
//import net.sf.jasperreports.engine.JasperFillManager;
//import net.sf.jasperreports.engine.JasperPrint;
//import net.sf.jasperreports.engine.JasperReport;
//import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
//import net.sf.jasperreports.engine.export.JRPdfExporter;
//import net.sf.jasperreports.export.SimpleExporterInput;
//import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

import net.sf.jasperreports.engine.JasperCompileManager;

import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

@Controller
public class ProductManageController {
	
	@Autowired
	private ProductManageService productManageService; 
	
	@Autowired
	private MonitoringService monitoringService;
	
	
	
	//낙하품관리 로드
    @RequestMapping(value= "/productionManagement/droppedGoods", method = RequestMethod.GET)
    public String droppedGoods(Model model) {
        return "/productionManagement/droppedGoods.jsp";  
    }
    
    
  //낙하품관리 조회
    @RequestMapping(value = "/productionManagement/droppedGoods/getDroppedGoodsList", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getDroppedGoodsList() {

        Map<String, Object> rtnMap = new HashMap<>();

        
        List<DroppedGoods> droppedGoodsList = productManageService.getDroppedGoodsList();

        List<Map<String, Object>> rtnList = new ArrayList<>();
        for (int i = 0; i < droppedGoodsList.size(); i++) {
        	DroppedGoods dg = droppedGoodsList.get(i);

            Map<String, Object> row = new HashMap<>();
            row.put("d_lot", dg.getD_lot());
            row.put("w_pnum", dg.getW_pnum());
            row.put("item_name", dg.getItem_name());
            row.put("w_sdatetime", dg.getW_sdatetime());
            row.put("w_in_edatetime", dg.getW_in_edatetime());
            row.put("w_edatetime", dg.getW_edatetime());
            row.put("d_in", dg.getD_in());
            row.put("d_qf", dg.getD_qf());
            row.put("d_tf",dg.getD_tf());
            row.put("d_out",dg.getD_out());
            row.put("d_bigo",dg.getD_bigo());

            rtnList.add(row);
        }

        rtnMap.put("last_page", 1); 
        rtnMap.put("data", rtnList);

        return rtnMap;
    }
    
    
    @RequestMapping(value = "/productionManagement/droppedGoods/updateDroppedGoods", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateDroppedGoods(@RequestBody Map<String, Object> param) {
        Map<String, Object> result = new HashMap<>();
        try {
            productManageService.updateDroppedGoods(param); 
            result.put("result", "success");
        } catch (Exception e) {
            result.put("result", "fail");
            result.put("message", e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
    
    
    
    
  //생산모니터링현황 로드
    @RequestMapping(value= "/productionManagement/integrationProduction", method = RequestMethod.GET)
    public String integrationProduction(Model model) {
        return "/productionManagement/integrationProduction.jsp";  
    }
    
    
    
  //생산모니터링현황 로드
    @RequestMapping(value= "/productionManagement/lotReport", method = RequestMethod.GET)
    public String lotReport(Model model) {
        return "/productionManagement/lotReport.jsp";  
    } 
    
    //lot보고서 조회
    @RequestMapping(value = "/productionManagement/lotReport/getLotList", method = RequestMethod.POST)
    @ResponseBody
    public List<ProductManage> getLotList(ProductManage productManage) {
    	System.out.println("productManage.getFac_no(): " + productManage.getFac_no());
    	String date = productManage.getLotno_date().replace("-", "");
    	productManage.setLotno_date(date);
        return monitoringService.getLotList(productManage);
    }
    
    //lotReort 생성(자스퍼리포트)
    @RequestMapping(value = "/productionManagement/lot_report/lotPrint", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Resource> lotPrint(@RequestBody ProductManage productManage,
                                             HttpServletRequest request) {

        System.out.println("===== lotPrint 진입 =====");

        if (productManage.getLot_no() == null) {
            System.out.println("▶ reportWorkJisi == null");
            return ResponseEntity.badRequest().body(null);
        }

        System.out.println("▶ 요청 LOT = " + productManage.getLot_no());

        if (productManage.getLot_no() == null) {
            System.out.println("▶ w_ci_lot == null");
            return ResponseEntity.badRequest().body(null);
        }

        String lotno = productManage.getLot_no();
        String pdfFileName = lotno + ".pdf";
        // "D:/제일_양식/lot보고서/" 로 추정됩니다.
        String pdfPath = "D:/미보기아파일/lot보고서/" + pdfFileName;

        try {
            // 1) 데이터 조회
            List<ProductManage> lotInfoList = productManageService.getLotListReport(productManage);

            System.out.println("▶ lotInfoList size = " + (lotInfoList == null ? "null" : lotInfoList.size()));

            if (lotInfoList != null && !lotInfoList.isEmpty()) {
                for (ProductManage v : lotInfoList) {
                    System.out.println("v.getRegtime()" + v.getRegtime());
                }
            } else {
                System.out.println("▶ lotInfoList 비어있음");
            }

            Map<String, Object> reportMap = new HashMap<>();
            reportMap.put("lotno", lotno);

            List<JasperPrint> jasperPrints = new ArrayList<>();

            // Report 1
            if (lotInfoList != null && !lotInfoList.isEmpty()) {
                String reportPath1 = request.getServletContext()
                        .getRealPath("/WEB-INF/resources/reports/lotReport.jrxml");

                System.out.println("▶ reportPath1 = " + reportPath1);

                JasperReport report1 = JasperCompileManager.compileReport(reportPath1);
                JasperPrint print1 = JasperFillManager.fillReport(
                        report1,
                        reportMap,
                        new JRBeanCollectionDataSource(lotInfoList)
                );

                jasperPrints.add(print1);
            }

            System.out.println("▶ jasperPrints size = " + jasperPrints.size());

            if (jasperPrints.isEmpty()) {
                System.out.println("▶ JasperPrint 없음 -> 400 반환");
                return ResponseEntity.badRequest().body(null);
            }

            // PDF 생성
            JRPdfExporter exporter = new JRPdfExporter();
            exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrints));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfPath));
            exporter.exportReport();

            File file = new File(pdfPath);
            System.out.println("▶ PDF 생성 완료 : " + file.exists());

            InputStreamResource resource = new InputStreamResource(new FileInputStream(file));

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + pdfFileName + "\"")
                    .contentLength(file.length())
                    .contentType(MediaType.parseMediaType("application/pdf"))
                    .body(resource);


        } catch (Exception e) {
            System.out.println("▶ 예외 발생");
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
    
    //종합생산현황 페이지 lot 정보 조회
    @RequestMapping(value = "/productionManagement/integrationLotList", method = RequestMethod.POST)
    @ResponseBody
    public List<ProductManage> integrationLotList(ProductManage productManage) {
        return productManageService.integrationLotList(productManage);
    }

    //종합생산현황 페이지 온도 조회
    //lot 정보 조회
    @RequestMapping(value = "/productionManagement/integrationGetTempList", method = RequestMethod.POST)
    @ResponseBody
    public Monitoring getTempList(Monitoring monitoring) {
        return productManageService.integrationGetTemp(monitoring);
    }
}
