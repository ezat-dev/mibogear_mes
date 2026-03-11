<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품등록</title>
    <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>
<style>
.main { width: 98%; }
.container { display:flex; justify-content:center; }

/* ========== 모달 오버레이 ========== */
.modal-overlay {
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.5);
    z-index: 999;
}
.modal-overlay.active { display: block; }

#cutumListModal.modal-overlay {
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1100;
    background: rgba(0,0,0,0.6);
}
#cutumListModal .modal-content {
    background: white; padding: 20px;
    border-radius: 8px; width: 90%; max-width: 1000px;
    position: relative; z-index: 1101;
    box-shadow: 0 10px 60px rgba(0,0,0,0.5);
}
#cutumListModal .modal-header {
    display: flex; justify-content: space-between; align-items: center;
    font-weight: bold; font-size: 18px;
    margin-bottom: 15px; padding-bottom: 10px;
    border-bottom: 2px solid #e9ecef;
}
#cutumListModal .modal-close {
    cursor: pointer; font-size: 24px; color: #495057;
}
#cutumListModal .modal-close:hover { color: #dc3545; }

/* ========== 제품 모달 ========== */
.product-modal {
    display: none;
    position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 900px;
    max-width: 95vw;
    max-height: 90vh;
    background: white;
    border-radius: 10px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    z-index: 1000;
    overflow: hidden;
}
.product-modal.active {
    display: flex;
    flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 25px;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white;
    cursor: move;
    flex-shrink: 0;
}
.modal-header h2 { margin:0; font-size:20px; font-weight:700; }
.modal-close-btn {
    background: none; border: none; color: white;
    font-size: 28px; cursor: pointer;
    width: 30px; height: 30px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 4px; transition: all 0.3s;
}
.modal-close-btn:hover {
    background: rgba(255,255,255,0.2);
    transform: rotate(90deg);
}

/* ========== 모달 본문 ========== */
.modal-body {
    flex: 1; overflow-y: auto; overflow-x: hidden;
    background: #f5f7fa; padding: 15px;
}
.modal-body::-webkit-scrollbar { width: 8px; }
.modal-body::-webkit-scrollbar-track { background: #e0e0e0; }
.modal-body::-webkit-scrollbar-thumb { background: #999; border-radius: 4px; }

/* ========== 섹션 ========== */
.field-section {
    background: white; border-radius: 8px;
    padding: 10px 15px; margin-bottom: 10px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}
.section-title {
    margin: 0 0 8px 0; font-size: 14px; font-weight: 700;
    color: #2c3e50; padding-bottom: 6px;
    border-bottom: 2px solid #e9ecef;
}

/* ========== 필드 행/열 ========== */
.field-row {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 8px; margin-bottom: 6px;
}
.field-row:last-child { margin-bottom: 0; }
.field-col { display:flex; flex-direction:column; gap:3px; }
.field-col-full {
    grid-column: 1 / -1;
    display:flex; flex-direction:column; gap:3px;
}
.field-col label, .field-col-full label {
    font-size: 11px; font-weight: 600; color: #495057;
}
.req { color: #dc3545; margin-left: 2px; }

/* ========== 입력 필드 ========== */
.field-col input[type="text"],
.field-col input[type="date"],
.field-col input[type="number"],
.field-col select,
.field-col-full input[type="text"],
.field-col-full textarea {
    width: 100%; padding: 5px 8px;
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 12px; box-sizing: border-box; transition: all 0.3s;
}
.field-col input:focus, .field-col select:focus,
.field-col-full input:focus, .field-col-full textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.field-col select {
    cursor: pointer; appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 8px center;
    padding-right: 26px;
}
textarea {
    resize: vertical; min-height: 40px;
    font-family: inherit; line-height: 1.4;
}

/* ========== 검색 버튼 포함 ========== */
.input-with-btn { display:flex; gap:4px; }
.input-with-btn input { flex:1; }
.btn-search {
    padding: 5px 10px; border: none; border-radius: 4px;
    background: #4dabf7; color: white;
    font-size: 11px; font-weight: 600; cursor: pointer; white-space: nowrap;
}
.btn-search:hover { background: #339af0; }

/* ========== SPEC 그리드 ========== */
.spec-grid {
    display: grid; grid-template-columns: repeat(2, 1fr);
    gap: 8px; margin-bottom: 8px;
}
.spec-item { display:flex; flex-direction:column; gap:3px; }
.spec-item label { font-size:11px; font-weight:600; color:#495057; }
.spec-inputs { display:flex; align-items:center; gap:4px; }
.spec-inputs select {
    width: 70px; padding: 4px 6px;
    border: 1px solid #ced4da; border-radius: 3px;
    font-size: 11px; cursor: pointer;
}
.spec-inputs input {
    width: 55px; padding: 4px 6px;
    border: 1px solid #ced4da; border-radius: 3px; font-size: 11px;
}
.spec-inputs span { font-size:11px; color:#6c757d; }

/* ========== 공정 체크 그리드 ========== */
.process-check-grid {
    display: grid; grid-template-columns: repeat(4, 1fr); gap: 8px;
}
.process-item { display:flex; align-items:center; gap:4px; }
.process-item input[type="checkbox"] { width:16px; height:16px; cursor:pointer; }
.process-item label { font-size:12px; cursor:pointer; margin:0; }

/* ========== 모달 푸터 ========== */
.modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 12px 20px;
    background: white; border-top: 1px solid #dee2e6; flex-shrink: 0;
}
.modal-footer button {
    min-width: 90px; height: 36px; border: none;
    border-radius: 5px; font-size: 13px; font-weight: 700;
    cursor: pointer; transition: all 0.3s;
}
.btn-save { background: linear-gradient(135deg, #51cf66, #37b24d); color: white; }
.btn-save:hover { background: linear-gradient(135deg, #40c057, #2f9e44); transform: translateY(-2px); }
.btn-saveas { background: linear-gradient(135deg, #4dabf7, #339af0); color: white; }
.btn-saveas:hover { background: linear-gradient(135deg, #339af0, #1c7ed6); transform: translateY(-2px); }
.btn-delete { background: linear-gradient(135deg, #ff6b6b, #fa5252); color: white; }
.btn-delete:hover { background: linear-gradient(135deg, #f03e3e, #e03131); transform: translateY(-2px); }
.btn-cancel { background: linear-gradient(135deg, #868e96, #495057); color: white; }
.btn-cancel:hover { background: linear-gradient(135deg, #6c757d, #343a40); transform: translateY(-2px); }
</style>
</head>
<body>

<div class="tab">
    <div class="box1">
        <p class="tabP" style="font-size:20px; margin-left:40px; color:white; font-weight:800;"></p>
    </div>
    <div class="button-container">
        <button class="select-button" onclick="getProductList();">
            <img src="/mibogear/image/search-icon.png" alt="select" class="button-image">조회
        </button>
        <button class="insert-button">
            <img src="/mibogear/image/insert-icon.png" alt="insert" class="button-image">추가
        </button>
        <button class="excel-button">
            <img src="/mibogear/image/excel-icon.png" alt="excel" class="button-image">엑셀
        </button>
    </div>
</div>

<main class="main">
    <div class="container">
        <div id="tab1" class="tabulator"></div>
    </div>
</main>

<form method="post" class="corrForm" id="productInsertForm" name="productInsertForm">

    <div class="modal-overlay"></div>

    <div class="product-modal">
        <div class="modal-header">
            <h2>제품등록</h2>
            <button type="button" class="modal-close-btn">&times;</button>
        </div>

        <div class="modal-body">

            <!-- 기본 정보 -->
            <div class="field-section">
                <h3 class="section-title">기본 정보</h3>
                <div class="field-row">
                    <div class="field-col">
                        <label>거래처</label>
                        <div class="input-with-btn">
                            <input type="text" id="corp_name" name="corp_name" readonly placeholder="거래처명">
                            <input type="hidden" id="corp_code" name="corp_code">
                            <button type="button" class="btn-search" onclick="openCutumModal();">검색</button>
                        </div>
                    </div>
                    <div class="field-col">
                        <label>관리번호</label>
                        <input type="text" id="prod_cno" name="prod_cno" placeholder="관리번호">
                    </div>
                </div>
                <div class="field-row">
                    <div class="field-col">
                        <label>품명 <span class="req">*</span></label>
                        <input type="text" id="prod_name" name="prod_name" placeholder="품명">
                    </div>
                    <div class="field-col">
                        <label>품번</label>
                        <input type="text" id="prod_no" name="prod_no" placeholder="품번">
                    </div>
                    <div class="field-col">
                        <label>모델명</label>
                        <input type="text" id="prod_model" name="prod_model" placeholder="모델명">
                    </div>
                </div>
                <div class="field-row">
                    <div class="field-col">
                        <label>재질</label>
                        <input type="text" id="prod_jai" name="prod_jai" placeholder="재질">
                    </div>
                    <div class="field-col">
                        <label>규격</label>
                        <input type="text" id="prod_gyu" name="prod_gyu" placeholder="규격">
                    </div>
                    <div class="field-col">
                        <label>단중(kg)</label>
                        <input type="text" id="prod_danj" name="prod_danj" placeholder="단중">
                    </div>
                </div>
            </div>

            <!-- 공정 정보 -->
            <div class="field-section">
			    <h3 class="section-title">공정 정보</h3>
			    <div class="field-row">
			        <div class="field-col">
			            <label>공정</label>
			            <input type="text" id="tech_no" name="tech_no" placeholder="공정 입력">
			        </div>
			        <div class="field-col">
			            <label>검사시편</label>
			            <input type="text" id="prod_pad" name="prod_pad" placeholder="검사시편 입력">
			        </div>
			    </div>
			</div>

            <!-- SPEC 정보 -->
            <div class="field-section">
                <h3 class="section-title">SPEC 정보</h3>
                <div class="spec-grid">
                    <div class="spec-item">
                        <label>표면경도</label>
                        <div class="spec-inputs">
                            <select id="prod_pg" name="prod_pg">
                                <option>HRC</option><option>HV</option><option>HS</option>
                                <option>HRA</option><option>HRB</option><option>HB</option>
                            </select>
                            <input type="text" id="prod_pg1" name="prod_pg1" placeholder="MIN">
                            <span>~</span>
                            <input type="text" id="prod_pg2" name="prod_pg2" placeholder="MAX">
                        </div>
                    </div>
                    <div class="spec-item">
                        <label>소입경도</label>
                        <div class="spec-inputs">
                            <select id="prod_si" name="prod_si">
                                <option>HRC</option><option>HV</option><option>HS</option>
                                <option>HRA</option><option>HRB</option><option>HB</option>
                            </select>
                            <input type="text" id="prod_si1" name="prod_si1" placeholder="MIN">
                            <span>~</span>
                            <input type="text" id="prod_si2" name="prod_si2" placeholder="MAX">
                        </div>
                    </div>
                </div>
                <div class="spec-grid">
                    <div class="spec-item">
                        <label>소려경도</label>
                        <div class="spec-inputs">
                            <select id="prod_sr" name="prod_sr">
                                <option>HRC</option><option>HV</option><option>HS</option>
                                <option>HRA</option><option>HRB</option><option>HB</option>
                            </select>
                            <input type="text" id="prod_sr1" name="prod_sr1" placeholder="MIN">
                            <span>~</span>
                            <input type="text" id="prod_sr2" name="prod_sr2" placeholder="MAX">
                        </div>
                    </div>
                    <div class="spec-item">
                        <label>심부경도</label>
                        <div class="spec-inputs">
                            <select id="prod_sg" name="prod_sg">
                                <option>HRC</option><option>HV</option>
                                <option>HRA</option><option>HRB</option><option>HB</option>
                            </select>
                            <input type="text" id="prod_sg1" name="prod_sg1" placeholder="MIN">
                            <span>~</span>
                            <input type="text" id="prod_sg2" name="prod_sg2" placeholder="MAX">
                        </div>
                    </div>
                </div>
            </div>

            <!-- 공정 체크 -->
            <div class="field-section">
                <h3 class="section-title">공정 체크</h3>
                <div class="process-check-grid">
                    <div class="process-item">
                        <input type="checkbox" id="prod_fac1" name="prod_fac1">
                        <label for="prod_fac1">승온</label>
                    </div>
                    <div class="process-item">
                        <input type="checkbox" id="prod_fac2" name="prod_fac2">
                        <label for="prod_fac2">침탄</label>
                    </div>
                    <div class="process-item">
                        <input type="checkbox" id="prod_fac3" name="prod_fac3">
                        <label for="prod_fac3">확산</label>
                    </div>
                    <div class="process-item">
                        <input type="checkbox" id="prod_fac4" name="prod_fac4">
                        <label for="prod_fac4">강온</label>
                    </div>
                    <div class="process-item">
                        <input type="checkbox" id="prod_fac5" name="prod_fac5">
                        <label for="prod_fac5">소입</label>
                    </div>
                    <div class="process-item">
                        <input type="checkbox" id="prod_fac6" name="prod_fac6">
                        <label for="prod_fac6">드레인</label>
                    </div>
                </div>
            </div>

        </div><!-- /modal-body -->

        <div class="modal-footer">
            <button type="button" class="btn-delete" onclick="deleteProduct();" style="display:none;">삭제</button>
            <button type="button" class="btn-save" onclick="save();">저장</button>
            <button type="button" class="btn-saveas" id="btnSaveAs" onclick="saveAsNew();" style="display:none;">다른이름저장</button>
            <button type="button" class="btn-cancel">닫기</button>
        </div>
    </div>

</form>

<!-- 거래처 검색 모달 -->
<div id="cutumListModal" class="modal-overlay" style="display:none;">
    <div class="modal-content">
        <div class="modal-header">
            <span class="modal-title">거래처 리스트</span>
            <span class="modal-close" onclick="closeCutumListModal()">&times;</span>
        </div>
        <div id="cutumListTabulator" style="height:500px;"></div>
    </div>
</div>

<script>
let now_page_code = "f01";
var productTable;
var isEditMode = false;
var selectedRowData = null;

$(function(){
    getProductList();
});

// ========== 모달 열기 (추가) ==========
$('.insert-button').on('click', function() {
    isEditMode = false;
    selectedRowData = null;
    $('#productInsertForm')[0].reset();
    $('.btn-delete, #btnSaveAs').hide();
    $('.product-modal').css({'left':'50%','top':'50%','transform':'translate(-50%,-50%)'});
    $('.modal-overlay, .product-modal').addClass('active');
});

// ========== 모달 닫기 ==========
$('.modal-close-btn, .btn-cancel').on('click', function() {
    $('.modal-overlay, .product-modal').removeClass('active');
});

// ========== 모달 드래그 ==========
let isDragging = false, startX, startY, modalLeft, modalTop;
$('.product-modal .modal-header').on('mousedown', function(e) {
    if($(e.target).hasClass('modal-close-btn') || $(e.target).closest('.modal-close-btn').length) return;
    isDragging = true;
    const modal = $('.product-modal');
    const offset = modal.offset();
    startX = e.pageX; startY = e.pageY;
    modalLeft = offset.left; modalTop = offset.top;
    modal.css('transform','none');
    e.preventDefault();
});
$(document).on('mousemove', function(e) {
    if(isDragging) {
        $('.product-modal').css({
            left: (modalLeft + e.pageX - startX) + 'px',
            top:  (modalTop  + e.pageY - startY) + 'px'
        });
    }
});
$(document).on('mouseup', function() { isDragging = false; });

// ========== 리스트 조회 ==========
function getProductList(){
    if(productTable){ productTable.destroy(); productTable = null; }
    $('#tab1').empty();

    productTable = new Tabulator("#tab1", {
        height:"715px",
        layout:"fitColumns",
        selectable:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/mibogear/standardManagement/productInsert/productList",
        ajaxParams:{},
        placeholder:"조회된 데이터가 없습니다.",
        paginationSize:20,
        ajaxResponse:function(url, params, response){
            return response.data ? response.data : response;
        },
        columns:[
            {title:"NO",     field:"idx",       width:60,  hozAlign:"center"},
            {title:"코드",   field:"prod_code", width:100, hozAlign:"center", visible:false},
            {title:"거래처명",field:"corp_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"품명",   field:"prod_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"품번",   field:"prod_no",   width:120, hozAlign:"center", headerFilter:"input"},
            {title:"규격",   field:"prod_gyu",  width:120, hozAlign:"center", headerFilter:"input"},
            {title:"재질",   field:"prod_jai",  width:100, hozAlign:"center", headerFilter:"input"},
            {title:"공정",   field:"tech_no",   width:100, hozAlign:"center", headerFilter:"input"},
            {title:"단중",   field:"prod_danj", width:80,  hozAlign:"center"},
            {title:"표면경도",field:"prod_pg",  width:100, hozAlign:"center"},
            {title:"심부경도",field:"prod_sg",  width:100, hozAlign:"center"},
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        rowClick:function(e, row){
            $("#tab1 div.row_select").removeClass("row_select");
            row.getElement().classList.add("row_select");
        },
        rowDblClick:function(e, row){
            var data = row.getData();
            selectedRowData = data;
            isEditMode = true;
            productInsertDetail(data.prod_code);
            $('.btn-delete, #btnSaveAs').show();
        }
    });
}

// ========== 상세 조회 ==========
function productInsertDetail(prod_code){
    $.ajax({
        url: "/mibogear/standardManagement/productInsert/productInsertDetail",
        type: "post", dataType: "json",
        data: { "prod_code": prod_code },
        success: function(result){
            const d = result.data;
            $('#productInsertForm')[0].reset();
            for(let key in d){
                if(key.startsWith("prod_fac")){
                    const cb = $("#" + key);
                    if(cb.length) cb.prop("checked", (d[key]||"").includes("1"));
                } else {
                    $("[name='" + key + "']").val(d[key]);
                }
            }
            $('.modal-overlay, .product-modal').addClass('active');
        },
        error: function(){ alert("상세 조회 오류"); }
    });
}

// ========== 거래처 모달 ==========
function openCutumModal(){
    document.getElementById('cutumListModal').style.display = 'flex';
    new Tabulator("#cutumListTabulator", {
        height:"450px", layout:"fitColumns", selectable:true,
        ajaxURL:"/mibogear/standardManagement/cutumInsert/cutumInsertList",
        ajaxConfig:"POST",
        ajaxParams:{"corp_name":"","corp_plc":"","corp_gubn":"","corp_mast":"","corp_code":""},
        ajaxResponse:function(url, params, response){ return response.data; },
        columns:[
            {title:"구분ID",   field:"corp_gubn", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"거래처명", field:"corp_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"사업자번호",field:"corp_no",  width:200, hozAlign:"center", headerFilter:"input"},
            {title:"거래처코드",field:"corp_code",width:120, visible:false}
        ],
        rowDblClick:function(e, row){
            const d = row.getData();
            document.getElementById('corp_name').value = d.corp_name;
            document.getElementById('corp_code').value = d.corp_code;
            document.getElementById('cutumListModal').style.display = 'none';
        }
    });
}
function closeCutumListModal(){
    document.getElementById('cutumListModal').style.display = 'none';
}

// ========== 저장 ==========
function save(){
    const checkboxFields = ["prod_fac1","prod_fac2","prod_fac3","prod_fac4","prod_fac5","prod_fac6"];
    checkboxFields.forEach(function(field){
        $("#hidden_" + field).remove();
        $("<input>").attr({
            type:"hidden", id:"hidden_"+field, name:field,
            value: $("#"+field).is(":checked") ? "1" : "0"
        }).appendTo("#productInsertForm");
    });

    var formData = new FormData($("#productInsertForm")[0]);
    let confirmMsg = "";
    if(isEditMode && selectedRowData && selectedRowData.prod_code){
        formData.append("mode","update");
        formData.append("prod_code", selectedRowData.prod_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode","insert");
        confirmMsg = "저장하시겠습니까?";
        formData.delete("prod_code");
    }
    if(!confirm(confirmMsg)) return;

    $.ajax({
        url: "/mibogear/standardManagement/productInsert/productInsertSave",
        type:"POST", data:formData, contentType:false, processData:false, dataType:"json",
        success:function(result){
            $('.modal-overlay, .product-modal').removeClass('active');
            $('.product-modal').css({'left':'50%','top':'50%','transform':'translate(-50%,-50%)'});
            $('#productInsertForm')[0].reset();
            isEditMode = false; selectedRowData = null;
            getProductList();
            setTimeout(function(){ alert("저장되었습니다."); }, 200);
        },
        error:function(){ alert("저장 오류"); }
    });
}

// ========== 다른이름으로 저장 ==========
function saveAsNew(){
    const checkboxFields = ["prod_fac1","prod_fac2","prod_fac3","prod_fac4","prod_fac5","prod_fac6"];
    checkboxFields.forEach(function(field){
        $("#hidden_" + field).remove();
        $("<input>").attr({
            type:"hidden", id:"hidden_"+field, name:field,
            value: $("#"+field).is(":checked") ? "1" : "0"
        }).appendTo("#productInsertForm");
    });
    var formData = new FormData($("#productInsertForm")[0]);
    formData.append("mode","insert");
    formData.delete("prod_code");
    if(!confirm("현재 데이터를 바탕으로 새 제품을 등록하시겠습니까?")) return;

    $.ajax({
        url: "/mibogear/standardManagement/productInsert/productInsertSave",
        type:"POST", data:formData, contentType:false, processData:false, dataType:"json",
        success:function(result){
            $('.modal-overlay, .product-modal').removeClass('active');
            $('.product-modal').css({'left':'50%','top':'50%','transform':'translate(-50%,-50%)'});
            $('#productInsertForm')[0].reset();
            isEditMode = false; selectedRowData = null;
            getProductList();
            setTimeout(function(){ alert("새로운 제품으로 저장되었습니다."); }, 200);
        },
        error:function(){ alert("저장 오류"); }
    });
}

// ========== 삭제 ==========
function deleteProduct(){
    if(!selectedRowData || !selectedRowData.prod_code){ alert("삭제할 대상을 선택하세요."); return; }
    if(!confirm("삭제하시겠습니까?")) return;

    $.ajax({
        url: "/mibogear/standardManagement/productInsert/productDelete",
        type:"POST", data:{ prod_code: selectedRowData.prod_code }, dataType:"json",
        success:function(result){
            if(result.status === "success"){
                $('.modal-overlay, .product-modal').removeClass('active');
                $('.product-modal').css({'left':'50%','top':'50%','transform':'translate(-50%,-50%)'});
                $('#productInsertForm')[0].reset();
                isEditMode = false; selectedRowData = null;
                getProductList();
                setTimeout(function(){ alert("삭제되었습니다."); }, 200);
            } else { alert("삭제 오류: " + result.message); }
        },
        error:function(){ alert("삭제 요청 오류"); }
    });
}

// ========== 엑셀 ==========
$(".excel-button").click(function(){
    const today = new Date().toISOString().slice(0,10).replace(/-/g,"");
    productTable.download("xlsx", "제품등록_" + today + ".xlsx", { sheetName:"제품등록" });
});
</script>
</body>
</html>