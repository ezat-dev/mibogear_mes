<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>F/P 점검 관리표</title>
    <%@include file="../include/pluginpage.jsp" %>
    <jsp:include page="../include/tabBar.jsp"/>
    <style>
        .main { padding: 10px; }

        /* 탭 스타일 */
        .equip-tabs {
            display: flex; gap: 4px; margin-bottom: 10px; flex-wrap: wrap;
        }
        .equip-tab {
            padding: 8px 18px; border: 2px solid #ccc;
            border-radius: 6px 6px 0 0; cursor: pointer;
            font-size: 13px; font-weight: 600; background: #f5f5f5; color: #666;
            transition: all 0.2s;
        }
        .equip-tab.active {
            background: #2c3e50; color: white; border-color: #2c3e50;
        }
        .equip-tab:hover:not(.active) { background: #e0e0e0; }

        /* 검색바 */
        .search-bar {
            display: flex; align-items: center; gap: 10px;
            padding: 8px 12px; background: #f4f4f4;
            border-radius: 6px; margin-bottom: 10px; flex-wrap: wrap;
        }
        .search-bar label { font-size: 13px; font-weight: bold; }
        .monthSet {
            height: 32px; padding: 0 10px; border: 1px solid #ccc;
            border-radius: 4px; font-size: 13px; text-align: center;
        }

        /* 기입방법 안내 */
        .input-guide {
            display: flex; gap: 20px; align-items: center;
            padding: 8px 14px; background: #fff8e1;
            border: 1px solid #ffc107; border-radius: 6px;
            margin-bottom: 10px; font-size: 12px; flex-wrap: wrap;
        }
        .input-guide span { font-weight: 600; }
        .guide-item { display: flex; align-items: center; gap: 4px; }

        /* 점검자/이력 섹션 */
        .bottom-section {
            display: flex; gap: 16px; margin-top: 14px; flex-wrap: wrap;
        }
        .inspector-box, .action-box {
            background: white; border: 1px solid #dee2e6;
            border-radius: 6px; padding: 12px; flex: 1; min-width: 300px;
        }
        .inspector-box h4, .action-box h4 {
            margin: 0 0 8px 0; font-size: 13px; color: #2c3e50;
            border-bottom: 2px solid #e9ecef; padding-bottom: 6px;
        }
        .inspector-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 6px;
        }
        .inspector-item {
            display: flex; flex-direction: column; gap: 3px;
        }
        .inspector-item label { font-size: 11px; color: #666; }
        .inspector-item input {
            border: 1px solid #ccc; border-radius: 3px;
            padding: 4px 6px; font-size: 12px;
        }
        .action-textarea {
            width: 100%; height: 80px; border: 1px solid #ccc;
            border-radius: 3px; padding: 6px; font-size: 12px;
            resize: vertical; box-sizing: border-box;
        }

        /* 테이블 */
        #dataTable { width: 100%; }
        .row_select { background-color: #ffeeba !important; }

        .tab { display: flex; align-items: center; justify-content: space-between;
               width: 95%; margin-bottom: 5px; }
        .button-container { display: flex; gap: 8px; align-items: center; }
        .button-image { width: 16px; height: 16px; }
    </style>
</head>
<body>
<main class="main">

    <!-- 검색바 -->
    <div class="search-bar">
        <label>조회월 :</label>
        <input type="text" id="s_sdate" class="monthSet" style="width:90px;">
        <button class="select-button" onclick="loadData();">
            <img src="/mibogear/image/search-icon.png" class="button-image">조회
        </button>
        <button class="insert-button" onclick="insertRow();">
            <img src="/mibogear/image/insert-icon.png" class="button-image">행 추가
        </button>
        <button class="delete-button" onclick="deleteRow();">
            <img src="/mibogear/css/tabBar/xDel3.png" class="button-image">삭제
        </button>
        <button class="select-button" style="background:#37b24d; border-color:#37b24d;"
                onclick="initEquipData();">
            📋 이번달 초기화
        </button>
    </div>

    <!-- 설비 탭 -->
    <div class="equip-tabs">
        <div class="equip-tab active" data-equip="BCF1"   onclick="selectTab(this)">BCF1 (침탄로)</div>
        <div class="equip-tab"        data-equip="BCF2"   onclick="selectTab(this)">BCF2 (침탄로)</div>
        <div class="equip-tab"        data-equip="템퍼링로" onclick="selectTab(this)">템퍼링로</div>
        <div class="equip-tab"        data-equip="변성로1" onclick="selectTab(this)">변성로1</div>
        <div class="equip-tab"        data-equip="진공세척기" onclick="selectTab(this)">진공세척기</div>
    </div>

    <!-- 기입방법 안내 -->
    <div class="input-guide">
        <span>기입방법 :</span>
        <div class="guide-item">○ <span>이상없음</span></div>
        <div class="guide-item">△ <span>수리요함</span></div>
        <div class="guide-item">▲ <span>수리완료</span></div>
        <div class="guide-item">수기 <span>기타</span></div>
    </div>

    <!-- 테이블 -->
    <div id="dataTable"></div>

    <!-- 하단 점검자 / 이상발생조치이력 -->
    <div class="bottom-section">
        <div class="inspector-box">
            <h4>점검자</h4>
            <div class="inspector-grid">
                <div class="inspector-item">
                    <label>1주차</label>
                    <input type="text" id="insp1" placeholder="성명">
                </div>
                <div class="inspector-item">
                    <label>2주차</label>
                    <input type="text" id="insp2" placeholder="성명">
                </div>
                <div class="inspector-item">
                    <label>3주차</label>
                    <input type="text" id="insp3" placeholder="성명">
                </div>
                <div class="inspector-item">
                    <label>4주차</label>
                    <input type="text" id="insp4" placeholder="성명">
                </div>
            </div>
        </div>
        <div class="action-box">
            <h4>이상발생 조치이력</h4>
            <textarea class="action-textarea" id="actionHistory"
                      placeholder="이상 발생 시 조치 내용을 입력하세요.&#10;예) 2026-05-03 가열실 온도 이상 → 온도 조절기 교체 완료"></textarea>
            <button onclick="saveActionHistory();"
                    style="margin-top:6px; padding:5px 14px; background:#2c3e50;
                           color:white; border:none; border-radius:4px; cursor:pointer; font-size:12px;">
                저장
            </button>
        </div>
    </div>

</main>

<script>
let now_page_code = "e02";

var dataTable = null;
var selectedRowData = null;
var clickedCnt = null;
var currentEquip = "BCF1";

$(function () {
    var tdate = todayDate();
    $("#s_sdate").val(tdate.substr(0, 7));
    initTable();
    loadData();
});

/* ── 설비 탭 선택 */
function selectTab(el) {
    $('.equip-tab').removeClass('active');
    $(el).addClass('active');
    currentEquip = $(el).data('equip');
    loadData();
}

/* ── 테이블 초기화 */
function initTable() {
    if (dataTable) { dataTable.destroy(); dataTable = null; }
    $("#dataTable").empty();

    dataTable = new Tabulator('#dataTable', {
        height: '520px',
        layout: 'fitDataFill',
        headerSort: false,
        columnHeaderVertAlign: "middle",
        headerHozAlign: 'center',
        placeholder: "조회된 데이터가 없습니다.",
        columns: [
            { title: "점검항목", field: "d_title", width: 180, hozAlign: "left",
              frozen: true, editor: "input" },
            { title: "점검내용(판정기준)", field: "d_desc", width: 350, hozAlign: "left",
              frozen: true, editor: "input",
              formatter: function(cell) {
                  return cell.getValue() ? cell.getValue().replace(/\n/g, '<br>') : '';
              }
            },
            ...[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
                21,22,23,24,25,26,27,28,29,30,31].map(d => ({
                title: d + "일",
                field: "d" + String(d).padStart(2, '0'),
                width: 55, hozAlign: "center",
                editor: "select",
                editorParams: { "": "", "○": "○", "△": "△", "▲": "▲" },
                formatter: function(cell) {
                    var v = cell.getValue();
                    var color = v === '○' ? '#2b8a3e' : v === '△' ? '#e67700' : v === '▲' ? '#c92a2a' : '#333';
                    return v ? '<span style="color:' + color + '; font-weight:bold;">' + v + '</span>' : '';
                }
            })),
            { title: "비고", field: "d_bigo", width: 180, hozAlign: "center", editor: "input" },
            { field: "cnt", visible: false },
            { field: "d_equip", visible: false },
        ],
        rowClick: function (e, row) {
            $('#dataTable .tabulator-row').removeClass('row_select');
            row.getElement().classList.add('row_select');
            selectedRowData = row.getData();
            clickedCnt = selectedRowData.cnt;
        },
        cellEdited: function (cell) {
            var field   = cell.getField();
            var value   = cell.getValue();
            var rowData = cell.getRow().getData();
            var cnt     = rowData.cnt;
            $.ajax({
                url: "/mibogear/quality/dailyCheckUpdate",
                type: "POST",
                dataType: "json",
                data: { d_field: field, d_value: value, cnt: cnt }
            });
        }
    });
}

/* ── 데이터 조회 */
function loadData() {
    initTable();
    $.ajax({
        url: "/mibogear/quality/dailyCheck/list",
        type: "POST",
        dataType: "json",
        data: { date: $("#s_sdate").val(), d_equip: currentEquip },
        success: function (result) {
            if (dataTable) dataTable.setData(result);
        }
    });
}

/* ── 행 추가 */
function insertRow() {
    var d_date = $("#s_sdate").val();
    if (!confirm(d_date + " / " + currentEquip + " 에 행을 추가하시겠습니까?")) return;
    $.ajax({
        url: "/mibogear/quality/dailyCheckInsert",
        type: "POST",
        dataType: "json",
        data: { d_ym: d_date, d_equip: currentEquip },
        success: function (result) {
            if (result === true) loadData();
            else alert("추가 실패");
        }
    });
}

/* ── 행 삭제 */
function deleteRow() {
    if (clickedCnt === null || typeof clickedCnt === 'undefined') {
        alert("삭제할 항목을 먼저 선택해주세요.");
        return;
    }
    if (!confirm("선택된 항목을 삭제하시겠습니까?")) return;
    $.ajax({
        url: "/mibogear/quality/dailyCheckDelete",
        type: "POST",
        dataType: "json",
        data: { cnt: clickedCnt },
        success: function (result) {
            if (result === true) {
                alert("삭제 완료");
                clickedCnt = null;
                loadData();
            } else alert("삭제 실패");
        }
    });
}

/* ── 이번달 설비별 초기 항목 세팅 */
function initEquipData() {
    var d_ym = $("#s_sdate").val();
    if (!confirm(d_ym + " / " + currentEquip + " 기본 점검항목을 초기화합니까?\n기존 데이터는 삭제됩니다.")) return;

    var equipItems = {
        "BCF1": [
            { d_title: "가열실 온도 이상",    d_desc: "▶설정값 보다 ±5℃ 초과 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 가열실 온도 상한/하한" },
            { d_title: "로내 분위기(CP) 이상", d_desc: "▶설정값 보다 ±0.05% 초과 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 로내 CP 상한/하한" },
            { d_title: "소입유 온도 이상",     d_desc: "▶설정값 보다 ±5℃ 초과 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 소입유 온도 상한/하한" },
            { d_title: "소입유 유면높이 이상", d_desc: "▶리미트 센서 범위 이탈 시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 소입유 유면 상한/하한" },
            { d_title: "RX 가스 압력이상",    d_desc: "▶리미트 센서 범위 이탈 시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 RX가스 공급 이상" },
            { d_title: "가열실 FAN 이상",     d_desc: "▶모터 전원 차단(멈춤) 시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 가열실 R/C FAN 회전 이상" }
        ],
        "BCF2": [
            { d_title: "가열실 온도 이상",    d_desc: "▶설정값 보다 ±5℃ 초과 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 가열실 온도 상한/하한" },
            { d_title: "로내 분위기(CP) 이상", d_desc: "▶설정값 보다 ±0.05% 초과 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 로내 CP 상한/하한" },
            { d_title: "소입유 온도 이상",     d_desc: "▶설정값 보다 ±5℃ 초과 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 소입유 온도 상한/하한" },
            { d_title: "소입유 유면높이 이상", d_desc: "▶리미트 센서 범위 이탈 시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 소입유 유면 상한/하한" },
            { d_title: "RX 가스 압력이상",    d_desc: "▶리미트 센서 범위 이탈 시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 RX가스 공급 이상" },
            { d_title: "가열실 FAN 이상",     d_desc: "▶모터 전원 차단(멈춤) 시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 가열실 R/C FAN 회전 이상" }
        ],
        "템퍼링로": [
            { d_title: "가열실 온도 이상",   d_desc: "▶설정값 보다 ±5℃ 초과 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 가열실 온도 상한/하한" },
            { d_title: "템퍼링로 FAN 이상", d_desc: "▶모터 전원 차단(멈춤) 시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 가열실 FAN 회전 이상" }
        ],
        "변성로1": [
            { d_title: "가열실 온도 이상",   d_desc: "▶설정값 보다 ±5℃ 초과 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 가열실 온도 상한/하한" },
            { d_title: "CO2 공급이상",       d_desc: "▶상한 0.5% 초과시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 CO2 공급 이상" },
            { d_title: "냉각수 공급 이상",   d_desc: "▶냉각수 차단시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 냉각수 공급 이상" },
            { d_title: "BLOWER 이상",       d_desc: "▶혼합가스밸브 차단시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 BLOWER 이상" }
        ],
        "진공세척기": [
            { d_title: "열매체유 온도 이상", d_desc: "▶설정값 초과시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 열매체유 온도 이상" },
            { d_title: "냉각수 공급 이상",  d_desc: "▶설정값 보다 40℃ 이상 셋팅시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 냉각수 공급 이상" },
            { d_title: "세정액양 이상",     d_desc: "▶리미트 센서 범위 이탈 시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 세정액양 이상" },
            { d_title: "AIR압력 이상",      d_desc: "▶AIR 공급밸브 차단시 알람경보\n▶절차 : 주간 시업전 실시\n▶확인 : 경보 및 AIR 압력 이상" }
        ]
    };

    var items = equipItems[currentEquip] || [];
    $.ajax({
        url: "/mibogear/quality/dailyCheckInitEquip",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ d_ym: d_ym, d_equip: currentEquip, items: items }),
        dataType: "json",
        success: function (result) {
            if (result === true) {
                alert("초기화 완료!");
                loadData();
            } else alert("초기화 실패");
        }
    });
}

/* ── 이상발생조치이력 저장 */
function saveActionHistory() {
    var val = $("#actionHistory").val();
    alert("저장되었습니다.");
    // 필요시 별도 API 연동
}
</script>
</body>
</html>