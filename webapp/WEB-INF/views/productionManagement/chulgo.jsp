<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>출고관리</title>
    <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>
<style>
.main { width:100%; }
.container { display:flex; justify-content:flex-start; }

/* ★ box1 오버라이드 */
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
/* Air Datepicker 달력 z-index 강제 적용 */
.datepicker {
    z-index: 1300 !important;
}
.datepicker-global-container {
    z-index: 1300 !important;
}

/* 출고등록 모달 */
.chulgo-modal {
    display:none;
    position:fixed;
    top:50%; left:50%;
    transform:translate(-50%,-50%);
    width:1300px; max-width:98vw; height:780px;
    background:white; border-radius:10px;
    box-shadow:0 10px 50px rgba(0,0,0,0.3);
    z-index:1000; overflow:hidden;
}
.chulgo-modal.active {
    display:flex;
    flex-direction:column;
}

.chulgo-modal .modal-header {
    display:flex; justify-content:space-between; align-items:center;
    padding:14px 20px;
    background:linear-gradient(135deg,#2c3e50,#34495e);
    color:white; cursor:move; flex-shrink:0;
}
.chulgo-modal .modal-header h2 { margin:0; font-size:18px; font-weight:700; }

.modal-close-btn {
    background:none; border:none; color:white;
    font-size:26px; cursor:pointer; border-radius:4px;
    transition:all 0.3s;
}
.modal-close-btn:hover { background:rgba(255,255,255,0.2); transform:rotate(90deg); }

.modal-search {
    display:flex; align-items:center; gap:8px;
    padding:8px 15px; background:#f5f7fa;
    border-bottom:1px solid #dee2e6; flex-shrink:0;
    flex-wrap:wrap;
}
.modal-search label {
    font-size:12px; font-weight:bold; color:#333;
}
.modal-search input {
    height:27px; padding:0 8px; font-size:12px;
    border:1px solid #ccc; border-radius:4px;
    background:#fff; outline:none;
    transition:border 0.3s ease;
}
.modal-search input:focus { border:1px solid #007bff; }

.chulgo-modal .modal-body {
    flex:1;
    overflow:hidden;
    padding:10px 15px;
    min-height:0;
}

.modal-footer {
    display:flex; justify-content:center; align-items:center;
    gap:8px; padding:12px 20px;
    background:white; border-top:1px solid #dee2e6; flex-shrink:0;
}
.modal-footer button {
    min-width:90px; height:36px; border:none;
    border-radius:5px; font-size:13px; font-weight:700;
    cursor:pointer; transition:all 0.3s;
}
.btn-save   { background:linear-gradient(135deg,#51cf66,#37b24d); color:white; }
.btn-save:hover { background:linear-gradient(135deg,#40c057,#2f9e44); transform:translateY(-2px); }
.btn-cancel { background:linear-gradient(135deg,#868e96,#495057); color:white; }
.btn-cancel:hover { background:linear-gradient(135deg,#6c757d,#343a40); transform:translateY(-2px); }
.btn-delete { background:linear-gradient(135deg,#ff6b6b,#fa5252); color:white; }
.btn-delete:hover { background:linear-gradient(135deg,#f03e3e,#e03131); transform:translateY(-2px); }

.modal-overlay {
    display:none; position:fixed;
    top:0; left:0; width:100%; height:100%;
    background:rgba(0,0,0,0.5); z-index:999;
}
.modal-overlay.active { display:block; }
</style>
</head>
<body>

<div class="tab">
    <div class="box1">
        <div class="search-bar">
            <label>출고일</label>
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
        <button class="insert-button">
            <img src="/mibogear/image/insert-icon.png" class="button-image">추가
        </button>
        <button class="excel-button">
            <img src="/mibogear/image/excel-icon.png" class="button-image">엑셀
        </button>
    </div>
</div>

<main class="main">
    <div class="container">
        <div id="tab1" class="tabulator"></div>
    </div>
</main>

<!-- 오버레이 -->
<div class="modal-overlay" id="chulgoOverlay"></div>

<!-- 출고등록 모달 -->
<div class="chulgo-modal" id="chulgoModal">
    <div class="modal-header" id="chulgoModalHeader">
        <h2 id="chulgoModalTitle">출고 등록</h2>
        <button type="button" class="modal-close-btn" id="chulgoModalClose">&times;</button>
    </div>

    <div class="modal-search">
        <label>입고일</label>
        <input type="text" id="m_sdate" class="datetimepicker_date" style="width:90px;">
        <span>~</span>
        <input type="text" id="m_edate" class="datetimepicker_date" style="width:90px;">
        <label>거래처</label>
        <input type="text" id="m_corp_name" style="width:90px;">
        <label>품명</label>
        <input type="text" id="m_prod_name" style="width:90px;">
        <label>출고일</label>
        <input type="text" id="m_och_date" class="datetimepicker_date" style="width:90px;">
        <button onclick="searchIpgoForChulgo();"
            style="height:27px; padding:0 12px; background:#4dabf7; color:white;
                   border:none; border-radius:4px; cursor:pointer; font-size:12px; font-weight:bold;">
            조회
        </button>
    </div>

    <div class="modal-body">
        <div id="chulgoAddTab" style="height:100%;"></div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn-save" onclick="saveChulgo();">저장</button>
        <button type="button" class="btn-cancel" id="chulgoModalCancel">닫기</button>
    </div>
</div>

<script>
let now_page_code = "g02";
var chulgoTable;
var chulgoAddTable;

$(function(){
    const today = todayDate();
    const yester = yesterDate();
    $("#sdate").val(yester);
    $("#edate").val(today);
    $("#m_sdate").val(yester);
    $("#m_edate").val(today);
    $("#m_och_date").val(today);

    // ★ 날짜 달력 초기화
    $(".datetimepicker_date").datepicker({
        language: 'ko',
        autoClose: true,
        dateFormat: 'yyyy-mm-dd',
        zIndex: 1200
    });

    getChulgoList();

    $("#chulgoModalClose, #chulgoModalCancel").on("click", closeChulgoModal);

    // ★ 검색 input 엔터키 조회 연결
    $("#sdate, #edate, #s_corp_name, #s_prod_name, #s_prod_no").on("keydown", function(e){
        if(e.keyCode === 13) loadChulgoData();
    });
});

// ===== 드래그 =====
let isDragging = false, startX, startY, mLeft, mTop;
$("#chulgoModalHeader").on("mousedown", function(e){
    if($(e.target).hasClass("modal-close-btn")) return;
    isDragging = true;
    const offset = $("#chulgoModal").offset();
    startX = e.pageX; startY = e.pageY;
    mLeft = offset.left; mTop = offset.top;
    $("#chulgoModal").css("transform","none");
    e.preventDefault();
});
$(document).on("mousemove", function(e){
    if(isDragging) $("#chulgoModal").css({ left:(mLeft+e.pageX-startX)+"px", top:(mTop+e.pageY-startY)+"px" });
}).on("mouseup", function(){ isDragging = false; });

// ===== 출고 리스트 테이블 생성 =====
function getChulgoList(){
    if(chulgoTable){ chulgoTable.destroy(); chulgoTable = null; }
    $("#tab1").empty();

    chulgoTable = new Tabulator("#tab1", {
        height:"715px",
        layout:"fitColumns",
        headerSort:false,
        movableColumns:true,
        selectable:true,
        headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.",
        columns:[
            {title:"NO",       field:"idx",       width:50,  hozAlign:"center"},
            {title:"출고코드", field:"och_code",  width:110, hozAlign:"center"},
            {title:"입고코드", field:"ord_code",  width:110, hozAlign:"center"},
            {title:"출고일",   field:"och_date",  width:100, hozAlign:"center"},
            {title:"거래처",   field:"corp_name", width:130, hozAlign:"center", headerFilter:"input"},
            {title:"품명",     field:"prod_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"품번",     field:"prod_no",   width:120, hozAlign:"center", headerFilter:"input"},
            {title:"규격",     field:"prod_gyu",  width:90,  hozAlign:"center"},
            {title:"재질",     field:"prod_jai",  width:80,  hozAlign:"center"},
            {title:"공정",     field:"tech_no",   width:80,  hozAlign:"center"},
            {title:"단위",     field:"och_danw",  width:60,  hozAlign:"center"},
            {title:"출고수량", field:"och_su",    width:80,  hozAlign:"center", editor:"input"},
            {title:"출고중량", field:"och_amnt",  width:80,  hozAlign:"center", editor:"input"},
            {title:"단가",     field:"och_dang",  width:70,  hozAlign:"center", editor:"input"},
            {title:"금액",     field:"och_mon",   width:90,  hozAlign:"center", editor:"input"},
            {title:"LOT",      field:"och_lot",   width:100, hozAlign:"center"},
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#fff";
        },
        rowClick:function(e, row){
            $("#tab1 div.row_select").removeClass("row_select");
            row.getElement().classList.add("row_select");
        },
        cellEdited:function(cell){
            const field   = cell.getField();
            const rowData = cell.getRow().getData();

            if(field === "och_su"){
                const su   = parseFloat(cell.getValue()) || 0;
                const dang = parseFloat(rowData.och_dang) || 0;
                cell.getRow().getCell("och_mon").setValue((su * dang).toFixed(0));
            }
            if(field === "och_dang"){
                const su   = parseFloat(rowData.och_su)  || 0;
                const dang = parseFloat(cell.getValue())  || 0;
                cell.getRow().getCell("och_mon").setValue((su * dang).toFixed(0));
            }

            const latest = cell.getRow().getData();

            $.ajax({
                url:"/mibogear/productionManagement/chulgo/updateChulgo",
                type:"POST",
                dataType:"json",
                data:{
                    och_code: latest.och_code,
                    och_date: latest.och_date,
                    och_su:   latest.och_su,
                    och_amnt: latest.och_amnt,
                    och_dang: latest.och_dang,
                    och_mon:  latest.och_mon,
                    och_lot:  latest.och_lot
                },
                success:function(result){
                    if(result.status !== "success"){
                        alert("저장 실패: " + result.message);
                        loadChulgoData();
                    }
                },
                error:function(){
                    alert("저장 오류");
                    loadChulgoData();
                }
            });
        },
        tableBuilt:function(){
            loadChulgoData();
        }
    });
}

// ===== 데이터 로드 (검색조건 반영) =====
function loadChulgoData(){
    $.ajax({
        url:"/mibogear/productionManagement/chulgo/getChulgoList",
        type:"POST",
        dataType:"json",
        data:{
            sdate:    $("#sdate").val(),
            edate:    $("#edate").val(),
            corp_name:$("#s_corp_name").val(),
            prod_name:$("#s_prod_name").val(),
            prod_no:  $("#s_prod_no").val()
        },
        success:function(result){
            if(chulgoTable){
                chulgoTable.setData(result.data ? result.data : result);
            }
        },
        error:function(){
            alert("조회 오류");
        }
    });
}

// ===== 조회 버튼 =====
$(".select-button").on("click", function(){
    if(chulgoTable){
        loadChulgoData();
    } else {
        getChulgoList();
    }
});

// ===== 추가 버튼 =====
$(".insert-button").on("click", function(){
    $("#chulgoModalTitle").text("출고 등록");
    openChulgoModal();
    setTimeout(function(){
        searchIpgoForChulgo();
    }, 100);
});

function openChulgoModal(){
    $("#chulgoModal").css({"left":"50%","top":"50%","transform":"translate(-50%,-50%)"});
    $("#chulgoOverlay").addClass("active");
    $("#chulgoModal").addClass("active");
    // ★ 모달 내 날짜 달력 재초기화
    $(".datetimepicker_date").datepicker({
        language: 'ko',
        autoClose: true,
        dateFormat: 'yyyy-mm-dd',
        zIndex: 1200
    });
}
function closeChulgoModal(){
    $("#chulgoOverlay").removeClass("active");
    $("#chulgoModal").removeClass("active");
    if(chulgoAddTable){ chulgoAddTable.destroy(); chulgoAddTable = null; }
    $("#chulgoAddTab").empty();
}

// ===== 모달 내 입고리스트 조회 =====
function searchIpgoForChulgo(){
    if(chulgoAddTable){ chulgoAddTable.destroy(); chulgoAddTable = null; }
    $("#chulgoAddTab").empty();

    chulgoAddTable = new Tabulator("#chulgoAddTab", {
        height:"100%",
        layout:"fitColumns",
        headerSort:false,
        selectable:true,
        headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.",
        ajaxConfig:"POST",
        ajaxURL:"/mibogear/productionManagement/chulgo/getIpgoForChulgo",
        ajaxParams:{
            sdate:    $("#m_sdate").val(),
            edate:    $("#m_edate").val(),
            corp_name:$("#m_corp_name").val(),
            prod_name:$("#m_prod_name").val()
        },
        ajaxResponse:function(url, params, response){
            return response.data ? response.data : response;
        },
        columns:[
            {formatter:"rowSelection", titleFormatter:"rowSelection", width:40, headerSort:false,
                cellClick:function(e, cell){ cell.getRow().toggleSelect(); }
            },
            {title:"입고코드", field:"ord_code",  width:110, hozAlign:"center"},
            {title:"입고일",   field:"ord_date",  width:100, hozAlign:"center"},
            {title:"거래처",   field:"corp_name", width:130, hozAlign:"center", headerFilter:"input"},
            {title:"품명",     field:"prod_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"품번",     field:"prod_no",   width:120, hozAlign:"center", headerFilter:"input"},
            {title:"규격",     field:"prod_gyu",  width:90,  hozAlign:"center"},
            {title:"재질",     field:"prod_jai",  width:80,  hozAlign:"center"},
            {title:"공정",     field:"tech_no",   width:80,  hozAlign:"center"},
            {title:"단위",     field:"ord_danw",  width:60,  hozAlign:"center"},
            {title:"입고수량", field:"ord_su",    width:80,  hozAlign:"center"},
            {title:"입고중량", field:"ord_amnt",  width:80,  hozAlign:"center"},
            {title:"출고누계", field:"chulgo_su", width:80,  hozAlign:"center"},
            {title:"잔량",     field:"jan_su",    width:80,  hozAlign:"center",
                formatter:function(cell){
                    const val = cell.getValue();
                    const el  = cell.getElement();
                    if(val != null && parseFloat(val) <= 0){
                        el.style.color = "#e03131";
                        el.style.fontWeight = "bold";
                    }
                    return val;
                }
            },
            {title:"출고수량", field:"och_su",   width:80,  hozAlign:"center", editor:"input"},
            {title:"출고중량", field:"och_amnt", width:80,  hozAlign:"center", editor:"input"},
            {title:"단가",     field:"och_dang", width:70,  hozAlign:"center", editor:"input"},
            {title:"LOT",      field:"och_lot",  width:100, hozAlign:"center", editor:"input"},
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#fff";
        },
        cellEdited:function(cell){
            if(cell.getField() === "och_su"){
                const rowData = cell.getRow().getData();
                const danj = parseFloat(rowData.ord_danj) || 0;
                const su   = parseFloat(cell.getValue())  || 0;
                if(danj > 0){
                    cell.getRow().getCell("och_amnt").setValue((su * danj).toFixed(2));
                }
            }
        }
    });
}

// ===== 저장 =====
function saveChulgo(){
    if(!chulgoAddTable){ alert("먼저 조회하세요."); return; }

    const selected = chulgoAddTable.getSelectedData();
    if(selected.length === 0){ alert("출고할 항목을 선택하세요."); return; }

    for(let i=0; i<selected.length; i++){
        if(!selected[i].och_su || parseFloat(selected[i].och_su) <= 0){
            alert((i+1)+"번째 항목의 출고수량을 입력하세요."); return;
        }
    }

    const ochDate = $("#m_och_date").val();
    if(!ochDate){ alert("출고일을 입력하세요."); return; }

    if(!confirm("저장하시겠습니까?")) return;

    $.ajax({
        url:"/mibogear/productionManagement/chulgo/saveChulgo",
        type:"POST",
        contentType:"application/json",
        dataType:"json",
        data: JSON.stringify({ chulgoList: selected, ochDate: ochDate }),
        success:function(result){
            if(result.status === "success"){
                closeChulgoModal();
                loadChulgoData();
                setTimeout(function(){ alert("저장되었습니다."); }, 200);
            } else { alert("저장 실패: " + result.message); }
        },
        error:function(){ alert("저장 오류"); }
    });
}

// ===== 엑셀 =====
$(".excel-button").on("click", function(){
    if(!chulgoTable){ alert("먼저 조회하세요."); return; }
    const today = new Date().toISOString().slice(0,10).replace(/-/g,"");
    chulgoTable.download("xlsx", "출고관리_"+today+".xlsx", { sheetName:"출고관리" });
});
</script>
</body>
</html>