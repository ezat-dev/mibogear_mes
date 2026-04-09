<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>작업지시서</title>
    <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>
<style>
.main { width: 100%; }
.container { display: flex; justify-content: flex-start; }

.box1 {
    display: flex !important;
    justify-content: flex-start !important;
    align-items: center !important;
    width: auto !important;
    margin-left: 0 !important;
}

/* 검색바 */
.search-bar {
    display: flex; align-items: center; gap: 8px;
    padding: 5px 8px; flex-wrap: wrap;
}
.search-bar label {
    font-size: 13px; font-weight: bold;
    white-space: nowrap; color: black; margin-right: 4px;
}
.search-bar input, .search-bar select {
    height: 29px; padding: 5px 8px; font-size: 13px;
    border: 1px solid #ccc; border-radius: 6px;
    background-color: #f9f9f9; color: #333;
    outline: none; transition: border 0.3s ease;
}
.search-bar input:focus, .search-bar select:focus {
    border: 1px solid #007bff; background-color: #fff;
}

/* 오버레이 */
.modal-overlay {
    display: none; position: fixed;
    top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0,0,0,0.5); z-index: 999;
}
.modal-overlay.active { display: block; }

/* 작업지시 메인 모달 */
.wo-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 860px; max-width: 95vw; max-height: 92vh;
    background: white; border-radius: 10px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.35);
    z-index: 1000; overflow: hidden;
    flex-direction: column;
}
.wo-modal.active { display: flex; }

.wo-modal .modal-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 14px 20px;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white; cursor: move; flex-shrink: 0;
}
.wo-modal .modal-header h2 { margin: 0; font-size: 18px; font-weight: 700; }

.modal-close-btn {
    background: none; border: none; color: white;
    font-size: 26px; cursor: pointer; border-radius: 4px;
    transition: all 0.3s;
}
.modal-close-btn:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }

.wo-modal .modal-body {
    flex: 1; overflow-y: auto; background: #f5f7fa; padding: 15px;
}

/* 섹션 공통 */
.field-section {
    background: white; border-radius: 8px;
    padding: 14px 16px; margin-bottom: 12px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.06);
}
.section-title {
    margin: 0 0 12px 0; font-size: 13px; font-weight: 700;
    color: #2c3e50; padding-bottom: 7px;
    border-bottom: 2px solid #e9ecef;
    display: flex; align-items: center; gap: 6px;
}
.section-badge {
    font-size: 10px; padding: 2px 7px; border-radius: 10px;
    font-weight: 600; color: white;
}
.badge-blue   { background: #339af0; }
.badge-orange { background: #ff922b; }
.badge-green  { background: #37b24d; }

/* ── 섹션① 전용 field-* 스타일 ── */
.field-row {
    display: grid; grid-template-columns: repeat(2, 1fr);
    gap: 8px; margin-bottom: 8px;
}
.field-row-3 {
    display: grid; grid-template-columns: repeat(3, 1fr);
    gap: 8px; margin-bottom: 8px;
}
.field-col { display: flex; flex-direction: column; gap: 3px; }
.field-col-full { grid-column: 1 / -1; display: flex; flex-direction: column; gap: 3px; }

.field-col label, .field-col-full label {
    font-size: 11px; font-weight: 600; color: #495057;
}
.field-col input, .field-col select,
.field-col-full input, .field-col-full select {
    width: 100%; padding: 5px 8px;
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 12px; box-sizing: border-box;
    background-color: #f9f9f9; color: #333;
    outline: none; transition: border 0.3s ease;
}
.field-col input:focus, .field-col select:focus,
.field-col-full input:focus {
    border: 1px solid #007bff; background-color: #fff;
}
.field-col input:read-only,
.field-col-full input:read-only {
    background: #f0f0f0; color: #666; cursor: default;
}

/* 입고 선택 버튼 */
.input-with-btn { display: flex; gap: 4px; }
.input-with-btn input { flex: 1; }
.btn-select {
    padding: 5px 10px; border: none; border-radius: 4px;
    background: #4dabf7; color: white;
    font-size: 11px; font-weight: 600; cursor: pointer;
    white-space: nowrap; transition: background 0.3s;
}
.btn-select:hover { background: #339af0; }
.optional-hint { font-size: 11px; color: #adb5bd; margin-left: 4px; }

/* 푸터 */
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
.btn-save   { background: linear-gradient(135deg, #51cf66, #37b24d); color: white; }
.btn-save:hover   { background: linear-gradient(135deg, #40c057, #2f9e44); transform: translateY(-2px); }
.btn-print  { background: linear-gradient(135deg, #339af0, #1971c2); color: white; }
.btn-print:hover  { background: linear-gradient(135deg, #228be6, #1864ab); transform: translateY(-2px); }
.btn-delete { background: linear-gradient(135deg, #ff6b6b, #fa5252); color: white; }
.btn-delete:hover { background: linear-gradient(135deg, #f03e3e, #e03131); transform: translateY(-2px); }
.btn-cancel { background: linear-gradient(135deg, #868e96, #495057); color: white; }
.btn-cancel:hover { background: linear-gradient(135deg, #6c757d, #343a40); transform: translateY(-2px); }

/* LOT 배지 */
.lot-badge {
    display: inline-block; padding: 3px 10px;
    background: #e7f5ff; color: #1971c2;
    border: 1px solid #74c0fc; border-radius: 4px;
    font-size: 12px; font-weight: 700; letter-spacing: 0.5px;
}

/* 입고 검색 모달 */
#ipgoSearchModal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 900px; max-width: 95vw;
    background: white; border-radius: 8px;
    box-shadow: 0 10px 60px rgba(0,0,0,0.4);
    z-index: 1200; padding: 20px;
}
#ipgoSearchModal .ism-header {
    display: flex; justify-content: space-between; align-items: center;
    font-weight: bold; font-size: 17px;
    margin-bottom: 14px; padding-bottom: 10px;
    border-bottom: 2px solid #e9ecef;
}
#ipgoSearchModal .ism-close { cursor: pointer; font-size: 24px; color: #495057; }
#ipgoSearchModal .ism-close:hover { color: #dc3545; }
#ipgoSearchOverlay {
    display: none; position: fixed;
    top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0,0,0,0.5); z-index: 1199;
}

/* 패턴 스피너 */
.pattern-spinner {
    width: 18px; height: 18px;
    border: 3px solid #ffd43b;
    border-top-color: #e67700;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }

/* datepicker z-index */
.datepicker { z-index: 1300 !important; }
.datepicker-global-container { z-index: 1300 !important; }

/* ── 섹션②③ 전용 (field-* 와 완전 분리) ── */
.wo-table {
    width: 100%; border-collapse: collapse;
    font-size: 12px; margin-bottom: 10px;
}
.wo-table th {
    background: #f5f6fa; text-align: center; font-weight: 600;
    border: 1px solid #dee2e6; padding: 6px 8px;
    width: 120px; white-space: nowrap; color: #2c3e50;
}
.wo-table td {
    border: 1px solid #dee2e6; padding: 5px 8px; vertical-align: middle;
}
.wo-table select,
.wo-table input[type="text"],
.wo-table input[type="number"] {
    width: 100%; padding: 4px 6px;
    border: 1px solid #ced4da; border-radius: 3px;
    font-size: 12px; box-sizing: border-box;
    background: #f9f9f9; color: #333; outline: none;
}
.wo-table input[readonly] {
    background: #f0f0f0; color: #666; cursor: default;
}

.wo-inner-table {
    width: 100%; border-collapse: collapse;
    text-align: center; font-size: 12px;
}
.wo-inner-table th {
    background: #f5f6fa; font-weight: 600;
    border: 1px solid #dee2e6; padding: 5px 4px;
    white-space: nowrap; color: #2c3e50;
}
.wo-inner-table td {
    border: 1px solid #dee2e6; padding: 3px; min-width: 50px;
}
.wo-inner-input {
    width: 88%; height: 24px;
    font-size: 12px; text-align: center;
    border: 1px solid #ced4da; border-radius: 3px;
    box-sizing: border-box;
    background: #f0f0f0; color: #333;
}
</style>
</head>
<body>

<!-- 탭바 -->
<div class="tab">
    <div class="box1">
        <div class="search-bar">
            <label>등록일</label>
            <input type="text" id="sdate" class="datetimepicker_date" style="width:95px;">
            <span style="color:black;">~</span>
            <input type="text" id="edate" class="datetimepicker_date" style="width:95px;">
            <label>LOT번호</label>
            <input type="text" id="s_lot_no" style="width:110px;" placeholder="LOT번호">
            <label>제품명</label>
            <input type="text" id="s_prod_name" style="width:100px;" placeholder="제품명">
            <label>거래처</label>
            <input type="text" id="s_corp_name" style="width:100px;" placeholder="거래처명">
        </div>
    </div>
    <div class="button-container">
        <button class="select-button" onclick="loadWoList();">
            <img src="/mibogear/image/search-icon.png" class="button-image">조회
        </button>
        <button class="insert-button" onclick="openInsertModal();">
            <img src="/mibogear/image/insert-icon.png" class="button-image">추가
        </button>
        <button class="excel-button" onclick="downloadExcel();">
            <img src="/mibogear/image/excel-icon.png" class="button-image">엑셀
        </button>
        <button class="printer-button" onclick="printSelected();">
            <img src="/mibogear/image/printer-icon.png" class="button-image">작업지시서출력
        </button>
    </div>
</div>

<!-- 메인 리스트 -->
<main class="main">
    <div class="container">
        <div id="woListTabulator" class="tabulator"></div>
    </div>
</main>

<!-- ============================================================ -->
<!-- 작업지시 등록/수정 모달                                        -->
<!-- ============================================================ -->
<div class="modal-overlay" id="woOverlay"></div>
<div class="wo-modal" id="woModal">
    <div class="modal-header" id="woModalHeader">
        <h2 id="woModalTitle">작업지시서 등록</h2>
        <button type="button" class="modal-close-btn" id="woModalClose">&times;</button>
    </div>

    <div class="modal-body">

        <!-- LOT번호 (수정 모드) -->
        <div id="lotBadgeArea" style="display:none; margin-bottom:10px;">
            <span style="font-size:12px; color:#495057; font-weight:600;">LOT번호 : </span>
            <span class="lot-badge" id="displayLotNo"></span>
        </div>

        <!-- ================================================== -->
        <!-- 섹션① 입고정보                                      -->
        <!-- ================================================== -->
        <div class="field-section">
            <h3 class="section-title">
                <span class="section-badge badge-blue">①</span>
                입고 정보
                <span class="optional-hint">※ 선택사항</span>
            </h3>

            <div class="field-row" style="margin-bottom:10px;">
                <div class="field-col">
                    <label>입고 데이터 선택</label>
                    <div class="input-with-btn">
                        <input type="text" id="m_ord_code" readonly placeholder="입고코드 (선택 후 자동입력)">
                        <button type="button" class="btn-select" onclick="openIpgoSearchModal();">검색</button>
                        <button type="button" class="btn-select" style="background:#adb5bd;"
                                onclick="clearIpgoSection();">초기화</button>
                    </div>
                </div>
                <div class="field-col">
                    <label>입고일</label>
                    <input type="text" id="m_ord_date" readonly>
                </div>
            </div>
            <div class="field-row">
                <div class="field-col">
                    <label>거래처명</label>
                    <input type="text" id="m_corp_name" readonly placeholder="-">
                </div>
                <div class="field-col">
                    <label>제품명</label>
                    <input type="text" id="m_prod_name" readonly placeholder="-">
                </div>
            </div>
            <div class="field-row-3">
                <div class="field-col">
                    <label>품번</label>
                    <input type="text" id="m_prod_no" readonly placeholder="-">
                </div>
                <div class="field-col">
                    <label>규격</label>
                    <input type="text" id="m_prod_gyu" readonly placeholder="-">
                </div>
                <div class="field-col">
                    <label>재질</label>
                    <input type="text" id="m_prod_jai" readonly placeholder="-">
                </div>
            </div>
            <div class="field-row">
                <div class="field-col">
                    <label>입고수량</label>
                    <input type="text" id="m_ord_su" readonly placeholder="-">
                </div>
                <div class="field-col">
                    <label>입고LOT</label>
                    <input type="text" id="m_ord_lot" readonly placeholder="-">
                </div>
            </div>
            <div class="field-row">
                <div class="field-col">
                    <label>현재 잔량</label>
                    <div style="display:flex; align-items:center; gap:6px;">
                        <input type="text" id="m_jan_su" readonly placeholder="-" style="flex:1;">
                        <span id="m_jan_badge" style="display:none; padding:3px 10px;
                              border-radius:12px; font-size:11px; font-weight:700;
                              white-space:nowrap;"></span>
                    </div>
                </div>
                <div class="field-col"></div>
            </div>
            <input type="hidden" id="h_ord_code">
            <input type="hidden" id="h_prod_code">
        </div>

        <!-- ================================================== -->
        <!-- 섹션② 패턴정보                                      -->
        <!-- ================================================== -->
        <div class="field-section">
            <h3 class="section-title">
                <span class="section-badge badge-orange">②</span>
                패턴 정보
            </h3>

            <!-- 호기/패턴번호 입력 -->
            <table class="wo-table" style="margin-bottom:10px;">
                <colgroup>
                    <col width="120px"><col><col width="120px"><col>
                </colgroup>
                <tbody>
                    <tr>
                        <th>침탄로 호기 <span style="color:#e03131;">*</span></th>
                        <td>
                            <select id="m_bcf_hogi" onchange="onBcfHogiChange(this.value);">
                                <option value="">-- 선택 --</option>
                                <option value="1">BCF1 (1호기)</option>
                                <option value="2">BCF2 (2호기)</option>
                                <option value="3">BCF3 (3호기)</option>
                                <option value="4">BCF4 (4호기)</option>
                            </select>
                        </td>
                        <th>소려로 호기</th>
                        <td>
                            <input type="text" id="m_tf_hogi_display" readonly
                                   placeholder="침탄호기 선택 시 자동결정">
                        </td>
                    </tr>
                    <tr>
                        <th>자동대차 패턴번호</th>
                        <td><input type="number" id="m_auto_pattern" placeholder="숫자 입력"></td>
                        <th>침탄로 패턴번호 <span style="color:#e03131;">*</span></th>
                        <td><input type="number" id="m_bcf_cycle_no" placeholder="숫자 입력"></td>
                    </tr>
                    <tr>
                        <th>소려로 패턴번호 <span style="color:#e03131;">*</span></th>
                        <td><input type="number" id="m_tf_cycle_no" placeholder="숫자 입력"></td>
                        <th></th><td></td>
                    </tr>
                </tbody>
            </table>

            <!-- 패턴조회 버튼 -->
            <div style="text-align:center; margin-bottom:14px;">
                <button type="button" id="btnPatternSearch" onclick="requestPattern();"
                        style="min-width:140px; height:36px; border:none; border-radius:6px;
                               background:linear-gradient(135deg,#ff922b,#e67700);
                               color:white; font-size:14px; font-weight:700; cursor:pointer;">
                    패턴 조회
                </button>
                <button type="button" onclick="doResetPattern();"
                        style="min-width:80px; height:36px; border:none; border-radius:6px;
                               background:#dee2e6; color:#495057;
                               font-size:13px; font-weight:600; cursor:pointer; margin-left:8px;">
                    초기화
                </button>
            </div>

            <!-- 진행 표시 -->
            <div id="patternLoading" style="display:none; text-align:center; padding:12px 0;">
                <div style="display:inline-flex; align-items:center; gap:10px;
                            background:#fff3bf; border:1px solid #ffd43b;
                            border-radius:8px; padding:10px 20px;">
                    <div class="pattern-spinner"></div>
                    <span style="font-size:13px; font-weight:600; color:#e67700;">
                        PLC 패턴 데이터 수신 중... (<span id="pollCount">0</span>초)
                    </span>
                </div>
            </div>

            <!-- 타임아웃 -->
            <div id="patternTimeout" style="display:none; text-align:center; padding:8px;">
                <span style="font-size:13px; color:#c92a2a; font-weight:600;">
                    ⚠ 응답 시간 초과 (60초). PLC 상태를 확인하세요.
                </span>
                <button type="button" onclick="requestPattern();"
                        style="margin-left:8px; padding:3px 10px; border:none; border-radius:4px;
                               background:#e03131; color:white; font-size:12px; cursor:pointer;">
                    재시도
                </button>
            </div>

            <!-- 패턴 결과 -->
            <div id="patternResult" style="display:none;">
                <div style="background:#ebfbee; border:1px solid #8ce99a; border-radius:6px;
                            padding:6px 12px; margin-bottom:10px;
                            font-size:12px; color:#2b8a3e; font-weight:600;">
                    ✓ 패턴 데이터 수신 완료
                </div>

                <table class="wo-table" style="margin-bottom:0;">
                    <tbody>
                        <!-- BCF 침탄로 -->
                        <tr>
                            <th>침탄로 패턴</th>
                            <td colspan="3">
                                <table class="wo-inner-table">
                                    <thead>
                                        <tr>
                                            <th>공정명</th>
                                            <td>승온&amp;팬정지</td>
                                            <td>침탄</td>
                                            <td>확산</td>
                                            <td>강온&amp;소입</td>
                                            <td>퀜칭</td>
                                            <td>드레인</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>처리시간(분)</th>
                                            <td><input class="wo-inner-input" id="bcf_time_fanup" readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_time_chim"  readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_time_diff"  readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_time_gang"  readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_time_que"   readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_time_drain" readonly></td>
                                        </tr>
                                        <tr>
                                            <th>처리온도(℃)</th>
                                            <td><input class="wo-inner-input" id="bcf_temp_fanup" readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_temp_chim"  readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_temp_diff"  readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_temp_gang"  readonly></td>
                                            <td colspan="2">
                                                <input class="wo-inner-input" id="bcf_temp_que_drain" readonly style="width:94%;">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>처리 C.P.(%)</th>
                                            <td><input class="wo-inner-input" id="bcf_cp_fanup" readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_cp_chim"  readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_cp_diff"  readonly></td>
                                            <td><input class="wo-inner-input" id="bcf_cp_gang"  readonly></td>
                                            <td colspan="2">
                                                <input class="wo-inner-input" id="bcf_cp_que_drain" readonly style="width:94%;">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>

                        <!-- TF 소려로 -->
                        <tr>
                            <th>소려로 패턴</th>
                            <td colspan="3">
                                <table class="wo-inner-table">
                                    <thead>
                                        <tr>
                                            <th>공정명</th>
                                            <td>건조</td>
                                            <td>팬정지&amp;승온</td>
                                            <td>N2퍼지</td>
                                            <td>소려</td>
                                            <td>냉각</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>처리시간(분)</th>
                                            <td><input class="wo-inner-input" id="tf_time_dry"   readonly></td>
                                            <td><input class="wo-inner-input" id="tf_time_fanup" readonly></td>
                                            <td><input class="wo-inner-input" id="tf_time_n2"    readonly></td>
                                            <td><input class="wo-inner-input" id="tf_time_tem"   readonly></td>
                                            <td><input class="wo-inner-input" id="tf_time_cool"  readonly></td>
                                        </tr>
                                        <tr>
                                            <th>처리온도(℃)</th>
                                            <td colspan="5">
                                                <input class="wo-inner-input" id="tf_temp_tem" readonly style="width:60%;">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div><!-- /patternResult -->
        </div><!-- /섹션② -->

        <!-- ================================================== -->
        <!-- 섹션③ 처리품정보                                    -->
        <!-- ================================================== -->
        <div class="field-section">
            <h3 class="section-title">
                <span class="section-badge badge-green">③</span>
                침탄로 본체 처리품 정보
            </h3>

            <table class="wo-table">
                <colgroup>
                    <col width="120px"><col><col width="120px"><col>
                </colgroup>
                <tbody>
                    <tr>
                        <th>처리품 유/무</th>
                        <td>
                            <select id="m_main_yn">
                                <option value="Y">Y</option>
                                <option value="N">N</option>
                            </select>
                        </td>
                        <th></th><td></td>
                    </tr>
                    <tr>
                        <th>스페어1</th>
                        <td><input type="text" id="m_main_spare_1"></td>
                        <th>스페어2</th>
                        <td><input type="text" id="m_main_spare_2"></td>
                    </tr>
                    <tr>
                        <th>스페어3</th>
                        <td><input type="text" id="m_main_spare_3"></td>
                        <th>스페어4</th>
                        <td><input type="text" id="m_main_spare_4"></td>
                    </tr>
                    <tr>
                        <th>비고1</th>
                        <td><input type="text" id="m_main_bigo_1"></td>
                        <th>비고2</th>
                        <td><input type="text" id="m_main_bigo_2"></td>
                    </tr>
                    <tr>
                        <th>비고3</th>
                        <td><input type="text" id="m_main_bigo_3"></td>
                        <th>비고4</th>
                        <td><input type="text" id="m_main_bigo_4"></td>
                    </tr>
                    <tr>
                        <th>비고5</th>
                        <td colspan="3">
                            <input type="text" id="m_main_bigo_5">
                        </td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td><input type="text" id="m_reg_user"></td>
                        <th></th><td></td>
                    </tr>
                </tbody>
            </table>
        </div><!-- /섹션③ -->

    </div><!-- /modal-body -->

    <div class="modal-footer">
        <button type="button" class="btn-delete" id="woModalBtnDelete"
                onclick="deleteWorkOrder();" style="display:none;">삭제</button>
        <button type="button" class="btn-save" onclick="saveWorkOrder();">저장</button>
        <button type="button" class="btn-print" id="woModalBtnPrint"
                onclick="saveAndPrint();" style="display:none;">저장 + 출력</button>
        <button type="button" class="btn-cancel" id="woModalBtnCancel">닫기</button>
    </div>
</div>

<!-- ============================================================ -->
<!-- 입고 검색 모달                                                 -->
<!-- ============================================================ -->
<div id="ipgoSearchOverlay"></div>
<div id="ipgoSearchModal">
    <div class="ism-header">
        <span>입고 데이터 선택</span>
        <span class="ism-close" onclick="closeIpgoSearchModal()">&times;</span>
    </div>
    <div style="display:flex; gap:8px; align-items:center; margin-bottom:10px; flex-wrap:wrap;">
        <label style="font-size:12px; font-weight:bold;">입고일</label>
        <input type="text" id="ips_sdate" class="datetimepicker_date"
               style="height:27px; padding:0 6px; border:1px solid #ccc; border-radius:3px; font-size:12px; width:95px;">
        <span style="font-size:12px;">~</span>
        <input type="text" id="ips_edate" class="datetimepicker_date"
               style="height:27px; padding:0 6px; border:1px solid #ccc; border-radius:3px; font-size:12px; width:95px;">
        <label style="font-size:12px; font-weight:bold;">거래처</label>
        <input type="text" id="ips_corp_name"
               style="height:27px; padding:0 6px; border:1px solid #ccc; border-radius:3px; font-size:12px; width:100px;">
        <label style="font-size:12px; font-weight:bold;">품명</label>
        <input type="text" id="ips_prod_name"
               style="height:27px; padding:0 6px; border:1px solid #ccc; border-radius:3px; font-size:12px; width:100px;">
        <button onclick="searchIpgoList();"
                style="height:27px; padding:0 12px; background:#4dabf7; color:white;
                       border:none; border-radius:3px; cursor:pointer; font-size:12px; font-weight:600;">
            조회
        </button>
    </div>
    <div id="ipgoSearchTabulator" style="height:420px;"></div>
    <div style="margin-top:10px; font-size:11px; color:#adb5bd; text-align:right;">
        * 행을 더블클릭하면 선택됩니다
    </div>
</div>

<!-- script 블록은 기존 workOrder.jsp의 <script> 그대로 유지 -->

</body>
</html>


<!-- ============================================================ -->
<!-- Script                                                        -->
<!-- ============================================================ -->
<script>
let now_page_code = "b04";

var woListTable     = null;
var ipgoSearchTable = null;
var isEditMode      = false;
var selectedWoCode  = null;
var selectedRowData = null;

// 패턴 관련 전역변수
var patternPollTimer = null;
var patternPollSec   = 0;
var MAX_POLL_SEC     = 60;
var patternReceived  = false;

/* ── 초기화 ── */
$(function () {
    const today = todayDate();
    const month = monthAgoDate();
    $("#sdate").val(month);
    $("#edate").val(today);

    $(".datetimepicker_date").datepicker({
        language: 'ko', autoClose: true,
        dateFormat: 'yyyy-mm-dd', zIndex: 1400
    });

    $("#woModalClose, #woModalBtnCancel").on("click", closeWoModal);

    $("#sdate,#edate,#s_lot_no,#s_prod_name,#s_corp_name").on("keydown", function (e) {
        if (e.keyCode === 13) loadWoList();
    });

    initWoList();
});

/* ============================================================ */
/* 메인 리스트                                                    */
/* ============================================================ */
function initWoList() {
    if (woListTable) { woListTable.destroy(); woListTable = null; }
    $("#woListTabulator").empty();

    woListTable = new Tabulator("#woListTabulator", {
        height: "715px",
        layout: "fitColumns",
        selectable: true,
        headerSort: false,
        headerHozAlign: "center",
        placeholder: "조회된 데이터가 없습니다.",
        columns: [
            { title: "NO",       field: "idx",       width: 50,  hozAlign: "center" },
            { title: "LOT번호",  field: "lot_no",    width: 170, hozAlign: "center" },
            { title: "거래처",   field: "corp_name", width: 140, hozAlign: "center", headerFilter: "input" },
            { title: "제품명",   field: "prod_name", width: 160, hozAlign: "center", headerFilter: "input" },
            { title: "품번",     field: "prod_no",   width: 130, hozAlign: "center", headerFilter: "input" },
            { title: "침탄호기", field: "bcf_hogi",  width: 80,  hozAlign: "center" },
            { title: "소려호기", field: "tf_hogi",   width: 80,  hozAlign: "center" },
            { title: "BCF패턴",  field: "bcf_cycle_no", width: 80, hozAlign: "center" },
            { title: "TF패턴",   field: "tf_cycle_no",  width: 80, hozAlign: "center" },
            { title: "입고수량", field: "ipgo_su",   width: 80,  hozAlign: "center" },
            {
                title: "잔량", field: "jan_su", width: 80, hozAlign: "center",
                formatter: function (cell) {
                    var val = parseFloat(cell.getValue()) || 0;
                    var color = val <= 0 ? "#e03131" : val <= 100 ? "#e67700" : "#2b8a3e";
                    return '<span style="color:' + color + '; font-weight:bold;">' + val + '</span>';
                }
            },
            { title: "작성자",   field: "reg_user",  width: 80,  hozAlign: "center" },
            { title: "등록일시", field: "reg_date",  width: 150, hozAlign: "center" },
        ],
        rowFormatter: function (row) {
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#fff";
        },
        rowClick: function (e, row) {
            $("#woListTabulator div.row_select").removeClass("row_select");
            row.getElement().classList.add("row_select");
            selectedRowData = row.getData();
        },
        rowDblClick: function (e, row) {
            openEditModal(row.getData());
        },
        tableBuilt: function () {
            loadWoList();
        }
    });
}

function loadWoList() {
    $.ajax({
        url: "/mibogear/workOrder/list",
        type: "POST",
        dataType: "json",
        data: {
            sdate:     $("#sdate").val(),
            edate:     $("#edate").val(),
            lot_no:    $("#s_lot_no").val(),
            prod_name: $("#s_prod_name").val(),
            corp_name: $("#s_corp_name").val()
        },
        success: function (res) {
            var list = res.data ? res.data : res;
            list.forEach(function (item, i) { item.idx = i + 1; });
            if (woListTable) woListTable.setData(list);
        },
        error: function () { alert("조회 오류"); }
    });
}

/* ============================================================ */
/* 모달 오픈/클로즈                                               */
/* ============================================================ */
function openInsertModal() {
    isEditMode     = false;
    selectedWoCode = null;
    clearWoModal();
    $("#woModalTitle").text("작업지시서 등록");
    $("#woModalBtnDelete").hide();
    $("#woModalBtnPrint").hide();
    $("#lotBadgeArea").hide();
    openWoModal();
}

function openEditModal(data) {
    isEditMode     = true;
    selectedWoCode = data.wo_code;
    clearWoModal();
    $("#woModalTitle").text("작업지시서 수정");
    $("#woModalBtnDelete").show();
    $("#woModalBtnPrint").show();

    $("#displayLotNo").text(data.lot_no);
    $("#lotBadgeArea").show();

    /* 섹션① 입고정보 */
    if (data.ord_code) {
        $("#m_ord_code").val(data.ord_code);
        $("#h_ord_code").val(data.ord_code);
        $("#m_ord_date").val(data.ord_date || "");
        $("#m_corp_name").val(data.corp_name || "");
        $("#m_prod_name").val(data.prod_name || "");
        $("#m_prod_no").val(data.prod_no     || "");
        $("#m_prod_gyu").val(data.prod_gyu   || "");
        $("#m_prod_jai").val(data.prod_jai   || "");
        $("#m_ord_su").val(data.ord_su       || "");
        $("#m_ord_lot").val(data.ord_lot     || "");

        var jan   = parseFloat(data.jan_su) || 0;
        var badge = $("#m_jan_badge");
        $("#m_jan_su").val(jan);
        if (jan <= 0) {
            badge.text("재고 없음").css({ background:"#ffe3e3", color:"#c92a2a", border:"1px solid #ffa8a8" });
        } else if (jan <= 100) {
            badge.text("잔량 부족").css({ background:"#fff3bf", color:"#e67700", border:"1px solid #ffd43b" });
        } else {
            badge.text("재고 있음").css({ background:"#d3f9d8", color:"#2b8a3e", border:"1px solid #8ce99a" });
        }
        badge.show();
    }

    /* 섹션③ 처리품정보 */
    $("#m_main_yn").val(data.main_yn || "Y");
    for (var i = 1; i <= 4; i++) $("#m_main_spare_" + i).val(data["main_spare_" + i] || "");
    for (var i = 1; i <= 5; i++) $("#m_main_bigo_"  + i).val(data["main_bigo_"  + i] || "");
    $("#m_reg_user").val(data.reg_user || "");

    openWoModal();
}

function openWoModal() {
    $("#woModal").css({ left:"50%", top:"50%", transform:"translate(-50%,-50%)" });
    $("#woOverlay").addClass("active");
    $("#woModal").addClass("active");
}

function closeWoModal() {
    stopPatternPoll();
    $.post("/mibogear/workOrder/pattern/reset");
    $("#woOverlay").removeClass("active");
    $("#woModal").removeClass("active");
}

function clearWoModal() {
    /* 섹션① */
    $("#m_ord_code,#h_ord_code,#h_prod_code").val("");
    $("#m_ord_date,#m_corp_name,#m_prod_name,#m_prod_no").val("");
    $("#m_prod_gyu,#m_prod_jai,#m_ord_su,#m_ord_lot").val("");
    $("#m_jan_su").val(""); $("#m_jan_badge").hide();
    /* 섹션② 패턴 */
    $("#m_bcf_hogi").val("");
    $("#m_tf_hogi_display").val("");
    $("#m_auto_pattern,#m_bcf_cycle_no,#m_tf_cycle_no").val("");
    $("#patternLoading,#patternResult,#patternTimeout").hide();
    $("#btnPatternSearch").prop("disabled", false).css("opacity", "1");
 // 패턴 인풋 초기화
    $("#bcf_time_fanup,#bcf_time_chim,#bcf_time_diff,#bcf_time_gang,#bcf_time_que,#bcf_time_drain").val("");
    $("#bcf_temp_fanup,#bcf_temp_chim,#bcf_temp_diff,#bcf_temp_gang,#bcf_temp_que_drain").val("");
    $("#bcf_cp_fanup,#bcf_cp_chim,#bcf_cp_diff,#bcf_cp_gang,#bcf_cp_que_drain").val("");
    $("#tf_time_dry,#tf_time_fanup,#tf_time_n2,#tf_time_tem,#tf_time_cool,#tf_temp_tem").val("");
    patternReceived = false;
    stopPatternPoll();
    /* 섹션③ */
    $("#m_main_yn").val("Y");
    for (var i = 1; i <= 4; i++) $("#m_main_spare_" + i).val("");
    for (var i = 1; i <= 5; i++) $("#m_main_bigo_"  + i).val("");
    $("#m_reg_user").val("");
}

/* ============================================================ */
/* 저장 / 삭제 / 출력                                             */
/* ============================================================ */
function saveWorkOrder() {
    doSave(function (res) {
        alert("저장 완료  LOT: " + res.lot_no);
        closeWoModal();
        loadWoList();
    });
}

function saveAndPrint() {
    doSave(function (res) {
        closeWoModal();
        loadWoList();
        $.ajax({
            url: "/mibogear/workOrder/print",
            type: "GET",
            data: { wo_code: res.wo_code },
            dataType: "json",
            success: function (r) {
                if (r.status === "success") {
                    alert("저장 완료  LOT: " + res.lot_no + "\n경로: " + r.pdfPath);
                } else { alert("출력 오류: " + r.message); }
            },
            error: function () { alert("출력 요청 오류"); }
        });
    });
}

function doSave(callback) {
    var data = collectFormData();
    var mode = isEditMode ? "update" : "insert";
    if (isEditMode) data.wo_code = selectedWoCode;

    $.ajax({
        url: "/mibogear/workOrder/save?mode=" + mode,
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(data),
        dataType: "json",
        success: function (res) {
            if (res.status === "success") {
                $.post("/mibogear/workOrder/pattern/reset");
                if (callback) callback(res);
            } else { alert("오류: " + res.message); }
        },
        error: function (xhr) { alert("저장 오류: " + xhr.status); }
    });
}

function collectFormData() {
    var tfHogiNum = (function () {
        var v = parseInt($("#m_bcf_hogi").val());
        if (!v) return null;
        return (v <= 2) ? 1 : 2;
    })();

    return {
        /* 섹션① */
        ord_code:  $("#h_ord_code").val(),
        corp_name: $("#m_corp_name").val(),
        prod_name: $("#m_prod_name").val(),
        prod_no:   $("#m_prod_no").val(),
        prod_gyu:  $("#m_prod_gyu").val(),
        prod_jai:  $("#m_prod_jai").val(),
        ord_su:    $("#m_ord_su").val(),
        ord_lot:   $("#m_ord_lot").val(),
        /* 섹션② 패턴 */
        auto_pattern: $("#m_auto_pattern").val() || null,
        bcf_cycle_no: $("#m_bcf_cycle_no").val() || null,
        tf_cycle_no:  $("#m_tf_cycle_no").val()  || null,
        bcf_hogi:     $("#m_bcf_hogi").val()     || null,
        tf_hogi:      tfHogiNum,
        /* 온도/시간 */
        bcf_time_fanup:  patternReceived ? ($("#bcf_time_fanup").val()  || null) : null,
		bcf_time_chim:   patternReceived ? ($("#bcf_time_chim").val()   || null) : null,
		bcf_time_diff:   patternReceived ? ($("#bcf_time_diff").val()   || null) : null,
		bcf_time_gang:   patternReceived ? ($("#bcf_time_gang").val()   || null) : null,
		bcf_time_que:    patternReceived ? ($("#bcf_time_que").val()    || null) : null,
		bcf_time_drain:  patternReceived ? ($("#bcf_time_drain").val()  || null) : null,
		bcf_temp_fanup:  patternReceived ? ($("#bcf_temp_fanup").val()  || null) : null,
		bcf_temp_chim:   patternReceived ? ($("#bcf_temp_chim").val()   || null) : null,
		bcf_temp_diff:   patternReceived ? ($("#bcf_temp_diff").val()   || null) : null,
		bcf_temp_gang:   patternReceived ? ($("#bcf_temp_gang").val()   || null) : null,
		bcf_temp_que:    patternReceived ? ($("#bcf_temp_que_drain").val() || null) : null,
		bcf_cp_fanup:    patternReceived ? ($("#bcf_cp_fanup").val()    || null) : null,
		bcf_cp_chim:     patternReceived ? ($("#bcf_cp_chim").val()     || null) : null,
		bcf_cp_diff:     patternReceived ? ($("#bcf_cp_diff").val()     || null) : null,
		bcf_cp_gang:     patternReceived ? ($("#bcf_cp_gang").val()     || null) : null,
		tf_time_dry:     patternReceived ? ($("#tf_time_dry").val()     || null) : null,
		tf_time_fanup:   patternReceived ? ($("#tf_time_fanup").val()   || null) : null,
		tf_time_n2:      patternReceived ? ($("#tf_time_n2").val()      || null) : null,
		tf_time_tem:     patternReceived ? ($("#tf_time_tem").val()     || null) : null,
		tf_time_cool:    patternReceived ? ($("#tf_time_cool").val()    || null) : null,
		tf_temp_tem:     patternReceived ? ($("#tf_temp_tem").val()     || null) : null,
		// 나머지 예비 스텝은 null
		bcf_time_spare1: null, bcf_time_spare2: null, bcf_time_spare3: null,
		bcf_temp_spare1: null, bcf_temp_spare2: null, bcf_temp_spare3: null,
		bcf_cp_spare1: null, bcf_cp_spare2: null,
		tf_time_spare1: null, tf_time_spare2: null, tf_time_spare3: null, tf_time_spare4: null,
		tf_temp_spare1: null, tf_temp_spare2: null, tf_temp_spare3: null, tf_temp_spare4: null,
		tf_temp_dry: null, tf_temp_fanup: null, tf_temp_n2: null, tf_temp_cool: null,
        /* 섹션③ - 호기/패턴번호는 섹션②에서 가져옴 */
        main_auto_pattern_number: $("#m_auto_pattern").val()  || null,
        main_bcf_pattern_number:  $("#m_bcf_cycle_no").val()  || null,
        main_tf_pattern_number:   $("#m_tf_cycle_no").val()   || null,
        main_bcf_hogi: $("#m_bcf_hogi").val() ? "BCF" + $("#m_bcf_hogi").val() : "",
        main_tf_hogi:  tfHogiNum              ? "TF"  + tfHogiNum              : "",
        main_yn:      $("#m_main_yn").val(),
        main_spare_1: $("#m_main_spare_1").val(),
        main_spare_2: $("#m_main_spare_2").val(),
        main_spare_3: $("#m_main_spare_3").val(),
        main_spare_4: $("#m_main_spare_4").val(),
        main_bigo_1:  $("#m_main_bigo_1").val(),
        main_bigo_2:  $("#m_main_bigo_2").val(),
        main_bigo_3:  $("#m_main_bigo_3").val(),
        main_bigo_4:  $("#m_main_bigo_4").val(),
        main_bigo_5:  $("#m_main_bigo_5").val(),
        reg_user: $("#m_reg_user").val()
    };
}

function deleteWorkOrder() {
    if (!selectedWoCode) { alert("삭제 대상이 없습니다."); return; }
    if (!confirm("삭제하시겠습니까?")) return;
    $.ajax({
        url: "/mibogear/workOrder/delete",
        type: "POST",
        data: { wo_code: selectedWoCode },
        dataType: "json",
        success: function (res) {
            if (res.status === "success") {
                alert("삭제되었습니다.");
                closeWoModal();
                loadWoList();
            } else { alert("삭제 오류: " + res.message); }
        },
        error: function () { alert("삭제 요청 오류"); }
    });
}

function printSelected() {
    if (!selectedRowData) { alert("출력할 행을 선택하세요."); return; }
    $.ajax({
        url: "/mibogear/workOrder/print",
        type: "GET",
        data: { wo_code: selectedRowData.wo_code },
        dataType: "json",
        success: function (r) {
            if (r.status === "success") {
                alert("작업지시서 저장 완료\nLOT: " + r.lot_no + "\n경로: " + r.pdfPath);
            } else { alert("출력 오류: " + r.message); }
        },
        error: function () { alert("출력 요청 오류"); }
    });
}

function downloadExcel() {
    if (!woListTable) { alert("먼저 조회하세요."); return; }
    var today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    woListTable.download("xlsx", "작업지시서_" + today + ".xlsx", { sheetName: "작업지시서" });
}

/* ============================================================ */
/* 입고 검색 모달                                                  */
/* ============================================================ */
function openIpgoSearchModal() {
    var today = todayDate();
    if (!$("#ips_sdate").val()) {
        var d = new Date(); d.setMonth(d.getMonth() - 1);
        $("#ips_sdate").val(d.getFullYear() + "-" +
            String(d.getMonth()+1).padStart(2,"0") + "-" +
            String(d.getDate()).padStart(2,"0"));
    }
    if (!$("#ips_edate").val()) $("#ips_edate").val(today);
    $("#ips_sdate, #ips_edate").datepicker({
        language: 'ko', autoClose: true,
        dateFormat: 'yyyy-mm-dd', zIndex: 1400
    });
    $("#ipgoSearchOverlay").show();
    $("#ipgoSearchModal").show();
    searchIpgoList();
}

function closeIpgoSearchModal() {
    $("#ipgoSearchOverlay").hide();
    $("#ipgoSearchModal").hide();
}

function searchIpgoList() {
    if (ipgoSearchTable) { ipgoSearchTable.destroy(); ipgoSearchTable = null; }
    ipgoSearchTable = new Tabulator("#ipgoSearchTabulator", {
        height: "370px",
        layout: "fitColumns",
        selectable: true,
        headerHozAlign: "center",
        placeholder: "조회된 데이터가 없습니다.",
        ajaxURL: "/mibogear/productionManagement/ipgo/getIpgoList",
        ajaxConfig: "POST",
        ajaxParams: {
            sdate:     $("#ips_sdate").val(),
            edate:     $("#ips_edate").val(),
            corp_name: $("#ips_corp_name").val(),
            prod_name: $("#ips_prod_name").val(),
            prod_no:   ""
        },
        ajaxResponse: function (url, params, response) {
            return response.data ? response.data : response;
        },
        columns: [
            { title: "입고코드", field: "ord_code",  width: 110, hozAlign: "center" },
            { title: "입고일",   field: "ord_date",  width: 100, hozAlign: "center" },
            { title: "거래처",   field: "corp_name", width: 140, hozAlign: "center", headerFilter: "input" },
            { title: "제품명",   field: "prod_name", width: 160, hozAlign: "center", headerFilter: "input" },
            { title: "품번",     field: "prod_no",   width: 120, hozAlign: "center", headerFilter: "input" },
            { title: "규격",     field: "prod_gyu",  width: 90,  hozAlign: "center" },
            { title: "재질",     field: "prod_jai",  width: 70,  hozAlign: "center" },
            { title: "수량",     field: "ord_su",    width: 70,  hozAlign: "center" },
            { title: "입고LOT",  field: "ord_lot",   width: 100, hozAlign: "center" },
        ],
        rowDblClick: function (e, row) { selectIpgoRow(row.getData()); }
    });
}

function selectIpgoRow(d) {
    $("#m_ord_code").val(d.ord_code);
    $("#h_ord_code").val(d.ord_code);
    $("#m_ord_date").val(d.ord_date ? d.ord_date.substring(0, 10) : "");
    $("#m_corp_name").val(d.corp_name || "");
    $("#m_prod_name").val(d.prod_name || "");
    $("#m_prod_no").val(d.prod_no    || "");
    $("#m_prod_gyu").val(d.prod_gyu  || "");
    $("#m_prod_jai").val(d.prod_jai  || "");
    $("#m_ord_su").val(d.ord_su      || "");
    $("#m_ord_lot").val(d.ord_lot    || "");

    $("#m_jan_su").val("조회 중...");
    $("#m_jan_badge").hide();

    $.ajax({
        url: "/mibogear/productionManagement/ipChulgoStatus/getJanStatus",
        type: "POST",
        dataType: "json",
        data: { sdate:"", edate:"", corp_name:"", prod_name:"", prod_no:"" },
        success: function (res) {
            var list  = res.data ? res.data : res;
            var found = list.find(function (item) { return item.ord_code === d.ord_code; });
            if (found) {
                var jan   = parseFloat(found.jan_su) || 0;
                var badge = $("#m_jan_badge");
                $("#m_jan_su").val(jan);
                if (jan <= 0) {
                    badge.text("재고 없음").css({ background:"#ffe3e3", color:"#c92a2a", border:"1px solid #ffa8a8" });
                } else if (jan <= 100) {
                    badge.text("잔량 부족").css({ background:"#fff3bf", color:"#e67700", border:"1px solid #ffd43b" });
                } else {
                    badge.text("재고 있음").css({ background:"#d3f9d8", color:"#2b8a3e", border:"1px solid #8ce99a" });
                }
                badge.show();
            } else {
                $("#m_jan_su").val("-");
            }
        },
        error: function () { $("#m_jan_su").val("조회 실패"); }
    });

    closeIpgoSearchModal();
}

function clearIpgoSection() {
    $("#m_ord_code,#h_ord_code,#m_ord_date").val("");
    $("#m_corp_name,#m_prod_name,#m_prod_no").val("");
    $("#m_prod_gyu,#m_prod_jai,#m_ord_su,#m_ord_lot").val("");
    $("#m_jan_su").val(""); $("#m_jan_badge").hide();
}

$("#ipgoSearchOverlay").on("click", function () { closeIpgoSearchModal(); });

/* ============================================================ */
/* 패턴 요청                                                      */
/* ============================================================ */
function onBcfHogiChange(val) {
    if (!val) { $("#m_tf_hogi_display").val(""); return; }
    $("#m_tf_hogi_display").val(parseInt(val) <= 2 ? "TF1 (1호기)" : "TF2 (2호기)");
}

function requestPattern() {
    var bcfHogi    = $("#m_bcf_hogi").val();
    var bcfCycleNo = $("#m_bcf_cycle_no").val();
    var tfCycleNo  = $("#m_tf_cycle_no").val();

    if (!bcfHogi)    { alert("침탄로 호기를 선택하세요."); return; }
    if (!bcfCycleNo) { alert("침탄로 패턴번호를 입력하세요."); return; }
    if (!tfCycleNo)  { alert("소려로 패턴번호를 입력하세요."); return; }

    var tfHogi = (parseInt(bcfHogi) <= 2) ? 1 : 2;

    stopPatternPoll();
    patternReceived = false;
    $("#patternResult,#patternTimeout").hide();
    $("#patternLoading").show();
    $("#btnPatternSearch").prop("disabled", true).css("opacity", "0.6");
    patternPollSec = 0;
    $("#pollCount").text("0");

    $.ajax({
        url: "/mibogear/workOrder/pattern/request",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            auto_pattern: $("#m_auto_pattern").val() || null,
            bcf_cycle_no: parseInt(bcfCycleNo),
            tf_cycle_no:  parseInt(tfCycleNo),
            bcf_hogi:     parseInt(bcfHogi),
            tf_hogi:      tfHogi
        }),
        dataType: "json",
        success: function (res) {
            if (res.status === "success") {
                startPatternPoll();
            } else {
                alert("패턴 요청 오류: " + res.message);
                $("#patternLoading").hide();
                $("#btnPatternSearch").prop("disabled", false).css("opacity", "1");
            }
        },
        error: function () {
            alert("패턴 요청 중 오류가 발생했습니다.");
            $("#patternLoading").hide();
            $("#btnPatternSearch").prop("disabled", false).css("opacity", "1");
        }
    });
}

function startPatternPoll() {
    patternPollTimer = setInterval(function () {
        patternPollSec++;
        $("#pollCount").text(patternPollSec);

        if (patternPollSec >= MAX_POLL_SEC) {
            stopPatternPoll();
            $("#patternLoading").hide();
            $("#patternTimeout").show();
            $("#btnPatternSearch").prop("disabled", false).css("opacity", "1");
            return;
        }

        $.ajax({
            url: "/mibogear/workOrder/pattern/status",
            type: "GET",
            dataType: "json",
            success: function (res) {
                if (res.patternStatus === 2) {
                    stopPatternPoll();
                    patternReceived = true;
                    fillPatternResult(res.data);
                    $.post("/mibogear/workOrder/pattern/complete");
                    $("#patternLoading").hide();
                    $("#patternResult").show();
                    $("#btnPatternSearch").prop("disabled", false).css("opacity", "1");
                    alert("패턴 조회가 완료되었습니다.");
                }
            }
        });
    }, 2000);
}

function stopPatternPoll() {
    if (patternPollTimer) {
        clearInterval(patternPollTimer);
        patternPollTimer = null;
    }
}

function fillPatternResult(d) {
    if (!d) return;

    // BCF 침탄로
    $("#bcf_time_fanup").val(d.bcf_time_fanup  != null ? d.bcf_time_fanup  : "");
    $("#bcf_time_chim").val(d.bcf_time_chim    != null ? d.bcf_time_chim   : "");
    $("#bcf_time_diff").val(d.bcf_time_diff    != null ? d.bcf_time_diff   : "");
    $("#bcf_time_gang").val(d.bcf_time_gang    != null ? d.bcf_time_gang   : "");
    $("#bcf_time_que").val(d.bcf_time_que      != null ? d.bcf_time_que    : "");
    $("#bcf_time_drain").val(d.bcf_time_drain  != null ? d.bcf_time_drain  : "");

    $("#bcf_temp_fanup").val(d.bcf_temp_fanup  != null ? d.bcf_temp_fanup  : "");
    $("#bcf_temp_chim").val(d.bcf_temp_chim    != null ? d.bcf_temp_chim   : "");
    $("#bcf_temp_diff").val(d.bcf_temp_diff    != null ? d.bcf_temp_diff   : "");
    $("#bcf_temp_gang").val(d.bcf_temp_gang    != null ? d.bcf_temp_gang   : "");
    // 퀜칭/드레인 온도는 동일한 값으로 표시
    $("#bcf_temp_que_drain").val(d.bcf_temp_que != null ? d.bcf_temp_que   : "");

    $("#bcf_cp_fanup").val(d.bcf_cp_fanup      != null ? d.bcf_cp_fanup    : "");
    $("#bcf_cp_chim").val(d.bcf_cp_chim        != null ? d.bcf_cp_chim     : "");
    $("#bcf_cp_diff").val(d.bcf_cp_diff        != null ? d.bcf_cp_diff     : "");
    $("#bcf_cp_gang").val(d.bcf_cp_gang        != null ? d.bcf_cp_gang     : "");
    $("#bcf_cp_que_drain").val("");  // CP없는 구간

    // TF 소려로
    $("#tf_time_dry").val(d.tf_time_dry        != null ? d.tf_time_dry     : "");
    $("#tf_time_fanup").val(d.tf_time_fanup    != null ? d.tf_time_fanup   : "");
    $("#tf_time_n2").val(d.tf_time_n2          != null ? d.tf_time_n2      : "");
    $("#tf_time_tem").val(d.tf_time_tem        != null ? d.tf_time_tem     : "");
    $("#tf_time_cool").val(d.tf_time_cool      != null ? d.tf_time_cool    : "");

    // TF 소려로 온도는 소려 온도 하나로 표시 (실제 처리온도)
    $("#tf_temp_tem").val(d.tf_temp_tem        != null ? d.tf_temp_tem     : "");
}
function doResetPattern() {
    stopPatternPoll();
    patternReceived = false;
    $("#m_bcf_hogi").val("");
    $("#m_tf_hogi_display").val("");
    $("#m_auto_pattern,#m_bcf_cycle_no,#m_tf_cycle_no").val("");
    $("#patternLoading,#patternResult,#patternTimeout").hide();
    $("#btnPatternSearch").prop("disabled", false).css("opacity", "1");
    $.post("/mibogear/workOrder/pattern/reset");
}

/* ============================================================ */
/* 드래그                                                         */
/* ============================================================ */
var isDragging = false, startX, startY, mLeft, mTop;
$("#woModalHeader").on("mousedown", function (e) {
    if ($(e.target).hasClass("modal-close-btn")) return;
    isDragging = true;
    var offset = $("#woModal").offset();
    startX = e.pageX; startY = e.pageY;
    mLeft = offset.left; mTop = offset.top;
    $("#woModal").css("transform", "none");
    e.preventDefault();
});
$(document).on("mousemove", function (e) {
    if (isDragging) $("#woModal").css({ left:(mLeft+e.pageX-startX)+"px", top:(mTop+e.pageY-startY)+"px" });
}).on("mouseup", function () { isDragging = false; });

/* ============================================================ */
/* 유틸                                                           */
/* ============================================================ */
function todayDate() {
    var d = new Date();
    return d.getFullYear() + "-" + String(d.getMonth()+1).padStart(2,"0") + "-" + String(d.getDate()).padStart(2,"0");
}
function yesterDate() {
    var d = new Date(); d.setDate(d.getDate()-1);
    return d.getFullYear() + "-" + String(d.getMonth()+1).padStart(2,"0") + "-" + String(d.getDate()).padStart(2,"0");
}
function monthAgoDate() {
    var d = new Date(); d.setMonth(d.getMonth()-1);
    return d.getFullYear() + "-" + String(d.getMonth()+1).padStart(2,"0") + "-" + String(d.getDate()).padStart(2,"0");
}
</script>
</body>
</html>
