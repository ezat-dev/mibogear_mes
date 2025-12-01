package com.mibogear.domain;

public class TempCorrectionQue {

	private int cnt; 
	private String year; //년도
	private String hogi; //설비명
	private String gb; //구분
	private String val1;
	private String val2;
	private String val3;
	private String special; //특기사항
	private String bigo; //비고
	private String yn; //사용구분
	
	private String c_field;
	private String c_value;
	
	//온도조절계보정현황
	private String temp_correction_id;
	private String before_correction;
	private String first_correction;
	private String second_correction;
	private String machine_name;
	
	
	
	public String getTemp_correction_id() {
		return temp_correction_id;
	}
	public void setTemp_correction_id(String temp_correction_id) {
		this.temp_correction_id = temp_correction_id;
	}
	public String getBefore_correction() {
		return before_correction;
	}
	public void setBefore_correction(String before_correction) {
		this.before_correction = before_correction;
	}
	public String getFirst_correction() {
		return first_correction;
	}
	public void setFirst_correction(String first_correction) {
		this.first_correction = first_correction;
	}
	public String getSecond_correction() {
		return second_correction;
	}
	public void setSecond_correction(String second_correction) {
		this.second_correction = second_correction;
	}
	public String getMachine_name() {
		return machine_name;
	}
	public void setMachine_name(String machine_name) {
		this.machine_name = machine_name;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getHogi() {
		return hogi;
	}
	public void setHogi(String hogi) {
		this.hogi = hogi;
	}
	public String getGb() {
		return gb;
	}
	public void setGb(String gb) {
		this.gb = gb;
	}
	public String getVal1() {
		return val1;
	}
	public void setVal1(String val1) {
		this.val1 = val1;
	}
	public String getVal2() {
		return val2;
	}
	public void setVal2(String val2) {
		this.val2 = val2;
	}
	public String getVal3() {
		return val3;
	}
	public void setVal3(String val3) {
		this.val3 = val3;
	}
	public String getSpecial() {
		return special;
	}
	public void setSpecial(String special) {
		this.special = special;
	}
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
	}
	public String getYn() {
		return yn;
	}
	public void setYn(String yn) {
		this.yn = yn;
	}
	public String getC_field() {
		return c_field;
	}
	public void setC_field(String c_field) {
		this.c_field = c_field;
	}
	public String getC_value() {
		return c_value;
	}
	public void setC_value(String c_value) {
		this.c_value = c_value;
	}
	
	
}
