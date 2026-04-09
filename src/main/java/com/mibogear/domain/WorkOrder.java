package com.mibogear.domain;

public class WorkOrder {

    private int     wo_code;
    private String  lot_no;

    // 섹션① 입고정보 (nullable)
    private String  ord_code;
    private String  corp_name;
    private String  prod_name;
    private String  prod_no;
    private String  prod_gyu;
    private String  prod_jai;
    private Integer ord_su;
    private String  ord_lot;

    // 섹션② 패턴정보
    private Integer auto_pattern;
    private Integer bcf_cycle_no;
    private Integer tf_cycle_no;
    private Integer bcf_hogi;
    private Integer tf_hogi;

    // BCF 시간
    private Integer bcf_time_fanup;
    private Integer bcf_time_spare1;
    private Integer bcf_time_spare2;
    private Integer bcf_time_chim;
    private Integer bcf_time_diff;
    private Integer bcf_time_gang;
    private Integer bcf_time_spare3;
    private Integer bcf_time_que;
    private Integer bcf_time_drain;

    // BCF 온도
    private Double  bcf_temp_fanup;
    private Double  bcf_temp_spare1;
    private Double  bcf_temp_spare2;
    private Double  bcf_temp_chim;
    private Double  bcf_temp_diff;
    private Double  bcf_temp_gang;
    private Double  bcf_temp_spare3;
    private Double  bcf_temp_que;
    private Double  bcf_temp_drain;

    // BCF CP
    private Double  bcf_cp_fanup;
    private Double  bcf_cp_spare1;
    private Double  bcf_cp_spare2;
    private Double  bcf_cp_chim;
    private Double  bcf_cp_diff;
    private Double  bcf_cp_gang;

    // TF 시간
    private Integer tf_time_spare1;
    private Integer tf_time_spare2;
    private Integer tf_time_spare3;
    private Integer tf_time_spare4;
    private Integer tf_time_dry;
    private Integer tf_time_fanup;
    private Integer tf_time_n2;
    private Integer tf_time_tem;
    private Integer tf_time_cool;

    // TF 온도
    private Double  tf_temp_spare1;
    private Double  tf_temp_spare2;
    private Double  tf_temp_spare3;
    private Double  tf_temp_spare4;
    private Double  tf_temp_dry;
    private Double  tf_temp_fanup;
    private Double  tf_temp_n2;
    private Double  tf_temp_tem;
    private Double  tf_temp_cool;

    // 섹션③ 처리품정보 (main_* 만)
    private Integer main_auto_pattern_number;
    private String  main_yn;
    private Integer main_bcf_pattern_number;
    private Integer main_tf_pattern_number;
    private String  main_bcf_hogi;
    private String  main_tf_hogi;
    private String  main_spare_1, main_spare_2, main_spare_3, main_spare_4;
    private String  main_bigo_1,  main_bigo_2,  main_bigo_3,  main_bigo_4,  main_bigo_5;

    // 공통
    private String  status;
    private String  reg_date;
    private String  reg_user;
    private String  pdf_path;

    // 검색 조건용
    private String  sdate;
    private String  edate;

    // ── Getters & Setters ──

    public int getWo_code() { return wo_code; }
    public void setWo_code(int wo_code) { this.wo_code = wo_code; }

    public String getLot_no() { return lot_no; }
    public void setLot_no(String lot_no) { this.lot_no = lot_no; }

    public String getOrd_code() { return ord_code; }
    public void setOrd_code(String ord_code) { this.ord_code = ord_code; }

    public String getCorp_name() { return corp_name; }
    public void setCorp_name(String corp_name) { this.corp_name = corp_name; }

    public String getProd_name() { return prod_name; }
    public void setProd_name(String prod_name) { this.prod_name = prod_name; }

    public String getProd_no() { return prod_no; }
    public void setProd_no(String prod_no) { this.prod_no = prod_no; }

    public String getProd_gyu() { return prod_gyu; }
    public void setProd_gyu(String prod_gyu) { this.prod_gyu = prod_gyu; }

    public String getProd_jai() { return prod_jai; }
    public void setProd_jai(String prod_jai) { this.prod_jai = prod_jai; }

    public Integer getOrd_su() { return ord_su; }
    public void setOrd_su(Integer ord_su) { this.ord_su = ord_su; }

    public String getOrd_lot() { return ord_lot; }
    public void setOrd_lot(String ord_lot) { this.ord_lot = ord_lot; }

    public Integer getAuto_pattern() { return auto_pattern; }
    public void setAuto_pattern(Integer auto_pattern) { this.auto_pattern = auto_pattern; }

    public Integer getBcf_cycle_no() { return bcf_cycle_no; }
    public void setBcf_cycle_no(Integer bcf_cycle_no) { this.bcf_cycle_no = bcf_cycle_no; }

    public Integer getTf_cycle_no() { return tf_cycle_no; }
    public void setTf_cycle_no(Integer tf_cycle_no) { this.tf_cycle_no = tf_cycle_no; }

    public Integer getBcf_hogi() { return bcf_hogi; }
    public void setBcf_hogi(Integer bcf_hogi) { this.bcf_hogi = bcf_hogi; }

    public Integer getTf_hogi() { return tf_hogi; }
    public void setTf_hogi(Integer tf_hogi) { this.tf_hogi = tf_hogi; }

    public Integer getBcf_time_fanup() { return bcf_time_fanup; }
    public void setBcf_time_fanup(Integer bcf_time_fanup) { this.bcf_time_fanup = bcf_time_fanup; }

    public Integer getBcf_time_spare1() { return bcf_time_spare1; }
    public void setBcf_time_spare1(Integer bcf_time_spare1) { this.bcf_time_spare1 = bcf_time_spare1; }

    public Integer getBcf_time_spare2() { return bcf_time_spare2; }
    public void setBcf_time_spare2(Integer bcf_time_spare2) { this.bcf_time_spare2 = bcf_time_spare2; }

    public Integer getBcf_time_chim() { return bcf_time_chim; }
    public void setBcf_time_chim(Integer bcf_time_chim) { this.bcf_time_chim = bcf_time_chim; }

    public Integer getBcf_time_diff() { return bcf_time_diff; }
    public void setBcf_time_diff(Integer bcf_time_diff) { this.bcf_time_diff = bcf_time_diff; }

    public Integer getBcf_time_gang() { return bcf_time_gang; }
    public void setBcf_time_gang(Integer bcf_time_gang) { this.bcf_time_gang = bcf_time_gang; }

    public Integer getBcf_time_spare3() { return bcf_time_spare3; }
    public void setBcf_time_spare3(Integer bcf_time_spare3) { this.bcf_time_spare3 = bcf_time_spare3; }

    public Integer getBcf_time_que() { return bcf_time_que; }
    public void setBcf_time_que(Integer bcf_time_que) { this.bcf_time_que = bcf_time_que; }

    public Integer getBcf_time_drain() { return bcf_time_drain; }
    public void setBcf_time_drain(Integer bcf_time_drain) { this.bcf_time_drain = bcf_time_drain; }

    public Double getBcf_temp_fanup() { return bcf_temp_fanup; }
    public void setBcf_temp_fanup(Double bcf_temp_fanup) { this.bcf_temp_fanup = bcf_temp_fanup; }

    public Double getBcf_temp_spare1() { return bcf_temp_spare1; }
    public void setBcf_temp_spare1(Double bcf_temp_spare1) { this.bcf_temp_spare1 = bcf_temp_spare1; }

    public Double getBcf_temp_spare2() { return bcf_temp_spare2; }
    public void setBcf_temp_spare2(Double bcf_temp_spare2) { this.bcf_temp_spare2 = bcf_temp_spare2; }

    public Double getBcf_temp_chim() { return bcf_temp_chim; }
    public void setBcf_temp_chim(Double bcf_temp_chim) { this.bcf_temp_chim = bcf_temp_chim; }

    public Double getBcf_temp_diff() { return bcf_temp_diff; }
    public void setBcf_temp_diff(Double bcf_temp_diff) { this.bcf_temp_diff = bcf_temp_diff; }

    public Double getBcf_temp_gang() { return bcf_temp_gang; }
    public void setBcf_temp_gang(Double bcf_temp_gang) { this.bcf_temp_gang = bcf_temp_gang; }

    public Double getBcf_temp_spare3() { return bcf_temp_spare3; }
    public void setBcf_temp_spare3(Double bcf_temp_spare3) { this.bcf_temp_spare3 = bcf_temp_spare3; }

    public Double getBcf_temp_que() { return bcf_temp_que; }
    public void setBcf_temp_que(Double bcf_temp_que) { this.bcf_temp_que = bcf_temp_que; }

    public Double getBcf_temp_drain() { return bcf_temp_drain; }
    public void setBcf_temp_drain(Double bcf_temp_drain) { this.bcf_temp_drain = bcf_temp_drain; }

    public Double getBcf_cp_fanup() { return bcf_cp_fanup; }
    public void setBcf_cp_fanup(Double bcf_cp_fanup) { this.bcf_cp_fanup = bcf_cp_fanup; }

    public Double getBcf_cp_spare1() { return bcf_cp_spare1; }
    public void setBcf_cp_spare1(Double bcf_cp_spare1) { this.bcf_cp_spare1 = bcf_cp_spare1; }

    public Double getBcf_cp_spare2() { return bcf_cp_spare2; }
    public void setBcf_cp_spare2(Double bcf_cp_spare2) { this.bcf_cp_spare2 = bcf_cp_spare2; }

    public Double getBcf_cp_chim() { return bcf_cp_chim; }
    public void setBcf_cp_chim(Double bcf_cp_chim) { this.bcf_cp_chim = bcf_cp_chim; }

    public Double getBcf_cp_diff() { return bcf_cp_diff; }
    public void setBcf_cp_diff(Double bcf_cp_diff) { this.bcf_cp_diff = bcf_cp_diff; }

    public Double getBcf_cp_gang() { return bcf_cp_gang; }
    public void setBcf_cp_gang(Double bcf_cp_gang) { this.bcf_cp_gang = bcf_cp_gang; }

    public Integer getTf_time_spare1() { return tf_time_spare1; }
    public void setTf_time_spare1(Integer tf_time_spare1) { this.tf_time_spare1 = tf_time_spare1; }

    public Integer getTf_time_spare2() { return tf_time_spare2; }
    public void setTf_time_spare2(Integer tf_time_spare2) { this.tf_time_spare2 = tf_time_spare2; }

    public Integer getTf_time_spare3() { return tf_time_spare3; }
    public void setTf_time_spare3(Integer tf_time_spare3) { this.tf_time_spare3 = tf_time_spare3; }

    public Integer getTf_time_spare4() { return tf_time_spare4; }
    public void setTf_time_spare4(Integer tf_time_spare4) { this.tf_time_spare4 = tf_time_spare4; }

    public Integer getTf_time_dry() { return tf_time_dry; }
    public void setTf_time_dry(Integer tf_time_dry) { this.tf_time_dry = tf_time_dry; }

    public Integer getTf_time_fanup() { return tf_time_fanup; }
    public void setTf_time_fanup(Integer tf_time_fanup) { this.tf_time_fanup = tf_time_fanup; }

    public Integer getTf_time_n2() { return tf_time_n2; }
    public void setTf_time_n2(Integer tf_time_n2) { this.tf_time_n2 = tf_time_n2; }

    public Integer getTf_time_tem() { return tf_time_tem; }
    public void setTf_time_tem(Integer tf_time_tem) { this.tf_time_tem = tf_time_tem; }

    public Integer getTf_time_cool() { return tf_time_cool; }
    public void setTf_time_cool(Integer tf_time_cool) { this.tf_time_cool = tf_time_cool; }

    public Double getTf_temp_spare1() { return tf_temp_spare1; }
    public void setTf_temp_spare1(Double tf_temp_spare1) { this.tf_temp_spare1 = tf_temp_spare1; }

    public Double getTf_temp_spare2() { return tf_temp_spare2; }
    public void setTf_temp_spare2(Double tf_temp_spare2) { this.tf_temp_spare2 = tf_temp_spare2; }

    public Double getTf_temp_spare3() { return tf_temp_spare3; }
    public void setTf_temp_spare3(Double tf_temp_spare3) { this.tf_temp_spare3 = tf_temp_spare3; }

    public Double getTf_temp_spare4() { return tf_temp_spare4; }
    public void setTf_temp_spare4(Double tf_temp_spare4) { this.tf_temp_spare4 = tf_temp_spare4; }

    public Double getTf_temp_dry() { return tf_temp_dry; }
    public void setTf_temp_dry(Double tf_temp_dry) { this.tf_temp_dry = tf_temp_dry; }

    public Double getTf_temp_fanup() { return tf_temp_fanup; }
    public void setTf_temp_fanup(Double tf_temp_fanup) { this.tf_temp_fanup = tf_temp_fanup; }

    public Double getTf_temp_n2() { return tf_temp_n2; }
    public void setTf_temp_n2(Double tf_temp_n2) { this.tf_temp_n2 = tf_temp_n2; }

    public Double getTf_temp_tem() { return tf_temp_tem; }
    public void setTf_temp_tem(Double tf_temp_tem) { this.tf_temp_tem = tf_temp_tem; }

    public Double getTf_temp_cool() { return tf_temp_cool; }
    public void setTf_temp_cool(Double tf_temp_cool) { this.tf_temp_cool = tf_temp_cool; }

    public Integer getMain_auto_pattern_number() { return main_auto_pattern_number; }
    public void setMain_auto_pattern_number(Integer main_auto_pattern_number) { this.main_auto_pattern_number = main_auto_pattern_number; }

    public String getMain_yn() { return main_yn; }
    public void setMain_yn(String main_yn) { this.main_yn = main_yn; }

    public Integer getMain_bcf_pattern_number() { return main_bcf_pattern_number; }
    public void setMain_bcf_pattern_number(Integer main_bcf_pattern_number) { this.main_bcf_pattern_number = main_bcf_pattern_number; }

    public Integer getMain_tf_pattern_number() { return main_tf_pattern_number; }
    public void setMain_tf_pattern_number(Integer main_tf_pattern_number) { this.main_tf_pattern_number = main_tf_pattern_number; }

    public String getMain_bcf_hogi() { return main_bcf_hogi; }
    public void setMain_bcf_hogi(String main_bcf_hogi) { this.main_bcf_hogi = main_bcf_hogi; }

    public String getMain_tf_hogi() { return main_tf_hogi; }
    public void setMain_tf_hogi(String main_tf_hogi) { this.main_tf_hogi = main_tf_hogi; }

    public String getMain_spare_1() { return main_spare_1; }
    public void setMain_spare_1(String main_spare_1) { this.main_spare_1 = main_spare_1; }

    public String getMain_spare_2() { return main_spare_2; }
    public void setMain_spare_2(String main_spare_2) { this.main_spare_2 = main_spare_2; }

    public String getMain_spare_3() { return main_spare_3; }
    public void setMain_spare_3(String main_spare_3) { this.main_spare_3 = main_spare_3; }

    public String getMain_spare_4() { return main_spare_4; }
    public void setMain_spare_4(String main_spare_4) { this.main_spare_4 = main_spare_4; }

    public String getMain_bigo_1() { return main_bigo_1; }
    public void setMain_bigo_1(String main_bigo_1) { this.main_bigo_1 = main_bigo_1; }

    public String getMain_bigo_2() { return main_bigo_2; }
    public void setMain_bigo_2(String main_bigo_2) { this.main_bigo_2 = main_bigo_2; }

    public String getMain_bigo_3() { return main_bigo_3; }
    public void setMain_bigo_3(String main_bigo_3) { this.main_bigo_3 = main_bigo_3; }

    public String getMain_bigo_4() { return main_bigo_4; }
    public void setMain_bigo_4(String main_bigo_4) { this.main_bigo_4 = main_bigo_4; }

    public String getMain_bigo_5() { return main_bigo_5; }
    public void setMain_bigo_5(String main_bigo_5) { this.main_bigo_5 = main_bigo_5; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getReg_date() { return reg_date; }
    public void setReg_date(String reg_date) { this.reg_date = reg_date; }

    public String getReg_user() { return reg_user; }
    public void setReg_user(String reg_user) { this.reg_user = reg_user; }

    public String getPdf_path() { return pdf_path; }
    public void setPdf_path(String pdf_path) { this.pdf_path = pdf_path; }

    public String getSdate() { return sdate; }
    public void setSdate(String sdate) { this.sdate = sdate; }

    public String getEdate() { return edate; }
    public void setEdate(String edate) { this.edate = edate; }
}