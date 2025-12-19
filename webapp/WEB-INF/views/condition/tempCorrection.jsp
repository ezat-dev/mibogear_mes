
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
	.excel-upload-button, #printBtn {
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

/* 버튼 스타일 (선택 사항) */
.modal-content button {
  margin: 8px;
  padding: 6px 12px;
  font-size: 14px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
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
		    overflow: auto;
		    z-index:20010;
		}
				.modal-content {
		    background: white;
		    width: 60%; /* 가로 길이를 50%로 설정 */
		    max-width: 600px; /* 최대 너비를 설정하여 너무 커지지 않도록 */
		    max-height: 800px; /* 화면 높이에 맞게 제한 */
		    overflow-y: auto;
		    margin: 2% auto; /* 수평 중앙 정렬 */
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
		    background-color: white;
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
		    width: 60%;
		    padding: 8px;
		    margin-bottom: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}

		.modal-content select {
		    width: 104%;
		    height: 38px;
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
		/* 1. Zebra striping 완전 제거 (모든 행 배경 동일하게) */
.tabulator .tabulator-row-even,
.tabulator .tabulator-row-odd {
    background-color: #ffffff !important;   /* 원하는 기본 배경색 (white 추천) */
    /* 만약 약간 회색 톤 원하면 #fdfdfd 나 #f9f9f9 로 변경 */
}

/* 2. Hover 효과 추가 (커서 올리면 행 색상 변경) */
.tabulator .tabulator-row:hover {
    background-color: #eaeaea !important;   /* 연한 파랑 추천 (aliceblue) */
    /* 다른 색 원하면 #ffffe0 (연한 노랑), #f5f5f5 (연한 회색) 등으로 변경 */
    transition: background-color 0.2s ease; /* 부드러운 전환 효과 (선택) */
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
 			<button class="insert-button">
				<img src="/mibogear/css/tabBar/add-outline.png" alt="insert"
					class="button-image">추가
			</button> 
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
			<button id="printBtn">
				    🖨️ 인쇄
				</button> 
			<input type="file" id="fileInput" style="display: none;">
		</div>
	</div>

	<main class="main">
		<div class="container">
			<h3 id="machineTitle">퀜칭로</h3>
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>

<!-- 추가 모달 -->
<div id="modalContainer" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <!-- 추가, 수정 -->
    <h2>트렌드 데이터 등록</h2>
    <form id="corrForm" autocomplete="off">
      <label>구분</label>
	  <input type="text"  name="machine_name" >

      <label>보정 전</label>
      <input type="text"  name="before_correction" >

      <label>상반기 보정</label>
      <input type="text" name="first_correction">

      <label>하반기 보정</label>
	  <input type="text" name="second_correction">
		
      <button type="submit" id="saveCorrStatus">저장</button>
      <button type="button" id="closeModal">닫기</button>
    </form>
  </div>
</div>
	<script>
		//전역변수
		let now_page_code = "c02";
		let temp_correction_id = "";
		 document.getElementById('printBtn').addEventListener('click', function() {
			    const style = document.createElement('style');
			    style.innerHTML = `
			        @page {
			            size: A4 landscape;
			            margin: 10mm;
			        }
			        @media print {
			            body { zoom: 67%; }
			            #container { width: 1700px !important; max-width: 1700px !important; height: 660px !important; }
			        }
			    `;
			    document.head.appendChild(style);
			    window.print();
			    setTimeout(() => { document.head.removeChild(style); }, 1000);
			});
		$(function() {
			updateMachineTitle(); 
	        
/* 	        $("#machine_name").on('change', function() {
	            updateMachineTitle();
	        }); */
	        
			getTempCorrectionList();
		});
		function getTempCorrectionList() {
			corrQue = new Tabulator("#tab1", {
		        height: "640px",
		        layout: "fitColumns",
		        //selectable: true,
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
		                title: "년도",
		                field: "year",
		                hozAlign: "center",
		                width: 120
		            },
		            {
		                title: "구분",
		                field: "machine_name",
		                hozAlign: "center",
		                editor: "input",
		                width: 120
		            },
		            {
		                title: "보정 전",
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
		            //row.getElement().style.backgroundColor = "#fdfdfd";
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
				},
				rowClick: function(e, row) {
			        var rowData = row.getData();
			        
			        temp_correction_id = rowData.temp_correction_id;
			        
			        console.log("클릭한 행의 ID:", temp_correction_id);
			    },
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

		//추가버튼 클릭시
		$(".insert-button").on("click", function(){
	    $('#modalContainer').show().addClass('show');
});
		//모달 닫기
		$('.close, #closeModal').click(function() { $('#corrForm')[0].reset(); $('#modalContainer').removeClass('show').hide(); });

		//저장버튼 클릭시
		$('#saveCorrStatus').click(function(event){
	    event.preventDefault();
	    var formData = new FormData($('#corrForm')[0]);
	    var year = $('#sdate').val();
	    formData.append("year", year);
	    $.ajax({
	      url:"/mibogear/condition/tempCorrectionInsert",
	      type:"POST",
	      data: formData,
	      processData: false,
	      contentType: false,
	      success: function (result) {
	    	    if (result === true) {
	    	        alert("저장되었습니다!");
	    	        $('#modalContainer').hide();
	    	        $('#corrForm')[0].reset();
	    	        getTempCorrectionList();
	    	    }else{
					alert("저장 실패했습니다.");
	        	    }
	    	},
	      error:function(){ alert('저장 중 오류가 발생했습니다.'); }
	    });
	});

		$('.delete-button').click(function(event){
			if (temp_correction_id.length === 0) {
		        alert("삭제할 행을 먼저 클릭해 주세요.");
		        return;
		    }

		    if (!confirm("데이터를 정말 삭제하시겠습니까?")) {
		        return;
		    }
		    $.ajax({
		      url:"/mibogear/condition/tempCorrectionDelete",
		      type:"POST",
		      data: {"temp_correction_id": temp_correction_id},
		      //processData: false,
		      //contentType: false,
		      success: function (result) {
		    	    if (result === true) {
		    	        alert("삭제되었습니다!");
		    	        temp_correction_id = "";
		    	        getTempCorrectionList();
		    	    }else{
						alert("삭제 실패했습니다.");
		    	        temp_correction_id = "";
		    	        getTempCorrectionList();
		        	    }
		    	},
		      error:function(){ alert('저장 중 오류가 발생했습니다.'); }
		    });
		});
		</script>
</body>
</html>
