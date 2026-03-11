<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>연간점검</title>
    <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
    <%@include file="../include/pluginpage.jsp" %>
    <style>
        body { overflow:hidden; }
        .main { width:100%; padding:0; margin:0; }

        .inner-tabs { display:flex; gap:6px; padding:6px 0 0 6px; background:#2c2f36; }
        .inner-tab {
            padding:7px 20px; border:1px solid #555; border-radius:4px 4px 0 0;
            background:#3a3d44; color:#ccc; cursor:pointer; font-size:13px; font-weight:bold;
        }
        .inner-tab.active { background:#FFD700; color:#000; border-color:#FFC107; }

        /* 검색바 */
        .search-bar {
            display:flex; align-items:center; gap:8px;
            padding:6px 10px; background:#f4f4f4;
            border:1px solid #ddd; border-top:none;
        }
        .search-bar label { font-size:13px; font-weight:bold; white-space:nowrap; }
        .search-bar input, .search-bar select {
            height:28px; padding:0 7px; border:1px solid #aaa;
            border-radius:3px; font-size:13px;
        }
        .bar-btn {
            height:28px; padding:0 12px; border-radius:3px; border:none;
            cursor:pointer; font-size:12px; font-weight:bold;
            display:inline-flex; align-items:center; gap:3px; white-space:nowrap;
        }
        .bar-btn img { width:14px; height:14px; }
        .bar-btn.search { background:#4a90e2; color:white; }
        .bar-btn.insert { background:#FFD700; color:#000; border:1px solid #FFC107; }
        .bar-btn.excel  { background:#217346; color:white; }

        /* 설비탭 */
        .equip-tabs { display:flex; gap:5px; padding:5px 10px; background:#fff; border-bottom:1px solid #ddd; }
        .equip-tab {
            padding:4px 14px; border:1px solid #ccc; border-radius:4px;
            background:white; cursor:pointer; font-size:13px; font-weight:bold;
        }
        .equip-tab.active { background:#FFD700; border-color:#FFC107; color:#000; }

        /* 종합현황 테이블 */
        .summary-wrap { overflow-x:auto; overflow-y:auto; height:calc(100vh - 140px); }
        #summaryTable { border-collapse:collapse; font-size:12px; width:100%; }
        #summaryTable th {
            background:#33363d; color:white; padding:6px 4px;
            text-align:center; border:1px solid #555; white-space:nowrap; position:sticky; top:0; z-index:1;
        }
        #summaryTable td { padding:4px; text-align:center; border:1px solid #ddd; white-space:nowrap; }
        #summaryTable .equip-cell  { background:#fffde7; font-weight:bold; }
        #summaryTable .plan-row    { background:#f9f9f9; }
        #summaryTable .result-row  { background:#f1f8e9; }
        #summaryTable .empty-row   { background:#fafafa; color:#bbb; }
        #summaryTable .circle      { color:#1565c0; font-size:14px; font-weight:bold; }
        #summaryTable .circle-done { color:#2e7d32; font-size:14px; font-weight:bold; }
        #summaryTable td input.cell-input {
            width:100%; border:none; background:transparent;
            text-align:center; font-size:12px; outline:none; padding:0;
        }
        #summaryTable td.editable:hover { background:#fffbcc; cursor:text; }

        /* 월별 tabulator 영역 */
        #monthlyTab {
            width:100%;
            height:calc(100vh - 145px);
        }

        /* 모달 */
        .yearCheckModal {
            position:fixed; top:50%; left:50%; display:none;
            transform:translate(-50%,-50%); z-index:1000;
        }
        .modal-detail {
            background:#fff; border:1px solid #000; width:680px;
            box-shadow:0 4px 20px rgba(0,0,0,0.7); border-radius:5px;
            max-height:90vh; overflow-y:auto;
        }
        .modal-header-bar {
            display:flex; justify-content:center; align-items:center; position:relative;
            background:#33363d; height:48px; color:white; font-size:17px; font-weight:bold;
        }
        .modal-header-bar .header-close {
            position:absolute; right:15px; top:12px; cursor:pointer; font-size:20px; color:white;
        }
        .modal-body { padding:12px 16px; }
        .modal-section-title {
            background:#4a90e2; color:white; font-weight:bold;
            font-size:13px; padding:4px 10px; margin:10px 0 5px; border-radius:3px;
        }
        .product-table { width:100%; border-collapse:collapse; font-size:13px; margin-bottom:4px; }
        .product-table th, .product-table td {
            border:1px solid #ccc; padding:6px 8px; vertical-align:middle;
        }
        .product-table th { background:#f4f4f4; text-align:center; font-weight:bold; width:110px; }
        .product-table td input[type="text"],
        .product-table td textarea {
            width:95%; padding:4px 6px; border:1px solid #aaa;
            border-radius:3px; font-size:13px; font-family:inherit; box-sizing:border-box;
        }
        .product-table td textarea { height:48px; resize:vertical; }
        .btnSaveClose { display:flex; justify-content:center; gap:16px; padding:10px 0 12px; }
        .btnSaveClose button {
            width:90px; height:32px; background:#FFD700; color:black;
            border:2px solid #FFC107; border-radius:5px; font-weight:bold;
            cursor:pointer; transition:background-color 0.2s, transform 0.2s;
        }
        .btnSaveClose .save:hover    { background:#FFC107; transform:scale(1.05); }
        .btnSaveClose .delete-btn    { background:#dc3545; color:white; border-color:#b02a37; }
        .btnSaveClose .delete-btn:hover { background:#b02a37; transform:scale(1.05); }
        .btnSaveClose .close-btn     { background:#A9A9A9; border-color:#808080; }
        .btnSaveClose .close-btn:hover { background:#808080; transform:scale(1.05); }
    </style>
</head>
<body>

<!-- 내부 탭 -->
<div class="inner-tabs">
    <div class="inner-tab active" id="tabSummary" onclick="switchTab('summary')">📊 종합현황</div>
    <div class="inner-tab"       id="tabMonthly" onclick="switchTab('monthly')">✏️ 월별 점검 입력</div>
</div>

<main class="main">

    <!-- ===== 종합현황 ===== -->
    <div id="sectionSummary">
        <div class="search-bar">
            <label>조회연도</label>
            <input type="text" id="summaryYear" style="width:68px;" maxlength="4">
            <button class="bar-btn search" onclick="loadSummary();">
                <img src="/mibogear/image/search-icon.png">조회
            </button>
            <button class="bar-btn excel" onclick="exportSummaryExcel();">
                <img src="/mibogear/image/excel-icon.png">엑셀
            </button>
        </div>
        <div class="summary-wrap">
            <table id="summaryTable">
                <thead>
                    <tr>
                        <th rowspan="2" style="width:36px;">NO</th>
                        <th rowspan="2" style="width:72px;">설&nbsp;비</th>
                        <th rowspan="2" style="min-width:150px;">세부내용</th>
                        <th rowspan="2" style="width:62px;">주&nbsp;기</th>
                        <th rowspan="2" style="width:42px;">구분</th>
                        <th>1월</th><th>2월</th><th>3월</th><th>4월</th>
                        <th>5월</th><th>6월</th><th>7월</th><th>8월</th>
                        <th>9월</th><th>10월</th><th>11월</th><th>12월</th>
                        <th rowspan="2" style="min-width:90px;">비&nbsp;고</th>
                    </tr>
                </thead>
                <tbody id="summaryTbody"></tbody>
            </table>
        </div>
    </div>

    <!-- ===== 월별 점검 입력 ===== -->
    <div id="sectionMonthly" style="display:none;">
        <div class="search-bar">
            <label>연도</label>
            <input type="text" id="inputYear" style="width:68px;" maxlength="4">
            <label>월</label>
            <select id="inputMonth" style="width:65px;">
                <option value="1">1월</option><option value="2">2월</option>
                <option value="3">3월</option><option value="4">4월</option>
                <option value="5">5월</option><option value="6">6월</option>
                <option value="7">7월</option><option value="8">8월</option>
                <option value="9">9월</option><option value="10">10월</option>
                <option value="11">11월</option><option value="12">12월</option>
            </select>
            <button class="bar-btn search" onclick="buildMonthlyTable();">
                <img src="/mibogear/image/search-icon.png">조회
            </button>
            <button class="bar-btn insert" onclick="openInsertModal();">
                <img src="/mibogear/image/insert-icon.png">추가
            </button>
            <button class="bar-btn excel" onclick="exportMonthlyExcel();">
                <img src="/mibogear/image/excel-icon.png">엑셀
            </button>
        </div>
        <div class="equip-tabs">
            <div class="equip-tab active" data-equip="변성로">변성로</div>
            <div class="equip-tab" data-equip="침탄로">침탄로</div>
            <div class="equip-tab" data-equip="세정기">세정기</div>
            <div class="equip-tab" data-equip="템퍼링로">템퍼링로</div>
            <div class="equip-tab" data-equip="기타">기타</div>
        </div>
        <div id="monthlyTab"></div>
    </div>

</main>

<!-- ===== 점검 입력/수정 모달 ===== -->
<div class="yearCheckModal" id="yearCheckModal">
    <div class="modal-detail">
        <div class="modal-header-bar" id="modalHeaderBar">
            <span id="modalTitle">점검 입력</span>
            <span class="header-close" id="modalHeaderClose">&times;</span>
        </div>
        <div class="modal-body">

            <table class="product-table">
                <colgroup><col width="110px"><col><col width="110px"><col></colgroup>
                <tbody>
                    <tr>
                        <th>설비</th>
                        <td><input type="text" id="m_equipType" readonly style="background:#f0f0f0;"></td>
                        <th>주기</th>
                        <td><input type="text" id="m_cycle" placeholder="예) 1회/월"></td>
                    </tr>
                    <tr>
                        <th>세부내용</th>
                        <td colspan="3"><input type="text" id="m_detail" style="width:97%;" placeholder="점검 세부내용"></td>
                    </tr>
                    <tr>
                        <th>계획월</th>
                        <td colspan="3"><input type="text" id="m_planMonths" style="width:97%;" placeholder="예) 1,3,6,9,12"></td>
                    </tr>
                </tbody>
            </table>

            <div class="modal-section-title">📋 점검항목</div>
            <table class="product-table">
                <colgroup><col width="110px"><col></colgroup>
                <tbody>
                    <tr>
                        <th>세부내용</th>
                        <td><textarea id="m_checkDetail" placeholder="점검항목 세부내용"></textarea></td>
                    </tr>
                    <tr>
                        <th>점검자</th>
                        <td><input type="text" id="m_checker" placeholder="점검자 이름"></td>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td><input type="text" id="m_checkNote" placeholder="비고"></td>
                    </tr>
                </tbody>
            </table>

            <div class="modal-section-title">📊 점검DATA</div>
            <table class="product-table">
                <colgroup><col width="110px"><col></colgroup>
                <tbody>
                    <tr>
                        <th>검교정 전<br>세부내용</th>
                        <td><textarea id="m_before" placeholder="검교정 전 세부내용"></textarea></td>
                    </tr>
                    <tr>
                        <th>검교정 후<br>세부내용</th>
                        <td><textarea id="m_after" placeholder="검교정 후 세부내용"></textarea></td>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td><input type="text" id="m_dataNote" placeholder="비고"></td>
                    </tr>
                </tbody>
            </table>

        </div>
        <div class="btnSaveClose">
            <button class="delete-btn" id="btnModalDelete" onclick="doDelete()" style="display:none;">삭제</button>
            <button class="save" onclick="doSave()">저장</button>
            <button class="close-btn" id="btnModalClose">닫기</button>
        </div>
    </div>
</div>

<script>
    let now_page_code = "d04";

    const EQUIP_LIST = ["변성로","침탄로","세정기","템퍼링로","기타"];
    let currentEquip = "변성로";
    let selectedId   = null;
    let currentMode  = "insert";
    let monthlyTable = null;

    /* ===== 초기화 ===== */
    $(function(){
        const now = new Date();
        $("#summaryYear").val(now.getFullYear());
        $("#inputYear").val(now.getFullYear());
        $("#inputMonth").val(now.getMonth() + 1);

        loadSummary();

        $(".equip-tab").on("click", function(){
            $(".equip-tab").removeClass("active");
            $(this).addClass("active");
            currentEquip = $(this).data("equip");
            buildMonthlyTable();
        });

        $("#btnModalClose, #modalHeaderClose").on("click", function(){
            $("#yearCheckModal").hide();
        });

        // 모달 드래그
        const $modal = document.getElementById("yearCheckModal");
        document.getElementById("modalHeaderBar").addEventListener("mousedown", function(e){
            const rect = $modal.getBoundingClientRect();
            $modal.style.left = rect.left + "px";
            $modal.style.top  = rect.top  + "px";
            $modal.style.transform = "none";
            let ox = e.clientX - rect.left, oy = e.clientY - rect.top;
            function mv(e){ $modal.style.left=(e.clientX-ox)+"px"; $modal.style.top=(e.clientY-oy)+"px"; }
            function up(){ window.removeEventListener("mousemove",mv); window.removeEventListener("mouseup",up); }
            window.addEventListener("mousemove",mv);
            window.addEventListener("mouseup",up);
        });
    });

    /* ===== 탭 전환 ===== */
    function switchTab(tab){
        if(tab === "summary"){
            $("#tabSummary").addClass("active"); $("#tabMonthly").removeClass("active");
            $("#sectionSummary").show(); $("#sectionMonthly").hide();
        } else {
            $("#tabMonthly").addClass("active"); $("#tabSummary").removeClass("active");
            $("#sectionMonthly").show(); $("#sectionSummary").hide();
            buildMonthlyTable();
        }
    }

    /* ===== 추가 버튼 ===== */
    function openInsertModal(){
        currentMode = "insert";
        selectedId  = null;
        $("#modalTitle").text("점검 입력");
        $("#btnModalDelete").hide();
        $("#m_equipType").val(currentEquip);
        $("#m_cycle,#m_detail,#m_planMonths").val("");
        $("#m_checkDetail,#m_checker,#m_checkNote").val("");
        $("#m_before,#m_after,#m_dataNote").val("");
        $("#yearCheckModal").show();
    }

    /* ===== 종합현황 ===== */
    function loadSummary(){
        const year = $("#summaryYear").val();
        if(!year || year.length !== 4){ alert("연도를 4자리로 입력하세요."); return; }
        $.ajax({
            url: "/mibogear/preservation/yearCheck/getAnnualCheckSummary",
            type: "POST", data: { checkYear: year }, dataType: "json",
            success: function(data){ renderSummary(data); },
            error: function(){ alert("종합현황 조회 오류"); }
        });
    }

    function renderSummary(data){
        const grouped = {};
        EQUIP_LIST.forEach(function(e){ grouped[e] = {}; });

        (data || []).forEach(function(r){
            if(!grouped[r.equipType]) return;
            const key = (r.detail||'') + "||" + (r.cycle||'');
            if(!grouped[r.equipType][key]){
                grouped[r.equipType][key] = {
                    detail:     r.detail  || '',
                    cycle:      r.cycle   || '',
                    note:       r.note    || '',
                    planMonths: r.planMonths ? r.planMonths.split(',').map(Number) : [],
                    resultIds:  {},
                    results:    {}
                };
            }
            if(r.checkMonth){
                grouped[r.equipType][key].results[r.checkMonth]   = true;
                grouped[r.equipType][key].resultIds[r.checkMonth] = r.id;
                if(r.note) grouped[r.equipType][key].note = r.note;
            }
        });

        const $tbody = $("#summaryTbody").empty();

        EQUIP_LIST.forEach(function(equip, no){
            const detailList = Object.values(grouped[equip] || {});

            if(detailList.length === 0){
                $tbody.append(
                    '<tr class="empty-row">' +
                        '<td>' + (no+1) + '</td>' +
                        '<td>' + equip + '</td>' +
                        '<td colspan="16" style="color:#bbb;font-style:italic;">입력된 점검 항목 없음</td>' +
                        '<td></td>' +
                    '</tr>'
                );
                return;
            }

            const totalRows = detailList.length * 2;

            detailList.forEach(function(item, idx){
                let planCells = '', resultCells = '';
                for(let m = 1; m <= 12; m++){
                    planCells += '<td>' + (item.planMonths.includes(m) ? '<span class="circle">◎</span>' : '') + '</td>';
                    const rid = item.resultIds[m];
                    resultCells += item.results[m]
                        ? '<td class="editable" data-id="' + rid + '" data-month="' + m + '"><span class="circle-done">◎</span></td>'
                        : '<td></td>';
                }

                const noEquipCells = idx === 0
                    ? '<td class="equip-cell" rowspan="' + totalRows + '">' + (no+1) + '</td>' +
                      '<td class="equip-cell" rowspan="' + totalRows + '">' + equip + '</td>'
                    : '';

                const latestId = Object.values(item.resultIds).slice(-1)[0] || '';
                const noteCell = '<td rowspan="2" class="editable">' +
                    '<input class="cell-input" type="text" value="' + (item.note||'') + '" data-id="' + latestId + '" data-field="note">' +
                '</td>';

                $tbody.append(
                    '<tr class="plan-row">' +
                        noEquipCells +
                        '<td rowspan="2" style="text-align:left;padding-left:8px;">' + item.detail + '</td>' +
                        '<td rowspan="2">' + item.cycle + '</td>' +
                        '<td style="color:#555;font-size:11px;">계&nbsp;획</td>' +
                        planCells + noteCell +
                    '</tr>' +
                    '<tr class="result-row">' +
                        '<td style="color:#2e7d32;font-size:11px;">실&nbsp;적</td>' +
                        resultCells +
                    '</tr>'
                );
            });
        });

        $("#summaryTbody").off("change","input.cell-input").on("change","input.cell-input", function(){
            const id    = $(this).data("id");
            const field = $(this).data("field");
            const value = $(this).val();
            if(!id) return;
            cellUpdate(id, field, value);
        });
    }

    /* ===== 셀 단건 업데이트 ===== */
    function cellUpdate(id, fieldName, fieldValue){
        $.ajax({
            url: "/mibogear/preservation/yearCheck/updateCheckResultCell",
            type: "POST",
            data: { id:id, fieldName:fieldName, fieldValue:fieldValue },
            dataType: "json",
            error: function(){ alert("셀 저장 오류"); }
        });
    }

    /* ===== 월별 점검 Tabulator ===== */
    function buildMonthlyTable(){
        const year  = $("#inputYear").val();
        const month = $("#inputMonth").val();
        if(!year || year.length !== 4){ alert("연도를 4자리로 입력하세요."); return; }

        $.ajax({
            url: "/mibogear/preservation/yearCheck/getCheckResultByMonth",
            type: "POST",
            data: { checkYear:year, checkMonth:month, equipType:currentEquip },
            dataType: "json",
            success: function(data){
                if(monthlyTable){ monthlyTable.destroy(); monthlyTable = null; }

                monthlyTable = new Tabulator("#monthlyTab", {
                    layout: "fitColumns",
                    height: "calc(100vh - 145px)",
                    selectable: true,
                    headerHozAlign: "center",
                    placeholder: "입력된 항목이 없습니다. [추가] 버튼으로 등록하세요.",
                    data: data || [],
                    rowFormatter: function(row){
                        row.getElement().style.fontWeight = "700";
                        row.getElement().style.backgroundColor = "#fff";
                    },
                    rowClick: function(e, row){
                        $("#monthlyTab div.row_select").removeClass("row_select");
                        row.getElement().classList.add("row_select");
                    },
                    rowDblClick: function(e, row){
                        openEditModal(row.getData());
                    },
                    cellEdited: function(cell){
                        const fieldMap = {
                            "checkDetail":"check_detail", "checker":"checker",
                            "checkNote":"check_note", "checkDataBefore":"check_data_before",
                            "checkDataAfter":"check_data_after", "dataBeforeNote":"data_before_note",
                            "note":"note"
                        };
                        const dbField = fieldMap[cell.getField()];
                        if(!dbField) return;
                        cellUpdate(cell.getRow().getData().id, dbField, cell.getValue());
                    },
                    columns: [
                        { title:"",    formatter:"rownum",  width:45, hozAlign:"center" },
                        { title:"세부내용", field:"detail",  hozAlign:"left", headerFilter:"input", editor:"input" },
                        { title:"주기",  field:"cycle",       width:80, hozAlign:"center", editor:"input" },
                        { title:"계획월", field:"planMonths", width:100, hozAlign:"center" },
                        { title:"점검항목", columns:[
                            { title:"세부내용", field:"checkDetail",    hozAlign:"left",   editor:"input", width:150 },
                            { title:"점검자",   field:"checker",        width:85,  hozAlign:"center", editor:"input" },
                            { title:"비고",     field:"checkNote",      width:90,  hozAlign:"center", editor:"input" }
                        ]},
                        { title:"점검DATA", columns:[
                            { title:"검교정전", field:"checkDataBefore", hozAlign:"left", editor:"input", width:120 },
                            { title:"검교정후", field:"checkDataAfter",  hozAlign:"left", editor:"input", width:120 },
                            { title:"비고",     field:"dataBeforeNote",  width:90, hozAlign:"center", editor:"input" }
                        ]},
                        { title:"등록일", field:"regDate", width:140, hozAlign:"center" }
                    ]
                });
            },
            error: function(){ alert("조회 오류"); }
        });
    }

    /* ===== 수정 모달 ===== */
    function openEditModal(data){
        currentMode = "update";
        selectedId  = data.id;
        $("#modalTitle").text("점검 수정");
        $("#btnModalDelete").show();
        $("#m_equipType").val(data.equipType     || '');
        $("#m_cycle").val(data.cycle             || '');
        $("#m_detail").val(data.detail           || '');
        $("#m_planMonths").val(data.planMonths   || '');
        $("#m_checkDetail").val(data.checkDetail || '');
        $("#m_checker").val(data.checker         || '');
        $("#m_checkNote").val(data.checkNote     || '');
        $("#m_before").val(data.checkDataBefore  || '');
        $("#m_after").val(data.checkDataAfter    || '');
        $("#m_dataNote").val(data.dataBeforeNote || '');
        $("#yearCheckModal").show();
    }

    /* ===== 저장 ===== */
    function doSave(){
        if(!confirm("저장하시겠습니까?")) return;
        const params = {
            mode:            currentMode,
            equipType:       $("#m_equipType").val(),
            checkYear:       $("#inputYear").val(),
            checkMonth:      $("#inputMonth").val(),
            detail:          $("#m_detail").val(),
            cycle:           $("#m_cycle").val(),
            planMonths:      $("#m_planMonths").val(),
            checkDetail:     $("#m_checkDetail").val(),
            checker:         $("#m_checker").val(),
            checkNote:       $("#m_checkNote").val(),
            checkDataBefore: $("#m_before").val(),
            checkDataAfter:  $("#m_after").val(),
            dataBeforeNote:  $("#m_dataNote").val(),
            userCode:        "${loginUser.user_code}"
        };
        if(currentMode === "update") params.id = selectedId;

        $.ajax({
            url: "/mibogear/preservation/yearCheck/saveCheckResult",
            type: "POST", data: params, dataType: "json",
            success: function(result){
                if(result.status === "success"){
                    alert("저장되었습니다.");
                    $("#yearCheckModal").hide();
                    buildMonthlyTable();
                    $("#summaryYear").val($("#inputYear").val());
                    loadSummary();
                } else { alert("저장 실패: " + result.message); }
            },
            error: function(){ alert("저장 오류"); }
        });
    }

    /* ===== 삭제 ===== */
    function doDelete(){
        if(!selectedId) return;
        if(!confirm("삭제하시겠습니까?")) return;
        $.ajax({
            url: "/mibogear/preservation/yearCheck/deleteCheckResult",
            type: "POST", data: { id: selectedId }, dataType: "json",
            success: function(result){
                if(result.status === "success"){
                    alert("삭제되었습니다.");
                    $("#yearCheckModal").hide();
                    buildMonthlyTable();
                    loadSummary();
                } else { alert("삭제 실패: " + result.message); }
            },
            error: function(){ alert("삭제 오류"); }
        });
    }

    /* ===== 엑셀 ===== */
    function exportMonthlyExcel(){
        if(!monthlyTable){ alert("먼저 조회하세요."); return; }
        const today = new Date().toISOString().slice(0,10).replace(/-/g,"");
        monthlyTable.download("xlsx", "연간점검_" + today + ".xlsx", { sheetName:"연간점검" });
    }
    function exportSummaryExcel(){
        alert("종합현황 엑셀은 준비 중입니다.");
    }
</script>
</body>
</html>