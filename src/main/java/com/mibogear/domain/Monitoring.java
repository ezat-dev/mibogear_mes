package com.mibogear.domain;

public class Monitoring {
	
	
	private String hogi;
    private String cutum;
    private String pum;
    private String lot;
    private String heat;
    private String bon;
    private String gangon;
    private String cool;
    private String gonglo;
    private String gong;
    private String gb;
    
    private String startDate;
    private String endDate;
    private String tdatetime;
    
    private Integer bcf1_cf_pv;
    private Integer bcf1_cf_sv;
    private Integer bcf1_oil_pv;
    private Integer bcf1_oil_sv;
    private Float bcf1_cp_pv;
    private Float bcf1_cp_sv;
    private Integer bcf2_cf_pv;
    private Integer bcf2_cf_sv;
    private Integer bcf2_oil_pv;
    private Integer bcf2_oil_sv;
    private Float bcf2_cp_pv;
    private Float bcf2_cp_sv;
    private Integer bcf3_cf_pv;
    private Integer bcf3_cf_sv;
    private Integer bcf3_oil_pv;
    private Integer bcf3_oil_sv;
    private Float bcf3_cp_pv;
    private Float bcf3_cp_sv;
    private Integer bcf4_cf_pv;
    private Integer bcf4_cf_sv;
    private Integer bcf4_oil_pv;
    private Integer bcf4_oil_sv;
    private Float bcf4_cp_pv;
    private Float bcf4_cp_sv;
    private Integer bcf5_cf_pv;
    private Integer bcf5_oil_pv;
    private Float bcf5_cp_pv;
    private Integer tf1_zone1;
    private Integer tf1_zone2;
    private Integer tf1_zone3;
    
    //알람
    private String alarm_address;
    private String  comment;
    private String occur_time;
    private String clear_time;
    private String id;
    private String alarm_count;
    
    //트렌드
    private String date;
    private String bcf1_chim;
    private String bcf1_oil;
    private String bcf1_cp;
    private String bcf1_tempering;
    private String bcf2_chim;
    private String bcf2_oil;
    private String bcf2_cp;
    private String bcf3_chim;
    private String bcf3_oil;
    private String bcf3_cp;
    private String bcf3_tempering;
    private String bcf4_chim;
    private String bcf4_oil;
    private String bcf4_cp;
    private String memo;
    private String writer;
    private String note;
    private String user_code;
    private String bcf1_chim_setting;
    private String bcf1_oil_setting;
    private String bcf1_cp_setting;
    private String bcf1_tempering_setting;
    private String bcf2_chim_setting;
    private String bcf2_oil_setting;
    private String bcf2_cp_setting;
    private String bcf3_chim_setting;
    private String bcf3_oil_setting;
    private String bcf3_cp_setting;
    private String bcf3_tempering_setting;
    private String bcf4_chim_setting;
    private String bcf4_oil_setting;
    private String bcf4_cp_setting;
    
    //알람현황
    private String alarm_hogi;
    private String addr;
    private String value;
    private String r_num;
    private String idx;
    private String machine_name;
    
    
	public String getBcf1_chim_setting() {
		return bcf1_chim_setting;
	}
	public void setBcf1_chim_setting(String bcf1_chim_setting) {
		this.bcf1_chim_setting = bcf1_chim_setting;
	}
	public String getBcf1_oil_setting() {
		return bcf1_oil_setting;
	}
	public void setBcf1_oil_setting(String bcf1_oil_setting) {
		this.bcf1_oil_setting = bcf1_oil_setting;
	}
	public String getBcf1_cp_setting() {
		return bcf1_cp_setting;
	}
	public void setBcf1_cp_setting(String bcf1_cp_setting) {
		this.bcf1_cp_setting = bcf1_cp_setting;
	}
	public String getBcf1_tempering_setting() {
		return bcf1_tempering_setting;
	}
	public void setBcf1_tempering_setting(String bcf1_tempering_setting) {
		this.bcf1_tempering_setting = bcf1_tempering_setting;
	}
	public String getBcf2_chim_setting() {
		return bcf2_chim_setting;
	}
	public void setBcf2_chim_setting(String bcf2_chim_setting) {
		this.bcf2_chim_setting = bcf2_chim_setting;
	}
	public String getBcf2_oil_setting() {
		return bcf2_oil_setting;
	}
	public void setBcf2_oil_setting(String bcf2_oil_setting) {
		this.bcf2_oil_setting = bcf2_oil_setting;
	}
	public String getBcf2_cp_setting() {
		return bcf2_cp_setting;
	}
	public void setBcf2_cp_setting(String bcf2_cp_setting) {
		this.bcf2_cp_setting = bcf2_cp_setting;
	}
	public String getBcf3_chim_setting() {
		return bcf3_chim_setting;
	}
	public void setBcf3_chim_setting(String bcf3_chim_setting) {
		this.bcf3_chim_setting = bcf3_chim_setting;
	}
	public String getBcf3_oil_setting() {
		return bcf3_oil_setting;
	}
	public void setBcf3_oil_setting(String bcf3_oil_setting) {
		this.bcf3_oil_setting = bcf3_oil_setting;
	}
	public String getBcf3_cp_setting() {
		return bcf3_cp_setting;
	}
	public void setBcf3_cp_setting(String bcf3_cp_setting) {
		this.bcf3_cp_setting = bcf3_cp_setting;
	}
	public String getBcf3_tempering_setting() {
		return bcf3_tempering_setting;
	}
	public void setBcf3_tempering_setting(String bcf3_tempering_setting) {
		this.bcf3_tempering_setting = bcf3_tempering_setting;
	}
	public String getBcf4_chim_setting() {
		return bcf4_chim_setting;
	}
	public void setBcf4_chim_setting(String bcf4_chim_setting) {
		this.bcf4_chim_setting = bcf4_chim_setting;
	}
	public String getBcf4_oil_setting() {
		return bcf4_oil_setting;
	}
	public void setBcf4_oil_setting(String bcf4_oil_setting) {
		this.bcf4_oil_setting = bcf4_oil_setting;
	}
	public String getBcf4_cp_setting() {
		return bcf4_cp_setting;
	}
	public void setBcf4_cp_setting(String bcf4_cp_setting) {
		this.bcf4_cp_setting = bcf4_cp_setting;
	}
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getMachine_name() {
		return machine_name;
	}
	public void setMachine_name(String machine_name) {
		this.machine_name = machine_name;
	}
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getAlarm_hogi() {
		return alarm_hogi;
	}
	public void setAlarm_hogi(String alarm_hogi) {
		this.alarm_hogi = alarm_hogi;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getR_num() {
		return r_num;
	}
	public void setR_num(String r_num) {
		this.r_num = r_num;
	}
	public String getAlarm_count() {
		return alarm_count;
	}
	public void setAlarm_count(String alarm_count) {
		this.alarm_count = alarm_count;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getBcf1_chim() {
		return bcf1_chim;
	}
	public void setBcf1_chim(String bcf1_chim) {
		this.bcf1_chim = bcf1_chim;
	}
	public String getBcf1_oil() {
		return bcf1_oil;
	}
	public void setBcf1_oil(String bcf1_oil) {
		this.bcf1_oil = bcf1_oil;
	}
	public String getBcf1_cp() {
		return bcf1_cp;
	}
	public void setBcf1_cp(String bcf1_cp) {
		this.bcf1_cp = bcf1_cp;
	}
	public String getBcf1_tempering() {
		return bcf1_tempering;
	}
	public void setBcf1_tempering(String bcf1_tempering) {
		this.bcf1_tempering = bcf1_tempering;
	}
	public String getBcf2_chim() {
		return bcf2_chim;
	}
	public void setBcf2_chim(String bcf2_chim) {
		this.bcf2_chim = bcf2_chim;
	}
	public String getBcf2_oil() {
		return bcf2_oil;
	}
	public void setBcf2_oil(String bcf2_oil) {
		this.bcf2_oil = bcf2_oil;
	}
	public String getBcf2_cp() {
		return bcf2_cp;
	}
	public void setBcf2_cp(String bcf2_cp) {
		this.bcf2_cp = bcf2_cp;
	}
	public String getBcf3_chim() {
		return bcf3_chim;
	}
	public void setBcf3_chim(String bcf3_chim) {
		this.bcf3_chim = bcf3_chim;
	}
	public String getBcf3_oil() {
		return bcf3_oil;
	}
	public void setBcf3_oil(String bcf3_oil) {
		this.bcf3_oil = bcf3_oil;
	}
	public String getBcf3_cp() {
		return bcf3_cp;
	}
	public void setBcf3_cp(String bcf3_cp) {
		this.bcf3_cp = bcf3_cp;
	}
	public String getBcf3_tempering() {
		return bcf3_tempering;
	}
	public void setBcf3_tempering(String bcf3_tempering) {
		this.bcf3_tempering = bcf3_tempering;
	}
	public String getBcf4_chim() {
		return bcf4_chim;
	}
	public void setBcf4_chim(String bcf4_chim) {
		this.bcf4_chim = bcf4_chim;
	}
	public String getBcf4_oil() {
		return bcf4_oil;
	}
	public void setBcf4_oil(String bcf4_oil) {
		this.bcf4_oil = bcf4_oil;
	}
	public String getBcf4_cp() {
		return bcf4_cp;
	}
	public void setBcf4_cp(String bcf4_cp) {
		this.bcf4_cp = bcf4_cp;
	}
	public String getOccur_time() {
		return occur_time;
	}
	public void setOccur_time(String occur_time) {
		this.occur_time = occur_time;
	}
	public String getClear_time() {
		return clear_time;
	}
	public void setClear_time(String clear_time) {
		this.clear_time = clear_time;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAlarm_address() {
		return alarm_address;
	}
	public void setAlarm_address(String alarm_address) {
		this.alarm_address = alarm_address;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getHogi() {
		return hogi;
	}
	public void setHogi(String hogi) {
		this.hogi = hogi;
	}
	public String getCutum() {
		return cutum;
	}
	public void setCutum(String cutum) {
		this.cutum = cutum;
	}
	public String getPum() {
		return pum;
	}
	public void setPum(String pum) {
		this.pum = pum;
	}
	public String getHeat() {
		return heat;
	}
	public void setHeat(String heat) {
		this.heat = heat;
	}
	public String getLot() {
		return lot;
	}
	public void setLot(String lot) {
		this.lot = lot;
	}
	public String getBon() {
		return bon;
	}
	public void setBon(String bon) {
		this.bon = bon;
	}
	public String getGangon() {
		return gangon;
	}
	public void setGangon(String gangon) {
		this.gangon = gangon;
	}
	public String getCool() {
		return cool;
	}
	public void setCool(String cool) {
		this.cool = cool;
	}
	public String getGonglo() {
		return gonglo;
	}
	public void setGonglo(String gonglo) {
		this.gonglo = gonglo;
	}
	public String getGong() {
		return gong;
	}
	public void setGong(String gong) {
		this.gong = gong;
	}
	public String getGb() {
		return gb;
	}
	public void setGb(String gb) {
		this.gb = gb;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getTdatetime() {
		return tdatetime;
	}
	public void setTdatetime(String tdatetime) {
		this.tdatetime = tdatetime;
	}
	public Integer getBcf1_cf_pv() {
		return bcf1_cf_pv;
	}
	public void setBcf1_cf_pv(Integer bcf1_cf_pv) {
		this.bcf1_cf_pv = bcf1_cf_pv;
	}
	public Integer getBcf1_cf_sv() {
		return bcf1_cf_sv;
	}
	public void setBcf1_cf_sv(Integer bcf1_cf_sv) {
		this.bcf1_cf_sv = bcf1_cf_sv;
	}
	public Integer getBcf1_oil_pv() {
		return bcf1_oil_pv;
	}
	public void setBcf1_oil_pv(Integer bcf1_oil_pv) {
		this.bcf1_oil_pv = bcf1_oil_pv;
	}
	public Integer getBcf1_oil_sv() {
		return bcf1_oil_sv;
	}
	public void setBcf1_oil_sv(Integer bcf1_oil_sv) {
		this.bcf1_oil_sv = bcf1_oil_sv;
	}
	public Float getBcf1_cp_pv() {
		return bcf1_cp_pv;
	}
	public void setBcf1_cp_pv(Float bcf1_cp_pv) {
		this.bcf1_cp_pv = bcf1_cp_pv;
	}
	public Float getBcf1_cp_sv() {
		return bcf1_cp_sv;
	}
	public void setBcf1_cp_sv(Float bcf1_cp_sv) {
		this.bcf1_cp_sv = bcf1_cp_sv;
	}
	public Integer getBcf2_cf_pv() {
		return bcf2_cf_pv;
	}
	public void setBcf2_cf_pv(Integer bcf2_cf_pv) {
		this.bcf2_cf_pv = bcf2_cf_pv;
	}
	public Integer getBcf2_cf_sv() {
		return bcf2_cf_sv;
	}
	public void setBcf2_cf_sv(Integer bcf2_cf_sv) {
		this.bcf2_cf_sv = bcf2_cf_sv;
	}
	public Integer getBcf2_oil_sv() {
		return bcf2_oil_sv;
	}
	public void setBcf2_oil_sv(Integer bcf2_oil_sv) {
		this.bcf2_oil_sv = bcf2_oil_sv;
	}
	public Integer getBcf2_oil_pv() {
		return bcf2_oil_pv;
	}
	public void setBcf2_oil_pv(Integer bcf2_oil_pv) {
		this.bcf2_oil_pv = bcf2_oil_pv;
	}
	public Float getBcf2_cp_pv() {
		return bcf2_cp_pv;
	}
	public void setBcf2_cp_pv(Float bcf2_cp_pv) {
		this.bcf2_cp_pv = bcf2_cp_pv;
	}
	public Float getBcf2_cp_sv() {
		return bcf2_cp_sv;
	}
	public void setBcf2_cp_sv(Float bcf2_cp_sv) {
		this.bcf2_cp_sv = bcf2_cp_sv;
	}
	public Integer getBcf3_cf_pv() {
		return bcf3_cf_pv;
	}
	public void setBcf3_cf_pv(Integer bcf3_cf_pv) {
		this.bcf3_cf_pv = bcf3_cf_pv;
	}
	public Integer getBcf3_cf_sv() {
		return bcf3_cf_sv;
	}
	public void setBcf3_cf_sv(Integer bcf3_cf_sv) {
		this.bcf3_cf_sv = bcf3_cf_sv;
	}
	public Integer getBcf3_oil_pv() {
		return bcf3_oil_pv;
	}
	public void setBcf3_oil_pv(Integer bcf3_oil_pv) {
		this.bcf3_oil_pv = bcf3_oil_pv;
	}
	public Integer getBcf3_oil_sv() {
		return bcf3_oil_sv;
	}
	public void setBcf3_oil_sv(Integer bcf3_oil_sv) {
		this.bcf3_oil_sv = bcf3_oil_sv;
	}
	public Float getBcf3_cp_pv() {
		return bcf3_cp_pv;
	}
	public void setBcf3_cp_pv(Float bcf3_cp_pv) {
		this.bcf3_cp_pv = bcf3_cp_pv;
	}
	public Float getBcf3_cp_sv() {
		return bcf3_cp_sv;
	}
	public void setBcf3_cp_sv(Float bcf3_cp_sv) {
		this.bcf3_cp_sv = bcf3_cp_sv;
	}
	public Integer getBcf4_cf_pv() {
		return bcf4_cf_pv;
	}
	public void setBcf4_cf_pv(Integer bcf4_cf_pv) {
		this.bcf4_cf_pv = bcf4_cf_pv;
	}
	public Integer getBcf4_cf_sv() {
		return bcf4_cf_sv;
	}
	public void setBcf4_cf_sv(Integer bcf4_cf_sv) {
		this.bcf4_cf_sv = bcf4_cf_sv;
	}
	public Integer getBcf4_oil_pv() {
		return bcf4_oil_pv;
	}
	public void setBcf4_oil_pv(Integer bcf4_oil_pv) {
		this.bcf4_oil_pv = bcf4_oil_pv;
	}
	public Integer getBcf4_oil_sv() {
		return bcf4_oil_sv;
	}
	public void setBcf4_oil_sv(Integer bcf4_oil_sv) {
		this.bcf4_oil_sv = bcf4_oil_sv;
	}
	public Float getBcf4_cp_pv() {
		return bcf4_cp_pv;
	}
	public void setBcf4_cp_pv(Float bcf4_cp_pv) {
		this.bcf4_cp_pv = bcf4_cp_pv;
	}
	public Float getBcf4_cp_sv() {
		return bcf4_cp_sv;
	}
	public void setBcf4_cp_sv(Float bcf4_cp_sv) {
		this.bcf4_cp_sv = bcf4_cp_sv;
	}
	public Integer getBcf5_cf_pv() {
		return bcf5_cf_pv;
	}
	public void setBcf5_cf_pv(Integer bcf5_cf_pv) {
		this.bcf5_cf_pv = bcf5_cf_pv;
	}
	public Integer getBcf5_oil_pv() {
		return bcf5_oil_pv;
	}
	public void setBcf5_oil_pv(Integer bcf5_oil_pv) {
		this.bcf5_oil_pv = bcf5_oil_pv;
	}
	public Float getBcf5_cp_pv() {
		return bcf5_cp_pv;
	}
	public void setBcf5_cp_pv(Float bcf5_cp_pv) {
		this.bcf5_cp_pv = bcf5_cp_pv;
	}
	public Integer getTf1_zone1() {
		return tf1_zone1;
	}
	public void setTf1_zone1(Integer tf1_zone1) {
		this.tf1_zone1 = tf1_zone1;
	}
	public Integer getTf1_zone2() {
		return tf1_zone2;
	}
	public void setTf1_zone2(Integer tf1_zone2) {
		this.tf1_zone2 = tf1_zone2;
	}
	public Integer getTf1_zone3() {
		return tf1_zone3;
	}
	public void setTf1_zone3(Integer tf1_zone3) {
		this.tf1_zone3 = tf1_zone3;
	}
	
	
	
	
	
	
	
	
	

}
