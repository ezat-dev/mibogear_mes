package com.mibogear.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mibogear.domain.Monitoring;
import com.mibogear.domain.Users;
import com.mibogear.service.MonitoringService;

@Controller
public class MonitoringController {
	@Autowired
	private MonitoringService monitoringService;
	
	@RequestMapping(value = "/monitoring/overView", method = RequestMethod.GET)
	public String overView(Users users) {

		return "/monitoring/overView.jsp";
	}	 
	
	@RequestMapping(value = "/monitoring/alarm", method = RequestMethod.GET)
	public String alarm(Users users) {

		return "/monitoring/alarm.jsp";
	}
	
	@RequestMapping(value = "/monitoring/alarmHistory", method = RequestMethod.GET)
	public String alarmHistory(Users users) {

		return "/monitoring/alarmHistory.jsp";
	}
	
	@RequestMapping(value = "/monitoring/alarmRanking", method = RequestMethod.GET)
	public String alarmRanking(Users users) {

		return "/monitoring/alarmRanking.jsp";
	}
	
	@RequestMapping(value = "/monitoring/trend", method = RequestMethod.GET)
	public String trend(Users users) {

		return "/monitoring/trend.jsp";
	}
    //알람이력 조회
    @RequestMapping(value = "/monitoring/getAlarmList", method = RequestMethod.POST)
    @ResponseBody
    public List<Monitoring> getAlarmList(Monitoring monitoring) {
        return monitoringService.getAlarmList(monitoring);
    }
    //트렌드 조회
    @RequestMapping(value = "/monitoring/getTempList", method = RequestMethod.POST)
    @ResponseBody
    public List<Monitoring> getTempList(Monitoring monitoring) {
        return monitoringService.getTempList(monitoring);
    }
    //알람랭킹 조회
    @RequestMapping(value = "/monitoring/getAlarmRankingList", method = RequestMethod.POST)
    @ResponseBody
    public List<Monitoring> getAlarmRankingList(Monitoring monitoring) {
        return monitoringService.getAlarmRankingList(monitoring);
    }
    //알람현황 조회
    @RequestMapping(value = "/monitoring/getAlarm1", method = RequestMethod.POST)
    @ResponseBody
    public List<Monitoring> getAlarm1(Monitoring monitoring) {
        return monitoringService.getAlarm1(monitoring);
    }

}
