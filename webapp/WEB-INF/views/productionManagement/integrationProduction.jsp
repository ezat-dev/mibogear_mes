<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>종합생산현황</title>
   <%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<style>

    /* 기본 레이아웃 (테이블 높이/패딩 축소 적용) */
    body{ background:#fff; font-family:"Noto Sans KR", "맑은 고딕", sans-serif; color:#222; margin:0; padding:0; overflow: hidden; }
   .main {
    max-width:1800px;
    margin:18px auto;
    padding:16px;
    height: 100%;
    overflow: hidden; /* 내부 카드 스크롤만 허용 */
}

/* 카드 내부 테이블 래퍼 스크롤 */
.card.fixed-height #tableHeatTopWrapper,
.card.fixed-height #tableAlarmWrapper,
.card.fixed-height #tableHeatWrapper {
    flex: 1; /* 남은 공간 모두 차지 */
    overflow-y: auto;
    height: 100px;
}
body, html {
    height: 100%;
    overflow: hidden; /* 화면 전체 스크롤 제거 */
}
    .header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:14px; }
    .title{ font-size:20px; font-weight:700; }
    .subtitle{ font-size:13px; color:#6b7280; }

    .grid{ display:flex; gap:18px; margin-bottom:18px; }
    .card{
        background:#fff;
        border-radius:10px;
        padding:16px; /* 기존 12 -> 10 */
        box-shadow:0 6px 18px rgba(2,6,23,0.06);
        border:1px solid rgba(2,6,23,0.04);
        flex:1;
        min-width:330px;
    }
    .card .card-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:8px; }
    .card-title{ font-weight:700; font-size:14px; }
    .card-sub{ font-size:12px; color:#6b7280; }

    /* 테이블 공통: 패딩/행높이 축소 */
    table { width:100%; border-collapse:collapse; font-size:13px; }
    thead th {
        text-align:center;
        padding:6px 6px; /* 기존 10px -> 6px */
        background:#f3f6fb;
        border-bottom:1px solid #e6eefc;
        font-weight:700;
        height:34px; /* 헤더 높이 약간 축소 */
    }
    tbody td {
        padding:6px 6px; /* 기존 10px -> 6px */
        border-bottom:1px solid #f1f5f9;
        text-align:center;
        height:36px; /* 각 행 높이 고정 */
        line-height:18px;
        white-space:nowrap;
        overflow:hidden;
        text-overflow:ellipsis;
    }
    tbody tr:hover { background:#fbfdff; cursor:pointer; }
    tbody tr.selected { background: linear-gradient(90deg, rgba(11,99,206,0.06), rgba(11,99,206,0.02)); font-weight:700; }

    .kpi { display:flex; gap:8px; }
    .kpi .item{ flex:1; background:#fbfcff; padding:6px; border-radius:8px; text-align:center; } /* padding 축소 */
    .kpi .label{ font-size:12px; color:#6b7280; }
    .kpi .value{ font-size:16px; font-weight:800; color:#111827; } /* 숫자 크기 약간 축소 */

    .btn{ display:inline-flex; align-items:center; gap:8px; padding:8px 12px; border-radius:8px; border:0; cursor:pointer; font-weight:700; }
    .btn.primary{ background:#0b63ce; color:#fff; }
    .btn.work{ background:#A566FF; color:#fff; }
    .btn.ghost{ background:#fff; color:#111; border:1px solid rgba(2,6,23,0.06); }



    .small-input{ padding:6px 8px; border-radius:6px; border:1px solid #e6eefc; }

    .muted{ color:#6b7280; font-size:12px; }

    /* 강조 셀 (온도, CP) */
    .temp { color:#e63946; font-weight:800; }
    .cp { color:#0b63ce; font-weight:800; }

    /* 개별 테이블 최대 높이 — 줄여서 스크롤 생기도록 설정 */
    #tableHeatTopWrapper { height:120px; overflow:auto; }   /* 요약 상단 테이블 (작게) */
   #tableHeatWrapper { 
    height: 220px;  /* 기존 330px → 250px */
    overflow:auto; 
}

    #tableAlarm { } /* 테이블 element 자체는 사용 안함 */
    #tableAlarm tbody { } 
   #tableAlarmWrapper { 
    height: 261px;  
    overflow:auto; 
}

    /* 온도표는 한 줄이라 높이 조절 필요 없음 — 셀 패딩만 작게 */
    .temp-table thead th{ padding:6px 6px; font-size:12px; color:#6b7280; }
    .temp-table tbody td{ padding:8px 6px; font-size:16px; height:36px; }

    @media (max-width:1100px){
        .grid{ flex-direction:column; }
    }
    
/*바코드스캔 모달용 css*/
  #lotModal .form-section {
    margin-bottom: 15px;
    padding: 10px;
    border-radius: 10px;
    background: #f9fafb;
    box-shadow: 0 1px 4px rgba(0,0,0,0.05);
  }

  #lotModal .form-section h3 {
    margin-bottom: 8px;
    font-size: 14px;
    color: #333;
    border-left: 4px solid #007bff;
    padding-left: 6px;
  }

  #lotModal .grid {
    display: grid;
    gap: 8px;
  }

  #lotModal .grid-3 { grid-template-columns: repeat(3, 1fr); }
  #lotModal .grid-7 { grid-template-columns: repeat(7, 1fr); }
  #lotModal .grid-6 { grid-template-columns: repeat(6, 1fr); }

  #lotModal .form-group {
    display: flex;
    flex-direction: column;
  }

  #lotModal .form-group label {
    font-size: 12px;
    margin-bottom: 3px;
    color: #555;
  }

  #lotModal .form-group input {
    padding: 4px 6px;
    border: 1px solid #ccc;
    border-radius: 6px;
    outline: none;
    font-size: 12px;
  }

  #lotModal .form-group input:focus {
    border-color: #007bff;
    background: #f0f7ff;
  }

  #lotModal .modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 8px;
    margin-top: 10px;
  }

  #lotModal .btn {
    padding: 6px 12px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
  }

  #lotModal .btn-primary {
    background-color: #007bff;
    color: white;
  }

  #lotModal .btn-secondary {
    background-color: #e0e0e0;
    color: #333;
  }
  .monitor-container {
        display: flex;
        flex-direction: column;
        gap: 10px;
        background-color: #99ccff; /* 하늘색 배경 */
        padding: 10px;
        font-family: 'Malgun Gothic', sans-serif;
        font-weight: bold;
    }

    .machine-group {
        display: flex;
        border: 2px solid white;
    }

    .machine-label {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        writing-mode: vertical-lr; /* 세로 쓰기 */
        text-align: center;
        font-size: 1.2rem;
        border-right: 2px solid white;
        text-orientation: upright;
    }

    .data-table {
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }

    .row {
        display: flex;
        flex-grow: 1;
    }

    .cell {
        flex: 1;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #ddd;
        text-align: center;
    }

    /* 색상 정의 */
    .orange { background-color: #ff6600; color: black; }
    .brown  { background-color: #a52a2a; color: white; }
    .gray   { background-color: #d3d3d3; color: black; }
    .yellow { background-color: #ffff00; color: black; }
    .green  { background-color: #00ff00; color: black; }
    .black  { background-color: #000000; }

    /* 텍스트 색상 */
    .yellow-text { color: #ffff00; }
    .green-text  { color: #00ff00; }
    
    #lotTable{
    height: 304px;
    }
</style>

</head>
<body>
<main class="main">
    <div class="header">
        <div>
  

        </div>
        <div style="text-align:right;">
            <div class="muted">최종 갱신: <span id="lastUpdated">--:--:--</span></div>
            <div style="margin-top:6px;">
                <!-- <button class="btn work" id="openModal">작업스캔</button> -->
                <button class="btn primary" id="btnRefresh">즉시갱신</button>
                <!-- <button class="btn ghost" id="btnRefreshAll">전체갱신</button> -->
            </div>
        </div>
    </div>

    <!-- 상단: 요약(왼) + 알람(오) (위치 변경: 알람을 상단 오른쪽에 배치) -->
    <div class="grid">
        <div class="card card" style="flex:0.45; fon">
            <div class="card-header">
                <div>
                    <div class="card-title">작업 진행</div>
                    <div class="card-sub"></div>
                </div>
               
            </div>

            	<div id="lotTable"></div>
            
            <div class="card card fixed-height"">
    <div class="card-title">현재 온도</div>
<div class="monitor-container">
    <div class="machine-group">
        <div class="machine-label orange">1호기</div>
        <div class="data-table">
            <div class="row header">
                <div class="cell brown">온도(℃)</div>
                <div class="cell gray">침탄</div>
                <div class="cell gray">유조</div>
                <div class="cell gray">CP</div>
                <div class="cell gray">소려</div>
            </div>
            <div class="row">
                <div class="cell yellow">설정값</div>
                <div class="cell black yellow-text" id="bcf1_chim_setting"></div>
                <div class="cell black yellow-text" id="bcf1_oil_setting"></div>
                <div class="cell black yellow-text" id="bcf1_cp_setting"></div>
                <div class="cell black yellow-text" id="bcf1_tempering_setting"></div>
            </div>
            <div class="row">
                <div class="cell green">현재값</div>
                <div class="cell black green-text" id="bcf1_chim"></div>
                <div class="cell black green-text" id="bcf1_oil"></div>
                <div class="cell black green-text" id="bcf1_cp"></div>
                <div class="cell black green-text" id="bcf1_tempering"></div>
            </div>
        </div>
    </div>

    <div class="machine-group">
        <div class="machine-label orange">2호기</div>
        <div class="data-table">
            <div class="row header">
                <div class="cell brown">온도(℃)</div>
                <div class="cell gray">침탄</div>
                <div class="cell gray">유조</div>
                <div class="cell gray">CP</div>
            </div>
            <div class="row">
                <div class="cell yellow">설정값</div>
                <div class="cell black yellow-text" id="bcf2_chim_setting"></div>
                <div class="cell black yellow-text" id="bcf2_oil_setting"></div>
                <div class="cell black yellow-text" id="bcf2_cp_setting"></div>
            </div>
            <div class="row">
                <div class="cell green">현재값</div>
                <div class="cell black green-text" id="bcf2_chim"></div>
                <div class="cell black green-text" id="bcf2_oil"></div>
                <div class="cell black green-text" id="bcf2_cp"></div>
            </div>
        </div>
    </div>
</div>
        </div>
        </div>

        <!-- 오른쪽 상단: 알람 카드로 변경 (위치 변경 적용) -->
        <div class="card card" style="flex:0.55;">
            <div class="card-header">
                <div>
                    <div class="card-title">최신 알람 이력</div>
                    <div class="card-sub"></div>
                </div>
                <div>
       <!--              <input type="date" id="s_sdate" class="small-input">
                    <input type="date" id="s_edate" class="small-input"> -->
                    <button class="btn ghost" id="btnLoadAlarm">조회</button>
                </div>
            </div>

            <div id="tableAlarmWrapper"  overflow:auto;">
                <table id="tableAlarm">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>PLC주소</th>
                            <th>알람내용</th>
                            <th>발생시간</th>
                            <th>해제시간</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <div class="card-title">현재 온도</div>
            <div class="monitor-container">
    <div class="machine-group">
        <div class="machine-label orange">3호기</div>
        <div class="data-table">
            <div class="row header">
                <div class="cell brown">온도(℃)</div>
                <div class="cell gray">침탄</div>
                <div class="cell gray">유조</div>
                <div class="cell gray">CP</div>
                <div class="cell gray">소려</div>
            </div>
            <div class="row">
                <div class="cell yellow">설정값</div>
                <div class="cell black yellow-text" id="bcf3_chim_setting"></div>
                <div class="cell black yellow-text" id="bcf3_oil_setting"></div>
                <div class="cell black yellow-text" id="bcf3_cp_setting"></div>
                <div class="cell black yellow-text" id="bcf3_tempering_setting"></div>
            </div>
            <div class="row">
                <div class="cell green">현재값</div>
                <div class="cell black green-text" id="bcf3_chim"></div>
                <div class="cell black green-text" id="bcf3_oil"></div>
                <div class="cell black green-text" id="bcf3_cp"></div>
                <div class="cell black green-text" id="bcf3_tempering"></div>
            </div>
        </div>
    </div>

    <div class="machine-group">
        <div class="machine-label orange">4호기</div>
        <div class="data-table">
            <div class="row header">
                <div class="cell brown">온도(℃)</div>
                <div class="cell gray">침탄</div>
                <div class="cell gray">유조</div>
                <div class="cell gray">CP</div>
            </div>
            <div class="row">
                <div class="cell yellow">설정값</div>
                <div class="cell black yellow-text" id="bcf4_chim_setting"></div>
                <div class="cell black yellow-text" id="bcf4_oil_setting"></div>
                <div class="cell black yellow-text" id="bcf4_cp_setting"></div>
            </div>
            <div class="row">
                <div class="cell green">현재값</div>
                <div class="cell black green-text" id="bcf4_chim"></div>
                <div class="cell black green-text" id="bcf4_oil"></div>
                <div class="cell black green-text" id="bcf4_cp"></div>
            </div>
        </div>
    </div>
</div>
        </div>
    </div>
    
<!-- 스캔한 바코드의 정보 표현할 모달 -->
<div id="lotModal" title="레시피 입력" style="display:none;">

  <!-- 로트번호 -->
  <div class="form-section">
    <h3>로트번호</h3>
    <div class="form-group">
      <input type="text" id="lotNumber">
    </div>
  </div>

  <!-- 기본 정보 -->
  <div class="form-section">
    <h3>기본 정보</h3>
    <div class="grid grid-3">
      <div class="form-group"><label>로트번호</label>
      <input type="text" name="w_ci_lot" class="w_ci_lot"></div>
      
      <div class="form-group"><label>업체명</label>
      <input type="text" name="cust_name" class="cust_name"></div>
      <div class="form-group"><label>품번</label>
      <input type="text" name="item_no" class="item_no"></div>
      <div class="form-group"><label>품명</label>
      <input type="text" name="item_name" class="item_name"></div>
      <div class="form-group"><label>규격</label>
      <input type="text" name="spec" class="spec"></div>
      <div class="form-group"><label>장입량</label>
      <input type="text" name="charge_weight" class="charge_weight"></div>
      <div class="form-group"><label>계획통수</label>
      <input type="text" name="w_plan_cnt" class="w_plan_cnt"></div>
      <div class="form-group"><label>투입통수</label>
      <input type="text" name="wd_in_cnt" class="wd_in_cnt"></div>
    </div>
  </div>

  <!-- 소입 존 -->
  <div class="form-section">
    <h3>소입 존</h3>
    <div class="grid grid-7">
      <div class="form-group"><label>소입1존</label>
      <input type="text" name="q1_zone" class="q1_zone"></div>
      <div class="form-group"><label>소입2존</label>
      <input type="text" name="q2_zone" class="q2_zone"></div>
      <div class="form-group"><label>소입3존</label>
      <input type="text" name="q3_4_zone" class="q3_4_zone"></div>
      <div class="form-group"><label>소입4존</label>
      <input type="text" class="q3_4_zone" readonly="readonly"></div>
      <div class="form-group"><label>소입5존</label>
      <input type="text" name="q5_zone" class="q5_zone"></div>
      <div class="form-group"><label>소입인버터</label>
      <input type="text" name="q_speed" class="q_speed"></div>
      <div class="form-group"><label>CP</label>
      <input type="text" name="cp" class="cp"></div>
    </div>
  </div>

  <!-- 소려 존 -->
  <div class="form-section">
    <h3>소려 존</h3>
    <div class="grid grid-6">
      <div class="form-group"><label>소려1존</label>
      <input type="text" name="t1_zone" class="t1_zone"></div>
      <div class="form-group"><label>소려2존</label>
      <input type="text" name="t2_5_zone" class="t2_5_zone"></div>
      <div class="form-group"><label>소려3존</label>
      <input type="text" class="t2_5_zone" readonly="readonly"></div>
      <div class="form-group"><label>소려4존</label>
      <input type="text" class="t2_5_zone" readonly="readonly"></div>
      <div class="form-group"><label>소려5존</label>
      <input type="text" class="t2_5_zone" readonly="readonly"></div>
      <div class="form-group"><label>소려인버터</label>
      <input type="text" name="t_speed" class="t_speed"></div>
    </div>
  </div>

  		<div class="view">
            <div id="dataTable"></div>
        </div>



  <!-- 버튼 -->
  <div class="modal-footer">
    <button type="button" id="applyBtn" class="btn btn-primary">레시피 적용</button>
    <button type="button" id="cancelBtn" class="btn btn-secondary">닫기</button>
  </div>
</div><!-- 모달 열기 버튼 -->
<!--  <button id="openModal">모달 열기</button>-->


</main>


<script>
    // jQuery 존재확인 (pluginpage.jsp에 포함되어있을 것으로 가정)
/*
    if(!window.jQuery){
        document.write('<script src="https://code.jquery.com/jquery-3.6.0.min.js"><\/script>');
    }
*/

/*전역변수*/
let now_page_code = "b02";
var opcInterval;
var selectedRowData = null;
var tempAuto = true;
var tempTimer = null;
var dataTable;
var lotTable;


/*바코드스캔 모달*/
$(function() {

    // 초기 로드
    fetchAlarm();
    fetchTempCurrent();
    initLotData();

    // 자동 갱신 설정
    tempTimer = setInterval(function(){
        if(tempAuto) fetchTempCurrent();
    }, 10000); // 10s

    setInterval(fetchAlarm, 30000); // 알람 30s

    // 버튼 이벤트
    $("#btnRefresh").on("click", function(){ initLotData(); fetchTempCurrent(); fetchAlarm(); });
    $("#btnRefreshAll").on("click", function(){ refreshAll(); });
    $("#btnLoadAlarm").on("click", function(){ fetchAlarm(); });
    $("#btnToggleAuto").on("click", function(){
        tempAuto = !tempAuto;
        $(this).text(tempAuto ? "자동(10s)" : "정지");
    });

    // 행 클릭 (테이블 바디에 이벤트 위임)
    $("#tableHeat tbody").on("click","tr", function(){
        $("#tableHeat tbody tr").removeClass("selected");
        $(this).addClass("selected");
        selectedRowData = $(this).data("rowdata");
    });
    $("#tableAlarm tbody").on("click","tr", function(){
        $("#tableAlarm tbody tr").removeClass("selected");
        $(this).addClass("selected");
        selectedRowData = $(this).data("rowdata");
    });
    $("#tableHeatTop tbody").on("click","tr", function(){
        $("#tableHeatTop tbody tr").removeClass("selected");
        $(this).addClass("selected");
        selectedRowData = $(this).data("rowdata");
    });
	
  $("#lotModal").dialog({
	    autoOpen: false,
	    modal: true,
	    width: 1300,  // 넓게 해서 스크롤 없음
	    height: "auto",
	    resizable: false
  });

  initLotData();
  
});

$("#cancelBtn, #closeBtn").click(function() {
  $("#lotModal").dialog("close");
});


let heatListTable; 
let scanTimer;

// 🔹 테이블 초기화 (최초 1회만)

function tongListInit() {
  heatListTable = new Tabulator('#dataTable', {
    height: '220px',
    layout: 'fitColumns',
    headerSort: false,
    reactiveData: true,
    columnHeaderVertAlign: "middle",
    rowVertAlign: "middle",
    headerHozAlign: 'center',
    ajaxConfig: { method: 'POST' },
    renderHorizontal: "virtual",
    selectable: true,
    selectableRangeMode: "click",
    placeholder: "조회된 데이터가 없습니다.",
    rowFormatter: function(row) {
      let data = row.getData();
      if(data.wd_state === 0 || data.wd_state === 99){
        row.getElement().style.backgroundColor = "#fffacd"; // 연노랑
      } else if(data.wd_state === 1){
        row.getElement().style.backgroundColor = "#d4edda"; // 연초록
      } else {
        row.getElement().style.backgroundColor = "";
      }
    },
    columns: [
      { title: "No", formatter: "rownum", hozAlign: "center", width: 70 },
      { title: "통 번호", field: "wd_tong_num", width: 220, hozAlign: "center" },
      { 
        title: "상태", 
        field: "wd_state",
        hozAlign: "center",
        formatter: function(cell) {
          let value = cell.getValue();
          if (value === 0) return "스캔 대기";
          if (value === 1) return "스캔 완료";
          if (value === 2) return "미적용";
          return value;
        },
        // width 제거 → 남은 공간을 자동으로 채움
      },
    ],
  });
}

function initLotData() {
	  lotTable = new Tabulator('#lotTable', {
		    height: '260px',
		    layout: 'fitDataFill',
		    headerSort: false,
		    reactiveData: true,
		    columnHeaderVertAlign: "middle",
		    headerHozAlign: 'center',
		    ajaxConfig: { method: 'POST' },
		    ajaxURL: "/mibogear/productionManagement/integrationLotList",
		    ajaxParams: { },	    
		    ajaxResponse:function(url, params, response){
				$("#dataTable .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    placeholder: "조회된 데이터가 없습니다.",
		    columns: [
		    	{ title: "LOT 번호", field: "lotno", width: 250, hozAlign: "center" },  
		      { title: "LOT 생성 날짜", field: "regtime", width: 250, hozAlign: "center"},
		      { title: "패턴 번호", field: "pattern", width: 90, hozAlign: "center" },
		      { title: "설비", field: "fac_no", width: 112, hozAlign: "center" }    		      
		    ]
		  });
	}

// 🔹 페이지 로드 시 테이블 초기화
$(document).ready(function () {
  tongListInit();
});




/*작업현황 그 외 함수*/




        function updateLastUpdated(){
            var d = new Date();
            var hh = String(d.getHours()).padStart(2,'0');
            var mm = String(d.getMinutes()).padStart(2,'0');
            var ss = String(d.getSeconds()).padStart(2,'0');
            $("#lastUpdated").text(hh+":"+mm+":"+ss);
        }

        function refreshAll(){
            fetchAlarm();
            fetchTempCurrent();
            updateLastUpdated();
        }
        


        var startTime = null; // 진행 중 작업 시작 시간

        function startKpiTimer(w_sdatetime){
            if(!w_sdatetime){
                $("#kpi_time").text("-");
                return;
            }

            // 문자열 → Date 객체
            startTime = new Date(w_sdatetime.replace(/-/g, '/'));

            // 기존 타이머가 있으면 제거
            if(window.kpiTimer) clearInterval(window.kpiTimer);

            // 1초마다 업데이트
            window.kpiTimer = setInterval(function(){
                var now = new Date();
                var diffMs = now - startTime;

                var diffH = Math.floor(diffMs / 1000 / 60 / 60);
                var diffM = Math.floor(diffMs / 1000 / 60) % 60;
                var diffS = Math.floor(diffMs / 1000) % 60;

                var timeStr = diffH.toString().padStart(2,'0') + ":" +
                              diffM.toString().padStart(2,'0') + ":" +
                              diffS.toString().padStart(2,'0');
                $("#kpi_time").text(timeStr);
            }, 1000);
        }

        /* ---------- Alarm ---------- */
        function fetchAlarm(){
            $.ajax({
                url: "/chunil/productionManagement/alarmRecord/list",
                method: "POST",
                dataType: "json",
                success: function(resp){
                    updateLastUpdated();
                    var arr = Array.isArray(resp) ? resp : (resp.data || resp.rows || (resp ? [resp] : []));
                    var $tbody = $("#tableAlarm tbody").empty();
                    if(!arr || arr.length === 0){
                        $tbody.append('<tr><td colspan="5">조회된 데이터가 없습니다.</td></tr>');
                        return;
                    }

                    arr.forEach(function(r, idx){
                        var tr = $("<tr></tr>");
                        tr.append("<td>"+(r.idx!=null?r.idx:"")+"</td>");
                        tr.append("<td>"+(r.a_addr || "")+"</td>");
                        tr.append("<td style='text-align:left;padding-left:12px;'>"+(r.a_desc || "")+"</td>");
                        tr.append("<td>"+(r.a_stime || "")+"</td>");
                        tr.append("<td>"+(r.a_etime || "")+"</td>");
                        tr.data("rowdata", r);

                        // ✅ 진행 중인 알람 시각적 강조
                        if(!r.a_etime || r.a_etime === ""){
                            tr.css({
                                "background": "linear-gradient(90deg, rgba(255,230,0,0.2), rgba(255,255,255,0))",
                                "font-weight": "bold",
                                "color": "#b30000"  // 빨간색 글씨
                            });
                            tr.append("<td style='color:#b30000; font-weight:bold;'>진행 중</td>");
                        } else {
                            tr.append("<td>-</td>");
                        }

                        $tbody.append(tr);
                    });
                },
                error: function(xhr){
                    console.error("fetchAlarm error", xhr);
                }
            });
        }


        //온도 조회
    function fetchTempCurrent(){
    $.ajax({
        url: "/mibogear/productionManagement/integrationGetTempList",
        method: "POST",
        data: { },
        dataType: "json",
        success: function(response){
            
        	if (response) {
                // Object의 모든 키(필드명)를 순회하며 ID와 매칭
                Object.keys(response).forEach(function(key) {
                    // # 접두사와 key 값을 문자열 결합으로 연결
                    var targetId = '#' + key;
                    
                    // 해당 ID를 가진 요소가 페이지에 존재할 때만 데이터 삽입
                    if ($(targetId).length > 0) {
                        $(targetId).text(response[key]);
                    }
                });
            }
            
        },
        error: function(xhr){
            console.error("fetchTempCurrent error", xhr);
        }
    });
}
	//알람 조회
      function fetchAlarm(){
  	    $.ajax({
  	        url: "/mibogear/monitoring/getAlarmList",
  	        method: "POST",
  	        data: { },
  	        dataType: "json",
  	        success: function(resp){
  	 
  	            var arr = Array.isArray(resp) ? resp : (resp.data || resp.rows || (resp ? [resp] : []));
  	            var $tbody = $("#tableAlarm tbody").empty();
  	            if(!arr || arr.length === 0){
  	                $tbody.append('<tr><td colspan="6">조회된 데이터가 없습니다.</td></tr>');
  	                return;
  	            }

  	            arr.forEach(function(r, idx){
  	                var tr = $("<tr></tr>");
  	                tr.append("<td>"+(idx + 1)+"</td>");
  	                tr.append("<td>"+(r.alarm_address || "")+"</td>");
  	                tr.append("<td padding-left:12px;'>"+(r.comment || "")+"</td>");
  	                tr.append("<td>"+(r.occur_time || "")+"</td>");
  	                tr.append("<td>"+(r.clear_time || "")+"</td>");
  	                tr.data("rowdata", r);

  	                // ✅ 진행 중인 알람 시각적 강조
  	                if(!r.clear_time || r.clear_time === ""){
  	                    tr.css({
  	                        "background": "linear-gradient(90deg, rgba(255,230,0,0.2), rgba(255,255,255,0))",
  	                        "font-weight": "bold",
  	                        "color": "#b30000"
  	                    });
  	                    tr.append("<td style='color:#b30000; font-weight:bold;'>진행 중</td>");
  	                } else {
  	                    tr.append("<td>-</td>");
  	                }

  	                $tbody.append(tr);
  	            });
  	        },
  	        error: function(xhr){
  	            console.error("fetchAlarm error", xhr);
  	        }
  	    });
  	}


</script>
</body>
</html>
