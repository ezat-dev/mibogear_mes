package com.mibogear.controller;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mibogear.domain.ProdData;
import com.mibogear.service.ProdDataService;

@Controller
public class ProdDataController {

    @Autowired
    private ProdDataService prodDataService;

    private static final String PDF_ROOT = "C:/mibogear/workorder/";

    // ── 리스트 조회
    @RequestMapping(value = "/mibogear/prodData/list", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getProdDataList(
            @RequestParam String startDate,
            @RequestParam String endDate) {
        Map<String, Object> rtnMap = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate",   endDate);
        rtnMap.put("status", "success");
        rtnMap.put("data",   prodDataService.getProdDataList(params));
        return rtnMap;
    }

    // ── 상세 조회
    @RequestMapping(value = "/mibogear/prodData/detail", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getProdDataDetail(@RequestParam int pd_code) {
        Map<String, Object> rtnMap = new HashMap<>();
        rtnMap.put("status", "success");
        rtnMap.put("data",   prodDataService.getProdDataDetail(pd_code));
        return rtnMap;
    }

    // ── 저장 + PDF 생성 (로트보고서 방식과 동일)
    @RequestMapping(value = "/mibogear/prodData/save", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> saveProdData(
            @RequestBody ProdData prodData,
            @RequestParam String mode,
            HttpServletRequest request) {

        Map<String, Object> result = new HashMap<>();
        try {
            // 1) DB 저장 (LOT번호 채번 포함)
            Map<String, Object> saved = prodDataService.saveProdData(prodData, mode);
            String lotNo  = (String) saved.get("lot_no");
            int    pdCode = (int)    saved.get("pd_code");

            // 2) PDF 생성
            String reportPath = request.getServletContext()
                .getRealPath("/WEB-INF/resources/reports/workOrder.jrxml");

            JasperReport jasperReport = JasperCompileManager.compileReport(reportPath);

            Map<String, Object> params = buildReportParams(prodData, lotNo);

            JasperPrint jasperPrint = JasperFillManager.fillReport(
            	    jasperReport, params, new JRBeanCollectionDataSource(new ArrayList<>()));

            // 3) PDF 파일 저장
            String pdfFileName = lotNo + ".pdf";
            String pdfPath     = PDF_ROOT + pdfFileName;

            File dir = new File(PDF_ROOT);
            if (!dir.exists()) dir.mkdirs();

            JRPdfExporter exporter = new JRPdfExporter();
            exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
            exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfPath));
            exporter.exportReport();

            System.out.println("▶ PDF 생성 완료: " + pdfPath);

            // 4) pdf_path DB 업데이트
            prodData.setPdf_path(pdfPath);
            prodData.setPd_code(pdCode);
            prodDataService.updatePdfPath(prodData);

            result.put("status",  "success");
            result.put("pd_code", pdCode);
            result.put("lot_no",  lotNo);

        } catch (Exception e) {
            result.put("status",  "error");
            result.put("message", e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    // ── PDF 출력 (브라우저에서 바로 보기)
    @RequestMapping(value = "/mibogear/prodData/print", method = RequestMethod.GET)
    public void printWorkOrder(
            @RequestParam int pd_code,
            HttpServletResponse response) throws Exception {

        ProdData data = prodDataService.getProdDataDetail(pd_code);

        if (data == null || data.getPdf_path() == null) {
            response.sendError(404, "PDF 없음");
            return;
        }

        File pdfFile = new File(data.getPdf_path());
        if (!pdfFile.exists()) {
            response.sendError(404, "파일 없음");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
            "inline; filename=\"workorder_" + data.getLot_no() + ".pdf\"");
        response.setContentLength((int) pdfFile.length());

        try (FileInputStream fis = new FileInputStream(pdfFile);
             OutputStream os = response.getOutputStream()) {
            byte[] buf = new byte[4096];
            int len;
            while ((len = fis.read(buf)) != -1) os.write(buf, 0, len);
        }
    }

    // ── 삭제
    @RequestMapping(value = "/mibogear/prodData/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteProdData(@RequestParam int pd_code) {
        Map<String, Object> result = new HashMap<>();
        try {
            prodDataService.deleteProdData(pd_code);
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status",  "error");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ── 최초 1회 .jasper 파일 생성용 (개발 시 한 번만 호출)
    @RequestMapping(value = "/mibogear/prodData/compileJasper", method = RequestMethod.GET)
    @ResponseBody
    public String compileJasper(HttpServletRequest request) {
        try {
            String jrxmlPath  = request.getServletContext()
                .getRealPath("/WEB-INF/resources/reports/workOrder.jrxml");
            String jasperPath = request.getServletContext()
                .getRealPath("/WEB-INF/resources/reports/workOrder.jasper");
            JasperCompileManager.compileReportToFile(jrxmlPath, jasperPath);
            return "컴파일 완료: " + jasperPath;
        } catch (Exception e) {
            return "실패: " + e.getMessage();
        }
    }

    /* =====================================================
       리포트 파라미터 구성
    ===================================================== */
    private Map<String, Object> buildReportParams(ProdData d, String lotNo) throws Exception {
        Map<String, Object> p = new HashMap<>();
        p.put("lot_no",        lotNo);
        p.put("reg_date",      nvl(d.getReg_date()));
        p.put("reg_user",      nvl(d.getReg_user()));
        p.put("BARCODE_IMAGE", createBarcodeImage(lotNo));

        // main
        p.put("main_auto_pattern_number", nvl(d.getMain_auto_pattern_number()));
        p.put("main_yn",                  nvl(d.getMain_yn()));
        p.put("main_bcf_pattern_number",  nvl(d.getMain_bcf_pattern_number()));
        p.put("main_tf_pattern_number",   nvl(d.getMain_tf_pattern_number()));
        p.put("main_bcf_hogi",            nvl(d.getMain_bcf_hogi()));
        p.put("main_tf_hogi",             nvl(d.getMain_tf_hogi()));
        p.put("main_spare_1", nvl(d.getMain_spare_1())); p.put("main_spare_2", nvl(d.getMain_spare_2()));
        p.put("main_spare_3", nvl(d.getMain_spare_3())); p.put("main_spare_4", nvl(d.getMain_spare_4()));
        p.put("main_bigo_1",  nvl(d.getMain_bigo_1()));  p.put("main_bigo_2",  nvl(d.getMain_bigo_2()));
        p.put("main_bigo_3",  nvl(d.getMain_bigo_3()));  p.put("main_bigo_4",  nvl(d.getMain_bigo_4()));
        p.put("main_bigo_5",  nvl(d.getMain_bigo_5()));

        // upper
        p.put("upper_auto_pattern_number", nvl(d.getUpper_auto_pattern_number()));
        p.put("upper_yn",                  nvl(d.getUpper_yn()));
        p.put("upper_bcf_pattern_number",  nvl(d.getUpper_bcf_pattern_number()));
        p.put("upper_tf_pattern_number",   nvl(d.getUpper_tf_pattern_number()));
        p.put("upper_bcf_hogi",            nvl(d.getUpper_bcf_hogi()));
        p.put("upper_tf_hogi",             nvl(d.getUpper_tf_hogi()));
        p.put("upper_spare_1", nvl(d.getUpper_spare_1())); p.put("upper_spare_2", nvl(d.getUpper_spare_2()));
        p.put("upper_spare_3", nvl(d.getUpper_spare_3())); p.put("upper_spare_4", nvl(d.getUpper_spare_4()));
        p.put("upper_bigo_1",  nvl(d.getUpper_bigo_1()));  p.put("upper_bigo_2",  nvl(d.getUpper_bigo_2()));
        p.put("upper_bigo_3",  nvl(d.getUpper_bigo_3()));  p.put("upper_bigo_4",  nvl(d.getUpper_bigo_4()));
        p.put("upper_bigo_5",  nvl(d.getUpper_bigo_5()));

        // lower
        p.put("lower_auto_pattern_number", nvl(d.getLower_auto_pattern_number()));
        p.put("lower_yn",                  nvl(d.getLower_yn()));
        p.put("lower_bcf_pattern_number",  nvl(d.getLower_bcf_pattern_number()));
        p.put("lower_tf_pattern_number",   nvl(d.getLower_tf_pattern_number()));
        p.put("lower_bcf_hogi",            nvl(d.getLower_bcf_hogi()));
        p.put("lower_tf_hogi",             nvl(d.getLower_tf_hogi()));
        p.put("lower_spare_1", nvl(d.getLower_spare_1())); p.put("lower_spare_2", nvl(d.getLower_spare_2()));
        p.put("lower_spare_3", nvl(d.getLower_spare_3())); p.put("lower_spare_4", nvl(d.getLower_spare_4()));
        p.put("lower_bigo_1",  nvl(d.getLower_bigo_1()));  p.put("lower_bigo_2",  nvl(d.getLower_bigo_2()));
        p.put("lower_bigo_3",  nvl(d.getLower_bigo_3()));  p.put("lower_bigo_4",  nvl(d.getLower_bigo_4()));
        p.put("lower_bigo_5",  nvl(d.getLower_bigo_5()));

        // belt
        p.put("belt_auto_pattern_number", nvl(d.getBelt_auto_pattern_number()));
        p.put("belt_yn",                  nvl(d.getBelt_yn()));
        p.put("belt_bcf_pattern_number",  nvl(d.getBelt_bcf_pattern_number()));
        p.put("belt_tf_pattern_number",   nvl(d.getBelt_tf_pattern_number()));
        p.put("belt_bcf_hogi",            nvl(d.getBelt_bcf_hogi()));
        p.put("belt_tf_hogi",             nvl(d.getBelt_tf_hogi()));
        p.put("belt_spare_1", nvl(d.getBelt_spare_1())); p.put("belt_spare_2", nvl(d.getBelt_spare_2()));
        p.put("belt_spare_3", nvl(d.getBelt_spare_3())); p.put("belt_spare_4", nvl(d.getBelt_spare_4()));
        p.put("belt_bigo_1",  nvl(d.getBelt_bigo_1()));  p.put("belt_bigo_2",  nvl(d.getBelt_bigo_2()));
        p.put("belt_bigo_3",  nvl(d.getBelt_bigo_3()));  p.put("belt_bigo_4",  nvl(d.getBelt_bigo_4()));
        p.put("belt_bigo_5",  nvl(d.getBelt_bigo_5()));

        return p;
    }

    // 바코드 이미지 생성
    private BufferedImage createBarcodeImage(String data) throws Exception {
        net.sourceforge.barbecue.Barcode bc =
            net.sourceforge.barbecue.BarcodeFactory.createCode128(data);
        bc.setBarHeight(50);
        bc.setBarWidth(2);
        bc.setDrawingText(false);

        int w = bc.getPreferredSize().width;
        int h = bc.getPreferredSize().height;
        BufferedImage img = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2 = img.createGraphics();
        g2.setColor(Color.WHITE);
        g2.fillRect(0, 0, w, h);
        bc.draw(g2, 0, 0);
        g2.dispose();
        return img;
    }

    private String nvl(Object val) {
        return val == null ? "" : val.toString();
    }
}