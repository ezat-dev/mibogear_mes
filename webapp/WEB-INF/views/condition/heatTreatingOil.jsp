<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>열처리유성상분석</title>
     <%@include file="../include/pluginpage.jsp" %>    
    <jsp:include page="../include/tabBar.jsp"/> 
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
		    width: 1100px;
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
        
        
        
        /*모달css  */
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
		}
		.row_select {
		    background-color: #d0d0d0 !important;
		}
		
		.modal-content {
		    background: white;
		    width: 40%; /* 가로 길이를 50%로 설정 */
		    max-width: 584px; /* 최대 너비를 설정하여 너무 커지지 않도록 */
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
		    top: 15%;
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
		    width: 90%;
		    padding: 8px;
		    margin-bottom: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}

		.modal-content select {
		    width: 94%;
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
		 .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;
	
	    height: 42px;
	    margin-left: 9px;
        }
        
        .radio-group {
		  display: flex;
		  gap: 20px;
		  margin-bottom: 15px;
		  align-items: center;
		}
		
		.radio-group label {
		  display: flex;
		
		  gap: 5px;
		  font-size: 18px;
		  padding: 4px 8px;
		  border: 1px solid #ccc;
		  border-radius: 6px;
		  cursor: pointer;
		  transition: all 0.2s;
		}
		
		.radio-group input[type="radio"] {
		  accent-color: #007bff; /* 파란색 포인트 */
		  cursor: pointer;
		}
		
		.radio-group label:hover {
		  background-color: #f0f0f0;
		  border-color: #007bff;
		}
.legend {
  font-family: 'Arial', sans-serif;
  background: #f9f9f9;
  padding: 12px 20px;
  border-radius: 8px;
  max-width:1100px;
  margin: 20px auto;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

.legend-items {
  display: flex;
  gap: 40px;
  flex-wrap: nowrap;
  justify-content: flex-start;
  align-items: center; /* 세로 정렬 */
}

.legend-item {
  white-space: nowrap;
  font-size: 15px;
}

.legend-item h3 {
  margin: 0;
  font-weight: 800;
  font-size: 18px;
  color: #333;
}
.legend-item strong {
  color: #222;
  margin-right: 6px;
  font-weight: 700;
}

.header {
    display: flex; /* 플렉스 박스 사용 */
    justify-content: center; /* 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 10px; /* 상단 여백 */
    background-color: #33363d; /* 배경색 */
    height: 50px; /* 높이 */
    color: white; /* 글자색 */
    font-size: 20px; /* 글자 크기 */
    text-align: center; /* 텍스트 정렬 */
    position: relative;
}
.btnSaveClose {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 30px;
    margin-bottom: 20px;
}
.btnSaveClose #saveCorrStatus{
	width: 100px;
	height: 35px;
	background-color: #FFD700; /* 기본 배경 - 노란색 */
	color: black;
	border: 2px solid #FFC107; /* 노란 테두리 */
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	line-height: 15px;
	margin: 0 10px;
	margin-top: 10px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}
.btnSaveClose #closeModal{
	width: 100px;
	height: 35px;
	background-color: #A9A9A9;
	color: black;
	border: 2px solid #808080;
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	line-height: 15px;
	margin: 0 10px;
	margin-top: 10px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}
#closePdfModal{
	position:absolute; 
	top:8px; 
	right:8px; 
	z-index:10; 
	padding:4px 8px;"
}
    </style>
</head>
<body>

    <main class="main">
        <div class="tab">
        
        
        
        
        

            <div class="button-container">
            
             <div class="box1">
			<p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
			
			<input type="hidden" id="id" name="id">

			
			
			           <label class="daylabel">검색 날짜 :</label>
				<input type="text" autocomplete="off"class="daySet" id="startDate" style="font-size: 16px; margin-bottom:10px;" placeholder="시작 날짜 선택">
				
				<span class="mid" style="font-size: 20px; font-weight: bold; margin-botomm:10px;"> ~ </span>
	
				<input type="text"autocomplete="off" class="daySet" id="endDate" style="font-size: 16px; margin-bottom:10px;" placeholder="종료 날짜 선택">
			
<!-- 			<label class="daylabel">설비명 :</label>
			<select name="mch_name"id="mch_name" class="dayselect" style="width: 20%; font-size: 15px; height: 34px; text-align: center; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px;">
			    <option value="BCF-1">BCF-1</option>
				<option value="BCF-2">BCF-2</option>
				<option value="BCF-3">BCF-3</option>
				<option value="BCF-4">BCF-4</option>				
				<option value="TF-1">TF-1</option>
				<option value="TF-2">TF-2</option>
			</select> -->


    
			</div>
                <button class="select-button">
                    <img src="/mibogear/image/search-icon.png" alt="select" class="button-image">조회
                </button>
        <button class="insert-button">
            <img src="/mibogear/image/insert-icon.png" alt="insert" class="button-image">추가 
        </button>

                <button class="delete-button">
				    <img src="/mibogear/css/tabBar/xDel3.png" alt="delete" class="button-image"> 삭제
				</button>
				
				
            </div>
        </div>

		





        <div class="view">
            <div id="dataList"></div>
        </div>
    </main>


<!-- <div id="modalContainer" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>열처리유 성상 분석</h2>
       <form id="corrForm" autocomplete="off" enctype="multipart/form-data">

          <label>채취일</label>
			  <input type="text"name="collection_date"  class="daySet" placeholder="일 선택" style="text-align: left;">
           
              <input type="hidden" id="heat_treating_code" name="heat_treating_code" />
            <label>설비</label>
			
			<select name="machine_name" class="daySet" style="text-align: left;">
			    <option value="BCF-1">BCF-1</option>
			    <option value="BCF-2">BCF-2</option>
			    <option value="BCF-3">BCF-3</option>
			    <option value="BCF-4">BCF-4</option>
			    <option value="TF-1">TF-1</option>
			    <option value="TF-2">TF-2</option>
			</select>
			
			<label>열분석 보고서</label>
			<input type="file" name="heat_report_file" id="fileInput1" placeholder="열분석 보고서" accept="application/pdf">
			<span id="box1FileName"></span>
			<input type="hidden" name="original_heat_report" id="originalFile1" />
			
			<label>냉각시험 그래프</label>
			<input type="file" name="cold_report_file" id="fileInput2" placeholder="냉각시험 그래프" accept="application/pdf">
			<span id="box2FileName"></span>
			<input type="hidden" name="original_cold_report" id="originalFile2" />
			
			<label>기타 파일</label>
			<input type="file" name="etc_report_file" id="fileInput3" placeholder="기타 파일" accept="application/pdf">
			<span id="box3FileName"></span>
			<input type="hidden" name="original_etc_report" id="originalFile3" />
			
            <label>비고</label>
			 <input type="text"  name="note" placeholder="비고 입력">
	

            <button type="submit" id="saveCorrStatus">저장</button>
            <button type="button" id="closeModal">닫기</button>
        </form>
    </div>
</div> -->

<div id="modalContainer" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div class="header">
       		 열처리유 성상 분석
        </div>
        
       <form id="corrForm" autocomplete="off" enctype="multipart/form-data">

      <table class="insideTable">
        <colgroup>
          <col width="15%">
          <col width="35%">
          <col width="15%">
          <col width="35%">
        </colgroup>
        <tbody>
          <!-- 설비 / 일자 -->
          <tr>
            <th>채취일</th>
            <td>
				<input type="text"name="collection_date"  class="daySet" placeholder="일 선택" style="text-align: left;">
            </td>
            <th>설비</th>
            <td>			
            <select name="machine_name" class="daySet" style="text-align: left;">
			    <option value="BCF-1">BCF-1</option>
			    <option value="BCF-2">BCF-2</option>
			    <option value="BCF-3">BCF-3</option>
			    <option value="BCF-4">BCF-4</option>
			    <option value="TF-1">TF-1</option>
			    <option value="TF-2">TF-2</option>
			</select>
			</td>
          </tr>

          <tr>
            <th>열분석<br>보고서</th>
            <td>
			<input type="file" name="heat_report_file" id="fileInput1" placeholder="열분석 보고서" accept="application/pdf">
			<span id="box1FileName"></span>
			<input type="hidden" name="original_heat_report" id="originalFile1" />
			</td>
            
            <th>냉각시험<br>그래프</th>
            <td>
			<input type="file" name="cold_report_file" id="fileInput2" placeholder="냉각시험 그래프" accept="application/pdf">
			<span id="box2FileName"></span>
			<input type="hidden" name="original_cold_report" id="originalFile2" />
			</td>
          </tr>

          <tr>
            <th>기타 파일</th>
            <td>
			<input type="file" name="etc_report_file" id="fileInput3" placeholder="기타 파일" accept="application/pdf">
			<span id="box3FileName"></span>
			<input type="hidden" name="original_etc_report" id="originalFile3" />
            </td>
            
            <th>비고</th>
            <td>
            <input type="text"  name="note" placeholder="비고 입력">
            </td>
          </tr>
        </tbody>
      </table>
	
		<div class="btnSaveClose">
            <button type="submit" id="saveCorrStatus">저장</button>
            <button type="button" id="closeModal">닫기</button>
        </div>
        </form>
    </div>
</div>


<div id="pdfViewerModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; 
     background:rgba(0,0,0,0.7); z-index:1000; align-items:center; justify-content:center;">
  <div style="position:relative; width:80%; height:90%; background:#fff; border-radius:8px; overflow:hidden;">
<div id="pdfModalHeader" style="padding: 10px 15px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center;">
            <h3 style="margin: 0;">PDF 문서 미리보기</h3>
            <button id="closePdfModal" style="z-index: 10;">✕ 닫기</button>
        </div>
    <iframe id="pdfFrame" 
            style="width:100%; height:100%; border:none;" 
            src=""></iframe>
  </div>
</div>

<script>
let now_page_code = "c03";
let dataTable;
let selectedRow;
var today = new Date();

function pdfLinkFormatter(cell) {
    var fn = cell.getValue();
    if (!fn) return "";
    var enc = encodeURIComponent(fn);
    enc = enc.replace(/\(/g, '%28').replace(/\)/g, '%29');
    return '<a href="javascript:void(0);" onclick="openPdf(\'' + enc + '\')">' + fn + '</a>';
}

// PDF 팝업 열기
function openPdf(encodedName) {
    console.log(">>> openPdf called with:", encodedName);
    if (!encodedName) {
        alert("파일명이 없습니다!");
        return;
    }
    document.getElementById('pdfFrame').src = 
        '/mibogear/condition/download_heat_treating?filename=' + encodedName;
    document.getElementById('pdfViewerModal').style.display = 'flex';
}

// getDataList 
function getDataList() {
    dataTable = new Tabulator("#dataList", {
        height: "760px",
        layout: "fitColumns",
        headerHozAlign: "center",
        columnHeaderVertAlign: "middle",
        //rowVertAlign: "middle",
        ajaxConfig: "POST",
        ajaxLoader: false,
        ajaxURL: "/mibogear/condition/selectHeatTreatingList",
        ajaxParams: {
            //machine_name: $("#mch_name").val() || "",
            startDate: $("#startDate").val() || "",
            endDate: $("#endDate").val() || ""
        },
        placeholder: "데이터 없음",
        ajaxResponse: function (url, params, response) {
            console.log("응답 데이터: ", response);
            return response;
        },
        columns: [
            { title: "No", formatter: "rownum", hozAlign: "center", width: 70, headerSort: false },
            { title: "heat_treating_code", field: "heat_treating_code", visible: false },
            { title: "채취일", field: "collection_date", hozAlign: "center", width: 120 },
            { title: "설비", field: "machine_name", hozAlign: "center", width: 120 },

            {
                title: "열분석 보고서", field: "heat_report", hozAlign: "center", width: 250,
                formatter: function (cell) {
                    var fn = cell.getValue();
                    if (!fn) return "";
                    return '<a href="javascript:void(0);" onclick="openPdf(\'' + encodeURIComponent(fn) + '\')">' + fn + '</a>';
                }
            },
            {
                title: "냉각시험 그래프", field: "cold_report", hozAlign: "center", width: 250,
                formatter: function (cell) {
                    var fn = cell.getValue();
                    if (!fn) return "";
                    return '<a href="javascript:void(0);" onclick="openPdf(\'' + encodeURIComponent(fn) + '\')">' + fn + '</a>';
                }
            },
            {
                title: "기타 파일", field: "etc_file", hozAlign: "center", width: 250,
                formatter: function (cell) {
                    var fn = cell.getValue();
                    if (!fn) return "";
                    return '<a href="javascript:void(0);" onclick="openPdf(\'' + encodeURIComponent(fn) + '\')">' + fn + '</a>';
                }
            },
            { title: "비고", field: "note", hozAlign: "center", width: 300 }
        ],
        rowClick: function (e, row) {
            $("#dataList .tabulator-row").removeClass("row_select");
            row.getElement().classList.add("row_select");
            selectedRow = row;
        },
        rowDblClick: function (e, row) {
            $("#originalFile1").val("");
            $("#originalFile2").val("");
            $("#originalFile3").val("");
            $("#heat_treating_code").val("");
            var d = row.getData();
            $("input[name='heat_treating_code']").val(d.heat_treating_code);
            $("input[name='collection_date']").val(d.collection_date);
            $("select[name='machine_name']").val(d.machine_name);

            const heatReport = d.heat_report || "";
            $("#box1FileName").text("기존 파일: " + heatReport || "파일 없음");
            $("#originalFile1").val(d.heat_report || "");

            const coldReport = d.cold_report || "";
            $("#box2FileName").text("기존 파일: " + coldReport || "파일 없음");
            $("#originalFile2").val(d.cold_report || "");

            const etcReport = d.etc_report || "";
            $("#box3FileName").text("기존 파일: " + etcReport || "파일 없음");
            $("#originalFile3").val(d.etc_report || "");
             
            $("input[name='note']").val(d.note);
            $("#modalContainer").show().addClass("show");
        }
    });
}

$(document).ready(function () {
    // 날짜 세팅

        yesterday = new Date(today);
    yesterday.setDate(today.getDate() - 1);

    function formatDate(date) {
        var y = date.getFullYear(),
            m = ("0" + (date.getMonth() + 1)).slice(-2),
            d = ("0" + date.getDate()).slice(-2);
        return y + "-" + m + "-" + d;
    }

    $("#startDate").val(formatDate(yesterday));
    $("#endDate").val(formatDate(today));

    getDataList();

    // 모달 닫기 (PDF 뷰어)
    $("#closePdfModal").click(function () {
        $("#pdfViewerModal").hide();
        $("#pdfFrame").attr("src", "");
    });

    // insert 버튼
    $(".insert-button").click(function () {
        $("#corrForm")[0].reset();
        $("#originalFile1").val("");
        $("#originalFile2").val("");
        $("#originalFile3").val("");
        $("#heat_treating_code").val("");
        $("input[name='collection_date']").val(formatDate(today));
        $("#box1FileName, #box2FileName, #box3FileName, #box4FileName").text("");
        $("#modalContainer").show().addClass("show");
    });

    $(".close, #closeModal").click(function () {
        $("#modalContainer").removeClass("show").hide();
    });

/*     $("#mch_name").on("change", function () {
        console.log("선택된 설비명:", $(this).val());
    }); */

    $(".select-button").click(function () {
        dataTable.setData("/mibogear/condition/selectHeatTreatingList", {
            //machine_name: $("#mch_name").val(),
            startDate: $("#startDate").val(),
            endDate: $("#endDate").val()
        });
    });

    // 저장 버튼 (PDF 검증)
    $("#saveCorrStatus").click(function (event) {
    	event.preventDefault();
        console.log("[EVENT] 저장 버튼 클릭됨");

        const form = document.getElementById("corrForm");
        if (!form) {
            console.error("[ERROR] corrForm 요소를 찾을 수 없음");
            return;
        }

        const formData = new FormData(form);

        // FormData 내용 전체 출력 로그
        console.log("[INFO] FormData 구성값:");
        for (const [key, value] of formData.entries()) {
            console.log(" -", key, ":", value);
        }
        console.log("[AJAX] HeatTreating insert 요청 시작");

        $.ajax({
            url: "/mibogear/condition/insertHeatTreating",
            type: "POST",
            data: formData,
            processData: false, // FormData → 무조건 false
            contentType: false, // multipart 자동 처리
            enctype: "multipart/form-data",

            beforeSend: function(xhr) {
                console.log("[AJAX] beforeSend - 요청 헤더 확인:");
                console.log("  contentType:", this.contentType);
                console.log("  processData:", this.processData);
            },

            success: function(res, status, xhr) {
                console.log("[AJAX] success 응답 수신");
                console.log("  status:", status);
                console.log("  response:", res);
                console.log("  RawHeader:", xhr.getAllResponseHeaders());

                if (res === true || res?.success === true) {
                    alert("저장 완료");
                    $("#modalContainer").hide();
                    getDataList();
                } else {
                    alert("저장 실패: " + (res?.message || res));
                }
            },

            error: function(xhr, status, error) {
                console.log("[AJAX] error 발생");
                console.log("  status:", status);
                console.log("  error:", error);
                console.log("  xhr:", xhr);
                console.log("  responseText:", xhr?.responseText);

                alert("서버 오류 발생");
            }
        });
    });

    // 삭제 버튼
    $(".delete-button").click(function (event) {
        event.preventDefault();
        if (!selectedRow) return alert("삭제할 행을 선택하세요.");
        if (!confirm("정말 삭제하시겠습니까?")) return;

        $.ajax({
            url: "/mibogear/condition/deleteHeatTreating",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ heat_treating_code: selectedRow.getData().heat_treating_code }),
            dataType: "json",
            success: function () {
                alert("삭제 완료");
                getDataList();
            },
            error: function (_, __, e) {
                alert("삭제 중 오류: " + e);
            }
        });
    });
});
</script>









</body>
</html>
