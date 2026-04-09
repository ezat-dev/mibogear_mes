package com.mibogear.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mibogear.domain.PatternRequest;
import com.mibogear.domain.WorkOrder;
import com.mibogear.service.ProdDataService;

@Controller
public class ProdDataController {

    @Autowired
    private ProdDataService prodDataService;

    private static final String PDF_ROOT = "C:/mibogear/workorder/";

    // ==========================================================
    // 작업지시서 페이지
    // ==========================================================

    @RequestMapping(value = "/prodData/workOrder", method = RequestMethod.GET)
    public String workOrder(Model model) {
        return "/prodData/workOrder.jsp";
    }

    // ── 리스트 조회
    @RequestMapping(value = "/workOrder/list", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getWorkOrderList(
            @RequestParam(defaultValue = "") String sdate,
            @RequestParam(defaultValue = "") String edate,
            @RequestParam(defaultValue = "") String lot_no,
            @RequestParam(defaultValue = "") String prod_name,
            @RequestParam(defaultValue = "") String corp_name) {

        Map<String, Object> rtnMap = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("sdate",     sdate);
        params.put("edate",     edate);
        params.put("lot_no",    lot_no);
        params.put("prod_name", prod_name);
        params.put("corp_name", corp_name);
        rtnMap.put("status", "success");
        rtnMap.put("data",   prodDataService.getWorkOrderList(params));
        return rtnMap;
    }

    // ── 상세 조회
    @RequestMapping(value = "/workOrder/detail", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getWorkOrderDetail(@RequestParam int wo_code) {
        Map<String, Object> rtnMap = new HashMap<>();
        rtnMap.put("status", "success");
        rtnMap.put("data",   prodDataService.getWorkOrderDetail(wo_code));
        return rtnMap;
    }

    // ── 저장 (insert / update)
    @RequestMapping(value = "/workOrder/save", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> saveWorkOrder(
            @RequestBody WorkOrder workOrder,
            @RequestParam String mode) {

        Map<String, Object> result = new HashMap<>();
        try {
            Map<String, Object> saved = prodDataService.saveWorkOrder(workOrder, mode);
            result.put("status",  "success");
            result.put("wo_code", saved.get("wo_code"));
            result.put("lot_no",  saved.get("lot_no"));
        } catch (Exception e) {
            result.put("status",  "error");
            result.put("message", e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    // ── 삭제
    @RequestMapping(value = "/workOrder/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteWorkOrder(@RequestParam int wo_code) {
        Map<String, Object> result = new HashMap<>();
        try {
            prodDataService.deleteWorkOrder(wo_code);
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status",  "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ── 작업지시서 PDF 출력
    @RequestMapping(value = "/workOrder/print", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> printWorkOrderNew(
            @RequestParam int wo_code,
            HttpServletRequest request) {

        System.out.println("===== printWorkOrderNew 진입 =====");
        Map<String, Object> result = new HashMap<>();

        try {
            WorkOrder data = prodDataService.getWorkOrderDetail(wo_code);
            if (data == null) {
                result.put("status",  "error");
                result.put("message", "데이터 없음");
                return result;
            }

            System.out.println("▶ LOT = " + data.getLot_no());

            String lotNo       = data.getLot_no();
            String pdfFileName = lotNo + ".pdf";
            String pdfPath     = PDF_ROOT + pdfFileName;

            File dir = new File(PDF_ROOT);
            if (!dir.exists()) dir.mkdirs();

            BufferedImage barcodeImg = generateWoBarcodeImage(lotNo, 300, 60);
            Map<String, Object> params = buildJasperParams(data, barcodeImg);

            String jrxmlPath = request.getServletContext()
                    .getRealPath("/WEB-INF/resources/reports/workOrder.jrxml");
            System.out.println("▶ jrxmlPath = " + jrxmlPath);

            JasperReport jasperReport = JasperCompileManager.compileReport(jrxmlPath);
            JasperPrint  jasperPrint  = JasperFillManager.fillReport(
                    jasperReport, params,
                    new JRBeanCollectionDataSource(new ArrayList<>()));

            JRPdfExporter exporter = new JRPdfExporter();
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfPath));
            exporter.exportReport();

            System.out.println("▶ PDF 저장 완료: " + pdfPath);

            data.setPdf_path(pdfPath);
            prodDataService.updatePdfPath(data);

            result.put("status",  "success");
            result.put("lot_no",  lotNo);
            result.put("pdfPath", pdfPath);

        } catch (Exception e) {
            System.out.println("▶ 예외 발생");
            e.printStackTrace();
            result.put("status",  "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ==========================================================
    // 패턴 요청
    // ==========================================================

    // ── 패턴조회 요청 (status=1 + 입력값 UPDATE)
    @RequestMapping(value = "/workOrder/pattern/request", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> requestPattern(@RequestBody PatternRequest patternRequest) {
        Map<String, Object> result = new HashMap<>();
        try {
            // tf_hogi 자동결정: bcf_hogi 1,2 → 1 / 3,4 → 2
            if (patternRequest.getBcf_hogi() != null) {
                patternRequest.setTf_hogi(patternRequest.getBcf_hogi() <= 2 ? 1 : 2);
            }
            prodDataService.requestPattern(patternRequest);
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status",  "error");
            result.put("message", e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    // ── 폴링: status 조회 (JSP에서 2초마다 호출)
    @RequestMapping(value = "/workOrder/pattern/status", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getPatternStatus() {
        Map<String, Object> result = new HashMap<>();
        try {
            int status = prodDataService.getPatternStatus();
            result.put("status",        "success");
            result.put("patternStatus", status);
            // status=2(수신완료)이면 전체 패턴 데이터 함께 반환
            if (status == 2) {
                result.put("data", prodDataService.getPattern());
            }
        } catch (Exception e) {
            result.put("status",  "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ── 완료 신호 (status=3)
    @RequestMapping(value = "/workOrder/pattern/complete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> completePattern() {
        Map<String, Object> result = new HashMap<>();
        try {
            prodDataService.completePattern();
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status",  "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ── 초기화 (status=0)
    @RequestMapping(value = "/workOrder/pattern/reset", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> resetPatternReq() {
        Map<String, Object> result = new HashMap<>();
        try {
            prodDataService.resetPattern();
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status",  "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ==========================================================
    // 헬퍼 메서드
    // ==========================================================

    private String nvlWo(Object val) {
        return (val == null) ? "" : val.toString();
    }

    private BufferedImage generateWoBarcodeImage(String text, int width, int height) throws Exception {
        com.google.zxing.MultiFormatWriter writer = new com.google.zxing.MultiFormatWriter();
        com.google.zxing.common.BitMatrix matrix =
            writer.encode(text, com.google.zxing.BarcodeFormat.CODE_128, width, height);
        return com.google.zxing.client.j2se.MatrixToImageWriter.toBufferedImage(matrix);
    }

    private Map<String, Object> buildJasperParams(WorkOrder d, BufferedImage barcodeImg) {
        Map<String, Object> p = new HashMap<>();
        // 기본
        p.put("lot_no",        nvlWo(d.getLot_no()));
        p.put("reg_date",      nvlWo(d.getReg_date()));
        p.put("reg_user",      nvlWo(d.getReg_user()));
        p.put("BARCODE_IMAGE", barcodeImg);
        // 입고정보
        p.put("corp_name", nvlWo(d.getCorp_name()));
        p.put("prod_name", nvlWo(d.getProd_name()));
        p.put("prod_no",   nvlWo(d.getProd_no()));
        p.put("prod_gyu",  nvlWo(d.getProd_gyu()));
        p.put("prod_jai",  nvlWo(d.getProd_jai()));
        p.put("ord_su",    d.getOrd_su() != null ? d.getOrd_su().toString() : "");
        p.put("ord_lot",   nvlWo(d.getOrd_lot()));
        // 패턴 호기/번호
        p.put("bcf_hogi",     d.getBcf_hogi()     != null ? d.getBcf_hogi().toString()     : "");
        p.put("tf_hogi",      d.getTf_hogi()      != null ? d.getTf_hogi().toString()      : "");
        p.put("bcf_cycle_no", d.getBcf_cycle_no() != null ? d.getBcf_cycle_no().toString() : "");
        p.put("tf_cycle_no",  d.getTf_cycle_no()  != null ? d.getTf_cycle_no().toString()  : "");
        // BCF 시간
        p.put("bcf_time_fanup",  nvlWo(d.getBcf_time_fanup()));
        p.put("bcf_time_spare1", nvlWo(d.getBcf_time_spare1()));
        p.put("bcf_time_spare2", nvlWo(d.getBcf_time_spare2()));
        p.put("bcf_time_chim",   nvlWo(d.getBcf_time_chim()));
        p.put("bcf_time_diff",   nvlWo(d.getBcf_time_diff()));
        p.put("bcf_time_gang",   nvlWo(d.getBcf_time_gang()));
        p.put("bcf_time_spare3", nvlWo(d.getBcf_time_spare3()));
        p.put("bcf_time_que",    nvlWo(d.getBcf_time_que()));
        p.put("bcf_time_drain",  nvlWo(d.getBcf_time_drain()));
        // BCF 온도
        p.put("bcf_temp_fanup",  nvlWo(d.getBcf_temp_fanup()));
        p.put("bcf_temp_spare1", nvlWo(d.getBcf_temp_spare1()));
        p.put("bcf_temp_spare2", nvlWo(d.getBcf_temp_spare2()));
        p.put("bcf_temp_chim",   nvlWo(d.getBcf_temp_chim()));
        p.put("bcf_temp_diff",   nvlWo(d.getBcf_temp_diff()));
        p.put("bcf_temp_gang",   nvlWo(d.getBcf_temp_gang()));
        p.put("bcf_temp_spare3", nvlWo(d.getBcf_temp_spare3()));
        p.put("bcf_temp_que",    nvlWo(d.getBcf_temp_que()));
        p.put("bcf_temp_drain",  nvlWo(d.getBcf_temp_drain()));
        // BCF CP
        p.put("bcf_cp_fanup",  nvlWo(d.getBcf_cp_fanup()));
        p.put("bcf_cp_spare1", nvlWo(d.getBcf_cp_spare1()));
        p.put("bcf_cp_spare2", nvlWo(d.getBcf_cp_spare2()));
        p.put("bcf_cp_chim",   nvlWo(d.getBcf_cp_chim()));
        p.put("bcf_cp_diff",   nvlWo(d.getBcf_cp_diff()));
        p.put("bcf_cp_gang",   nvlWo(d.getBcf_cp_gang()));
        // TF 시간
        p.put("tf_time_spare1", nvlWo(d.getTf_time_spare1()));
        p.put("tf_time_spare2", nvlWo(d.getTf_time_spare2()));
        p.put("tf_time_spare3", nvlWo(d.getTf_time_spare3()));
        p.put("tf_time_spare4", nvlWo(d.getTf_time_spare4()));
        p.put("tf_time_dry",    nvlWo(d.getTf_time_dry()));
        p.put("tf_time_fanup",  nvlWo(d.getTf_time_fanup()));
        p.put("tf_time_n2",     nvlWo(d.getTf_time_n2()));
        p.put("tf_time_tem",    nvlWo(d.getTf_time_tem()));
        p.put("tf_time_cool",   nvlWo(d.getTf_time_cool()));
        // TF 온도
        p.put("tf_temp_spare1", nvlWo(d.getTf_temp_spare1()));
        p.put("tf_temp_spare2", nvlWo(d.getTf_temp_spare2()));
        p.put("tf_temp_spare3", nvlWo(d.getTf_temp_spare3()));
        p.put("tf_temp_spare4", nvlWo(d.getTf_temp_spare4()));
        p.put("tf_temp_dry",    nvlWo(d.getTf_temp_dry()));
        p.put("tf_temp_fanup",  nvlWo(d.getTf_temp_fanup()));
        p.put("tf_temp_n2",     nvlWo(d.getTf_temp_n2()));
        p.put("tf_temp_tem",    nvlWo(d.getTf_temp_tem()));
        p.put("tf_temp_cool",   nvlWo(d.getTf_temp_cool()));
        // 처리품정보
        p.put("main_auto_pattern_number", nvlWo(d.getMain_auto_pattern_number()));
        p.put("main_yn",                  nvlWo(d.getMain_yn()));
        p.put("main_bcf_pattern_number",  nvlWo(d.getMain_bcf_pattern_number()));
        p.put("main_tf_pattern_number",   nvlWo(d.getMain_tf_pattern_number()));
        p.put("main_bcf_hogi",            nvlWo(d.getMain_bcf_hogi()));
        p.put("main_tf_hogi",             nvlWo(d.getMain_tf_hogi()));
        p.put("main_spare_1",  nvlWo(d.getMain_spare_1()));
        p.put("main_spare_2",  nvlWo(d.getMain_spare_2()));
        p.put("main_spare_3",  nvlWo(d.getMain_spare_3()));
        p.put("main_spare_4",  nvlWo(d.getMain_spare_4()));
        p.put("main_bigo_1",   nvlWo(d.getMain_bigo_1()));
        p.put("main_bigo_2",   nvlWo(d.getMain_bigo_2()));
        p.put("main_bigo_3",   nvlWo(d.getMain_bigo_3()));
        p.put("main_bigo_4",   nvlWo(d.getMain_bigo_4()));
        p.put("main_bigo_5",   nvlWo(d.getMain_bigo_5()));
        return p;
    }
}