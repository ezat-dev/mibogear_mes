<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>입출고관리현황</title>
    <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>
<style>
.main { width:100%; padding:10px; box-sizing:border-box; }

.box1 {
    display:flex !important;
    justify-content:flex-start !important;
    align-items:center !important;
    width:auto !important;
    margin-left:0 !important;
}

.search-bar {
    display:flex; align-items:center; gap:8px;
    padding:5px 8px; flex-wrap:wrap;
}
.search-bar label {
    font-size:13px; font-weight:bold;
    white-space:nowrap; color:black; margin-right:4px;
}
.search-bar input, .search-bar select {
    height:29px; padding:5px 8px; font-size:13px;
    border:1px solid #ccc; border-radius:6px;
    background-color:#f9f9f9; color:#333;
    outline:none; transition:border 0.3s ease;
}
.search-bar input:focus, .search-bar select:focus {
    border:1px solid #007bff; background-color:#fff;
}

/* 요약 카드 */
.summary-wrap {
    display:flex; gap:12px;
    margin:10px 0; flex-wrap:wrap;
}
.summary-card {
    flex:1; min-width:160px;
    background:white; border-radius:8px;
    padding:14px 18px;
    box-shadow:0 2px 8px rgba(0,0,0,0.08);
    border-left:4px solid #aaa;
}
.summary-card.ipgo  { border-left-color:#4dabf7; }
.summary-card.chulgo{ border-left-color:#ff6b6b; }
.summary-card.jan   { border-left-color:#51cf66; }
.summary-card .card-title {
    font-size:12px; color:#868e96; font-weight:600; margin-bottom:6px;
}
.summary-card .card-value {
    font-size:22px; font-weight:700; color:#2c3e50;
}
.summary-card .card-unit {
    font-size:12px; color:#868e96; margin-left:4px;
}

/* 탭 */
.inner-tabs {
    display:flex; gap:4px; margin:10px 0 6px 0;
}
.inner-tab {
    padding:7px 18px; border:none; border-radius:6px 6px 0 0;
    background:#dee2e6; color:#495057;
    font-size:13px; font-weight:600; cursor:pointer;
    transition:all 0.2s;
}
.inner-tab.active {
    background:#2c3e50; color:white;
}

.tab-section { display:none; }
.tab-section.active { display:block; }
</style>
</head>
<body>

<div class="tab">
    <div class="box1">
        <div class="search-bar">
            <label>기간</label>
            <input type="text" id="sdate" class="datetimepicker_date" style="width:90px;">
            <span style="color:black;">~</span>
            <input type="text" id="edate" class="datetimepicker_date" style="width:90px;">
            <label>거래처명</label>
            <input type="text" id="s_corp_name" style="width:90px;">
            <label>품명</label>
            <input type="text" id="s_prod_name" style="width:90px;">
            <label>품번</label>
            <input type="text" id="s_prod_no" style="width:90px;">
        </div>
    </div>
    <div class="button-container">
        <button class="select-button">
            <img src="/mibogear/image/search-icon.png" class="button-image">조회
        </button>
        <button class="excel-button">
            <img src="/mibogear/image/excel-icon.png" class="button-image">엑셀
        </button>
    </div>
</div>

<main class="main">

    <!-- 요약 카드 -->
    <div class="summary-wrap">
        <div class="summary-card ipgo">
            <div class="card-title">총 입고수량</div>
            <div class="card-value" id="totalIpgo">-<span class="card-unit">EA</span></div>
        </div>
        <div class="summary-card chulgo">
            <div class="card-title">총 출고수량</div>
            <div class="card-value" id="totalChulgo">-<span class="card-unit">EA</span></div>
        </div>
        <div class="summary-card jan">
            <div class="card-title">현재 잔량</div>
            <div class="card-value" id="totalJan">-<span class="card-unit">EA</span></div>
        </div>
    </div>

    <!-- 탭 -->
    <div class="inner-tabs">
        <button class="inner-tab active" onclick="switchTab('tabJan',   this)">📦 잔량현황</button>
        <button class="inner-tab"        onclick="switchTab('tabIpgo',  this)">⬇ 입고이력</button>
        <button class="inner-tab"        onclick="switchTab('tabChulgo',this)">⬆ 출고이력</button>
    </div>

    <!-- 잔량현황 탭 -->
    <div id="tabJan" class="tab-section active">
        <div id="janTab" style="width:100%;"></div>
    </div>

    <!-- 입고이력 탭 -->
    <div id="tabIpgo" class="tab-section">
        <div id="ipgoHistTab" style="width:100%;"></div>
    </div>

    <!-- 출고이력 탭 -->
    <div id="tabChulgo" class="tab-section">
        <div id="chulgoHistTab" style="width:100%;"></div>
    </div>

</main>

<script>
let now_page_code = "g03";
var janTable, ipgoHistTable, chulgoHistTable;

$(function(){
    const today = todayDate();
    const yester = yesterDate();
    $("#sdate").val(yester);
    $("#edate").val(today);

    $(".datetimepicker_date").datepicker({
        language: 'ko',
        autoClose: true,
        dateFormat: 'yyyy-mm-dd'
    });

    loadAllData();

    $("#sdate, #edate, #s_corp_name, #s_prod_name, #s_prod_no").on("keydown", function(e){
        if(e.keyCode === 13) loadAllData();
    });
});

// ===== 탭 전환 =====
function switchTab(tabId, btn){
    $(".tab-section").removeClass("active");
    $(".inner-tab").removeClass("active");
    $("#" + tabId).addClass("active");
    $(btn).addClass("active");
}

// ===== 전체 데이터 로드 =====
function loadAllData(){
    const params = {
        sdate:     $("#sdate").val(),
        edate:     $("#edate").val(),
        corp_name: $("#s_corp_name").val(),
        prod_name: $("#s_prod_name").val(),
        prod_no:   $("#s_prod_no").val()
    };
    loadJanStatus(params);
    loadIpgoHist(params);
    loadChulgoHist(params);
}

// ===== 잔량현황 =====
function loadJanStatus(params){
    if(janTable){ janTable.destroy(); janTable = null; }
    $("#janTab").empty();

    janTable = new Tabulator("#janTab", {
        height:"580px",
        layout:"fitColumns",
        headerSort:false,
        headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.",
        columns:[
            {title:"NO",       field:"idx",        width:50,  hozAlign:"center"},
            {title:"입고코드", field:"ord_code",     width:110, hozAlign:"center"},
            {title:"입고일",   field:"ord_date",     width:100, hozAlign:"center"},
            {title:"거래처",   field:"corp_name",  width:130, hozAlign:"center", headerFilter:"input"},
            {title:"품명",     field:"prod_name",  width:160, hozAlign:"center", headerFilter:"input"},
            {title:"품번",     field:"prod_no",    width:130, hozAlign:"center", headerFilter:"input"},
            {title:"규격",     field:"prod_gyu",   width:100, hozAlign:"center"},
            {title:"재질",     field:"prod_jai",   width:80,  hozAlign:"center"},
            {title:"공정",     field:"tech_no",    width:80,  hozAlign:"center"},
            {title:"단위",     field:"ord_danw",   width:60,  hozAlign:"center"},
            {title:"총입고",   field:"total_ipgo", width:90,  hozAlign:"center"},
            {title:"총출고",   field:"total_chulgo",width:90, hozAlign:"center"},
            {title:"잔량",     field:"jan_su",     width:90,  hozAlign:"center",
                formatter:function(cell){
                    const val = parseFloat(cell.getValue()) || 0;
                    const el  = cell.getElement();
                    if(val <= 0){
                        el.style.color = "#e03131";
                        el.style.fontWeight = "bold";
                    } else {
                        el.style.color = "#2f9e44";
                        el.style.fontWeight = "bold";
                    }
                    return val;
                }
            },
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#fff";
        },
        rowClick:function(e, row){
            $("#janTab div.row_select").removeClass("row_select");
            row.getElement().classList.add("row_select");
        },
        tableBuilt:function(){
            $.ajax({
                url:"/mibogear/productionManagement/ipChulgoStatus/getJanStatus",
                type:"POST", dataType:"json", data: params,
                success:function(result){
                    const data = result.data ? result.data : result;
                    janTable.setData(data);

                    // 요약 카드 계산
                    let sumIpgo = 0, sumChulgo = 0, sumJan = 0;
                    data.forEach(function(r){
                        sumIpgo   += parseFloat(r.total_ipgo)   || 0;
                        sumChulgo += parseFloat(r.total_chulgo) || 0;
                        sumJan    += parseFloat(r.jan_su)       || 0;
                    });
                    $("#totalIpgo").html(sumIpgo.toFixed(0)   + '<span class="card-unit">EA</span>');
                    $("#totalChulgo").html(sumChulgo.toFixed(0)+'<span class="card-unit">EA</span>');
                    $("#totalJan").html(sumJan.toFixed(0)     + '<span class="card-unit">EA</span>');
                }
            });
        }
    });
}

// ===== 입고이력 =====
function loadIpgoHist(params){
    if(ipgoHistTable){ ipgoHistTable.destroy(); ipgoHistTable = null; }
    $("#ipgoHistTab").empty();

    ipgoHistTable = new Tabulator("#ipgoHistTab", {
        height:"580px",
        layout:"fitColumns",
        headerSort:false,
        headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.",
        columns:[
            {title:"NO",       field:"idx",       width:50,  hozAlign:"center"},
            {title:"입고코드", field:"ord_code",  width:110, hozAlign:"center"},
            {title:"입고일",   field:"ord_date",  width:100, hozAlign:"center"},
            {title:"거래처",   field:"corp_name", width:130, hozAlign:"center", headerFilter:"input"},
            {title:"품명",     field:"prod_name", width:160, hozAlign:"center", headerFilter:"input"},
            {title:"품번",     field:"prod_no",   width:130, hozAlign:"center", headerFilter:"input"},
            {title:"규격",     field:"prod_gyu",  width:100, hozAlign:"center"},
            {title:"재질",     field:"prod_jai",  width:80,  hozAlign:"center"},
            {title:"공정",     field:"tech_no",   width:80,  hozAlign:"center"},
            {title:"단위",     field:"ord_danw",  width:60,  hozAlign:"center"},
            {title:"입고수량", field:"ord_su",    width:90,  hozAlign:"center"},
            {title:"중량(kg)", field:"ord_amnt",  width:90,  hozAlign:"center"},
            
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#fff";
        },
        tableBuilt:function(){
            $.ajax({
                url:"/mibogear/productionManagement/ipChulgoStatus/getIpgoHist",
                type:"POST", dataType:"json", data: params,
                success:function(result){
                    ipgoHistTable.setData(result.data ? result.data : result);
                }
            });
        }
    });
}

// ===== 출고이력 =====
function loadChulgoHist(params){
    if(chulgoHistTable){ chulgoHistTable.destroy(); chulgoHistTable = null; }
    $("#chulgoHistTab").empty();

    chulgoHistTable = new Tabulator("#chulgoHistTab", {
        height:"580px",
        layout:"fitColumns",
        headerSort:false,
        headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.",
        columns:[
            {title:"NO",       field:"idx",       width:50,  hozAlign:"center"},
            {title:"출고코드", field:"och_code",  width:110, hozAlign:"center"},
            {title:"입고코드", field:"ord_code",  width:110, hozAlign:"center"},
            {title:"출고일",   field:"och_date",  width:100, hozAlign:"center"},
            {title:"거래처",   field:"corp_name", width:130, hozAlign:"center", headerFilter:"input"},
            {title:"품명",     field:"prod_name", width:160, hozAlign:"center", headerFilter:"input"},
            {title:"품번",     field:"prod_no",   width:130, hozAlign:"center", headerFilter:"input"},
            {title:"규격",     field:"prod_gyu",  width:100, hozAlign:"center"},
            {title:"재질",     field:"prod_jai",  width:80,  hozAlign:"center"},
            {title:"공정",     field:"tech_no",   width:80,  hozAlign:"center"},
            {title:"단위",     field:"och_danw",  width:60,  hozAlign:"center"},
            {title:"출고수량", field:"och_su",    width:90,  hozAlign:"center"},
            {title:"출고중량", field:"och_amnt",  width:90,  hozAlign:"center"},
            {title:"단가",     field:"och_dang",  width:70,  hozAlign:"center"},
            {title:"금액",     field:"och_mon",   width:90,  hozAlign:"center"},
            
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#fff";
        },
        tableBuilt:function(){
            $.ajax({
                url:"/mibogear/productionManagement/ipChulgoStatus/getChulgoHist",
                type:"POST", dataType:"json", data: params,
                success:function(result){
                    chulgoHistTable.setData(result.data ? result.data : result);
                }
            });
        }
    });
}

// ===== 조회 버튼 =====
$(".select-button").on("click", function(){
    loadAllData();
});

// ===== 엑셀 (현재 활성 탭 기준) =====
$(".excel-button").on("click", function(){
    const today = new Date().toISOString().slice(0,10).replace(/-/g,"");
    if($("#tabJan").hasClass("active") && janTable){
        janTable.download("xlsx", "잔량현황_"+today+".xlsx", {sheetName:"잔량현황"});
    } else if($("#tabIpgo").hasClass("active") && ipgoHistTable){
        ipgoHistTable.download("xlsx", "입고이력_"+today+".xlsx", {sheetName:"입고이력"});
    } else if($("#tabChulgo").hasClass("active") && chulgoHistTable){
        chulgoHistTable.download("xlsx", "출고이력_"+today+".xlsx", {sheetName:"출고이력"});
    } else {
        alert("먼저 조회하세요.");
    }
});
</script>
</body>
</html>