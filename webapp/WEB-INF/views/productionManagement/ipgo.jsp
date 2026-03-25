<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>입고관리</title>
    <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>
<style>
.main { width:100%; }
.container { display:flex; justify-content:flex-start; }

/* ★ box1 오버라이드 - 전역 스타일 충돌 방지 */
.box1 {
    display:flex !important;
    justify-content:flex-start !important;
    align-items:center !important;
    width:auto !important;
    margin-left:0 !important;
}

/* 검색바 */
.search-bar {
    display:flex; align-items:center; gap:8px;
    padding:5px 8px; flex-wrap:wrap;
}
.search-bar label {
    font-size:13px; font-weight:bold;
    white-space:nowrap; color:black;
    margin-right:4px;
}
.search-bar input, .search-bar select {
    height:29px;
    padding:5px 8px;
    font-size:13px;
    border:1px solid #ccc;
    border-radius:6px;
    background-color:#f9f9f9;
    color:#333;
    outline:none;
    transition:border 0.3s ease;
}
.search-bar input:focus, .search-bar select:focus {
    border:1px solid #007bff;
    background-color:#fff;
}

/* 모달 오버레이 */
.modal-overlay {
    display:none; position:fixed;
    top:0; left:0; width:100%; height:100%;
    background:rgba(0,0,0,0.5); z-index:999;
}
.modal-overlay.active { display:block; }

#prodSearchModal.modal-overlay {
    display:flex; align-items:center; justify-content:center; z-index:1100;
    background:rgba(0,0,0,0.6);
}
#prodSearchModal .modal-content {
    background:white; padding:20px; border-radius:8px;
    width:90%; max-width:1000px; position:relative; z-index:1101;
    box-shadow:0 10px 60px rgba(0,0,0,0.5);
}
#prodSearchModal .modal-header {
    display:flex; justify-content:space-between; align-items:center;
    font-weight:bold; font-size:18px;
    margin-bottom:15px; padding-bottom:10px;
    border-bottom:2px solid #e9ecef;
}
#prodSearchModal .modal-close { cursor:pointer; font-size:24px; color:#495057; }
#prodSearchModal .modal-close:hover { color:#dc3545; }
/* Air Datepicker 달력 z-index 강제 적용 */
.datepicker {
    z-index: 1300 !important;
}
.datepicker-global-container {
    z-index: 1300 !important;
}
/* 입고등록 모달 */
.ipgo-modal {
    display:none; position:fixed;
    top:50%; left:50%;
    transform:translate(-50%,-50%);
    width:600px; max-width:95vw; max-height:90vh;
    background:white; border-radius:10px;
    box-shadow:0 10px 50px rgba(0,0,0,0.3);
    z-index:1000; overflow:hidden;
}
.ipgo-modal.active { display:flex; flex-direction:column; }

.ipgo-modal .modal-header {
    display:flex; justify-content:space-between; align-items:center;
    padding:14px 20px;
    background:linear-gradient(135deg,#2c3e50,#34495e);
    color:white; cursor:move; flex-shrink:0;
}
.ipgo-modal .modal-header h2 { margin:0; font-size:18px; font-weight:700; }
.modal-close-btn {
    background:none; border:none; color:white;
    font-size:26px; cursor:pointer; border-radius:4px;
    transition:all 0.3s;
}
.modal-close-btn:hover { background:rgba(255,255,255,0.2); transform:rotate(90deg); }

.ipgo-modal .modal-body {
    flex:1; overflow-y:auto; background:#f5f7fa; padding:15px;
}

/* 섹션 */
.field-section {
    background:white; border-radius:8px;
    padding:12px 15px; margin-bottom:10px;
    box-shadow:0 2px 4px rgba(0,0,0,0.05);
}
.section-title {
    margin:0 0 10px 0; font-size:13px; font-weight:700;
    color:#2c3e50; padding-bottom:6px;
    border-bottom:2px solid #e9ecef;
}

/* 필드 */
.field-row {
    display:grid; grid-template-columns:repeat(2,1fr);
    gap:8px; margin-bottom:8px;
}
.field-row:last-child { margin-bottom:0; }
.field-col { display:flex; flex-direction:column; gap:3px; }
.field-col-full { grid-column:1/-1; display:flex; flex-direction:column; gap:3px; }
.field-col label, .field-col-full label {
    font-size:11px; font-weight:600; color:#495057;
}
.field-col input, .field-col select,
.field-col-full input {
    width:100%; padding:5px 8px;
    border:1px solid #ced4da; border-radius:4px;
    font-size:12px; box-sizing:border-box;
    background-color:#f9f9f9; color:#333;
    outline:none; transition:border 0.3s ease;
}
.field-col input:focus, .field-col select:focus,
.field-col-full input:focus {
    border:1px solid #007bff;
    background-color:#fff;
}
.field-col input:read-only,
.field-col-full input:read-only {
    background:#f0f0f0;
    color:#666;
    cursor:default;
}

/* 제품선택 버튼 */
.input-with-btn { display:flex; gap:4px; }
.input-with-btn input { flex:1; }
.btn-search {
    padding:5px 10px; border:none; border-radius:4px;
    background:#4dabf7; color:white;
    font-size:11px; font-weight:600; cursor:pointer; white-space:nowrap;
    transition:background 0.3s ease;
}
.btn-search:hover { background:#339af0; }

/* 푸터 버튼 */
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
.btn-save    { background:linear-gradient(135deg,#51cf66,#37b24d); color:white; }
.btn-save:hover { background:linear-gradient(135deg,#40c057,#2f9e44); transform:translateY(-2px); }
.btn-delete  { background:linear-gradient(135deg,#ff6b6b,#fa5252); color:white; }
.btn-delete:hover { background:linear-gradient(135deg,#f03e3e,#e03131); transform:translateY(-2px); }
.btn-cancel  { background:linear-gradient(135deg,#868e96,#495057); color:white; }
.btn-cancel:hover { background:linear-gradient(135deg,#6c757d,#343a40); transform:translateY(-2px); }
</style>
</head>
<body>

<div class="tab">
    <div class="box1">
        <div class="search-bar">
            <label>입고일</label>
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

<!-- 입고등록/수정 모달 -->
<div class="modal-overlay" id="ipgoOverlay"></div>
<div class="ipgo-modal" id="ipgoModal">
    <div class="modal-header" id="ipgoModalHeader">
        <h2 id="modalTitle">입고 등록</h2>
        <button type="button" class="modal-close-btn" id="ipgoModalClose">&times;</button>
    </div>
    <div class="modal-body">

        <!-- 제품 정보 (읽기전용) -->
        <div class="field-section">
            <h3 class="section-title">제품 정보</h3>
            <div class="field-row">
                <div class="field-col">
                    <label>제품 선택</label>
                    <div class="input-with-btn">
                        <input type="text" id="m_prod_name" readonly placeholder="제품명">
                        <button type="button" class="btn-search" onclick="openProdSearchModal();">검색</button>
                    </div>
                </div>
                <div class="field-col">
                    <label>거래처명</label>
                    <input type="text" id="m_corp_name" readonly>
                </div>
            </div>
            <div class="field-row">
                <div class="field-col">
                    <label>품번</label>
                    <input type="text" id="m_prod_no" readonly>
                </div>
                <div class="field-col">
                    <label>규격</label>
                    <input type="text" id="m_prod_gyu" readonly>
                </div>
            </div>
            <div class="field-row">
                <div class="field-col">
                    <label>재질</label>
                    <input type="text" id="m_prod_jai" readonly>
                </div>
                <div class="field-col">
                    <label>공정</label>
                    <input type="text" id="m_tech_no" readonly>
                </div>
            </div>
            <input type="hidden" id="m_prod_code">
        </div>

        <!-- 입고 정보 -->
        <div class="field-section">
            <h3 class="section-title">입고 정보</h3>
            <div class="field-row">
                <div class="field-col">
                    <label>입고일</label>
                    <input type="text" id="m_ord_date" class="datetimepicker_date">
                </div>
                <div class="field-col">
                    <label>입고수량</label>
                    <input type="number" id="m_ord_su" placeholder="0">
                </div>
            </div>
            <div class="field-row">
                <div class="field-col">
                    <label>박스수량</label>
                    <input type="text" id="m_ord_boxsu" placeholder="0">
                </div>
                <div class="field-col">
                    <label>단위</label>
                    <select id="m_ord_danw">
                        <option value="EA">EA</option>
                        <option value="KG">KG</option>
                        <option value="CH">CH</option>
                    </select>
                </div>
            </div>
            <div class="field-row">
                <div class="field-col">
                    <label>단중(kg)</label>
                    <input type="number" id="m_ord_danj" step="0.01" placeholder="0">
                </div>
                <div class="field-col">
                    <label>중량(kg)</label>
                    <input type="number" id="m_ord_amnt" readonly step="0.01" placeholder="자동계산">
                </div>
            </div>
            <!-- <div class="field-row">
                <div class="field-col-full">
                    <label>입고/타각 LOT</label>
                    <input type="text" id="m_ord_lot" placeholder="LOT 번호">
                </div>
            </div> -->
        </div>

    </div>
    <div class="modal-footer">
        <button type="button" class="btn-delete" id="btnDelete" onclick="deleteIpgo();" style="display:none;">삭제</button>
        <button type="button" class="btn-save" onclick="saveIpgo();">저장</button>
        <button type="button" class="btn-cancel" id="btnCancel">닫기</button>
    </div>
</div>

<!-- 제품 검색 모달 -->
<div id="prodSearchModal" class="modal-overlay" style="display:none;">
    <div class="modal-content">
        <div class="modal-header">
            <span>제품 검색</span>
            <span class="modal-close" onclick="closeProdSearchModal()">&times;</span>
        </div>
        <div style="display:flex; gap:6px; padding:8px 0; align-items:center;">
            <label style="font-size:12px; font-weight:bold;">품명</label>
            <input type="text" id="ps_prod_name" style="height:26px; padding:0 6px; border:1px solid #aaa; border-radius:3px; font-size:12px; width:120px;">
            <label style="font-size:12px; font-weight:bold;">거래처</label>
            <input type="text" id="ps_corp_name" style="height:26px; padding:0 6px; border:1px solid #aaa; border-radius:3px; font-size:12px; width:120px;">
            <button onclick="searchProdList();" style="height:26px; padding:0 12px; background:#4dabf7; color:white; border:none; border-radius:3px; cursor:pointer; font-size:12px;">검색</button>
        </div>
        <div id="prodSearchTabulator" style="height:450px;"></div>
    </div>
</div>

<script>
let now_page_code = "g01";
var ipgoTable;
var isEditMode = false;
var selectedOrdCode = null;
var prodSearchTable = null;

$(function(){
    const today = todayDate();
    const yester = yesterDate();
    $("#sdate").val(yester);
    $("#edate").val(today);
    $("#m_ord_date").val(today);

    // ★ 날짜 달력 직접 초기화 (daySet 클래스 기반)
    $(".datetimepicker_date").datepicker({
        language: 'ko',
        autoClose: true,
        dateFormat: 'yyyy-mm-dd',
        zIndex: 1200
    });

    getIpgoList();

    // 수량/단중 변경 시 중량 자동계산
    $("#m_ord_su, #m_ord_danj").on("input", function(){
        const su   = parseFloat($("#m_ord_su").val())   || 0;
        const danj = parseFloat($("#m_ord_danj").val()) || 0;
        $("#m_ord_amnt").val((su * danj).toFixed(2));
    });

    $("#ipgoModalClose, #btnCancel").on("click", closeIpgoModal);

    // 검색 input 엔터키 조회 연결
    $("#sdate, #edate, #s_corp_name, #s_prod_name, #s_prod_no").on("keydown", function(e){
        if(e.keyCode === 13) loadIpgoData();
    });
});

// ===== 드래그 =====
let isDragging = false, startX, startY, mLeft, mTop;
$("#ipgoModalHeader").on("mousedown", function(e){
    if($(e.target).hasClass("modal-close-btn")) return;
    isDragging = true;
    const offset = $("#ipgoModal").offset();
    startX = e.pageX; startY = e.pageY;
    mLeft = offset.left; mTop = offset.top;
    $("#ipgoModal").css("transform","none");
    e.preventDefault();
});
$(document).on("mousemove", function(e){
    if(isDragging) $("#ipgoModal").css({ left:(mLeft+e.pageX-startX)+"px", top:(mTop+e.pageY-startY)+"px" });
}).on("mouseup", function(){ isDragging = false; });

// ===== 리스트 테이블 생성 =====
function getIpgoList(){
    if(ipgoTable){ ipgoTable.destroy(); ipgoTable = null; }
    $("#tab1").empty();

    ipgoTable = new Tabulator("#tab1", {
        height:"715px",
        layout:"fitColumns",
        selectable:true,
        headerSort:false,
        headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.",
        columns:[
            {title:"NO",       field:"idx",       width:50,  hozAlign:"center"},
            {title:"입고코드", field:"ord_code",  width:110, hozAlign:"center"},
            {title:"입고일",   field:"ord_date",  width:100, hozAlign:"center"},
            {title:"거래처",   field:"corp_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"품명",     field:"prod_name", width:170, hozAlign:"center", headerFilter:"input"},
            {title:"품번",     field:"prod_no",   width:150, hozAlign:"center", headerFilter:"input"},
            {title:"규격",     field:"prod_gyu",  width:110, hozAlign:"center"},
            {title:"재질",     field:"prod_jai",  width:90,  hozAlign:"center"},
            {title:"공정",     field:"tech_no",   width:90,  hozAlign:"center"},
            {title:"단위",     field:"ord_danw",  width:70,  hozAlign:"center"},
            {title:"박스수량", field:"ord_boxsu", width:90,  hozAlign:"center"},
            {title:"단중",     field:"ord_danj",  width:80,  hozAlign:"center"},
            {title:"입고수량",     field:"ord_su",    width:80,  hozAlign:"center"},
            {title:"중량(kg)", field:"ord_amnt",  width:90,  hozAlign:"center"},
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#fff";
        },
        rowClick:function(e, row){
            $("#tab1 div.row_select").removeClass("row_select");
            row.getElement().classList.add("row_select");
        },
        rowDblClick:function(e, row){
            openEditModal(row.getData());
        },
        tableBuilt:function(){
            loadIpgoData();
        }
    });
}

// ===== 데이터 로드 (검색조건 반영) =====
function loadIpgoData(){
    $.ajax({
        url:"/mibogear/productionManagement/ipgo/getIpgoList",
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
            if(ipgoTable){
                ipgoTable.setData(result.data ? result.data : result);
            }
        },
        error:function(){
            alert("조회 오류");
        }
    });
}

// ===== 추가 버튼 =====
$(".insert-button").on("click", function(){
    isEditMode = false;
    selectedOrdCode = null;
    clearModal();
    $("#modalTitle").text("입고 등록");
    $("#btnDelete").hide();
    $("#m_ord_date").val(todayDate());
    openIpgoModal();
});

function openIpgoModal(){
    $("#ipgoModal").css({"left":"50%","top":"50%","transform":"translate(-50%,-50%)"});
    $("#ipgoOverlay").addClass("active");
    $("#ipgoModal").addClass("active");
    // ★ 모달 내 날짜 input 달력 재초기화
    $("#m_ord_date").datepicker({
        language: 'ko',
        autoClose: true,
        dateFormat: 'yyyy-mm-dd',
        zIndex: 1200
    });
}
function closeIpgoModal(){
    $("#ipgoOverlay").removeClass("active");
    $("#ipgoModal").removeClass("active");
}
function clearModal(){
    $("#m_prod_code,#m_prod_name,#m_corp_name,#m_prod_no,#m_prod_gyu,#m_prod_jai,#m_tech_no").val("");
    $("#m_ord_date,#m_ord_su,#m_ord_boxsu,#m_ord_danj,#m_ord_amnt,#m_ord_lot").val("");
    $("#m_ord_danw").val("EA");
}

// ===== 더블클릭 수정 =====
function openEditModal(data){
    isEditMode = true;
    selectedOrdCode = data.ord_code;
    $("#modalTitle").text("입고 수정");
    $("#btnDelete").show();

    $("#m_prod_code").val(data.prod_code);
    $("#m_prod_name").val(data.prod_name);
    $("#m_corp_name").val(data.corp_name);
    $("#m_prod_no").val(data.prod_no);
    $("#m_prod_gyu").val(data.prod_gyu);
    $("#m_prod_jai").val(data.prod_jai);
    $("#m_tech_no").val(data.tech_no);
    $("#m_ord_date").val(data.ord_date ? data.ord_date.substring(0,10) : "");
    $("#m_ord_su").val(data.ord_su);
    $("#m_ord_boxsu").val(data.ord_boxsu);
    $("#m_ord_danw").val(data.ord_danw);
    $("#m_ord_danj").val(data.ord_danj);
    $("#m_ord_amnt").val(data.ord_amnt);
    $("#m_ord_lot").val(data.ord_lot);

    openIpgoModal();
}

// ===== 저장 =====
function saveIpgo(){
    if(!$("#m_prod_code").val()){ alert("제품을 선택하세요."); return; }
    if(!$("#m_ord_date").val()){  alert("입고일을 입력하세요."); return; }
    if(!$("#m_ord_su").val()){    alert("수량을 입력하세요."); return; }
    if(!confirm(isEditMode ? "수정하시겠습니까?" : "저장하시겠습니까?")) return;

    const params = {
        mode:      isEditMode ? "update" : "insert",
        ord_code:  selectedOrdCode || "",
        prod_code: $("#m_prod_code").val(),
        ord_date:  $("#m_ord_date").val(),
        ord_su:    $("#m_ord_su").val(),
        ord_boxsu: $("#m_ord_boxsu").val(),
        ord_danw:  $("#m_ord_danw").val(),
        ord_danj:  $("#m_ord_danj").val(),
        ord_amnt:  $("#m_ord_amnt").val(),
        ord_lot:   $("#m_ord_lot").val()
    };

    $.ajax({
        url:"/mibogear/productionManagement/ipgo/saveIpgo",
        type:"POST", data:params, dataType:"json",
        success:function(result){
            if(result.status === "success"){
                closeIpgoModal();
                loadIpgoData();
                setTimeout(function(){ alert("저장되었습니다."); }, 200);
            } else { alert("저장 실패: " + result.message); }
        },
        error:function(){ alert("저장 오류"); }
    });
}

// ===== 삭제 =====
function deleteIpgo(){
    if(!selectedOrdCode){ alert("삭제 대상이 없습니다."); return; }
    if(!confirm("삭제하시겠습니까?")) return;

    $.ajax({
        url:"/mibogear/productionManagement/ipgo/deleteIpgo",
        type:"POST", data:{ ord_code: selectedOrdCode }, dataType:"json",
        success:function(result){
            if(result.status === "success"){
                closeIpgoModal();
                loadIpgoData();
                setTimeout(function(){ alert("삭제되었습니다."); }, 200);
            } else { alert("삭제 실패: " + result.message); }
        },
        error:function(){ alert("삭제 오류"); }
    });
}

// ===== 제품 검색 모달 =====
function openProdSearchModal(){
    document.getElementById("prodSearchModal").style.display = "flex";
    searchProdList();
}
function closeProdSearchModal(){
    document.getElementById("prodSearchModal").style.display = "none";
}
function searchProdList(){
    if(prodSearchTable){ prodSearchTable.destroy(); prodSearchTable = null; }
    prodSearchTable = new Tabulator("#prodSearchTabulator", {
        height:"400px", layout:"fitColumns", selectable:true,
        ajaxURL:"/mibogear/standardManagement/productInsert/productList",
        ajaxConfig:"POST",
        ajaxParams:{
            prod_name: $("#ps_prod_name").val(),
            corp_name: $("#ps_corp_name").val()
        },
        ajaxResponse:function(url, params, response){ return response.data ? response.data : response; },
        columns:[
            {title:"거래처",  field:"corp_name", width:130, hozAlign:"center", headerFilter:"input"},
            {title:"품명",    field:"prod_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"품번",    field:"prod_no",   width:120, hozAlign:"center", headerFilter:"input"},
            {title:"규격",    field:"prod_gyu",  width:100, hozAlign:"center"},
            {title:"재질",    field:"prod_jai",  width:80,  hozAlign:"center"},
            {title:"공정",    field:"tech_no",   width:80,  hozAlign:"center"},
            {title:"제품코드",field:"prod_code", width:80,  hozAlign:"center", visible:false}
        ],
        rowDblClick:function(e, row){
            const d = row.getData();
            $("#m_prod_code").val(d.prod_code);
            $("#m_prod_name").val(d.prod_name);
            $("#m_corp_name").val(d.corp_name);
            $("#m_prod_no").val(d.prod_no);
            $("#m_prod_gyu").val(d.prod_gyu);
            $("#m_prod_jai").val(d.prod_jai);
            $("#m_tech_no").val(d.tech_no);
            closeProdSearchModal();
        }
    });
}

// ===== 조회 버튼 =====
$(".select-button").on("click", function(){
    if(ipgoTable){
        loadIpgoData();
    } else {
        getIpgoList();
    }
});

// ===== 엑셀 =====
$(".excel-button").on("click", function(){
    if(!ipgoTable){ alert("먼저 조회하세요."); return; }
    const today = new Date().toISOString().slice(0,10).replace(/-/g,"");
    ipgoTable.download("xlsx", "입고관리_"+today+".xlsx", { sheetName:"입고관리" });
});
</script>
</body>
</html>