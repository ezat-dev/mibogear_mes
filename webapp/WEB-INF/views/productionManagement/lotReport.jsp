<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LOT 보고서</title>
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

.button-image {
    width: 16px; 
    height: 16px;
}

/*품번모달*/
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

        .monthSet {
        	width: 20%;
      		text-align: center;
            height: 17px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
         .machine_select {
        	width: 20%;
      		text-align: center;
            height: 35px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
        .btn-print {
    background: none;      /* 배경색 제거 */
    border: none;          /* 테두리 제거 */
    padding: 0;            /* 내부 여백 제거 */
    cursor: pointer;       /* 마우스 호버 시 손가락 모양 */
    font-size: 1.2rem;     /* 이모지 크기 조절 (필요 시) */
    outline: none;         /* 클릭 시 생기는 강조선 제거 */
}

.btn-print:hover {
    opacity: 0.7;          /* 마우스를 올렸을 때 살짝 흐리게 효과 */
}
    </style>

<body>
    <main class="main">
        <div class="tab">
        

            <div class="button-container">
            
               <div class="box1">
               
               	<label class="daylabel">설비명 :</label>
	            <select id="fac_no" class="machine_select">
	            <option value="" selected>전체</option>
	            <option value="BCF1">BCF1</option>
	            <option value="BCF2">BCF2</option>
	            <option value="BCF3">BCF3</option>
	            <option value="BCF4">BCF4</option>
	            <option value="CM">CM</option>
	            <option value="CM2">CM2</option>
	            </select>
	            
	            <label class="daylabel">월 선택 :</label>
	            <input type="text" id="lotno_date" class="dayselect monthSet"/>
	            
				</div>
				
                <button class="select-button">
                    <img src="/mibogear/image/search-icon.png" alt="select" class="button-image">조회
                </button>
                
<!--                 <button class="insert-button">
                    <img src="/mibogear/tabBar/add-outline.png" alt="insert" class="button-image">추가
                </button>
                <button class="delete-button">
				    <img src="/mibogear/tabBar/xDel3.png" alt="delete" class="button-image"> 삭제
				</button> -->
                
                
<!--                 <button class="excel-download-button">
                    <img src="/mibogear/image/excel-icon.png" alt="excel" class="button-image">엑셀
                </button> -->
                
                <button id="printBtn" 
				        style="margin-left:10px; background-color:#ffffff; border:1px solid #000000; border-radius:4px; padding:5px 10px; cursor:pointer; width:72px; height:40px;">
				    🖨️ 인쇄
				</button> 
                
            </div>
        </div>

        <div class="view">
            <div id="dataTable"></div>
        </div>
    </main>
    
<script>
let now_page_code = "b01";

var dataTable;
var selectedRowData = null;
var fac_no;
var lotno_date;
var date = new Date();

document.getElementById('printBtn').addEventListener('click', function() {
    const style = document.createElement('style');
    style.innerHTML = `
        @page {
            size: A4 landscape;
            margin: 0mm;
        }
        @media print {
            body { zoom: 67%; }
            #container {
                /* 고정 px 대신 100% 사용 */
                width: 100% !important;
                max-width: none !important;
                height: auto !important;
                
                /* zoom 대신 scale 사용 (더 표준적이고 정확함) */
                transform: scale(0.95); /* 화면에 맞춰 비율 조절 */
                transform-origin: top left;
                
                /* 가로 스크롤 방지 */
                overflow: hidden !important; 
            }
            /* 인쇄에 불필요한 스크롤바 제거 */
            ::-webkit-scrollbar { display: none; }
        }
    `;
    document.head.appendChild(style);
    window.print();
    setTimeout(() => { document.head.removeChild(style); }, 1000);
}); 

$(function() {
	  var year = date.getFullYear();
	  var month = ('0' + (date.getMonth() + 1)).slice(-2);
	  var thisMonthFormatted = year + '-' + month;
	  $('#lotno_date').val(thisMonthFormatted);
	getList();
});

//이벤트
  $('.select-button').click(function() {
	  getList();
  });

//엑셀 다운로드
 $('.excel-download-button').click(function() {
	    dataTable.download("xlsx", "LOT보고서.xlsx", {sheetName:"LOT 보고서",
	    	 visibleColumnsOnly: false //숨겨진 데이터도 출력
	    	 });
	});

 $(".excel-upload-button").on("click", function () {
     $("#fileInput").click(); 
 });


//함수
function getList(){
	
	  if (!document.getElementById('progress-styles')) {
  	    const style = document.createElement('style');
  	    style.id = 'progress-styles';
  	    style.innerHTML = `
  	      .custom-progress { background: #f0f0f0; border-radius: 4px; overflow: hidden; height: 22px; position: relative; box-shadow: inset 0 1px 3px rgba(0,0,0,0.2); }
  	      .custom-progress .bar { height: 100%; border-radius: 4px; transition: width 0.5s ease-in-out; }
  	      .bar.color-red { background: #e74c3c; }
  	      .bar.color-orange { background: #e67e22; }
  	      .bar.color-yellow { background: #f1c40f; }
  	      .bar.color-lightgreen { background: #2ecc71; }
  	      .custom-progress .label { position: absolute; width: 100%; text-align: center; font-size: 12px; font-weight: bold; color: #333; top: 0; left: 0; line-height: 16px; }
  	    `;
  	    document.head.appendChild(style);
  	  }

  	  // 퍼센트 포맷터 정의: 범위별 색상 적용
  	  var percentFormatter = function(cell, formatterParams, onRendered) {
  	    var value = cell.getValue() || 0;
  	    var colorClass = value <= 25 ? 'color-red'
  	                   : value <= 50 ? 'color-orange'
  	                   : value <= 75 ? 'color-yellow'
  	                   : 'color-lightgreen';
  	    var wrapper = document.createElement('div');
  	    wrapper.className = 'custom-progress';

  	    var bar = document.createElement('div');
  	    bar.className = 'bar ' + colorClass;
  	    bar.style.width = value + '%';
  	    wrapper.appendChild(bar);

  	    var label = document.createElement('div');
  	    label.className = 'label';
  	    label.textContent = value + '%';
  	    wrapper.appendChild(label);

  	    return wrapper;
  	  };

//  	fac_no: $('#fac_no').val();
//  	lotno_date: $('#lotno_date').val()
	  dataTable = new Tabulator('#dataTable', {
		    height: '720px',
		    layout: 'fitDataFill',
		    headerSort: false,
		    reactiveData: true,
		    columnHeaderVertAlign: "middle",
		    headerHozAlign: 'center',
		    ajaxConfig: { method: 'POST' },
		    ajaxURL: "/mibogear/productionManagement/lotReport/getLotList",
		    ajaxParams: {
		            "fac_no": $('#fac_no').val(),
		            "lotno_date": $('#lotno_date').val()
		    },	    
		    ajaxResponse:function(url, params, response){
				$("#dataTable .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    placeholder: "조회된 데이터가 없습니다.",
		    columns: [
		    	{ title: "LOT 번호", field: "lot_no", width: 230, hozAlign: "center" },  
		      { title: "LOT 생성 날짜", field: "lotno_date", width: 180, hozAlign: "center",
		    	  formatter: function(cell) {
		    	        var value = String(cell.getValue()); 
		    	        
		    	        if (value) {
		    	            return value.substring(0, 4) + "-" + value.substring(4, 6) + "-" + value.substring(6, 8);
		    	        }
		    	        
		    	        return value; // 형식이 맞지 않으면 원래 값 반환
		    	    }
	    	     },
		      { title: "패턴 번호", field: "pattern", width: 130, hozAlign: "center" },
		      { title: "설비", field: "fac_no", width: 110, hozAlign: "center" },
		      { title: "시작 시간", field: "regtime",  width: 200, hozAlign: "center" },
		      { title: "종료 시간", field: "end_time",width: 200, hozAlign: "center" },
		      {
		          title: "LOT보고서 저장",
		          field: "print",
		          width: 150,
		          hozAlign: "center",
		          headerSort: false,
		          // 버튼 모양을 정의합니다.
		          formatter: function(cell, formatterParams, onRendered) {
		              return "<button class='btn-print'>💾</button>";
		          },
		          cellClick: function(e, cell) {
		              var rowData = cell.getRow().getData(); // 해당 행의 데이터 가져오기
		              printLotReport(rowData); // 인쇄 함수 호출
		          }
		      }      		      
		    ]
		  });

	  function printLotReport(rowData){
          if(rowData){
              console.log("저장할 LOT:", rowData.lot_no);

              $.ajax({
                  url: "/mibogear/productionManagement/lot_report/lotPrint",
                  type: "POST",
                  contentType: "application/json",
                  data: JSON.stringify({ lot_no: rowData.lot_no}), 
                  xhrFields: {
                      responseType: 'blob' // PDF 바이너리 처리
                  },
                  success: function(blob){
                      // PDF 다운로드
                      var link = document.createElement('a');
                      link.href = window.URL.createObjectURL(blob);
                      link.download = rowData.lot_no + ".pdf";
                      document.body.appendChild(link);
                      link.click();
                      document.body.removeChild(link);
                      window.URL.revokeObjectURL(link.href);
                  },
                  error: function(xhr, status, error){
                      console.error("PDF 생성 실패:", error);
                  }
              });

          } else {
              console.log("rowData가 없습니다.");
          }
		  };
}

</script>

</body>
</html>