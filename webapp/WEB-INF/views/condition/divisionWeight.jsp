<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>기준정보관리</title>
<%@include file="../include/pluginpage.jsp"%>
<jsp:include page="../include/tabBar.jsp" />
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
	margin-top: 4px;
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

button-container.button {
	height: 16px;
}

.mid {
	margin-right: 9px;
	font-size: 20px;
	font-weight: bold;
	height: 42px;
	margin-left: 9px;
}

.row_select {
	background-color: #ffeeba !important;
}

.excel-download-button, .excel-upload-button {
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

.button-image {
	width: 16px;
	height: 16px;
}
</style>
</head>

<body>

	<main class="main">
	<div class="tab">


		<div class="button-container">

			<div class="box1">
				<!--  <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
	           <label class="daylabel">검색일자 :</label>
				<input type="text" autocomplete="off" class="daySet" id="startDate" style="font-size: 16px; margin-bottom:10px;" placeholder="시작 날짜 선택">
				
				<span class="mid"  style="font-size: 20px; font-weight: bold; margin-botomm:10px;"> ~ </span>
	
				<input type="text"autocomplete="off" class="daySet" id="endDate" style="font-size: 16px; margin-bottom:10px;" placeholder="종료 날짜 선택"> -->

				<label class="daylabel">설비 :</label> 
				<select class="dayselect">
					<option value="ALL">전체</option>
					<option value="연속열처리로">연속열처리로</option>
				</select> 
				
								<label class="daylabel">품번 :</label> 
				<select class="dayselect">
					<option value="ALL">All</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
				</select>

			</div>

			<button class="select-button">
				<img src="/chunil/css/tabBar/search-icon.png" alt="select"
					class="button-image">조회
			</button>
			<button class="insert-button">
				<img src="/chunil/css/tabBar/add-outline.png" alt="insert"
					class="button-image">추가
			</button>
			<button class="delete-button">
				<img src="/chunil/css/tabBar/xDel3.png" alt="delete"
					class="button-image"> 삭제
			</button>


			<button class="excel-download-button">
				<img src="/chunil/css/tabBar/excel-icon.png" alt="excel"
					class="button-image">엑셀다운로드
			</button>

			<button class="excel-upload-button">
				<img src="/chunil/css/tabBar/excel-icon.png" alt="excel"
					class="button-image">엑셀업로드
			</button>
			<input type="file" id="fileInput" style="display: none;">

		</div>
	</div>

	<div class="view">
		<div id="dataTable"></div>
	</div>
	</main>

	<div id="modalContainer" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<!-- 추가, 수정 -->
			<h2>부품교체 이력 등록</h2>
			<form id="corrForm" autocomplete="off">
				<label>설비명</label> <select name="equipment_name">
					<option value="연속열처리로">연속열처리로</option>
				</select> <label>품번</label> <input type="text" name="item_no" class="read">
				<!--       <select name="item_no">
        <option value="BN0sjfnskdf">BN0sjfnskdf</option>
        <option value="BN0sjfnskdf">BN0sjfnskdf2</option>
        <option value="BN0sjfnskdf">K-BN0sjfnskdf3</option>
      </select> -->

				<label>품명</label> <input type="text" name="item_name"> <label>강종</label>
				<input type="text" name="steel_grade"> <label>T급</label> <input
					type="text" name="t_grade"> <label>진합로트</label> <input
					type="text" name="batch"> <label>참고 기준정보</label> <label>소입온도</label>
				<input type="text" name="ref_soak_temp"> <label>템퍼링온도</label>
				<input type="text" name="ref_cool_temp"> <label>CP</label> <input
					type="text" name="ref_cp"> <label>적용 기준정보</label> <label>소입온도</label>
				<input type="text" name="apply_soak_temp"> <label>템퍼링온도</label>
				<input type="text" name="apply_cool_temp"> <label>CP</label>
				<input type="text" name="apply_cp"> <label>장입량1</label> <input
					type="text" name="load1"> <label>장입량2</label> <input
					type="text" name="load2"> <label>장입량3</label> <input
					type="text" name="load3"> <label>기준장입량</label> <input
					type="text" name="std_load"> <label>요구경도</label> <input
					type="text" name="hardness_req1"> ~ <input type="text"
					name="hardness_req2">


				<button type="submit" id="saveCorrStatus">저장</button>
				<button type="button" id="closeModal">닫기</button>
			</form>
		</div>
	</div>



	<script>
  let now_page_code = "h05";

  var dataTable;
  var selectedRowData = null;

  $(function() {

    dataTable = new Tabulator('#dataTable', {
      height: '500px',
      layout: 'fitDataFill',
      headerSort: false,
      reactiveData: true,
      columnHeaderVertAlign: "middle",
      rowVertAlign: "middle",
      headerHozAlign: 'center',
      ajaxConfig: { method: 'GET' },
      ajaxURL: "/chunil/condition/standardData/list",
      ajaxParams: { equipment_name: "ALL" },
      
/*       ajaxResponse: function(url, params, response) {
    	    // 받아온 데이터에 NO 필드 추가
    	    return response.map(function(row, index) {
    	      row.NO1 = index + 1;
    	      return row;
    	    });
    	  }, */

      placeholder: "조회된 데이터가 없습니다.",
      columns: [
          //{ title: "no", field: "no", visible: false }, 
        //{ title: "NO", field: "NO1",  width: 70, hozAlign: "center" },
        { title: "설비명",              field: "equipment_name",       width: 150, hozAlign: "center" },
        { title: "품번",               field: "item_no",    width: 150, hozAlign: "center" },
        { title: "품명",               field: "item_name",       width: 150, hozAlign: "center" },
        { title: "강종",    			field: "steel_grade",         width: 150, hozAlign: "center" },
        { title: "T급",           field: "t_grade",  width: 150, hozAlign: "center" },
        { title: "진합로트",    field: "batch",    width: 110, hozAlign: "center" },
        {
            title:"참고 기준정보",
            columns:[
                {title:"소입온도", field:"ref_soak_temp"},
                {title:"템퍼링온도", field:"ref_cool_temp"},
                {title:"CP", field:"ref_cp"},
            ]
        },
        {
        title:"적용 기준정보",
        columns:[
            {title:"소입온도", field:"apply_soak_temp"},
            {title:"템퍼링온도", field:"apply_cool_temp"},
            {title:"CP", field:"apply_cp"},
        ]
    },
        { title: "장입량1",                field: "load1",   width: 110, hozAlign: "center" },
        { title: "장입량2",                field: "load2",   width: 110, hozAlign: "center" },
        { title: "장입량3",                field: "load3",   width: 110, hozAlign: "center" },
        { title: "기준 장입량",                field: "std_load",   width: 110, hozAlign: "center" },
        { title: "요구경도",                field: "hardness_req",   width: 110, hozAlign: "center" }
      ],

      rowClick: function(e, row) {
        $('#dataTable .tabulator-row').removeClass('row_select');
        row.getElement().classList.add('row_select');
        selectedRowData = row.getData();
        console.log("selectedRowData:" , selectedRowData);
      },

      //더블클릭 했을때 
      rowDblClick: function(e, row) {
    	  var d = row.getData();
    	  selectedRowData = d;
    	  $('#corrForm')[0].reset();

    	  //$('select[name="no"]').val(d.no);
    	  $('select[name="equipment_name"]').val(d.equipment_name);
    	  $('input[name="item_no"]').val(d.item_no);
    	  $('input[name="item_name"]').val(d.item_name);
    	  $('input[name="steel_grade"]').val(d.steel_grade);
    	  $('input[name="t_grade"]').val(d.t_grade);
    	  $('input[name="batch"]').val(d.batch);
    	  $('input[name="ref_soak_temp"]').val(d.ref_soak_temp);
    	  $('input[name="ref_cool_temp"]').val(d.ref_cool_temp);
    	  $('input[name="ref_cp"]').val(d.ref_cp);
    	  $('input[name="apply_soak_temp"]').val(d.apply_soak_temp);
    	  $('input[name="apply_cool_temp"]').val(d.apply_cool_temp);
    	  $('input[name="apply_cp"]').val(d.apply_cp);
    	  $('input[name="load1"]').val(d.load1);
    	  $('input[name="load2"]').val(d.load2);
    	  $('input[name="load3"]').val(d.load3);
    	  $('input[name="std_load"]').val(d.std_load);
    	  
    	  if (d.hardness_req != null && d.hardness_req.includes("~")) {
    	        var hardnessParts = d.hardness_req.split("~");
    	        $('input[name="hardness_req1"]').val(hardnessParts[0].trim());
    	        $('input[name="hardness_req2"]').val(hardnessParts[1].trim());
    	    } else {
    	        // 값이 비어있으면 초기화
    	        $('input[name="hardness_req1"]').val("");
    	        $('input[name="hardness_req2"]').val("");
    	    }
    	  
    	  $('input[name="item_no"]').prop('readonly', true);

    	  $('#modalContainer').show().addClass('show');
    	}

    });

    $('.select-button').click(function() {
      var sel = $('.dayselect').val();
      dataTable.setData("/chunil/condition/standardData/list", { equipment_name: sel });
    });

    $('.insert-button').click(function() {
    $('input[name="item_no"]').prop('readonly', false);
      selectedRowData = null;
      $('#corrForm')[0].reset();
      $('#modalContainer').show().addClass('show');
    });

    $('.delete-button').click(function() {
      if (!selectedRowData) {
        alert('삭제할 행을 먼저 클릭해 주세요.');
        return;
      }
      if (!confirm('선택된 항목을 정말 삭제하시겠습니까?')) return;

      $.ajax({
        url: "/chunil/condition/standardData/delete",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ item_no: selectedRowData.item_no }),
        success: function(res) {
        	if(res.result === true){
          alert('삭제되었습니다.');
          var currentFilter = $('.dayselect').val() || 'ALL';
          dataTable.setData("/chunil/condition/standardData/list", { mch_name: currentFilter });
          selectedRowData = null;
        	}else{
        		alert("삭제 실패했습니다.")
        	}
        },
        error: function() {
          alert('삭제 중 오류가 발생했습니다.');
        }
      });
    });

    $('.close, #closeModal').click(function() {
      $('#modalContainer').removeClass('show').hide();
    });

    $('#saveCorrStatus').click(function(event) {
      event.preventDefault();
      var formData = new FormData($('#corrForm')[0]);
      if (selectedRowData && selectedRowData.no) {
        formData.append('no', selectedRowData.no);
      }
      $.ajax({
        url: "/chunil/condition/standardData/insert",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function(result) {
        	 if (result.result === true) {
        		 alert("저장되었습니다!");
                 $('#modalContainer').hide();
                 var currentFilter = $('.dayselect').val() || 'ALL';
                 dataTable.setData("/chunil/condition/standardData/list", { mch_name: currentFilter });
                 selectedRowData = null;
               }else {
            alert("저장에 실패했습니다.");
               }},
        error: function() {
          alert('저장 중 오류가 발생했습니다.');
        }
      });
    });


  });
  
  //엑셀 다운로드
   $('.excel-download-button').click(function() {
	    dataTable.download("xlsx", "기준정보관리.xlsx", {sheetName:"기준정보관리",
	    	 visibleColumnsOnly: false //숨겨진 데이터도 출력
	    	 });
	});
  
   $(".excel-upload-button").on("click", function () {
       $("#fileInput").click(); 
   });

   // 파일 선택 후 업로드 처리
   $("#fileInput").on("change", function () {
       var file = this.files[0];
       if (!file) return;

       var formData = new FormData();
       formData.append("file", file);

       $.ajax({
           url: "/chunil/machine/spare/uploadFile",
           type: "POST",
           data: formData,
           contentType: false,
           processData: false,
           success: function (response) {
        	   if(response.result === true){
               alert("엑셀 업로드가 완료되었습니다.");
               $('#modalContainer').hide();
               var currentFilter = $('.dayselect').val() || 'ALL';
               dataTable.setData("/chunil/machine/spareStatus/list", { mch_name: currentFilter });
               selectedRowData = null;
               console.log(response);
               getDataList();
        	   }else{
        		   alert("엑셀 업로드 실패했습니다.")
        	   }
           },
           error: function (xhr, status, error) {
               alert("엑셀 업로드 중 오류가 발생했습니다. 다시 시도해주세요.");
               console.error("Error:", error);
           }
       });
  
   });







  
</script>
	<script type="text/javascript"
		src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>

</body>
</html>