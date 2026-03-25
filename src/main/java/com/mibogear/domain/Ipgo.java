package com.mibogear.domain;

public class Ipgo {
    private String ord_code;
    private String prod_code;
    private String  ord_date;
    private Integer ord_su;
    private Float   ord_amnt;
    private String  ord_lot;
    private String  ord_boxsu;
    private String  ord_danw;
    private Float   ord_danj;

    // 조회용 조인 필드 (tb_product, tb_corp)
    private String prod_name;
    private String prod_no;
    private String prod_gyu;
    private String prod_jai;
    private String tech_no;
    private String corp_name;

    // 검색 조건용
    private String sdate;
    private String edate;

    public String getOrd_code()  { return ord_code; }
    public void setOrd_code(String ord_code) { this.ord_code = ord_code; }
    public String getProd_code() { return prod_code; }
    public void setProd_code(String prod_code) { this.prod_code = prod_code; }
    public String getOrd_date()   { return ord_date; }
    public void setOrd_date(String ord_date) { this.ord_date = ord_date; }
    public Integer getOrd_su()    { return ord_su; }
    public void setOrd_su(Integer ord_su) { this.ord_su = ord_su; }
    public Float getOrd_amnt()    { return ord_amnt; }
    public void setOrd_amnt(Float ord_amnt) { this.ord_amnt = ord_amnt; }
    public String getOrd_lot()    { return ord_lot; }
    public void setOrd_lot(String ord_lot) { this.ord_lot = ord_lot; }
    public String getOrd_boxsu()  { return ord_boxsu; }
    public void setOrd_boxsu(String ord_boxsu) { this.ord_boxsu = ord_boxsu; }
    public String getOrd_danw()   { return ord_danw; }
    public void setOrd_danw(String ord_danw) { this.ord_danw = ord_danw; }
    public Float getOrd_danj()    { return ord_danj; }
    public void setOrd_danj(Float ord_danj) { this.ord_danj = ord_danj; }
    public String getProd_name()  { return prod_name; }
    public void setProd_name(String prod_name) { this.prod_name = prod_name; }
    public String getProd_no()    { return prod_no; }
    public void setProd_no(String prod_no) { this.prod_no = prod_no; }
    public String getProd_gyu()   { return prod_gyu; }
    public void setProd_gyu(String prod_gyu) { this.prod_gyu = prod_gyu; }
    public String getProd_jai()   { return prod_jai; }
    public void setProd_jai(String prod_jai) { this.prod_jai = prod_jai; }
    public String getTech_no()    { return tech_no; }
    public void setTech_no(String tech_no) { this.tech_no = tech_no; }
    public String getCorp_name()  { return corp_name; }
    public void setCorp_name(String corp_name) { this.corp_name = corp_name; }
    public String getSdate()      { return sdate; }
    public void setSdate(String sdate) { this.sdate = sdate; }
    public String getEdate()      { return edate; }
    public void setEdate(String edate) { this.edate = edate; }
}