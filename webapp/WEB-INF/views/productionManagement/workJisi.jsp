<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작업일보</title>
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
		     gap: 3px;
		}
        .dayselect {
            width: 20%;
            text-align: center;
            font-size: 15px;
        }
        .monthSet {
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


    /* 기본 레이아웃 (테이블 높이/패딩 축소 적용) */
    body{ background:#fff; font-family:"Noto Sans KR", "맑은 고딕", sans-serif; color:#222; margin:0; padding:0; overflow: hidden; }
   .main {
    max-width:1800px;
    margin:18px auto;
    padding:16px;
    height: 100%;
    overflow: hidden; /* 내부 카드 스크롤만 허용 */
	}

	/* 카드 내부 테이블 래퍼 스크롤 */
	.card.fixed-height #tableHeatTopWrapper,
	.card.fixed-height #tablelot_reportWrapper,
	.card.fixed-height #tableHeatWrapper {
	    flex: 1; /* 남은 공간 모두 차지 */
	    overflow-y: auto;
	    height: 100px;
	}
	body, html {
	    height: 100%;
	    overflow: hidden; /* 화면 전체 스크롤 제거 */
	}
	    .header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:14px; }
	    .title{ font-size:20px; font-weight:700; }
	    .subtitle{ font-size:13px; color:#6b7280; }
	
	    .grid{ display:flex; gap:18px; margin-bottom:18px; }
	    .card{
	        background:#fff;
	        border-radius:10px;
	        padding:16px; /* 기존 12 -> 10 */
	        box-shadow:0 6px 18px rgba(2,6,23,0.06);
	        border:1px solid rgba(2,6,23,0.04);
	        flex:1;
	        min-width:330px;
	    }
	    .card .card-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:8px; }
	    .card-title{ font-weight:700; font-size:14px; }
	    .card-sub{ font-size:12px; color:#6b7280; }
	
	    /* 테이블 공통: 패딩/행높이 축소 */
	    table { width:100%; border-collapse:collapse; font-size:13px; }
	  thead th {
	    text-align: center;
	    padding: 6px 6px;
	    background: #d0daeb;
	    border-bottom: 1px solid #e6eefc;
	    font-weight: 700;
	    height: 34px;
	}

/* 왼쪽 상단 모서리 */
thead th:first-child {
    border-top-left-radius: 8px;
}

/* 오른쪽 상단 모서리 */
thead th:last-child {
    border-top-right-radius: 8px;
}

	    tbody td {
	        padding:6px 6px; /* 기존 10px -> 6px */
	        border-bottom:1px solid #f1f5f9;
	        text-align:center;
	        height:36px; /* 각 행 높이 고정 */
	        line-height:18px;
	        white-space:nowrap;
	        overflow:hidden;
	        text-overflow:ellipsis;
	    }
	    tbody tr:hover { background:#fbfdff; cursor:pointer; }
	    tbody tr.selected { background: linear-gradient(90deg, rgba(11,99,206,0.06), rgba(11,99,206,0.02)); font-weight:700; }
	
	    .kpi { display:flex; gap:8px; }
	    .kpi .item{ flex:1; background:#fbfcff; padding:6px; border-radius:8px; text-align:center; } /* padding 축소 */
	    .kpi .label{ font-size:12px; color:#6b7280; }
	    .kpi .value{ font-size:16px; font-weight:800; color:#111827; } /* 숫자 크기 약간 축소 */
	
	    .btn{ display:inline-flex; align-items:center; gap:8px; padding:8px 12px; border-radius:8px; border:0; cursor:pointer; font-weight:700; }
	    .btn.primary{ background:#0b63ce; color:#fff; }
	    .btn.work{ background:#A566FF; color:#fff; }
	    .btn.ghost{ background:#fff; color:#111; border:1px solid rgba(2,6,23,0.06); }
	
	
	
	    .small-input{ padding:6px 8px; border-radius:6px; border:1px solid #e6eefc; }
	
	    .muted{ color:#6b7280; font-size:12px; }
	
	    /* 강조 셀 (온도, CP) */
	    .temp { color:#e63946; font-weight:800; }
	    .cp { color:#0b63ce; font-weight:800; }
	
	    /* 개별 테이블 최대 높이 — 줄여서 스크롤 생기도록 설정 */
	    #tableHeatTopWrapper { height:150px; overflow:auto; }   /* 요약 상단 테이블 (작게) */
	   #tableHeatWrapper { 
	    height: 420px;  /* 기존 330px → 250px */
	    overflow:auto; 
	}
	
	    #tablelot_report { } /* 테이블 element 자체는 사용 안함 */
	    #tablelot_report tbody { } 
	   #tablelot_reportWrapper { 

    height: 600px;
    width: 1300px;
    overflow: auto;
    margin-left: 200px;

	}
	
	    /* 온도표는 한 줄이라 높이 조절 필요 없음 — 셀 패딩만 작게 */
	    .temp-table thead th{ padding:6px 6px; font-size:12px; color:#6b7280; }
	    .temp-table tbody td{ padding:8px 6px; font-size:16px; height:36px; }
	
	    @media (max-width:1100px){
	        .grid{ flex-direction:column; }
	    }
	    
	/*바코드스캔 모달용 css*/
	  #lotModal .form-section {
	    margin-bottom: 15px;
	    padding: 10px;
	    border-radius: 10px;
	    background: #f9fafb;
	    box-shadow: 0 1px 4px rgba(0,0,0,0.05);
	  }
	
	  #lotModal .form-section h3 {
	    margin-bottom: 8px;
	    font-size: 14px;
	    color: #333;
	    border-left: 4px solid #007bff;
	    padding-left: 6px;
	  }
	
	  #lotModal .grid {
	    display: grid;
	    gap: 8px;
	  }
	
	  #lotModal .grid-3 { grid-template-columns: repeat(3, 1fr); }
	  #lotModal .grid-7 { grid-template-columns: repeat(7, 1fr); }
	  #lotModal .grid-6 { grid-template-columns: repeat(6, 1fr); }
	
	  #lotModal .form-group {
	    display: flex;
	    flex-direction: column;
	  }
	
	  #lotModal .form-group label {
	    font-size: 12px;
	    margin-bottom: 3px;
	    color: #555;
	  }
	
	  #lotModal .form-group input {
	    padding: 4px 6px;
	    border: 1px solid #ccc;
	    border-radius: 6px;
	    outline: none;
	    font-size: 12px;
	  }
	
	  #lotModal .form-group input:focus {
	    border-color: #007bff;
	    background: #f0f7ff;
	  }
	
	  #lotModal .modal-footer {
	    display: flex;
	    justify-content: flex-end;
	    gap: 8px;
	    margin-top: 10px;
	  }
	
	  #lotModal .btn {
	    padding: 6px 12px;
	    border: none;
	    border-radius: 6px;
	    cursor: pointer;
	    font-size: 13px;
	  }
	
	  #lotModal .btn-primary {
	    background-color: #007bff;
	    color: white;
	  }
	
	  #lotModal .btn-secondary {
	    background-color: #e0e0e0;
	    color: #333;
	  }
	  
	  .save-btn {
    background-color: transparent;
    border: none;
    cursor: pointer;
}
	.save-btn:hover {
	    background-color: #cce0ff;
	    border-radius: 4px;
	}
	.text_m{
	margin-bottom: 10px;
	}
	
	.select-button {
	    margin-top: 3px;
	    /* width: 120px; */
	    height: 37px;
	    padding: 0 11px;
	    border: 1px solid rgb(53, 53, 53);
	    border-radius: 4px;
	    background-color: #ffffff;
	    cursor: pointer;
	    display: flex;
	    align-items: center;
	}

    </style>

<body>
    <main class="main">
        <div class="tab">
        

            <div class="button-container">
            
               <div class="box1">
	
	            <label class="daylabel">조회 월 :</label>
	            <input type="text" id="s_sdate" class="dayselect monthSet"/>

			</div>
                <button class="select-button">
                    <img src="/mibogear/image/search-icon.png" alt="select" class="button-image">조회
                </button>

                
                
            </div>
        </div>

         <div class="card card" style="flex:0.55;">
            <div class="card-header">
                <div>
                    <div class="card-title"></div>
                    <div class="card-sub"></div>
                </div>
                <div>

                </div>
            </div>

            <div id="tablelot_reportWrapper" style="max-height:860px; overflow:auto;">
                <table id="tablelot_report">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>작업일</th>
                            <th>LOT 카운트</th>
                             <th>최초 LOT</th>
                             <th>마지막 LOT</th>
                             <th>작업일보 생성</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>       
        </div>
    </main>               
    
<script>
let now_page_code = "b03";

var dataTable;
var selectedRowData = null;

$(function() {
    // 오늘 날짜 기준 yyyy-MM
    let today = new Date();
    let year = today.getFullYear();
    let month = today.getMonth() + 1; // 0~11이므로 +1
    if(month < 10) month = '0' + month;

    let currentYearMonth = year + '-' + month;

    $("#s_sdate").val(currentYearMonth);

    fetchlot_report();
});


//이벤트
  $('.select-button').click(function() {
	  fetchlot_report();
  });




  function fetchlot_report(){
	    $.ajax({
	        url: "/mibogear/productionManagement/workDailyList",
	        method: "POST",
	        data: {
	            date: $("#s_sdate").val()
	        },
	        dataType: "json",
	        success: function(resp){
	 
	            var arr = Array.isArray(resp) ? resp : (resp.data || resp.rows || (resp ? [resp] : []));
	            var $tbody = $("#tablelot_report tbody").empty();
	            if(!arr || arr.length === 0){
	                $tbody.append('<tr><td colspan="6">조회된 데이터가 없습니다.</td></tr>');
	                return;
	            }

	            arr.forEach(function(r, idx){
	                var tr = $("<tr></tr>");

	                tr.append("<td>"+ (idx + 1 || "") +"</td>");
	                tr.append("<td>"+ (r.regtime || "") +"</td>");
	                tr.append("<td>"+ (r.count || "") +"</td>");
	                tr.append("<td>"+ (r.first_lot || "") +"</td>");
	                tr.append("<td>"+ (r.last_lot || "") +"</td>");


	                // 저장 버튼 추가
	              var saveBtn = $("<button class='save-btn' title='저장'>💾</button>");
	                var tdBtn = $("<td></td>").append(saveBtn);
	                tr.append(tdBtn);

/* 		             // 저장 버튼 클릭 이벤트
	                saveBtn.click(function(e){
	                    e.stopPropagation(); // tr 클릭 이벤트 방지
	                    var rowData = tr.data("rowdata");
	                    if(rowData){
	                        console.log("저장할 LOT:", rowData.w_ci_lot);

	                        // 서버로 w_ci_lot 전송
	                        $.ajax({
	                            url: "/chunil/productionManagement/work_report/dayPrint",
	                            type: "POST",
	                            contentType: "application/json",
	                            data: JSON.stringify({ w_ci_lot: rowData.w_ci_lot }), // w_ci_lot만 전송
	                            xhrFields: {
	                                responseType: 'blob' // PDF 바이너리 처리
	                            },
	                            success: function(blob){
	                                // PDF 다운로드
	                                var link = document.createElement('a');
	                                link.href = window.URL.createObjectURL(blob);
	                                link.download = rowData.w_ci_lot + ".pdf";
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
	                }); */

	                saveBtn.click(function(e){
	                    e.stopPropagation();

	                    var rowData = tr.data("rowdata");

	                    if(rowData){
	                        console.log("저장할 날짜:", rowData.w_date); 

	                        $.ajax({
	                            url: "/mibogear/productionManagement/workDailyList/report",
	                            type: "POST",
	                            data: JSON.stringify({ regtime: rowData.regtime }),
	                            contentType: "application/json",
	                            xhrFields: { responseType: 'blob' },  // ✅ PDF 바이너리 받기
	                            success: function(blob){
	                                var link = document.createElement('a');
	                                link.href = window.URL.createObjectURL(blob);
	                                link.download = "work_report_" + rowData.w_date + ".pdf";
	                                link.click();
	                                window.URL.revokeObjectURL(link.href);
	                            },
	                            error: function(xhr){
	                                console.error("다운로드 실패", xhr);
	                            }
	                        });


	                    } else {
	                        console.log("rowData가 없습니다.");
	                    }
	                });

	                	                
	                tr.data("rowdata", r);
	                $tbody.append(tr);
	            });


	        },
	        error: function(xhr){
	            console.error("fetchlot_report error", xhr);
	        }
	    });
	}

</script>

</body>
</html>