<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>트렌드</title>
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
		    width: 1500px;
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
            padding: 11px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
       .daylabel {
		    margin-right: 10px;
		    margin-bottom: 13px;
		    font-size: 20px;
		    margin-left: 20px;
		    margin-top: 3px;
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
		    z-index:20010;
		}
		.row_select {
		    background-color: #d0d0d0 !important;
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
		 .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;
	
	    height: 42px;
	    margin-left: 9px;
        }
       .mchSelect {
		    margin-right: 10px;
		    margin-bottom: 13px;
		    font-size: 20px;
		    margin-left: -120px;
		    margin-top: 3px;
		}
.select-button {
    height: 40px;
    padding: 0 11px;
    border: 1px solid rgb(53, 53, 53);
    border-radius: 4px;
    background-color: #ffffff;
    cursor: pointer;
    display: flex;
    align-items: center;
}
.button-image {
  /* 이미지 크기 조정 */
  width: 20px;     /* 원하는 너비 (예: 20px) */
  height: 20px;    /* 원하는 높이 (예: 20px) */
  
  /* 버튼 텍스트와의 간격 조정 (선택 사항) */
  vertical-align: middle; /* 이미지와 텍스트를 중앙 정렬 */
  margin-right: 5px;      /* 텍스트 '조회'와의 간격 */
}
       .checkboxClass {
		    margin-right: 140px;
		    margin-bottom: 13px;
		    font-size: 20px;
		    margin-left: -120px;
		    margin-top: 6px;
		}
		.large-machine-display {
		    margin-right: 250px;
		    margin-bottom: 13px;
		    font-size: 45px;
		    margin-top: 3px;
		}
    </style>
    </head>
<body>


     		<div class="button-container">
     		
     		<span id="currentMachineDisplay" class="large-machine-display">1호기</span>
     		
     	<div class="checkboxClass">
            <input type="checkbox" id="autoUpdateCheckbox" checked style="margin-right: 5px;">
            <label for="autoUpdateCheckbox" style="font-size: 20px; cursor: pointer;">자동 갱신</label>
        </div>
     		<div class="mchSelect">
     		<label>호기 선택</label>
     		<select id="machineSelect"
			        style="font-size: 16px; margin: 5px; border-radius: 4px; border: 1px solid #ccc; 
			        text-align: center; height: 30px; width: 75px">
			        <option value="bcf1" selected>1호기</option>
			        <option value="bcf2">2호기</option>
     				<option value="bcf3">3호기</option>
     				<option value="bcf4">4호기</option>
     		</select>
     		</div>
        		<label class="daylabel">검색 날짜 :</label>
			<div class="date_input" style="text-align: center; ">
			    <input type="text" autocomplete="off" class="datetimeSet" id="startDate"
			        style="font-size: 16px; margin: 5px; border-radius: 4px; border: 1px solid #ccc; text-align: center;    height: 30px;">

				<span class="mid" style="font-size: 20px; font-weight: bold; margin-bottom:10px;"> ~ </span>
				
			   <input type="text" autocomplete="off" class="datetimeSet" id="endDate"
			        style="font-size: 16px; margin: 5px; border-radius: 4px; border: 1px solid #ccc; text-align: center;    height: 30px;">
			</div>
				<button class="select-button">
                    <img src="/mibogear/image/search-icon.png" alt="select" class="button-image">조회
                </button>
<!--            <button class="insert-button">
				<img src="/mibogear/css/tabBar/add-outline.png" alt="insert"
					class="button-image">추가
			</button> -->
				<button id="printBtn" 
				        style="margin-left:10px; background-color:#ffffff; border:1px solid #000000; border-radius:4px; padding:5px 10px; cursor:pointer; width:72px; height:40px;">
				    🖨️ 인쇄
				</button> 



                
			</div>
			<div id="container" style="width: 100%; height: 600px; margin-top:100px;"></div>

<script>
let now_page_code = "a05";

let categories;

let bcf1_chim,bcf1_oil,bcf1_cp,bcf1_tempering,bcf2_chim,bcf2_oil,bcf2_cp,
bcf3_chim,bcf3_oil,bcf3_cp,bcf3_tempering, bcf4_chim, bcf4_oil, bcf4_cp;
let memoSeries = []; // ✅ 메모 시리즈용 전역 변수
var trendInterval;
var chart;
const selectedMachine = "${selectedMachine}";

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
    if(chart){ chart.reflow(); }
    window.print();
    setTimeout(() => { document.head.removeChild(style); }, 1000);
}); 

//자동갱신 체크
function toggleTrendInterval() {
	console.log("체크박스 변경");
    const isChecked = $('#autoUpdateCheckbox').is(':checked');
    
    if (isChecked) {
        // 체크되어 있으면: 인터벌 시작 (기존 타이머가 없거나 중단된 경우에만)
        if (!trendInterval) {
            console.log("자동 갱신 시작: 1분 간격");
            // 인터벌 시작 시점에 한 번 수동으로 데이터를 다시 로드하여 즉시 최신화
            fetchData(); 
            trendInterval = setInterval(trendIntervalFunc, 1000*60);
        }
    } else {
        // 체크 해제되면: 인터벌 중지
        if (trendInterval) {
            clearInterval(trendInterval);
            trendInterval = null; // 인터벌 변수를 null로 설정하여 중지 상태를 표시
            console.log("자동 갱신 중지");
        }
    }
}
//트렌드 시작시간
function trendStime(){
	var now = new Date();
	now.setHours(now.getHours() - 8);
	
	var ye = now.getFullYear();
	var mo = paddingZero(now.getMonth()+1);
	var da = paddingZero(now.getDate());
	
	var ho = paddingZero(now.getHours());
	var mi = paddingZero(now.getMinutes());
		
	return ye+"-"+mo+"-"+da+" "+ho+":"+mi; 
}

//트렌드 종료시간
function trendEtime(){
	var now = new Date();
	var ye = now.getFullYear();
	var mo = paddingZero(now.getMonth()+1);
	var da = paddingZero(now.getDate());
	
	var ho = paddingZero(now.getHours());
	var mi = paddingZero(now.getMinutes());
		
	return ye+"-"+mo+"-"+da+" "+ho+":"+mi; 
}



function escapeHtml(str) {
    if (!str) return "";
    return String(str).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;").replace(/'/g,"&#039;");
}

function safeNum(v){ return (v===null||v===undefined||v==="")?null:(isNaN(Number(v))?null:Number(v)); }

function dataLabelFormat(val){
    var d = new Date(val);
    return paddingZero(d.getMonth()+1) + "-" + paddingZero(d.getDate()) + "<br/>" +
           paddingZero(d.getHours()) + ":" + paddingZero(d.getMinutes());
}

function paddingZero(v){ return v<10?"0"+v:v; }

$(document).ready(function () {
	//$("#machineSelect").val(selectedMachine);
	updateMachineDisplay();
	
    $(".datetimeSet").datepicker({ language:'ko', timepicker:true, dateFormat:'yyyy-mm-dd', timeFormat:'hh:ii', autoClose:true });
    $("#startDate").val(trendStime());
    $("#endDate").val(trendEtime());
    fetchData();
    //trendInterval = setInterval(trendIntervalFunc, 1000*60);
    toggleTrendInterval();
    $("#autoUpdateCheckbox").on("change", toggleTrendInterval);
});

//호기 출력
function updateMachineDisplay() {
    const selectedText = $("#machineSelect option:selected").text();
    $("#currentMachineDisplay").text(selectedText);
}

// ✨ 추가된 이벤트 핸들러: 호기 선택 변경 시 큰 글씨 업데이트
$("#machineSelect").on('change', function() {
	updateMachineDisplay();
});

$(".select-button").on("click", fetchData);

$('.close, #closeModal').click(function() { $('#corrForm')[0].reset(); $('#modalContainer').removeClass('show').hide(); });

function trendIntervalFunc(){ $("#startDate").val(trendStime()); $("#endDate").val(trendEtime()); fetchData(); }

var signListObj = {};
function fetchData() {
	console.log("데이터 조회");
    const startDate=$("#startDate").val(), endDate=$("#endDate").val();
    const machine = $("#machineSelect").val();
    $.ajax({
        type:"POST",
        url:"/mibogear/monitoring/getTempList",
        data:{ startDate, endDate, machine },
        success:function(result){
           console.log("조회 데이터: ", result);
            if(!result || result.length===0){ console.log("데이터가 없습니다."); return; }

            // 그룹화 + 중복 제거
            const grouped={}, uniqueOrder=[];
            result.forEach(r=>{
                const key = r.date;
                if(!grouped.hasOwnProperty(key)){
                    grouped[key] = r; // 최초 데이터만
                    uniqueOrder.push(key);
                }
            });
            categories = uniqueOrder.slice();


            // 시리즈 데이터 구성
            bcf1_chim=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf1_chim));
            bcf1_oil=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf1_oil));
            bcf1_cp=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf1_cp));
            bcf1_tempering=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf1_tempering));
            bcf2_chim=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf2_chim));
            bcf2_oil=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf2_oil));
            bcf2_cp=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf2_cp));
            bcf3_chim=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf3_chim));
            bcf3_oil=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf3_oil));
            bcf3_cp=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf3_cp));
            bcf3_tempering=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf3_tempering));
            bcf4_chim=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf4_chim));
            bcf4_oil=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf4_oil));
            bcf4_cp=uniqueOrder.map(rt=>safeNum(grouped[rt].bcf4_cp));

            const dynamicSeries = createSeriesData(machine);

            //const newSeriesData=[bcf1_chim,bcf1_oil,bcf1_cp,bcf1_tempering,bcf2_chim,bcf2_oil,bcf2_cp,
            //	bcf3_chim,bcf3_oil,bcf3_cp,bcf3_tempering, bcf4_chim, bcf4_oil, bcf4_cp];

            if(!chart) getTrend(dynamicSeries);
/*             else{
                chart.xAxis[0].setCategories(categories,false);
                chart.series.forEach((s,i)=>s.setData(newSeriesData[i]||[],false));
                // ✅ 메모 시리즈 갱신
                const memoIdx = chart.series.length - 1;
                chart.series[memoIdx].setData(memoSeries,false);
                chart.redraw();
            } */
            chart.xAxis[0].setCategories(categories,false);
            
            while (chart.series.length > 0) {
                chart.series[0].remove(false);
            }
            
            // 2. 새로운 시리즈 추가
            dynamicSeries.forEach(s => {
                chart.addSeries(s, false);
            });

            chart.redraw();
        },
        error:function(xhr,status,error){ console.error("❌ 에러:",error); alert("데이터 조회 중 오류가 발생했습니다."); }
    });
}

function getTrend(initialSeries){
	console.log("getTrend 함수");
    chart = Highcharts.chart('container',{
        chart:{ type:'line' },
        title:{ text:'트렌드' },
        xAxis:{
            categories: categories,
            title:{ text:'시간' },
            labels: {
                formatter: function() { return dataLabelFormat(this.value); },
                step: 2
            },
            tickInterval:40
        },
        yAxis:[
            { title:{ text:"온도", rotation:0 }, labels:{ align:"right", x:-10 }, 
              min:0, max:1000, 
              tickAmount: 11,   
              //tickPositions: [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000],          
              minorTickInterval: null, 
              endOnTick: true,
              maxPadding: 0,}
        ],
        tooltip:{
        	shared: true,
            crosshairs: true,
            formatter: function() {
                var s = '<b>' + (this.x || '') + '</b><br/>';
                // ✅ 핵심 수정: this.points 안전 체크 (undefined/빈 배열 방지)
                if (this.points && this.points.length > 0) {
                    this.points.forEach(function(pt) {  // 화살표 → function으로 변경 (this 안전)
                        s += pt.series.name + ': ' + (pt.y === null ? '-' : pt.y) + '<br/>';
                    });
                    // ✅ regtime 접근도 안전하게
                    var pointIndex = this.points[0].point ? this.points[0].point.x : 0;
                    var regtime = categories[pointIndex] || '';
                    var labelHtml = signListObj[regtime] || "";
                    if (labelHtml) s += '<hr/>' + labelHtml;
                } else {
                    s += '데이터 없음';  // 옵션: 빈 툴팁 시 메시지 (제거 가능)
                }
                return s;
            }
        },
        series: initialSeries
    });
}

//설비별 다른 시리즈
function createSeriesData(machine) {
    const seriesMap = {
        'bcf1': [
            { name:'1호기 침탄', data: bcf1_chim, yAxis:0 },
            { name:'1호기 유조', data: bcf1_oil, yAxis:0 },
            { name:'1호기 CP', data: bcf1_cp, yAxis:0 },
            { name:'1호기 소려', data: bcf1_tempering, yAxis:0 }
        ],
        'bcf2': [
            { name:'2호기 침탄', data: bcf2_chim, yAxis:0 },
            { name:'2호기 유조', data: bcf2_oil, yAxis:0 },
            { name:'2호기 CP', data: bcf2_cp, yAxis:0 }
        ],
        'bcf3': [
            { name:'3호기 침탄', data: bcf3_chim, yAxis:0 },
            { name:'3호기 유조', data: bcf3_oil, yAxis:0 },
            { name:'3호기 CP', data: bcf3_cp, yAxis:0 },
            { name:'3호기 소려', data: bcf3_tempering, yAxis:0 }
        ],
        'bcf4': [
            { name:'4호기 침탄', data: bcf4_chim, yAxis:0 },
            { name:'4호기 유조', data: bcf4_oil, yAxis:0 },
            { name:'4호기 CP', data: bcf4_cp, yAxis:0 }
        ]
    };
    // 선택된 호기에 해당하는 시리즈 배열을 반환합니다.
    return seriesMap[machine] || []; 
}
</script>

</body>
</html>