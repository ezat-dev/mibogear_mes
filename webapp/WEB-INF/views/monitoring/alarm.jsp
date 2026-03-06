<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>알람현황</title>
<%@include file="../include/pluginpage.jsp"%>
<jsp:include page="../include/tabBar.jsp" />
<style>
.main {
	width: 98%;
}

.container {
	display: flex;
	gap: 14px;
}

#alarmTable1, #alarmTable2, #alarmTable3, #alarmTable4 {
	font-size: 13px;
}

.tabb {
	width: 90%;
	margin-bottom: 22px;
	margin-top: 5px;
	height: 30px;
	border-radius: 6px 6px 0px 0px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.machine-select-button {
	height: 32px;
	padding: 0 11px;
	border: 1px solid rgb(53, 53, 53);
	border-radius: 4px;
	background-color: #ffffff;
	cursor: pointer;
	display: flex;
	align-items: center;
}

.reset-button {
	height: 32px;
	padding: 0 11px;
	border: 1px solid #dc3545;
	border-radius: 4px;
	background-color: #fff0f0;
	color: #dc3545;
	cursor: pointer;
	display: flex;
	align-items: center;
	font-weight: bold;
	margin-left: 8px;
}

.reset-button:hover {
	background-color: #dc3545;
	color: white;
}

.box1 label {
	font-size: 1.1em;
	margin-right: 5px;
}

#machine_name {
	height: 30px;
	padding: 0 11px;
	border: 1px solid rgb(53, 53, 53);
	border-radius: 4px;
	font-size: 1.0em;
	vertical-align: middle;
}

.button-container {
	display: flex;
	align-items: center;
}

.hidden-count {
	margin-left: 12px;
	font-size: 13px;
	color: #888;
}
</style>
</head>
<body>
	<div class="tabb">
		<div class="box1">
			<p class="tabP"
				style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
		</div>
		<div class="button-container">
			<div class="box1">
				<label for="machime_select">설비 선택:</label>
				<select id="machine_name">
					<option value="BCF1">BCF1</option>
					<option value="BCF2">BCF2</option>
					<option value="BCF3">BCF3</option>
					<option value="BCF4">BCF4</option>
					<option value="CM">CM</option>
					<option value="CM2">CM2</option>
				</select>
			</div>
			<button class="machine-select-button" onclick="getAlarm1();">
				<img src="/mibogear/image/search-icon.png" alt="select"
					class="button-image"> 조회
			</button>
			<!-- ✅ 숨김 해제 버튼 -->
			<button class="reset-button" onclick="resetHiddenAlarms();">
				🔄 숨김 해제
			</button>
			<span class="hidden-count" id="hiddenCount"></span>
		</div>
	</div>

	<main class="main">
		<div class="container">
			<div id="alarmTable1" class="tabulator"></div>
			<div id="alarmTable2" class="tabulator"></div>
			<div id="alarmTable3" class="tabulator"></div>
			<div id="alarmTable4" class="tabulator"></div>
		</div>
	</main>

	<script>
	let now_page_code = "a02";

	let alarmTable1, alarmTable2, alarmTable3, alarmTable4;

	// ✅ 숨김 처리된 주소 목록 (localStorage 유지)
	let hiddenAddrs = JSON.parse(localStorage.getItem('hiddenAlarmAddrs') || '[]');

	// ✅ 숨김 카운트 표시
	function updateHiddenCount() {
	    const count = hiddenAddrs.length;
	    $("#hiddenCount").text(count > 0 ? "숨김: " + count + "개" : "");
	}

	// ✅ 공통 Tabulator 생성 함수
	function makeAlarmTable(id) {
	    return new Tabulator(id, {
	        height: "750px",
	        layout: "fitColumns",
	        headerHozAlign: "center",
	        data: [],
	        placeholder: "조회된 데이터가 없습니다.",
	        columns: [
	            {title: "idx",       field: "idx",       hozAlign: "center", visible: false},
	            {title: "NO",        field: "r_num",      hozAlign: "center", width: 30,  headerSort: false},
	            {title: "호기",      field: "alarm_hogi", hozAlign: "center", width: 60,  headerSort: false, visible: false},
	            {title: "주소",      field: "addr",       hozAlign: "center", width: 70,  headerSort: false},
	            {title: "알람 내용", field: "comment",                        width: 280, headerSort: false},
	            {title: "값",        field: "value",      hozAlign: "center", width: 80,  headerSort: false, visible: false}
	        ],
	        rowFormatter: function(row) {
	            var data = row.getData();
	            row.getElement().style.fontWeight = "700";
	            row.getElement().style.backgroundColor = "#FFFFFF";

	            if (data.value == 1) {
	                row.getElement().style.backgroundColor = "#FFDDDD";
	            }

	            // ✅ 숨김 처리된 행 숨기기
	            if (hiddenAddrs.includes(data.addr)) {
	                row.getElement().style.display = "none";
	            }
	        },
	        // ✅ 더블클릭 시 숨김 처리
	        rowDblClick: function(e, row) {
	            var data  = row.getData();
	            var addr  = data.addr;
	            var comment = data.comment || addr;

	            if (hiddenAddrs.includes(addr)) return;

	            if (confirm("'" + comment + "' 알람을 숨기겠습니까?")) {
	                hiddenAddrs.push(addr);
	                localStorage.setItem('hiddenAlarmAddrs', JSON.stringify(hiddenAddrs));
	                row.getElement().style.display = "none";
	                updateHiddenCount();
	            }
	        }
	    });
	}

	// ✅ 숨김 해제
	function resetHiddenAlarms() {
	    if (hiddenAddrs.length === 0) {
	        alert("숨겨진 알람이 없습니다.");
	        return;
	    }
	    if (confirm("숨긴 알람 " + hiddenAddrs.length + "개를 모두 다시 표시하겠습니까?")) {
	        hiddenAddrs = [];
	        localStorage.removeItem('hiddenAlarmAddrs');
	        updateHiddenCount();
	        getAlarm1();
	    }
	}

	// 로드
	$(function(){
	    alarmTable1 = makeAlarmTable("#alarmTable1");
	    alarmTable2 = makeAlarmTable("#alarmTable2");
	    alarmTable3 = makeAlarmTable("#alarmTable3");
	    alarmTable4 = makeAlarmTable("#alarmTable4");

	    updateHiddenCount();
	    getAlarm1();
	});

	// 10초 자동 갱신
	const alarmInterval = setInterval(getAlarm1, 10000);

	function getAlarm1(){
	    console.log("getAlarm1 함수 실행");
	    var machine_name = $("#machine_name").val();

	    $.ajax({
	        url: "/mibogear/monitoring/getAlarm1",
	        type: "POST",
	        dataType: "json",
	        contentType: "application/json;charset=UTF-8",
	        data: JSON.stringify({ machine_name: machine_name }),
	        success: function(allData) {
	            var data1 = allData.slice(0, 25);
	            var data2 = allData.slice(25, 50);
	            var data3 = allData.slice(50, 75);
	            var data4 = allData.slice(75, 100);

	            if(alarmTable1) alarmTable1.setData(data1);
	            if(alarmTable2) alarmTable2.setData(data2);
	            if(alarmTable3) alarmTable3.setData(data3);
	            if(alarmTable4) alarmTable4.setData(data4);

	            console.log("Tabulator에 데이터 로드 완료");
	        },
	        error: function(xhr, status, error) {
	            console.error("데이터 조회 오류:", error);
	            if(alarmTable1) alarmTable1.clearData();
	            if(alarmTable2) alarmTable2.clearData();
	            alert("데이터를 불러오는데 실패했습니다.");
	        }
	    });

	    if(machine_name.includes('BCF')){
	        $('#alarmTable3').hide();
	        $('#alarmTable4').hide();
	    } else {
	        $('#alarmTable3').show();
	        $('#alarmTable4').show();
	    }
	}
	</script>

</body>
</html>