<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알람발생 빈도</title>
	<%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/>
</head>
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            margin-left: 1008px;
            margin-top: 200px;
        }
        .view {
            display: flex;
            justify-content: center;
            margin-top: 1%;
        }
        .tab {
            width: 95%;
            margin-bottom: 37px;
            margin-top: 5px;
            height: 45px;
            border-radius: 6px 6px 0px 0px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .modal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: opacity 0.3s ease-in-out;
        }
	    .modal-content {
	        background: white;
	        width: 24%;
	        max-width: 500px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
        .modal.show {
            display: block;
            opacity: 1;
        }
        .modal.show .modal-content {
            transform: scale(1);
            opacity: 1;
        }
        .close {
            background-color:white;
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }
        .closePumbun {
            background-color:white;
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }
        .modal-content form {
            display: flex;
            flex-direction: column;
        }
        .modal-content label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        .modal-content input, .modal-content textarea {
            width: 97%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal-content button {
            background-color: #d3d3d3;
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .modal-content button:hover {
            background-color: #a9a9a9;
        }
        
        .button-container {
    		display: flex;
		    gap: 10px;
		    margin-left: auto;
		    margin-right: 10px;
		    margin-top: 40px;
		}
		.box1 {
		    display: flex;
		    justify-content: right;
		    align-items: center;
		    width: 800px;
		    margin-right: 20px;
		    margin-top:4px;
		}
        .dayselect {
            width: 20%;
            text-align: center;
            font-size: 15px;
        }
        .daySet {
        	width: 20%;
      		text-align: center;
            height: 16px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
        .daylabel {
            margin-right: 10px;
            margin-bottom: 13px;
            font-size: 18px;
            margin-left: 20px;
        }
        button-container.button{
        height: 16px;
        }
         .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;
	    height: 42px;
	    margin-left: 9px;
        }
        .row_select {
	    background-color: #ffeeba !important;
	    }
	    .excel-download-button,
		.excel-upload-button {
  		  height: 40px;
  		  background-color: white; 
   		  border: 1px solid black; 
   		  border-radius: 4px;
   		  padding: 4px 10px; 
   		  display: flex;
  		  align-items: center;
  		  gap: 5px;
  		  cursor: pointer;
        }

        /* ✅ 숨김 해제 버튼 */
        .reset-button {
            height: 40px;
            padding: 0 11px;
            border: 1px solid #dc3545;
            border-radius: 4px;
            background-color: #fff0f0;
            color: #dc3545;
            cursor: pointer;
            font-weight: bold;
        }
        .reset-button:hover {
            background-color: #dc3545;
            color: white;
        }

        .button-image {
            width: 16px; 
            height: 16px;
        }

        .pumbunModal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: opacity 0.3s ease-in-out;
        }
	    .pumbun-modal-content {
	        background: white;
	        width: 60%;
	        max-width: 1200px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
        .pumbunModal.show {
            display: block;
            opacity: 1;
        }
        .pumbunModal.show .pumbun-modal-content {
            transform: scale(1);
            opacity: 1;
        }
        .pumbun-modal-content button {
            background-color: #d3d3d3;
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .pumbun-modal-content button:hover {
            background-color: #a9a9a9;
        }
        .pumbun-modal-content form {
            display: flex;
            flex-direction: column;
        }
        .pumbun-modal-content label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        .pumbun-modal-content input, .pumbun-modal-content textarea {
            width: 97%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

    body{ background:#fff; font-family:"Noto Sans KR", "맑은 고딕", sans-serif; color:#222; margin:0; padding:0; overflow: hidden; }
    .main {
        max-width:1800px;
        margin:18px auto;
        padding:16px;
        height: 100%;
        overflow: hidden;
    }
    .card.fixed-height #tableHeatTopWrapper,
    .card.fixed-height #tableAlarmWrapper,
    .card.fixed-height #tableHeatWrapper {
        flex: 1;
        overflow-y: auto;
        height: 100px;
    }
    body, html {
        height: 100%;
        overflow: hidden;
    }
    .header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:14px; }
    .title{ font-size:20px; font-weight:700; }
    .subtitle{ font-size:13px; color:#6b7280; }
    .grid{ display:flex; gap:18px; margin-bottom:18px; }
    .card{
        background:#fff;
        border-radius:10px;
        padding:16px;
        box-shadow:0 6px 18px rgba(2,6,23,0.06);
        border:1px solid rgba(2,6,23,0.04);
        flex:1;
        min-width:330px;
    }
    .card .card-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:8px; }
    .card-title{ font-weight:700; font-size:14px; }
    .card-sub{ font-size:12px; color:#6b7280; }
    table { width:100%; border-collapse:collapse; font-size:13px; }
    thead th {
        text-align:center;
        padding:6px 6px;
        background:#f3f6fb;
        border-bottom:1px solid #e6eefc;
        font-weight:700;
        height:34px;
    }
    tbody td {
        padding:6px 6px;
        border-bottom:1px solid #f1f5f9;
        text-align:center;
        height:36px;
        line-height:18px;
        white-space:nowrap;
        overflow:hidden;
        text-overflow:ellipsis;
    }
    tbody tr:hover { background:#fbfdff; cursor:pointer; }
    tbody tr.selected { background: linear-gradient(90deg, rgba(11,99,206,0.06), rgba(11,99,206,0.02)); font-weight:700; }
    .kpi { display:flex; gap:8px; }
    .kpi .item{ flex:1; background:#fbfcff; padding:6px; border-radius:8px; text-align:center; }
    .kpi .label{ font-size:12px; color:#6b7280; }
    .kpi .value{ font-size:16px; font-weight:800; color:#111827; }
    .btn{ display:inline-flex; align-items:center; gap:8px; padding:8px 12px; border-radius:8px; border:0; cursor:pointer; font-weight:700; }
    .btn.primary{ background:#0b63ce; color:#fff; }
    .btn.work{ background:#A566FF; color:#fff; }
    .btn.ghost{ background:#fff; color:#111; border:1px solid rgba(2,6,23,0.06); }
    .small-input{ padding:6px 8px; border-radius:6px; border:1px solid #e6eefc; }
    .muted{ color:#6b7280; font-size:12px; }
    .temp { color:#e63946; font-weight:800; }
    .cp { color:#0b63ce; font-weight:800; }
    #tableHeatTopWrapper { height:150px; overflow:auto; }
    #tableHeatWrapper { height:420px; overflow:auto; }
    #tableAlarm { }
    #tableAlarm tbody { }
    #tableAlarmWrapper { height:1380px; overflow:auto; }
    .temp-table thead th{ padding:6px 6px; font-size:12px; color:#6b7280; }
    .temp-table tbody td{ padding:8px 6px; font-size:16px; height:36px; }
    @media (max-width:1100px){ .grid{ flex-direction:column; } }

    .mchSelect {
        margin-right: 10px;
        margin-bottom: 13px;
        font-size: 20px;
        margin-left: -120px;
        margin-top: 3px;
    }
    #machineSelect{
        font-size: 16px; 
        margin: 5px; 
        border-radius: 4px; 
        border: 1px solid #ccc; 
        text-align: center; 
        height: 34px; 
        width: 75px;
    }
    #tableAlarm {
        width: 100%;
        border-collapse: collapse;
    }
    #tableAlarm th:nth-child(1) { width: 100px; }
    #tableAlarm th:nth-child(2) { width: 300px; }
    #tableAlarm th:nth-child(3) { width: auto; }
    #tableAlarm th:nth-child(4) { width: 100px; }
    </style>

<body>
    <main class="main">
        <div class="tab">
            <div class="button-container">
               <div class="box1">
                    <div class="mchSelect">
                        <label>호기 선택</label>
                        <select id="machineSelect">
                            <option value="" selected>전체</option>
                            <option value="bcf1">BCF1</option>
                            <option value="bcf2">BCF2</option>
                            <option value="bcf3">BCF3</option>
                            <option value="bcf4">BCF4</option>
                            <option value="cm">CM</option>
                            <option value="cm2">CM2</option>
                        </select>
                    </div>
                    <label class="daylabel">조회일자 :</label>
                    <input type="text" id="s_sdate" class="dayselect daySet"/>
                    <label for="">~</label>
                    <input type="text" id="s_edate" class="dayselect daySet"/>
                </div>
                <button class="select-button">
                    <img src="/mibogear/image/search-icon.png" alt="select" class="button-image">조회
                </button>
                <!-- ✅ 숨김 해제 버튼 -->
                <button id="resetHiddenBtn" class="reset-button">
                    🔄 숨김 해제
                </button>
                <span id="hiddenCount" style="margin-left:10px; font-size:13px; color:#888;"></span>
            </div>
        </div>

        <div class="card card" style="flex:0.55;">
            <div class="card-header">
                <div>
                    <div class="card-title"></div>
                    <div class="card-sub"></div>
                </div>
            </div>
            <div id="tableAlarmWrapper" style="max-height:860px; overflow:auto;">
                <table id="tableAlarm">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>PLC주소</th>
                            <th>알람내용</th>
                            <th>발생 수</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </main>
    
<script>
let now_page_code = "a04";

var selectedRowData = null;

// ✅ 숨김 처리된 주소 목록 (localStorage 유지)
let hiddenAlarmRanking = JSON.parse(localStorage.getItem('hiddenAlarmRanking') || '[]');

// ✅ 숨김 카운트 표시
function updateHiddenCount() {
    const count = hiddenAlarmRanking.length;
    $("#hiddenCount").text(count > 0 ? "숨김: " + count + "개" : "");
}

// ✅ 숨김 해제
$("#resetHiddenBtn").on("click", function() {
    if (hiddenAlarmRanking.length === 0) {
        alert("숨겨진 알람이 없습니다.");
        return;
    }
    if (confirm("숨긴 알람 " + hiddenAlarmRanking.length + "개를 모두 다시 표시하겠습니까?")) {
        hiddenAlarmRanking = [];
        localStorage.removeItem('hiddenAlarmRanking');
        updateHiddenCount();
        fetchAlarm();
    }
});

// ✅ tbody 더블클릭 이벤트
$(document).on("dblclick", "#tableAlarm tbody tr", function() {
    var rowData = $(this).data("rowdata");
    if (!rowData) return;

    var addr    = rowData.alarm_address;
    var comment = rowData.comment || addr;

    if (hiddenAlarmRanking.includes(addr)) return;

    if (confirm("'" + comment + "' 알람을 숨기겠습니까?")) {
        hiddenAlarmRanking.push(addr);
        localStorage.setItem('hiddenAlarmRanking', JSON.stringify(hiddenAlarmRanking));
        $(this).hide();
        updateHiddenCount();
    }
});

$(function() {
    $("#s_sdate").val(yesterDate());
    $("#s_edate").val(todayDate());
    updateHiddenCount();
    fetchAlarm();
});

$('.select-button').click(function() {
    fetchAlarm();
});

function fetchAlarm(){
    $.ajax({
        url: "/mibogear/monitoring/getAlarmRankingList",
        method: "POST",
        data: {
            startDate:    $("#s_sdate").val(),
            endDate:      $("#s_edate").val(),
            machine_name: $("#machineSelect").val()
        },
        dataType: "json",
        success: function(resp){
            var arr = Array.isArray(resp) ? resp : (resp.data || resp.rows || (resp ? [resp] : []));
            var $tbody = $("#tableAlarm tbody").empty();

            if(!arr || arr.length === 0){
                $tbody.append('<tr><td colspan="4">조회된 데이터가 없습니다.</td></tr>');
                return;
            }

            arr.forEach(function(r, idx){
                var tr = $("<tr></tr>");
                tr.append("<td>"+(idx+1)+"</td>");
                tr.append("<td>"+(r.alarm_address || "")+"</td>");
                tr.append("<td>"+(r.comment || "")+"</td>");
                tr.append("<td>"+(r.alarm_count || "")+"</td>");
                tr.data("rowdata", r);

                // ✅ 숨김 처리된 주소면 hide
                if(hiddenAlarmRanking.includes(r.alarm_address)){
                    tr.hide();
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