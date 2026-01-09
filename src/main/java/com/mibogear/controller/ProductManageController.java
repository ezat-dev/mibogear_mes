package com.mibogear.controller;

import java.io.File;
import java.io.FileInputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

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
			System.out.println("▶ 로트번호 == null");
			return ResponseEntity.badRequest().body(null);
		}

		String lotno = productManage.getLot_no();
		String pdfFileName = lotno + ".pdf";
		String pdfPath = "D:/미보기아파일/lot보고서/" + pdfFileName;

		//시작, 종료시간
		String startTime = productManage.getRegtime();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");

		LocalDateTime dateTime = LocalDateTime.parse(startTime, formatter);

		LocalDateTime plusTwoHours = dateTime.plusHours(2);

		String endTime = plusTwoHours.format(formatter);
		System.out.println("차트 시작시간: " + startTime);
		System.out.println("차트 종료시간" + endTime);

		Monitoring monitoring = new Monitoring();
		monitoring.setStartDate(startTime);
		monitoring.setEndDate(endTime);
		String fac_no = "";	//lot 설비
		try {
			// 1) 데이터 조회
			List<ProductManage> lotInfoList = productManageService.getLotListReport(productManage);
			fac_no = lotInfoList.get(0).getFac_no();
			System.out.println("lot 설비명: " + fac_no);
			List<Monitoring> tempList = monitoringService.getTempList(monitoring);

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

			// Report 1 - lot보고서
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

			//Report 2 - 차트

			//필요한 데이터 말고 null처리
				for (Monitoring m : tempList) {
					if ("bcf1".equalsIgnoreCase(fac_no)) {
						// bcf1만 남기고 나머지는 null 처리
						m.setBcf2_chim(null); m.setBcf2_oil(null); m.setBcf2_cp(null);
						m.setBcf3_chim(null); m.setBcf3_oil(null); m.setBcf3_cp(null); m.setBcf3_tempering(null);
						m.setBcf4_chim(null); m.setBcf4_oil(null); m.setBcf4_cp(null);
					} 
					else if ("bcf2".equalsIgnoreCase(fac_no)) {
						// bcf2만 남기고 나머지는 null 처리
						m.setBcf1_chim(null); m.setBcf1_oil(null); m.setBcf1_cp(null); m.setBcf1_tempering(null);
						m.setBcf3_chim(null); m.setBcf3_oil(null); m.setBcf3_cp(null); m.setBcf3_tempering(null);
						m.setBcf4_chim(null); m.setBcf4_oil(null); m.setBcf4_cp(null);
					}
					else if ("bcf3".equalsIgnoreCase(fac_no)) {
						// bcf3만 남기고 나머지는 null 처리
						m.setBcf1_chim(null); m.setBcf1_oil(null); m.setBcf1_cp(null); m.setBcf1_tempering(null);
						m.setBcf2_chim(null); m.setBcf2_oil(null); m.setBcf2_cp(null);
						m.setBcf4_chim(null); m.setBcf4_oil(null); m.setBcf4_cp(null);
					}
					else if ("bcf4".equalsIgnoreCase(fac_no)) {
						// bcf4만 남기고 나머지는 null 처리
						m.setBcf1_chim(null); m.setBcf1_oil(null); m.setBcf1_cp(null); m.setBcf1_tempering(null);
						m.setBcf2_chim(null); m.setBcf2_oil(null); m.setBcf2_cp(null);
						m.setBcf3_chim(null); m.setBcf3_oil(null); m.setBcf3_cp(null); m.setBcf3_tempering(null);
					}
				}
				
				for(Monitoring v: tempList) {
					v.setFac_no(fac_no);
				}

				String reportPath2 = request.getServletContext()
						.getRealPath("/WEB-INF/resources/reports/lotReportChart.jrxml");

				System.out.println("▶ reportPath2 = " + reportPath2);

				JasperReport report2 = JasperCompileManager.compileReport(reportPath2);
				
				List<Monitoring> finalTempList = (tempList != null) ? tempList : new ArrayList<>();
				
				JasperPrint print2 = JasperFillManager.fillReport(
						report2,
						reportMap,
						new JRBeanCollectionDataSource(finalTempList)
						);

				jasperPrints.add(print2);

			System.out.println("▶ jasperPrints size = " + jasperPrints.size());

			if (jasperPrints.isEmpty()) {
				System.out.println("▶ JasperPrint 없음 -> 400 반환");
				return ResponseEntity.badRequest().body(null);
			}

			// PDF 생성
			JRPdfExporter exporter = new JRPdfExporter();
			exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrints));
			exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfPath));

			//파일 2개 합치기
			SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
			configuration.setCreatingBatchModeBookmarks(true);
			exporter.setConfiguration(configuration);

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
	@RequestMapping(value = "/productionManagement/integrationGetTempList", method = RequestMethod.POST)
	@ResponseBody
	public Monitoring getTempList(Monitoring monitoring) {
		return productManageService.integrationGetTemp(monitoring);
	}

	//작업일보 페이지 이동
	@RequestMapping(value= "/productionManagement/workDailyReport", method = RequestMethod.GET)
	public String workDailyReport(Model model) {
		return "/productionManagement/workDailyReport.jsp";  
	}

	//작업일보 조회
	@RequestMapping(value = "/productionManagement/workDailyList", method = RequestMethod.POST)
	@ResponseBody
	public List<ProductManage> workDailyList(ProductManage productManage) {
		return productManageService.workDailyList(productManage);
	}

	//작업일보 리포트 생성(자스퍼리포트)
	@RequestMapping(value = "/productionManagement/workDailyList/report", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Resource> workDailyListReport(@RequestBody ProductManage productManage,
			HttpServletRequest request) {

		System.out.println("===== workDailyListReport 진입 =====");

		if (productManage.getRegtime() == null) {
			System.out.println("▶ regtime == null");
			return ResponseEntity.badRequest().body(null);
		}

		System.out.println("▶ 요청 LOT = " + productManage.getLot_no());

		String reportDate = productManage.getRegtime();
		String pdfFileName = reportDate + ".pdf";
		String pdfPath = "D:/미보기아파일/작업일보 보고서/" + pdfFileName;

		try {
			// 1) 데이터 조회
			List<ProductManage> workDailyList = productManageService.workDailyListReport(productManage);

			for(int i=0; i<workDailyList.size(); i++) {
				ProductManage item = workDailyList.get(i);
				item.setNo(String.valueOf(i + 1));
				item.setRegtime(item.getRegtime().substring(11, 19));
			}

			System.out.println("▶ lotInfoList size = " + (workDailyList == null ? "null" : workDailyList.size()));

			if (workDailyList != null && !workDailyList.isEmpty()) {
				for (ProductManage v : workDailyList) {
					System.out.println("v.getRegtime()" + v.getRegtime());
				}
			} else {
				System.out.println("▶ lotInfoList 비어있음");
			}

			Map<String, Object> reportMap = new HashMap<>();
			String lotno = productManage.getLotno();
			reportMap.put("lotno", lotno);

			List<JasperPrint> jasperPrints = new ArrayList<>();

			// Report 1
			if (workDailyList != null && !workDailyList.isEmpty()) {
				String reportPath1 = request.getServletContext()
						.getRealPath("/WEB-INF/resources/reports/workDailyReport.jrxml");

				System.out.println("▶ reportPath1 = " + reportPath1);

				JasperReport report1 = JasperCompileManager.compileReport(reportPath1);
				JasperPrint print1 = JasperFillManager.fillReport(
						report1,
						reportMap,
						new JRBeanCollectionDataSource(workDailyList)
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
}
