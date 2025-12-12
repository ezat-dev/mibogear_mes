package com.mibogear.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mibogear.domain.Quality;
import com.mibogear.service.QualityService;

@Controller
public class QualityController {
	@Autowired
	private QualityService qualityService;

	//fproof 페이지 이동
    @RequestMapping(value= "/quality/fProof", method = RequestMethod.GET)
    public String fProof(Model model) {
        return "/quality/fProof.jsp"; 
    }
    //fproof 조회
    @RequestMapping(value = "/quality/dailyCheck/list", method = RequestMethod.POST)
    @ResponseBody
    public List<Quality> dailyCheckList(Quality quality) {
        return qualityService.getDailyCheckList(quality);
    }
    //fproof 업데이트
    @RequestMapping(value = "/quality/dailyCheckUpdate", method = RequestMethod.POST)
    @ResponseBody
    public boolean dailyCheckUpdate(Quality quality) {
    		return qualityService.dailyCheckUpdate(quality);
    }
    //fproof 삭제
    @RequestMapping(value = "/quality/dailyCheckDelete", method = RequestMethod.POST)
    @ResponseBody
    public boolean dailyCheckDelete(Quality quality) {
    		return qualityService.dailyCheckDelete(quality);
    }
    //fproof 추가
    @RequestMapping(value = "/quality/dailyCheckInsert", method = RequestMethod.POST)
    @ResponseBody
    public boolean dailyCheckInsert(Quality quality) {
    		return qualityService.dailyCheckInsert(quality);
    }
	//온도균일성 조사보고서 페이지 이동
    @RequestMapping(value= "/quality/tempUniformity", method = RequestMethod.GET)
    public String tempUniformity(Model model) {
        return "/quality/tempUniformity.jsp"; 
    }
    //온도균일성 조회
    @RequestMapping(value = "/quality/getTempUniformityList", method = RequestMethod.POST)
    @ResponseBody
    public List<Quality> getTempUniformityList(Quality quality) {
        return qualityService.getTempUniformityList(quality);
    }
    //온도균일성 업데이트
    @RequestMapping(value = "/quality/updateTempUniformity", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> savetusTest(@ModelAttribute Quality quality,
                                           @RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile) {
        Map<String, Object> rtnMap = new HashMap<>();

   
        if (quality.getT_month() != null && quality.getT_month().length() >= 4) {
            String year = quality.getT_month().substring(0, 4);
            quality.setT_year(year);
        }



      
        if (uploadFile != null && !uploadFile.isEmpty()) {
            try {
                String originalFilename = uploadFile.getOriginalFilename();
                String savePath = "D:/미보기아파일/온도균일성/";

                File dir = new File(savePath);
                if (!dir.exists()) dir.mkdirs();

                File dest = new File(savePath + originalFilename);
                uploadFile.transferTo(dest);

              
                quality.setT_url(originalFilename);

            } catch (IOException e) {
                e.printStackTrace();
                rtnMap.put("result", "fail");
                rtnMap.put("message", "파일 저장 실패");
                return rtnMap;
            }
        }

   
        qualityService.updateTempUniformity(quality);

        rtnMap.put("result", "success");
        return rtnMap;
    }
    
    @RequestMapping(value = "/download_tusTest", method = RequestMethod.GET)
    public void downloadExcel(@RequestParam("filename") String filename,
                              HttpServletResponse response) throws IOException {

        String baseDir = "D:/미보기아파일/온도균일성/";

       
        if (filename.contains("..") || filename.contains("/") || filename.contains("\\")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        File file = new File(baseDir + filename);
      
        if (!file.exists()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType = Files.probeContentType(file.toPath());
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());

   
        String encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");


        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFilename);

        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int len;
            while ((len = fis.read(buffer)) != -1) {
                os.write(buffer, 0, len);
            }
            os.flush();
        }
    }
}
