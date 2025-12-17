
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>온도조절계보정현황</title>
    <%@include file="../include/pluginpage.jsp" %>
    <jsp:include page="../include/tabBar.jsp"/>
    <link href="https://unpkg.com/tabulator-tables@5.5.0/dist/css/tabulator.min.css" rel="stylesheet">
    <style>
.container {
	max-width: 95%;
	margin: 0 auto;
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

.button-container {
	display: flex;
	gap: 10px;
}

.box1 {
	display: flex;
	align-items: center;
	margin-right: auto;
	color: white;
	font-weight: bold;
}

.tabulator {
	background: white;
	border-radius: 6px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 80px;
}

.daylabel {
	margin: 0 10px;
}

.daySet {
	padding: 6px 10px;
	font-size: 14px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

.button-image {
	width: 16px;
	height: 16px;
}

.select-button, .insert-button, .delete-button, .excel-download-button,
	.excel-upload-button {
	height: 36px;
	padding: 6px 10px;
	font-size: 13px;
	border-radius: 4px;
	background: white;
	border: 1px solid #aaa;
	display: flex;
	align-items: center;
	gap: 5px;
	cursor: pointer;
}

.box1 {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-left: 20px;
	font-size: 14px;
}

.box1 label {
	font-weight: bold;
	margin-right: 5px;
}

.box1 select {
	padding: 4px 10px;
	font-size: 14px;
	height: 32px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

.button-container label {
	font-weight: bold;
	margin-right: 5px;
	height: 37px;
	padding-top:3px;
}

.button-container select {
	padding: 4px 10px;
	font-size: 14px;
	height: 37px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

.box1 .tabP {
	font-size: 16px;
	font-weight: bold;
	color: white;
	margin: 0 10px 0 0;
}
.modal {
  position: fixed;
  z-index: 9999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.4); /* 반투명 검정 배경 */
}

/* 모달 본문 */
.modal-content {
  background-color: #fff;
  margin: 15% auto;
  padding: 20px;
  border-radius: 8px;
  width: 300px;
  text-align: center;
  box-shadow: 0px 0px 15px rgba(0,0,0,0.3);
  animation: fadeIn 0.3s ease-in-out;
}

/* 모달 애니메이션 */
@keyframes fadeIn {
  from { opacity: 0; margin-top: 50px; }
  to { opacity: 1; margin-top: 15%; }
}

/* 버튼 스타일 (선택 사항) */
.modal-content button {
  margin: 8px;
  padding: 6px 12px;
  font-size: 14px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
</style>
</head>
<body>

	<div class="tab">
		<div class="box1">
			<p class="tabP">조건관리 - 열전대교체이력</p>
		</div>
		<div class="button-container">
			<label for="sdate">년도 선택:</label> 
			<select id="sdate">
				<option value="2025">2025</option>
				<option value="2026">2026</option>
				<option value="2027">2027</option>
			</select>
<!-- 			<label for="sdate">설비 선택:</label> 
			<select id="machine_name">
				<option value="BCF-1">BCF-1</option>
				<option value="BCF-2">BCF-2</option>
				<option value="BCF-3">BCF-3</option>
				<option value="BCF-4">BCF-4</option>				
				<option value="TF-1">TF-1</option>
				<option value="TF-2">TF-2</option>
			</select> -->
		
			<button class="select-button" onclick="getTempCorrectionList();">
				<img src="/mibogear/css/tabBar/search-icon.png" alt="select"
					class="button-image">조회
			</button>
<!-- 			<button class="insert-button">
				<img src="/mibogear/css/tabBar/add-outline.png" alt="insert"
					class="button-image">추가
			</button> -->
			<button class="delete-button">
				<img src="/mibogear/css/tabBar/xDel3.png" alt="delete"
					class="button-image">삭제
			</button>
<!-- 			<button class="excel-download-button">
				<img src="/mibogear/css/tabBar/excel-icon.png" alt="excel"
					class="button-image">엑셀다운로드
			</button>
			<button class="excel-upload-button">
				<img src="/mibogear/css/tabBar/excel-icon.png" alt="excel"
					class="button-image">엑셀업로드
			</button> -->
			<input type="file" id="fileInput" style="display: none;">
		</div>
	</div>

	<main class="main">
		<div class="container">
			<h3 id="machineTitle">퀜칭로</h3>
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	
	<div id="inputModal" class="modal" style="display:none;">
	  <div class="modal-content">
	    <h3 id="modalTitle"></h3>
	    <input type="text" id="inputValue">
	    <input type="date" id="dateValue" style="display:none;">
	    <button onclick="saveInput()">저장</button>
	    <button onclick="closeModal()">닫기</button>
	  </div>
	</div>

	<script>
		//전역변수
		let now_page_code = "c02";

		$(function() {
			updateMachineTitle(); 
	        
/* 	        $("#machine_name").on('change', function() {
	            updateMachineTitle();
	        }); */
	        
			getTempCorrectionList();
		});
		function getTempCorrectionList() {
			corrQue = new Tabulator("#tab1", {
		        height: "578px",
		        layout: "fitColumns",
		        selectable: true,
		        tooltips: true,
		        selectableRangeMode: "click",
		        reactiveData: true,
		        headerHozAlign: "center",
		        ajaxConfig: "POST",
		        ajaxLoader: false,
		        ajaxURL: "/mibogear/condition/tempCorrection/tempCorrectionList",
		        ajaxParams: {
		            year: $("#sdate").val()
		            //machine_name: $("#machine_name").val()
		        },

		        ajaxResponse: function (url, params, response) {
		            $("#tab1 .tabulator-col.tabulator-sortable").css("height", "55px");
		            return response; // 리스트 전체 반환
		        },
		        placeholder: "조회된 데이터가 없습니다.",
		        paginationSize: 20,
		        columns: [
		        	{
		        		title:"temp_correction_id",
		        		field:"temp_correction_id",
		        		visible:false		        		
		        	},
		            {
		                title: "구분",
		                field: "machine_name",
		                hozAlign: "center",
		                width: 120
		            },
		            {
		                title: "보정전",
		                field: "before_correction",
		                hozAlign: "center",
		                editor: "input"
		            },
		            {
		                title: "상반기 보정",
		                field: "first_correction",
		                hozAlign: "center",
		                editor: "input"
		            },
		            {
		                title: "하반기 보정",
		                field: "second_correction",
		                hozAlign: "center",
		                editor: "input"
		            }
		        ],
		        rowFormatter: function (row) {
		            row.getElement().style.fontWeight = "600";
		            row.getElement().style.backgroundColor = "#fdfdfd";
		        },
		        cellEdited: function(cell) {
				    var field = cell.getField(); 
				    var value = cell.getValue(); 
				    var rowData = cell.getRow().getData(); 
				    var temp_correction_id = rowData.temp_correction_id; 

				    $.ajax({
				        url: "/mibogear/condition/tempCorrection/updateTempCorrectionField",
				        type: "POST",
				        dataType:"json",			        
				        data: {
				        	"c_field":field,
				        	"c_value":value,
				        	"temp_correction_id":temp_correction_id
				        },
				        success: function(result) {
				        	
				        }
				    });
				}
		    });
		}


		function updateMachineTitle() {
	        const selectedMachine = $("#machine_name option:selected").text(); // 선택된 옵션의 텍스트(예: BCF-1)
	        $("#machineTitle").text(selectedMachine); // <h3> 태그의 텍스트를 업데이트
	        
	        // Tabulator를 다시 로드하거나 필터링해야 하는 경우 여기에 getTempCorrectionList()를 호출할 수 있습니다.
	        // getTempCorrectionList(); 
	    }
		function closeModal() {
		    $("#inputModal").hide();
		}
	</script>
</body>
</html>
