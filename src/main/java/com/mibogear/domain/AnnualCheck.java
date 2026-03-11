package com.mibogear.domain;

public class AnnualCheck {
    private int    id;
    private String equipType;
    private String checkYear;
    private int    checkMonth;
    private String detail;
    private String cycle;
    private String planMonths;
    private String checkDetail;
    private String checker;
    private String checkDataBefore;
    private String checkDataAfter;
    private String note;
    private String userCode;
    private String regDate;
    private String sdate;
    private String edate;
    private String checkNote;
    private String dataBeforeNote;

    // getter/setter
    public String getCheckNote()              { return checkNote; }
    public void   setCheckNote(String v)      { this.checkNote = v; }
    public String getDataBeforeNote()         { return dataBeforeNote; }
    public void   setDataBeforeNote(String v) { this.dataBeforeNote = v; }
    public int    getId()                          { return id; }
    public void   setId(int id)                   { this.id = id; }
    public String getEquipType()                   { return equipType; }
    public void   setEquipType(String equipType)   { this.equipType = equipType; }
    public String getCheckYear()                   { return checkYear; }
    public void   setCheckYear(String checkYear)   { this.checkYear = checkYear; }
    public int    getCheckMonth()                  { return checkMonth; }
    public void   setCheckMonth(int checkMonth)    { this.checkMonth = checkMonth; }
    public String getDetail()                      { return detail; }
    public void   setDetail(String detail)         { this.detail = detail; }
    public String getCycle()                       { return cycle; }
    public void   setCycle(String cycle)           { this.cycle = cycle; }
    public String getPlanMonths()                  { return planMonths; }
    public void   setPlanMonths(String planMonths) { this.planMonths = planMonths; }
    public String getCheckDetail()                 { return checkDetail; }
    public void   setCheckDetail(String checkDetail){ this.checkDetail = checkDetail; }
    public String getChecker()                     { return checker; }
    public void   setChecker(String checker)       { this.checker = checker; }
    public String getCheckDataBefore()             { return checkDataBefore; }
    public void   setCheckDataBefore(String v)     { this.checkDataBefore = v; }
    public String getCheckDataAfter()              { return checkDataAfter; }
    public void   setCheckDataAfter(String v)      { this.checkDataAfter = v; }
    public String getNote()                        { return note; }
    public void   setNote(String note)             { this.note = note; }
    public String getUserCode()                    { return userCode; }
    public void   setUserCode(String userCode)     { this.userCode = userCode; }
    public String getRegDate()                     { return regDate; }
    public void   setRegDate(String regDate)       { this.regDate = regDate; }
    public String getSdate()                       { return sdate; }
    public void   setSdate(String sdate)           { this.sdate = sdate; }
    public String getEdate()                       { return edate; }
    public void   setEdate(String edate)           { this.edate = edate; }
}