package com.mibogear.domain;

public class Chulgo {
    private String  och_code;
    private String  ord_code;
    private String  och_date;
    private Float   och_amnt;
    private String  och_danw;
    private String  och_lot;
    private Float   och_su;
    private Float   och_mon;
    private Float   och_dang;

    // 조회용 조인 필드
    private String  prod_name;
    private String  prod_no;
    private String  prod_gyu;
    private String  prod_jai;
    private String  tech_no;
    private String  corp_name;
    private String  ord_danw;
    private Float   ord_su;
    private Float   ord_amnt;
    private Float   ord_danj;
    private Float   chulgo_su;   // 출고누계
    private Float   jan_su;      // 잔량

    // 검색 조건
    private String  sdate;
    private String  edate;
    private String  prod_code;

    public String getOch_code()  { return och_code; }
    public void setOch_code(String och_code) { this.och_code = och_code; }
    public String getOrd_code()  { return ord_code; }
    public void setOrd_code(String ord_code) { this.ord_code = ord_code; }
    public String getOch_date()  { return och_date; }
    public void setOch_date(String och_date) { this.och_date = och_date; }
    public Float getOch_amnt()   { return och_amnt; }
    public void setOch_amnt(Float och_amnt) { this.och_amnt = och_amnt; }
    public String getOch_danw()  { return och_danw; }
    public void setOch_danw(String och_danw) { this.och_danw = och_danw; }
    public String getOch_lot()   { return och_lot; }
    public void setOch_lot(String och_lot) { this.och_lot = och_lot; }
    public Float getOch_su()     { return och_su; }
    public void setOch_su(Float och_su) { this.och_su = och_su; }
    public Float getOch_mon()    { return och_mon; }
    public void setOch_mon(Float och_mon) { this.och_mon = och_mon; }
    public Float getOch_dang()   { return och_dang; }
    public void setOch_dang(Float och_dang) { this.och_dang = och_dang; }
    public String getProd_name() { return prod_name; }
    public void setProd_name(String prod_name) { this.prod_name = prod_name; }
    public String getProd_no()   { return prod_no; }
    public void setProd_no(String prod_no) { this.prod_no = prod_no; }
    public String getProd_gyu()  { return prod_gyu; }
    public void setProd_gyu(String prod_gyu) { this.prod_gyu = prod_gyu; }
    public String getProd_jai()  { return prod_jai; }
    public void setProd_jai(String prod_jai) { this.prod_jai = prod_jai; }
    public String getTech_no()   { return tech_no; }
    public void setTech_no(String tech_no) { this.tech_no = tech_no; }
    public String getCorp_name() { return corp_name; }
    public void setCorp_name(String corp_name) { this.corp_name = corp_name; }
    public String getOrd_danw()  { return ord_danw; }
    public void setOrd_danw(String ord_danw) { this.ord_danw = ord_danw; }
    public Float getOrd_su()     { return ord_su; }
    public void setOrd_su(Float ord_su) { this.ord_su = ord_su; }
    public Float getOrd_amnt()   { return ord_amnt; }
    public void setOrd_amnt(Float ord_amnt) { this.ord_amnt = ord_amnt; }
    public Float getOrd_danj()   { return ord_danj; }
    public void setOrd_danj(Float ord_danj) { this.ord_danj = ord_danj; }
    public Float getChulgo_su()  { return chulgo_su; }
    public void setChulgo_su(Float chulgo_su) { this.chulgo_su = chulgo_su; }
    public Float getJan_su()     { return jan_su; }
    public void setJan_su(Float jan_su) { this.jan_su = jan_su; }
    public String getSdate()     { return sdate; }
    public void setSdate(String sdate) { this.sdate = sdate; }
    public String getEdate()     { return edate; }
    public void setEdate(String edate) { this.edate = edate; }
    public String getProd_code() { return prod_code; }
    public void setProd_code(String prod_code) { this.prod_code = prod_code; }
}